# Development Guide

This guide covers the complete development workflow for working with x86 assembly programs in this repository using DOSBox and MASM 6.11.

## Table of Contents

- [Environment Setup](#environment-setup)
- [DOSBox Configuration](#dosbox-configuration)
- [Development Workflow](#development-workflow)
- [Project Structure](#project-structure)
- [Building Programs](#building-programs)
- [Debugging](#debugging)
- [Testing](#testing)
- [Common Issues](#common-issues)
- [Best Practices](#best-practices)

## Environment Setup

### Prerequisites

1. **DOSBox** - DOS emulator
2. **Text Editor** with assembly syntax highlighting (recommended)
3. **Git** - Version control

### Installing DOSBox

#### Windows

**Option 1: Direct Download**
1. Visit https://www.dosbox.com/download.php?main=1
2. Download DOSBox 0.74-3 installer
3. Run installer and follow prompts

**Option 2: Package Manager**
```powershell
# Using Chocolatey
choco install dosbox

# Using Winget
winget install DOSBox.DOSBox
```

#### macOS

```bash
# Using Homebrew
brew install dosbox

# Or download from https://www.dosbox.com/
```

#### Linux

```bash
# Debian/Ubuntu
sudo apt-get update
sudo apt-get install dosbox

# Fedora
sudo dnf install dosbox

# Arch Linux
sudo pacman -S dosbox

# From source
sudo apt-get install build-essential libsdl1.2-dev
./configure
make
sudo make install
```

### Verifying Installation

```bash
dosbox --version
# Should output: DOSBox version 0.74-3 or similar
```

## DOSBox Configuration

### Basic Configuration

DOSBox uses a configuration file typically located at:
- **Windows**: `C:\Users\<username>\AppData\Local\DOSBox\dosbox-0.74-3.conf`
- **macOS**: `~/Library/Preferences/DOSBox 0.74-3 Preferences`
- **Linux**: `~/.dosbox/dosbox-0.74-3.conf`

### Recommended Settings for Assembly Development

Edit your `dosbox.conf`:

```ini
[cpu]
core=auto              # Auto-select fastest CPU core
cputype=auto           # Auto-detect CPU type
cycles=max             # Maximum speed for assembly/linking

[dosbox]
memsize=16             # 16 MB memory (sufficient for MASM)
machine=svga_s3        # SVGA graphics

[render]
aspect=true            # Maintain aspect ratio
scaler=normal2x        # 2x scaling

[autoexec]
# Auto-mount repository on startup
# Replace /path/to/DOSBOX with your actual path
mount c /path/to/DOSBOX
c:
cd \MASM611\BIN
path c:\MASM611\BIN;%PATH%
cd \Programs
```

### Creating a Development Batch File (Optional)

For quick DOSBox launches, create `dosbox-dev.bat` (Windows) or `dosbox-dev.sh` (Unix):

**Windows (dosbox-dev.bat):**
```batch
@echo off
dosbox -conf "%~dp0dosbox-dev.conf"
```

**Linux/macOS (dosbox-dev.sh):**
```bash
#!/bin/bash
dosbox -conf "$(dirname "$0")/dosbox-dev.conf"
```

Create `dosbox-dev.conf` in repository root:
```ini
[autoexec]
mount c .
c:
path c:\MASM611\BIN;%PATH%
cd \Programs
```

## Development Workflow

### 1. Starting DOSBox

#### Manual Mount
```
dosbox
# At Z:\ prompt:
mount c /path/to/DOSBOX
c:
```

#### Auto-Mount (via config)
```
dosbox
# Already mounted if configured in [autoexec]
```

### 2. Setting Up PATH

To avoid typing full paths:
```
path c:\MASM611\BIN;%PATH%
```

Verify:
```
masm
# Should show MASM version info
```

### 3. Creating a New Program

```
cd \Programs\TEMPLATE
copy TEMPLATE.asm ..\MyProgram\MyProgram.asm
cd ..\MyProgram
copy ..\PCMAC.INC .
copy ..\UTIL.LIB .
edit MyProgram.asm
```

### 4. The Edit-Assemble-Link-Test Cycle

```
# 1. Edit source (use external editor or DOSBox EDIT)
edit myprogram.asm

# 2. Assemble
masm myprogram.asm;

# 3. Link
link myprogram.obj,,,util;

# 4. Run
myprogram.exe

# 5. Repeat as needed
```

## Project Structure

### Directory Organization

Each program should have its own directory:

```
Programs/
└── MyProgram/
    ├── MyProgram.asm    # Source code
    ├── MyProgram.obj    # Object file (generated)
    ├── MyProgram.exe    # Executable (generated)
    ├── MyProgram.map    # Link map (generated)
    ├── PCMAC.INC        # Copy of macro library
    └── UTIL.LIB         # Copy of utility library
```

### File Naming Conventions

- **Source files**: `UPPERCASE.asm` or `MyProgram.asm`
- **Maximum 8 characters** for DOS compatibility (8.3 format)
- Use descriptive names: `GCD.asm`, `CONVERT.asm`, `NAMEFORM.asm`

### Version Control

**Files to commit:**
- `*.asm` - Source code
- `*.inc` - Include files
- `*.md` - Documentation

**Files to ignore (.gitignore):**
```gitignore
*.obj
*.exe
*.map
*.lst
*.bak
*.tmp
```

## Building Programs

### Single-File Programs

#### Method 1: Interactive (with prompts)

```
masm myprogram.asm
# Press Enter for object file name
# Press Enter for listing file (or none)
# Press Enter for cross-reference (or none)

link myprogram.obj
# Press Enter for exe name
# Press Enter for map file (or none)
# Press Enter for libraries (or type: util)
```

#### Method 2: Command-line (suppressed prompts)

```
masm myprogram.asm;
link myprogram.obj,,,util;
```

#### Method 3: One-liner with all options

```
masm /nologo myprogram.asm;
link /nologo myprogram.obj,,,util;
```

### Multi-File Programs

Example: Main program + procedure module

**Files:**
- `main.asm` - Main program
- `helper.asm` - Helper procedures

**Build Process:**

```
# Assemble both files
masm main.asm;
masm helper.asm;

# Link together
link main.obj helper.obj,,,util;

# Run
main.exe
```

### Using a Makefile (with NMAKE)

Create `MAKEFILE`:

```makefile
# Makefile for MyProgram
PROG = myprogram
OBJS = $(PROG).obj

$(PROG).exe: $(OBJS)
    link $(OBJS),,,util;

$(PROG).obj: $(PROG).asm
    masm $(PROG).asm;

clean:
    del *.obj
    del *.map
```

Build:
```
nmake
```

### Assembler Options

| Option | Purpose | Example |
|--------|---------|---------|
| `/nologo` | Suppress copyright banner | `masm /nologo file.asm;` |
| `/Zi` | Generate debug info | `masm /Zi file.asm;` |
| `/Fl` | Generate listing file | `masm /Fl file.asm;` |
| `/c` | Assemble only (no link) | `masm /c file.asm` |
| `/W2` | Warning level 2 | `masm /W2 file.asm;` |

### Linker Options

| Option | Purpose | Example |
|--------|---------|---------|
| `/nologo` | Suppress banner | `link /nologo file.obj;` |
| `/CO` | Include CodeView debug info | `link /CO file.obj;` |
| `/MAP` | Generate map file | `link /MAP file.obj;` |

## Debugging

### Using CodeView Debugger

#### Preparing for Debug

```
# Assemble with debug symbols
masm /Zi myprogram.asm;

# Link with CodeView info
link /CO myprogram.obj,,,util;

# Launch debugger
cv myprogram.exe
```

#### CodeView Commands

| Command | Action |
|---------|--------|
| `F5` | Run program |
| `F8` | Step over |
| `F10` | Step into |
| `F7` | Step out |
| `F9` | Set/clear breakpoint |
| `Ctrl+B` | View breakpoints |
| `Ctrl+W` | Add watch |
| `Ctrl+D` | View data |
| `Ctrl+R` | View registers |
| `Ctrl+C` | View code |
| `Q` | Quit |

#### Common Debugging Tasks

**View Register Values:**
```
# In CodeView, press Ctrl+R
# Shows AX, BX, CX, DX, SI, DI, BP, SP, etc.
```

**Set Breakpoint:**
```
# Navigate to line
# Press F9
```

**Watch Variable:**
```
# Press Ctrl+W
# Type variable name
```

### Debug Output Techniques

#### Print Debug Messages

```assembly
.data
debugMsg db "Debug: Reached point A", 13, 10, '$'

.code
; ...
_PutStr debugMsg        ; Print debug message
; ...
```

#### Display Register Values

```assembly
; Display AX value
call PutDec             ; If AX contains value to display

; Display character in AL
_PutCh                  ; If AL contains ASCII char
```

## Testing

### Manual Testing

Create test cases documented in comments:

```assembly
; Test Cases:
; 1. Input: 24, 36 → Expected Output: GCD = 12
; 2. Input: 17, 19 → Expected Output: GCD = 1 (primes)
; 3. Input: 0, 5  → Expected Output: GCD = 5 (zero case)
```

### Test Automation (Batch File)

Create `test.bat`:

```batch
@echo off
echo Testing MyProgram...

echo Test 1: Normal input
echo 5 | myprogram.exe > output1.txt
fc output1.txt expected1.txt

echo Test 2: Edge case
echo 0 | myprogram.exe > output2.txt
fc output2.txt expected2.txt

echo Tests complete.
```

### Validation Checklist

Before submitting/committing:

- [ ] Program assembles without errors
- [ ] Program links without errors
- [ ] Program runs without crashes
- [ ] All inputs validated (range checks)
- [ ] Edge cases tested (0, max values, empty input)
- [ ] Output format matches specification
- [ ] Code follows naming conventions
- [ ] Comments are clear and accurate
- [ ] Header block is complete

## Common Issues

### Problem: "File not found" during assembly

**Cause**: PCMAC.INC not in current directory or INCLUDE path

**Solution**:
```
copy \Programs\PCMAC.INC .
```

### Problem: "Unresolved external" during linking

**Cause**: UTIL.LIB not specified or not found

**Solution**:
```
link myprogram.obj,,,util;
# Or copy UTIL.LIB to current directory
copy \Programs\UTIL.LIB .
link myprogram.obj;
```

### Problem: "Segment too large"

**Cause**: Code or data exceeds 64KB (small model limit)

**Solution**: Reduce code size or switch to medium/large model

### Problem: "Stack overflow"

**Cause**: Stack size too small

**Solution**: Increase stack size:
```assembly
.stack 200h    ; 512 bytes instead of 256
```

### Problem: Program hangs

**Causes & Solutions**:
1. **Infinite loop**: Check loop conditions
2. **Waiting for input**: Verify GetDec/GetCh calls
3. **Incorrect jump**: Verify jump labels and conditions

### Problem: Incorrect output

**Debug steps**:
1. Add debug prints before/after key operations
2. Use CodeView to inspect register values
3. Check arithmetic operations for overflow
4. Verify string terminators ('$' for DOS strings)

## Best Practices

### Code Organization

1. **Use the template**: Start from `TEMPLATE/TEMPLATE.asm`
2. **Group related code**: Keep procedures together
3. **Separate data and code**: Clear .data and .code sections
4. **Comment abundantly**: Explain non-obvious operations

### Naming Conventions

```assembly
; Variables: descriptive, lowercase
count dw 0
userName db 80 dup(?)

; Constants: UPPERCASE
MAX_SIZE equ 100
CR equ 13
LF equ 10

; Procedures: PascalCase or descriptive
GetUserInput proc
ValidateNumber proc
PrintResults proc
```

### Error Handling

```assembly
; Always validate input
getUserAge:
    call GetDec
    cmp ax, 1
    jl invalidAge       ; Too young
    cmp ax, 120
    jg invalidAge       ; Too old
    ret
invalidAge:
    _PutStr errorMsg
    jmp getUserAge
```

### Performance Tips

1. **Use registers**: Faster than memory access
2. **Minimize procedure calls**: Inline simple operations
3. **Efficient loops**: Use LOOP instruction when appropriate
4. **Avoid redundant moves**: Plan register usage

### Documentation Standards

```assembly
;; ============================================================================
;; Procedure: CalculateGCD
;; Purpose:   Calculate Greatest Common Divisor using Euclidean algorithm
;; Inputs:    AX = first number, BX = second number
;; Outputs:   AX = GCD result
;; Modifies:  AX, BX, DX
;; ============================================================================
CalculateGCD proc
    ; Implementation
    ret
CalculateGCD endp
```

## Editor Setup

### Recommended Editors

1. **VS Code** with MASM extension
   - Syntax highlighting
   - IntelliSense
   - Integrated terminal

2. **Vim** with asm syntax
   ```vim
   :syntax on
   :set filetype=asm
   ```

3. **Notepad++** with asm language
   - Language → A → Assembly
   - Settings → Style Configurator → Assembly

4. **DOSBox EDIT** (built-in)
   ```
   edit myprogram.asm
   ```

### VS Code Configuration

Install extension: "x86 and x86_64 Assembly" by 13xforever

`.vscode/settings.json`:
```json
{
    "files.associations": {
        "*.asm": "asm-intel-x86-generic",
        "*.inc": "asm-intel-x86-generic"
    },
    "editor.insertSpaces": false,
    "editor.tabSize": 8
}
```

## Next Steps

- Review [ARCHITECTURE.md](ARCHITECTURE.md) for system design
- Check [CONTRIBUTING.md](../CONTRIBUTING.md) for contribution guidelines
- Read assignment specifications in program directories
- Experiment with example programs in `Programs/Examples from Class/`

## References

- **MASM Documentation**: See `MASM611/README.TXT`
- **DOSBox Wiki**: https://www.dosbox.com/wiki/
- **x86 Instruction Reference**: https://www.felixcloutier.com/x86/
- **DOS Interrupts**: http://www.ctyme.com/intr/int.htm

---

For questions or issues, please open a GitHub issue or consult the assignment specifications.
