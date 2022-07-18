# OS161 - Intro to Kernel Hacking

## Directory Layout

```
files/
│
├── os161/
│   ├── flag.txt        # Place holder flag, server contains real flag
│   ├── kernel          # Compiled kernel
│   ├── sys161.conf     # Config to run kernel, you won't need to change this
│   └── ...             # Kernel source code
│
├── tools/              # Pre-compiled tools to make your life easier
│   ├── os161           # Cross compiled tools for dealing with os161
│   └── sys161          # The os161 emulator
│
├── compile_pwn.sh      # Compile userland binary - "pwn"
├── run_pwn.sh          # Execute the userland binary - "pwn"
└── README.md           # This file
```
