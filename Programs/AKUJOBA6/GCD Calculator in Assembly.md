### Project Description: GCD Calculator in Assembly

#### Project Title: Assembly GCD Calculator (AGC)

#### Author: John Akujobi

#### Course: CSC 314

#### Assignment: Assignment 6

#### Due Date: November 29, 2023

---

#### Overview:

The Assembly GCD Calculator (AGC) project is an assembly language-based application developed for the Intel 586 processor. Its primary objective is to demonstrate the implementation and integration of modular assembly programming by calculating the Greatest Common Divisor (GCD) of two integers.

#### Components:

1. **JCAGCD Module:**
   * **File Name:** `JCAGCD.asm`
   * **Description:** This module contains the core logic for calculating the GCD. It is designed as a separate procedure, `JCAGCD`, which takes two integers in the `AX` and `BX` registers and returns the GCD in the `AX` register.
2. **Main Application:**
   * **File Name:** `AKUJOBA6.asm`
   * **Description:** This is the primary user interface of the application. It prompts the user to input two integers and then calls the `JCAGCD` procedure to compute their GCD. The result is then displayed to the user. This module also handles user interactions for repeating the calculation or exiting the program.

#### Functionality:

* **Input:** The user is prompted to enter two integer values.
* **Processing:** The `JCAGCD` procedure is called with these values to compute their GCD.
* **Output:** The application displays the calculated GCD.
* **Repeat Option:** After each calculation, the user is asked whether they wish to perform another calculation or exit the program.

#### Usage:

1. **Compilation:** The separate modules (`JCAGCD.asm` and `AKUJOBA6.asm`) are compiled into object files using the MASM assembler.
2. **Linking:** The object files are then linked together to create the final executable.
3. **Execution:** The user runs the executable, inputs integers as prompted, and receives the GCD calculation results.

#### Educational Value:

This project is an excellent example of modular programming in assembly language. It demonstrates important concepts like procedure calling, modular code design, and user interaction in a low-level programming environment. The project is particularly relevant for students of computer science, showcasing practical applications of assembly language in computational tasks.

#### Additional Notes:

* **Environment:** The project is intended to be compiled and run in a DOS environment, particularly using tools like DOSBox for emulation.
* **Prerequisites:** Basic knowledge of assembly language programming, especially in MASM, and familiarity with command-line operations are required to compile and run this project.
