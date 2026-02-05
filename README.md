# DOSBOX - x86 Assembly Language Course Projects

A comprehensive collection of x86 assembly language programs developed for CSC 314 (Assembly Language Programming). This repository contains completed student assignments demonstrating fundamental to advanced assembly programming concepts, along with the Microsoft MASM 6.11 development toolkit.

## 📋 Table of Contents

- [Features](#-features)
- [Repository Structure](#-repository-structure)
- [Architecture](#-architecture)
- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start)
- [Usage](#-usage)
- [Program Catalog](#-program-catalog)
- [Development Workflow](#-development-workflow)
- [What This Project Demonstrates](#-what-this-project-demonstrates)
- [Project Status](#-project-status)
- [License](#-license)

## ✨ Features

- **Complete MASM 6.11 Toolkit**: Full Microsoft Macro Assembler Professional Development System, Version 6.11
- **Assembly Workflow Examples**: Demonstrates complete development cycle from source to executable
- **DOS Interrupt Programming**: Real-world examples of DOS system calls (INT 21h) for I/O operations
- **Structured Assembly Code**: Well-documented programs following professional coding standards
- **Practical Algorithms**: Implementations of common algorithms (GCD, string manipulation, formatting)
- **User Interaction**: Programs demonstrating keyboard input, screen output, and user prompts
- **Code Reusability**: Shared libraries (PCMAC.INC, UTIL.LIB) demonstrating modular programming
- **Educational Documentation**: Assignment requirements and pseudocode included for learning reference

## 📁 Repository Structure

```
DOSBOX/
├── LICENSE                 # GNU GPL v3.0 license
├── README.md              # This file
├── MASM611/               # Microsoft MASM 6.11 assembler toolkit
│   ├── BIN/              # Assembler, linker, and development tools
│   ├── INCLUDE/          # Standard assembly include files
│   ├── HELP/             # Online help documentation
│   └── *.TXT             # Release notes and documentation
└── Programs/             # Student assembly programs
    ├── FIRST/           # Basic "Hello World" example
    ├── TEMPLATE/        # Reusable program template
    ├── AKUJOBIA3/       # Assignment 3: Date display using DOS services
    ├── A2JOHNA2/        # Assignment 2: Basic I/O operations
    ├── AKUJOBA4/        # Assignment 4: Celsius to Fahrenheit conversion
    ├── AKUJOBA5/        # Assignment 5: Character animation across screen
    ├── AKUJOBA6/        # Assignment 6: GCD calculator with procedures
    ├── AKUJOBA7/        # Assignment 7: Name formatting (lastname, firstname)
    ├── DOGAGE/          # Dog age calculator
    ├── Examples from Class/ # Classroom demonstration programs
    ├── Text store/      # Backup copies and documentation
    ├── PCMAC.INC        # Macro library for PC programming
    └── UTIL.LIB         # Utility library with I/O procedures
```

For detailed architecture documentation, see [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## 🏗 Architecture

### Assembly Program Structure

All programs follow a consistent structure based on the small memory model:

```assembly
include pcmac.inc          ; Macro definitions
.model small               ; Small memory model (code + data < 64KB each)
.586                       ; Intel 586 instruction set
.stack 100h                ; 256-byte stack

.data                      ; Data segment
    ; Variables here

.code                      ; Code segment
extrn PutDec:near          ; External procedures from UTIL.LIB
extrn GetDec:near

main proc
    _Begin                 ; Initialize data segment
    ; Program logic
    _Exit 0                ; Exit to DOS
main endp

end main
```

### Key Components

- **MASM 6.11**: Professional assembler with macro support, CodeView debugger, and LINK linker
- **PCMAC.INC**: High-level macros (_Begin, _Exit, _PutStr, _GetCh) simplifying DOS calls
- **UTIL.LIB**: Compiled library providing decimal I/O procedures (GetDec, PutDec)
- **DOS Interrupts**: INT 21h services for console I/O, file operations, and system functions

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for a complete system overview with diagrams.

## 📋 Prerequisites

### Required Software

1. **DOSBox** (v0.74-3 or later recommended)
   - DOS emulator to run 16-bit assembly programs
   - Download: https://www.dosbox.com/

### Included in Repository

- Microsoft MASM 6.11 (MASM611/ directory)
- Required libraries (UTIL.LIB, PCMAC.INC)
- All necessary include files

### System Requirements

- **Host OS**: Windows, macOS, or Linux
- **DOSBox**: 50 MB disk space, 16 MB RAM minimum
- **Display**: VGA-compatible (any modern system)

## 🚀 Quick Start

### 1. Install DOSBox

**Windows:**
```bash
# Download from https://www.dosbox.com/download.php?main=1
# Or using Chocolatey:
choco install dosbox
```

**macOS:**
```bash
brew install dosbox
```

**Linux:**
```bash
# Debian/Ubuntu:
sudo apt-get install dosbox

# Fedora:
sudo dnf install dosbox

# Arch:
sudo pacman -S dosbox
```

### 2. Clone Repository

```bash
git clone https://github.com/jakujobi/DOSBOX.git
cd DOSBOX
```

### 3. Configure DOSBox

Create or edit your DOSBox configuration file to mount the repository:

**Option A: Command-line mounting (temporary)**
```
# Start DOSBox
dosbox

# At the DOSBox prompt:
mount c /path/to/DOSBOX
c:
```

**Option B: Auto-mount configuration (permanent)**

Edit `dosbox.conf` (typically in `~/.dosbox/` or `C:\Users\<user>\AppData\Local\DOSBox\`):

```ini
[autoexec]
# Adjust path to your repository location
mount c ~/DOSBOX
c:
```

### 4. Run Your First Program

```
# Navigate to the FIRST program
cd Programs\FIRST

# Assemble the source file
c:\MASM611\BIN\MASM FIRST.asm

# Press Enter twice for default output files

# Link the object file
c:\MASM611\BIN\LINK FIRST.obj

# Press Enter four times for defaults

# Run the executable
FIRST.EXE
```

You should see: `Hello, my name is Bill Jones`

## 📖 Usage

### Standard Assembly Workflow

All programs follow this workflow:

```bash
# 1. Navigate to program directory
cd Programs\<ProgramName>

# 2. Assemble (.asm → .obj)
c:\MASM611\BIN\MASM <ProgramName>.asm
# Press Enter twice to accept defaults

# 3. Link with library if needed (.obj → .exe)
c:\MASM611\BIN\LINK <ProgramName>.obj,,,UTIL
# Press Enter to accept prompts

# 4. Execute
<ProgramName>.exe
```

### Using the Template

Start new programs from the template:

```bash
cd Programs\TEMPLATE
copy TEMPLATE.asm ..\MyProgram\MyProgram.asm
cd ..\MyProgram
# Edit MyProgram.asm with your code
```

### Common MASM Options

```bash
# Basic assembly
MASM myfile.asm

# With debugging symbols for CodeView
MASM /Zi myfile.asm
LINK /CO myfile.obj

# Suppress logo and prompts
MASM /nologo myfile.asm;
LINK /nologo myfile.obj,,,util;
```

### Example: Running the GCD Calculator

```bash
cd Programs\AKUJOBA6

# The program uses an external procedure, so assemble both files
c:\MASM611\BIN\MASM JCAGCD.asm
c:\MASM611\BIN\MASM AKUJOBA6.asm

# Link both object files with UTIL library
c:\MASM611\BIN\LINK AKUJOBA6.obj JCAGCD.obj,,,UTIL

# Run
AKUJOBA6.exe

# Enter two numbers when prompted to calculate their GCD
```

## 📚 Program Catalog

### Basic Programs

| Program | Description | Key Concepts |
|---------|-------------|--------------|
| **FIRST** | Hello World program | Basic structure, string output, DOS INT 21h |
| **TEMPLATE** | Reusable program skeleton | Project structure, PCMAC macros |
| **char.asm** | Character output with delay | Loops, delays, cursor control |
| **exp2.asm** | Simple expression example | Arithmetic operations |

### Course Assignments

| Assignment | Program | Description | Demonstrates |
|------------|---------|-------------|--------------|
| **A2** | JOHNA2 | Basic I/O operations | User input, console output |
| **A3** | AKUJOBIA3 | Date display program | DOS date service (INT 21h/2Ah), PutDec procedure |
| **A4** | AKUJOBA4 | Temperature converter | Arithmetic (Celsius→Fahrenheit), formula implementation |
| **A5** | AKUJOBA5 | Character animation | Screen positioning, delays, loops, user input validation |
| **A6** | AKUJOBA6 + JCAGCD | GCD calculator | Multi-file projects, external procedures, Euclidean algorithm |
| **A7** | AKUJOBA7 | Name formatter | String manipulation, array processing, complex parsing |

### Additional Programs

| Program | Description | Features |
|---------|-------------|----------|
| **DOGAGE** | Dog age calculator | Arithmetic operations, user interaction |

### Pre-compiled Binaries

The repository includes pre-built executables (*.EXE) for immediate testing. These are MS-DOS MZ executables that run in DOSBox.

## 🔧 Development Workflow

### Setting Up Your Environment

See [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md) for comprehensive development setup, including:
- DOSBox configuration tips
- Editor setup (syntax highlighting for .asm files)
- Debugging with CodeView
- Batch file automation
- Testing strategies

### Code Structure Guidelines

All programs follow these conventions:

1. **Header Comment Block**: Name, class, assignment, due date, description
2. **Includes**: `include pcmac.inc` for macro support
3. **Model Declaration**: `.model small` for most programs
4. **Segments**: .stack, .data, .code in order
5. **External References**: Declare before use (e.g., `extrn PutDec:near`)
6. **Initialization**: Use `_Begin` macro to set up data segment
7. **Exit**: Use `_Exit 0` macro for clean program termination

### Debugging

```bash
# Assemble with debug info
MASM /Zi myfile.asm

# Link with CodeView symbols
LINK /CO myfile.obj

# Run in CodeView debugger
c:\MASM611\BIN\CV myfile.exe
```

### Testing

Each program directory may contain:
- **Assignment requirements** (*.md, *.doc): Original specifications
- **Pseudocode** (*.md): Algorithm planning
- **Test cases**: Documented in assignment files

## 💡 What This Project Demonstrates

This repository showcases practical skills relevant to systems programming and low-level development:

### Assembly Language Proficiency
- **x86 Architecture Understanding**: Direct hardware interaction through registers, memory models, and instruction sets
  - See: All *.asm files, particularly [AKUJOBA7.asm](Programs/AKUJOBA7/AKUJOBA7.asm) (400+ lines)
- **Memory Management**: Stack manipulation, segment registers, data alignment
  - Example: [TEMPLATE.asm](Programs/TEMPLATE/TEMPLATE.asm) - `.stack 100h`, `.model small`

### Systems Programming
- **OS Interface**: DOS interrupt services (INT 21h) for I/O and system calls
  - Example: [AKUJOBIA3/AKUJOBA3.asm](Programs/AKUJOBIA3/AKUJOBA3.asm) - Date service (AH=2Ah)
- **Low-Level I/O**: Direct console control, character/string manipulation
  - Example: [AKUJOBA5/AKUJOBA5.asm](Programs/AKUJOBA5/AKUJOBA5.asm) - Screen cursor animation

### Software Engineering
- **Modular Programming**: Procedures, external libraries, code reuse
  - Example: [AKUJOBA6/](Programs/AKUJOBA6/) - Multi-file project with [JCAGCD.asm](Programs/AKUJOBA6/JCAGCD.asm) procedure
- **Documentation**: Comprehensive comments, assignment specifications
  - All programs include header blocks with name, class, assignment, description
- **Code Organization**: Consistent structure, naming conventions, separation of concerns
  - Template: [TEMPLATE/TEMPLATE.asm](Programs/TEMPLATE/TEMPLATE.asm)

### Algorithm Implementation
- **Euclidean Algorithm**: Greatest Common Divisor calculation
  - Implementation: [JCAGCD.asm](Programs/AKUJOBA6/JCAGCD.asm)
- **String Processing**: Parsing, searching, reformatting
  - Example: [AKUJOBA7/AKUJOBA7.asm](Programs/AKUJOBA7/AKUJOBA7.asm) - Name parsing and reordering
- **Arithmetic Operations**: Formula implementation, type conversions
  - Example: [AKUJOBA4/AKUJOBA4.asm](Programs/AKUJOBA4/AKUJOBA4.asm) - (C * 9/5) + 32

### Development Practices
- **Version Control**: Git repository with clear history
  - Repository: [jakujobi/DOSBOX](https://github.com/jakujobi/DOSBOX)
- **Build Process**: Assembly, linking, library management
  - Demonstrated in all programs with MASM/LINK workflow
- **Testing**: Input validation, edge case handling
  - Example: [AKUJOBA5/AKUJOBA5.asm](Programs/AKUJOBA5/AKUJOBA5.asm) - Validates trips input (1-3)
- **Incremental Development**: Assignment progression from simple to complex
  - Assignment 2 (basic I/O) → Assignment 7 (complex string processing)

### Tools & Ecosystem
- **Microsoft MASM 6.11**: Professional assembler with macro preprocessor
  - Included: [MASM611/](MASM611/) - Complete toolkit
- **Library Development**: Created/used shared utility libraries
  - Files: [PCMAC.INC](Programs/PCMAC.INC), [UTIL.LIB](Programs/UTIL.LIB)
- **Legacy System Knowledge**: DOS environment, 16-bit programming, real-mode memory
  - All programs target MS-DOS real mode with 16-bit architecture

## 📊 Project Status

**Status**: Complete ✅

This repository represents completed coursework for CSC 314 (Fall 2023). All assignments have been:
- ✅ Successfully assembled and linked
- ✅ Tested with DOSBox
- ✅ Documented with comments and specifications
- ✅ Compiled to working executables (*.EXE files included)

### Tested Environment

- **DOSBox**: Version 0.74-3 (confirmed working)
- **MASM**: Version 6.11 (included in repository)
- **Platform**: Successfully tested on Windows, macOS (via DOSBox)

### Known Limitations

- **Platform**: Programs require DOSBox or compatible DOS environment (MS-DOS, FreeDOS)
- **16-bit Only**: No support for 32-bit/64-bit native execution
- **Text Mode**: Console-only programs, no graphics
- **Legacy Tools**: MASM 6.11 is from 1993; modern alternatives exist (NASM, FASM)

## 🤝 Contributing

This is an educational project archive. While pull requests are welcome for:
- Documentation improvements
- Bug fixes in existing code
- Additional educational examples

Please note that assignment solutions should not be substantially modified, as they represent submitted coursework.

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

This project is licensed under the **GNU General Public License v3.0** - see the [LICENSE](LICENSE) file for details.

### Third-Party Components

- **Microsoft MASM 6.11**: Included under Microsoft's distribution license (see [MASM611/README.TXT](MASM611/README.TXT))
- **PCMAC.INC**: From "Assembly Language for the IBM PC Family" by William B. Jones
  - © Copyright 1992, 1997, 2001, Scott/Jones Inc.
- **UTIL.LIB**: From "Assembly Language for the IBM PC Family" companion materials

### Usage Notes

- Student work (Programs/) is original and provided as-is for educational reference
- MASM toolkit provided for educational and archival purposes
- If using this repository for learning, please cite appropriately and do not submit as your own work

## 🙏 Acknowledgements

- **Course**: CSC 314 - Assembly Language Programming
- **Instructor**: Course assignments and specifications from Fall 2023
- **Textbook**: "Assembly Language for the IBM PC Family" by William B. Jones
- **Tools**: Microsoft MASM Professional Development System 6.11
- **Platform**: DOSBox development team for DOS emulation

---

**Note**: This repository is maintained as an educational resource and portfolio piece. For questions or issues, please open a GitHub issue.
