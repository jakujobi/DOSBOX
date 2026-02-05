# Contributing to DOSBOX

Thank you for your interest in contributing to this x86 assembly language educational repository! This document provides guidelines for contributing code, documentation, and improvements.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Guidelines](#development-guidelines)
- [Coding Standards](#coding-standards)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Pull Request Process](#pull-request-process)
- [Testing Requirements](#testing-requirements)

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome newcomers and learners
- Provide constructive feedback
- Focus on educational value
- Credit original authors

### Scope

This is an educational repository. Contributions should enhance learning and understanding of assembly language programming.

## How to Contribute

### Types of Contributions Welcome

#### 1. Documentation Improvements ✅

- Clarifying existing documentation
- Adding examples and tutorials
- Fixing typos and formatting
- Translating documentation

#### 2. Bug Fixes ✅

- Fixing assembly errors in existing code
- Correcting logical errors
- Improving error handling

#### 3. New Examples ✅

- Additional assembly programs demonstrating concepts
- Alternative implementations of existing programs
- Examples of new algorithms or techniques

#### 4. Tooling & Automation ✅

- Build scripts and automation
- Testing frameworks
- Development utilities

### Types of Contributions NOT Welcome

#### Major Changes to Assignment Solutions

Assignment programs (AKUJOBA3-AKUJOBA7) represent submitted coursework and should remain largely unchanged to preserve their educational and historical value.

#### Plagiarism or Academic Dishonesty

Do not submit work that is not your own or that violates academic integrity policies.

## Development Guidelines

### Setting Up Your Development Environment

1. **Fork the repository**

   ```bash
   # On GitHub, click "Fork"
   ```
2. **Clone your fork**

   ```bash
   git clone https://github.com/YOUR_USERNAME/DOSBOX.git
   cd DOSBOX
   ```
3. **Add upstream remote**

   ```bash
   git remote add upstream https://github.com/jakujobi/DOSBOX.git
   ```
4. **Install DOSBox**
   See [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md) for installation instructions.
5. **Create a branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

### Making Changes

1. **Test your changes in DOSBox**

   - Assemble your code: `masm yourfile.asm;`
   - Link: `link yourfile.obj,,,util;`
   - Run and verify: `yourfile.exe`
2. **Follow coding standards** (see below)
3. **Document your changes**

   - Update relevant documentation
   - Add comments to code
   - Include examples if applicable
4. **Commit your changes**

   ```bash
   git add .
   git commit -m "Add: Brief description of changes"
   ```
5. **Push to your fork**

   ```bash
   git push origin feature/your-feature-name
   ```
6. **Open a Pull Request**

   - Go to GitHub
   - Click "New Pull Request"
   - Select your branch
   - Fill in the PR template

## Coding Standards

### Assembly Code Style

#### File Structure

```assembly
;; ============================================================================
;; File: FILENAME.asm
;; Author: Your Name
;; Date: YYYY-MM-DD
;; Purpose: Brief description
;; ============================================================================

include pcmac.inc

.model small
.586
.stack 100h

;; ============================================================================
;; DATA SEGMENT
;; ============================================================================
.data
    ; Variables here with descriptive comments

;; ============================================================================
;; CODE SEGMENT
;; ============================================================================
.code

extrn GetDec:near
extrn PutDec:near

;; ----------------------------------------------------------------------------
;; Main Procedure
;; ----------------------------------------------------------------------------
main proc
    _Begin
  
    ; Implementation
  
    _Exit 0
main endp

end main
```

#### Naming Conventions

**Variables**

```assembly
; Use descriptive names, camelCase or lowercase
userName db 80 dup(?)
userAge dw 0
totalCount dw 0
```

**Constants**

```assembly
; Use UPPERCASE with underscores
MAX_SIZE equ 100
MIN_VALUE equ 1
BUFFER_SIZE equ 256
```

**Procedures**

```assembly
; Use PascalCase or descriptive names
GetUserInput proc
CalculateTotal proc
DisplayResults proc
```

**Labels**

```assembly
; Use lowercase with underscores for clarity
main_loop:
error_handler:
done:
```

#### Indentation and Spacing

```assembly
; Use consistent indentation (4 or 8 spaces, or tabs)
main proc
    _Begin                  ; Indent inside procedures
  
    mov ax, bx              ; Align instructions
    add ax, cx              ; Align operands
    call MyProc             ; One instruction per line
  
    _Exit 0
main endp

; Blank line between procedures
helper proc
    ; Implementation
    ret
helper endp
```

#### Comments

```assembly
; Line comments for single-line explanations
mov ax, bx              ; Copy BX to AX

;; Section comments for major blocks
;; This section handles user input validation

; Procedure headers
;; ----------------------------------------------------------------------------
;; Procedure: CalculateSum
;; Purpose:   Add two numbers and return result
;; Inputs:    AX = first number, BX = second number  
;; Outputs:   AX = sum
;; Modifies:  AX
;; ----------------------------------------------------------------------------
```

### Documentation Style

#### Markdown Files

- Use proper heading hierarchy (# ## ###)
- Include table of contents for long documents
- Use code blocks with language specification
- Add examples where appropriate
- Keep lines under 100 characters when possible

#### Code Examples

```markdown
## Example: Temperature Conversion

This example demonstrates arithmetic operations:

\`\`\`assembly
; Convert Celsius to Fahrenheit: F = (C * 9/5) + 32
mov ax, celsius         ; Load Celsius value
mov bx, 9
mul bx                  ; AX = C * 9
mov bx, 5
div bx                  ; AX = (C * 9) / 5
add ax, 32              ; AX = F
mov fahrenheit, ax      ; Store result
\`\`\`
```

### File Organization

#### New Programs

Create a new directory:

```
Programs/
└── YourProgram/
    ├── YourProgram.asm      # Main source file
    ├── README.md            # Program description
    ├── PCMAC.INC            # Copy of macro library
    └── UTIL.LIB             # Copy of utility library
```

#### Supporting Files

- Include a README.md explaining the program
- Document test cases
- Provide example input/output
- List any special requirements

## Commit Message Guidelines

### Format

```
Type: Short summary (50 chars max)

Detailed description if needed (wrap at 72 chars).
- Bullet points are fine
- Explain what and why, not how

Fixes #123
```

### Types

- **Add**: New feature or file
- **Fix**: Bug fix
- **Docs**: Documentation changes
- **Style**: Formatting, missing semicolons, etc.
- **Refactor**: Code restructuring without changing behavior
- **Test**: Adding or updating tests
- **Chore**: Maintenance tasks

### Examples

```
Add: GCD calculator with Euclidean algorithm

Implements the Euclidean algorithm for calculating
greatest common divisor. Includes input validation
and error handling.

Fixes #15
```

```
Docs: Update README with DOSBox installation steps

Added detailed installation instructions for Windows,
macOS, and Linux. Includes package manager commands
and verification steps.
```

```
Fix: Correct stack overflow in AKUJOBA5

Increased stack size from 100h to 200h to prevent
overflow during character animation loop.
```

## Pull Request Process

### Before Submitting

- [ ] Code assembles without errors
- [ ] Code links without errors
- [ ] Program runs correctly in DOSBox
- [ ] All test cases pass
- [ ] Documentation is updated
- [ ] Commit messages follow guidelines
- [ ] Code follows style guidelines

### PR Template

When opening a pull request, include:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring

## Testing
Describe how you tested your changes:
- [ ] Assembled with MASM
- [ ] Linked successfully
- [ ] Tested in DOSBox
- [ ] Verified output

## Test Cases
1. Input: ... → Output: ...
2. Input: ... → Output: ...

## Screenshots (if applicable)
(Add screenshots of DOSBox output)

## Related Issues
Fixes #123
```

### Review Process

1. **Automated Checks**: Ensure all checks pass
2. **Code Review**: Maintainer will review your code
3. **Feedback**: Address any requested changes
4. **Approval**: Once approved, your PR will be merged

### After Merge

```bash
# Update your local repository
git checkout main
git pull upstream main

# Delete your feature branch
git branch -d feature/your-feature-name
git push origin --delete feature/your-feature-name
```

## Testing Requirements

### Assembly Programs

**Minimum Testing:**

1. **Assemble**: No errors or warnings

   ```
   masm /W2 yourfile.asm;
   ```
2. **Link**: No unresolved externals

   ```
   link yourfile.obj,,,util;
   ```
3. **Execute**: Runs without crashes

   ```
   yourfile.exe
   ```
4. **Verify Output**: Matches expected results

**Test Cases:**

Document test cases in code comments:

```assembly
;; Test Cases:
;; 1. Normal: Input 5, 10 → Output: 15
;; 2. Zero:   Input 0, 5  → Output: 5
;; 3. Negative: Input -3, 7 → Output: 4
;; 4. Edge: Input 32767, 1 → Output: Overflow handling
```

### Documentation

- [ ] No spelling errors
- [ ] Links work correctly
- [ ] Code examples are accurate
- [ ] Formatting is consistent

## Getting Help

### Resources

- **Documentation**: See [docs/](docs/)
- **Examples**: Check [Programs/Examples from Class/](Programs/Examples%20from%20Class/)
- **Issues**: Browse existing [GitHub Issues](https://github.com/jakujobi/DOSBOX/issues)

### Questions?

- Open a [GitHub Discussion](https://github.com/jakujobi/DOSBOX/discussions)
- Open an [Issue](https://github.com/jakujobi/DOSBOX/issues/new)
- Tag @jakujobi in comments

## Recognition

Contributors will be recognized in:

- README.md acknowledgements section
- CHANGELOG.md (if we create one)
- Git commit history

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (GNU GPL v3.0).

---

Thank you for contributing to the DOSBOX project! Your efforts help make assembly language more accessible to learners worldwide. 🎓
