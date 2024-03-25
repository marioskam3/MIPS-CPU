# MIPS CPU

## Overview 
This is an implementation of the MIPS CPU developed in VHDL

## Contents

- [How it works](#How-it-works)
- [How to test it](#How-to-test-it)
- [License](#License)

## How it Works

### The operating cycle is as follows:

- The instruction is fetched from memory. 
- It is then decoded to determine the type of type and which\
CPU components are required to execute it. 
- The operands of the instruction are read from the registers. 
- The instruction is then executed and the results are\ 
are stored in the registers. 
- Finally, the PC calculates the new address of the next instruction to be\
to be executed 
- The cycle is executed from the beginning.

## How to test it

- You will need a simulator that runs VHDL code (like Altera Modelsim)
- Load the project folder to the simulator 
- Compile components
- Simulate by running the Test Bench

## License

This project is licensed under the MIT License