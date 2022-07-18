#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct BMPHeader {
    int32_t header_size;
    int32_t img_width;
    int32_t img_height;
    int16_t col_planes;
    int16_t bits_per_pixel;
    int32_t compression_method;
};

char* read_file_to_buf(char* fname, long* len);

int main(int argc, char* argv[]) {
    if (argc != 4) {
        printf("Usage:\n%s <bmp file to hide data in> <txt file to hide> <outfile>\n", argv[0]);

        return 1;
    }

    // Get last 4 bytes
    char* last_bytes = argv[1] + strlen(argv[1]) - 4;

    if (strcmp(last_bytes, ".bmp") != 0) {
        printf("First argument must be the path to a .bmp file\n");

        return 1;
    }

    long img_file_size;
    char* img_data = read_file_to_buf(argv[1], &img_file_size);

    struct BMPHeader* header = (struct BMPHeader*)(img_data + 14);

    if (header->header_size != 40) {
        printf("BMP file does not have the correct header. Try not exporting colour space information and ensure you are exporting in 24 bits mode.\n");

        return 1;
    }

    printf("IMAGE INFO:\n");
    printf("Width: %d\n", header->img_width);
    printf("Height: %d\n", header->img_height);
    printf("Col planes: %d\n", header->col_planes);
    printf("Bits Per Pixel: %d\n", header->bits_per_pixel);
    printf("Compression method: %d\n", header->compression_method);

    if (header->compression_method != 0) {
        printf("Image is compressed. Please try again with an uncompressed bmp file.\n");
        return 1;
    }
    if (header->bits_per_pixel != 24) {
        printf("Please use an image with 24 bits per pixel.\n");
        return 1;
    }

    char* img_data_start = img_data + *(int32_t*)(img_data + 10);

    int row_size = ((header->bits_per_pixel * header->img_width + 31) / 32) * 4;
    int img_data_size = row_size * header->img_height;

    long secret_file_size;
    char* secret_text = read_file_to_buf(argv[2], &secret_file_size);

    if ((secret_file_size + 1) * 8 > img_data_size) {
        printf("Text too big to fit in image! Use a bigger image or a smaller text file\n");
        return 1;
    }

    char key[] = {0x13, 0x37, 0xbe, 0xef};

    for (int i = 0; i < secret_file_size; i++) {
        // simple xor encryption
        secret_text[i] ^= key[i % 4];
        for (int j = 0; j < 8; j++) {
            img_data_start[i * 8 + j] &= ~((char)0x1);
            img_data_start[i * 8 + j] |= ((0x1 << j) & secret_text[i]) ? 1 : 0;
        }
    }

    // Add a null byte at the end
    for (int j = 0; j < 8; j++) {
        img_data_start[secret_file_size * 8 + j] &= ~((char)0x1);
    }

    FILE* out = fopen(argv[3], "w");
    fwrite(img_data, img_file_size, 1, out);
    fclose(out);

    free(img_data);
}

char* read_file_to_buf(char* fname, long* len) {
    FILE* fp;

    fp = fopen(fname, "r");

    char* file_data;

    fseek(fp, 0, SEEK_END);
    *len = ftell(fp);
    rewind(fp);

    file_data = malloc(*len * sizeof(char));
    fread(file_data, *len, 1, fp);
    fclose(fp);

    return file_data;
}