docker build -t RRISC .
docker run -d -p 9999:9999 --name=RRISC RRISC
