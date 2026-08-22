# 🪙 Verilog Vending Machine Controller

A production-grade, synthesizable hardware implementation of an automated Vending Machine Controller using **Verilog HDL** and designed via a **Finite State Machine (FSM)** architecture.

---

## 📌 Project Overview
This repository contains a digital vending machine controller designed to handle item selection, handle sequential currency insertions, calculate change variations, and trigger item dispensation upon fulfilling payment conditions.

*   **Design Paradigm:** RTL Design using Synchronous Finite State Machine (FSM).
*   **Target Applications:** FPGA Prototyping (e.g., Xilinx Artix-7, Basys 3), ASIC IP Blocks.
*   **Design Tools:** AMD Xilinx Vivado, Intel Quartus, Icarus Verilog, ModelSim.

---

## 🛠️ Features
*   **Currency Validation:** Accepts various coin/note inputs (e.g., $5, $10, $20, or nickels/dimes depending on specifications).
*   **Price Logic:** Supports configurable item pricing (e.g., Default base cost of 15 / 25 currency units).
*   **Change Calculation System:** Returns precise change variations seamlessly if the inserted amount exceeds the target value.
*   **User Interrupts:** Built-in cancellation mechanism to abort transactions midway and retrieve deposited amounts safely.
*   **Status Indicators:** LED/Display outputs marking payment success, insufficient funds, and dispensing phases.

---

## 📐 FSM Architecture & State Machine
The core system operation depends on a Mealy/Moore FSM mechanism consisting of the following key computational state pathways:

