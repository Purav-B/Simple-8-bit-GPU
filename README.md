**8-Bit General-Purpose Processor (GPU)**

A simple general-purpose processor built entirely in VHDL and implemented on an FPGA, designed around a modular architecture of storage, control, and arithmetic logic units.

**Overview:**

This project implements an 8-bit GPU capable of performing 9 distinct logic, arithmetic, and shift operations. The design integrates a Storage Unit, Control Unit, Arithmetic Logic Unit (ALU), and Seven-Segment Display Unit, all built from scratch using VHDL and verified through waveform simulation in Quartus II before being deployed on physical FPGA hardware.

**Architecture:**

Storage Unit: Two 8-bit latches temporarily hold operand inputs (A and B) and synchronize data transfer to the ALU on the rising clock edge

Control Unit: A Finite State Machine (FSM) cycles through 9 states, driving a 4-to-16 decoder to select the active ALU operation

Decoder: Built from two 3-to-8 decoders combined with NAND/NOT gates instead of a standard 4-to-16 design, reducing gate count and propagation delay

ALU: Performs the selected logic, arithmetic, or shift operation on the stored operands, outputting results to the display units

Display Unit: Seven-segment displays output the result, split across two 4-bit registers (R1, R2), with a separate indicator for negative results

**Process:**

Designed and simulated individual components (latches, decoder, FSM, ALU) in VHDL, verifying each with dedicated truth tables and waveform simulations

Integrated all components into a complete top-level GPU design

Developed three separate ALU problem sets, each implementing a different set of logic/arithmetic operations while reusing the same overall architecture

Validated full-system functionality through microcode mapping and waveform simulation, confirming correct output behavior with zero timing errors

Deployed and tested the design on physical FPGA hardware

**Tools Used:**

VHDL, Quartus II, FPGA, Block Schematic Entry
