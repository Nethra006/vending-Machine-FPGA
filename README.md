
# FPGA Vending Machine Controller

A simple vending machine controller written in **Verilog** and implemented on the **Digilent Nexys A7-100T** (Xilinx Artix-7 `xc7a100tcsg324-1`) using **Vivado 2025.2**.

The controller accepts ₹5 and ₹10 coins, maintains a running balance, dispenses one of two products, and signals the change to return.

> **Status:** Successfully synthesized and implemented. Bitstream generated, and timing constraints met.

---

## 1. Project Overview

This project implements a digital vending machine controller using Verilog HDL. It accepts two types of coin inputs and supports two product selections with different prices.

The controller checks the accumulated balance, activates the appropriate product dispensing output, and indicates the applicable change through dedicated LED outputs.

## 2. Key Features

- Accepts ₹5 and ₹10 coin inputs.
- Supports two products:
  - Product A – ₹10
  - Product B – ₹15
- Uses a 5-bit running balance register.
- Provides product dispensing and change indication outputs.
- Supports asynchronous active-high reset.
- Operates using the 100 MHz Nexys A7 system clock.

## 3. Working Principle

The accumulated balance is stored in an internal register named `amount`.

On every rising edge of the system clock:

1. If `coin5` is high, ₹5 is added to the balance. Otherwise, if `coin10` is high, ₹10 is added.
2. If `select_A` is high and the balance is at least ₹10, `dispense_A` is activated.
3. Otherwise, if `select_B` is high and the balance is at least ₹15, `dispense_B` is activated.
4. Change is indicated using `change_5` when the excess is exactly ₹5, or `change_10` when the excess is ₹10 or more.
5. After a successful product selection, the accumulated balance is cleared.

All outputs default to zero during each clock cycle. Therefore, dispensing and change indications are single-clock-cycle pulses.

## 4. Hardware Interface and Pin Mapping

The following table describes the FPGA input and output assignments used on the Nexys A7 board.

| Signal | Direction | Nexys A7 Connection | Description |
|---|---|---|---|
| `clk` | Input | E3 | 100 MHz system clock |
| `reset` | Input | BTNC (U18) | Active-high asynchronous reset |
| `coin5` | Input | SW0 (J15) | Insert ₹5 coin |
| `coin10` | Input | SW1 (L16) | Insert ₹10 coin |
| `select_A` | Input | SW2 (M13) | Select Product A |
| `select_B` | Input | SW3 (R15) | Select Product B |
| `dispense_A` | Output | LED0 (H17) | Product A dispensing indication |
| `dispense_B` | Output | LED1 (K15) | Product B dispensing indication |
| `change_5` | Output | LED2 (J13) | ₹5 change indication |
| `change_10` | Output | LED3 (N14) | ₹10 or more change indication |

All I/O pins are configured using the LVCMOS33 standard.

### Hardware Testing Photographs

**Hardware Test 1**

![Vending Machine FPGA Hardware Test 1](<WhatsApp Image 2026-11-12 at 11.53.12 PM (1).jpeg>)

**Hardware Test 2**

![Vending Machine FPGA Hardware Test 2](<WhatsApp Image 2026-11-12 at 11.53.12 PM.jpeg>)


## 5. Design and Implementation Flow

The project follows these FPGA development stages:

1. Verilog RTL design.
2. Vivado project creation and configuration.
3. XDC pin constraint assignment.
4. RTL synthesis.
5. FPGA implementation and placement.
6. Routing and static timing analysis.
7. Bitstream generation.
8. FPGA hardware programming and testing.

## 6. Project Directory Structure

```text
vending_machine/
├── vending_machine.xpr
├── vending_machine.srcs/
│   ├── sources_1/new/
│   │   └── vending_machine.v
│   └── constrs_1/new/
│       └── vending_machine.xdc
└── vending_machine.runs/
    └── Synthesis and implementation results
```

## 7. FPGA Resource Utilization

The following resource utilization values were obtained from the Vivado implementation reports.

| FPGA Resource | Utilization | Device Capacity |
|---|---:|---:|
| Slice LUTs | 13 | 63,400 |
| Slice Registers | 9 | 126,800 |
| Bonded IOBs | 10 | 210 |
| Clock Buffers (BUFG) | 1 | Device dependent |

The design uses a small portion of the available FPGA resources, demonstrating a lightweight hardware implementation.

## 8. Timing Analysis

Post-route timing results obtained from Vivado 2025.2:

| Timing Parameter | Reported Result |
|---|---:|
| Worst Negative Slack (WNS) | +7.212 ns |
| Total Negative Slack (TNS) | 0.000 ns |
| Worst Hold Slack (WHS) | +0.191 ns |
| Total Hold Slack (THS) | 0.000 ns |
| Setup Failing Endpoints | 0 |
| Hold Failing Endpoints | 0 |

**Timing Result:** All user-specified timing constraints were met according to the routed timing summary.

## 9. Power Analysis

| Parameter | Reported Value |
|---|---:|
| Total On-Chip Power | 0.100 W |

This is the estimated total on-chip power reported by Vivado.

## 10. Hardware Implementation

The design was programmed onto the **Digilent Nexys A7-100T FPGA Development Board**.

The board switches provide coin and product selection inputs, while the center push button provides reset functionality. Four LEDs are assigned to display product dispensing and change indication outputs.

Two photographs of the FPGA board implementation are included in this repository as visual evidence of the hardware setup and testing.

## 11. Known Limitations and Future Improvements

- **Input Debouncing:** Coin inputs are level-sensitive. Holding a switch high can add money repeatedly on successive clock cycles. A debouncer and rising-edge detector would ensure that each input action is counted once.

- **Output Pulse Extension:** Dispensing and change outputs last one clock cycle (10 ns), which is too short to observe directly on an LED. Pulse stretching or output latching would improve visibility.

- **Change Handling:** Any excess of ₹10 or more activates only `change_10`. Therefore, excess amounts of ₹15 or ₹20 are not represented accurately.

- **Balance Overflow Protection:** The 5-bit balance register can represent values only from 0 to 31. Additional balance-limit logic could prevent overflow.

- **Explicit FSM Architecture:** The current RTL uses a clocked process and a balance register rather than an explicit finite state machine. A future version could use named states such as `IDLE`, `COLLECT`, `DISPENSE`, and `CHANGE`.

- **Seven-Segment Display:** A display interface could be added to show the accumulated balance and transaction information.

## 12. Tools and Technologies Used

| Category | Technology |
|---|---|
| Hardware Description Language | Verilog HDL |
| FPGA Development Tool | Xilinx Vivado 2025.2 |
| FPGA Development Board | Digilent Nexys A7-100T |
| FPGA Architecture | Xilinx Artix-7 |
| Constraints | XDC |
| Implementation | Synthesis, Placement and Routing |
| Analysis | Static Timing and Power Analysis |





No license has been specified for this repository yet.

