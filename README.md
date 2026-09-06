# Computer First-Aid Toolkit

A portable, safety-first toolkit for diagnosing, preserving, recovering, and repairing Windows computers without unnecessary changes.

The goal is simple:

**Download → prepare a USB → run the toolkit → diagnose safely.**

---

## What This Project Is

Computer First-Aid Toolkit is a portable collection of:

* PowerShell diagnostic scripts
* Hardware and storage diagnostics
* Network diagnostics
* Windows repair assessment
* Backup and data-preservation workflows
* File-recovery guidance
* Security assessment
* Portable diagnostic-tool integration
* Session management
* Operator checklists
* Safety documentation

It is designed to help a computer owner or authorized helper investigate computer problems while minimizing unnecessary changes to the system.

The core philosophy is:

**OBSERVE → PRESERVE → DIAGNOSE → CONFIRM → REPAIR**

The toolkit starts with read-only inspection whenever possible.

---

# Quick Start

## 1. Download This Repository

Download the repository from GitHub and copy its contents to a working USB drive.

The toolkit itself does not need to be installed into Windows.

Recommended USB structure:

```text
USB
└── STORAGE_HUB
    └── COMPUTER_TOOLKIT
```

The toolkit can also be placed in another directory if desired, but keeping the supplied structure makes the documentation and launcher easier to follow.

---

# 2. Obtain the Optional Third-Party Tools

Some excellent diagnostic and recovery utilities cannot legally be redistributed inside this repository.

Therefore, this project **does not bundle those third-party binaries**.

Instead, obtain them directly from their official publishers.

## Microsoft Sysinternals Suite

Official Microsoft source:

https://learn.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite

Download the **Sysinternals Suite**.

The toolkit's approved Sysinternals tools are:

* Process Explorer
* Autoruns
* Process Monitor
* TCPView
* RAMMap
* Sigcheck

After extracting the Microsoft package, place the approved tools in:

```text
COMPUTER_TOOLKIT
└── 08_PORTABLE_TOOLS
    └── SYSINTERNALS
        ├── Autoruns64.exe
        ├── Procmon64.exe
        ├── procexp64.exe
        ├── RAMMap64.exe
        ├── sigcheck64.exe
        └── tcpview64.exe
```

Keep the original Sysinternals files together unless the toolkit documentation specifically instructs otherwise.

### Important

Do **not** download Sysinternals from third-party download sites.

Use Microsoft's official source.

This repository does not redistribute the Sysinternals binaries.

---

# 3. TestDisk & PhotoRec

For file recovery, obtain TestDisk & PhotoRec directly from CGSecurity:

https://www.cgsecurity.org/

Download the current **Windows 64-bit** portable package.

Do not install it onto the drive from which you are attempting to recover data.

Extract the complete package and place it here:

```text
COMPUTER_TOOLKIT
└── 04_FILE_RECOVERY
    └── TESTDISK_PHOTOREC
        └── testdisk-[version]
```

The package normally contains tools including:

* `testdisk_win.exe`
* `photorec_win.exe`
* `qphotorec_win.exe`
* `fidentify_win.exe`

Keep the TestDisk/PhotoRec files together.

### Critical Recovery Rule

If a drive contains deleted or otherwise endangered files:

**Do not save recovered files back onto that same drive.**

Use a separate destination with enough available storage.

If the drive is physically failing or producing repeated I/O errors, consider creating an image of the drive before attempting filesystem repair.

---

# 4. Run the Toolkit

Once the repository and optional tools are prepared, open PowerShell and run:

```powershell
powershell -ExecutionPolicy Bypass -File ".\RUN_TOOLKIT.ps1"
```

The launcher performs a required-file check before presenting the toolkit menu.

The toolkit includes:

1. System Information
2. Storage Health
3. Memory Diagnostics
4. GPU Diagnostics
5. Network Diagnostics
6. Battery Diagnostics
7. Device Errors
8. Network Triage
9. Windows Repair Assessment
10. Security Assessment
11. Safety Rules
12. Start Here Guide
13. Sysinternals Diagnostic Tools
14. Start New Session
15. Collect Session Reports
16. Toolkit Self-Check

---

# Toolkit Structure

```text
01_SYSTEM_INFO
02_HARDWARE_DIAGNOSTICS
03_NETWORK
04_FILE_RECOVERY
05_WINDOWS_REPAIR
06_BACKUP
07_SECURITY_CHECKS
08_PORTABLE_TOOLS
09_DOCUMENTATION
10_SCRIPTS
SESSIONS
RUN_TOOLKIT.ps1
START_HERE.txt
README.md
LICENSE
```

---

# What Is Already Included

The GitHub repository contains the project's original:

### Diagnostics

* System information collection
* Storage health assessment
* Memory diagnostics
* GPU diagnostics
* Network diagnostics
* Battery diagnostics
* Device-error inspection

### Windows Assessment

* Windows repair assessment
* System File Checker verification
* DISM health assessment
* Security assessment

The repair assessment is deliberately separate from automatic repair.

The toolkit does not blindly run destructive or system-changing commands.

### Backup & Preservation

The project includes workflows for:

* identifying important data
* preserving files
* copying data to a separate destination
* avoiding accidental overwrites
* recording what was preserved

### File Recovery

The repository provides safe recovery guidance and integration instructions for TestDisk/PhotoRec.

### Sessions

Diagnostic reports can be organized into session folders so that information from different computers does not become mixed together.

---

# Safety Model

This toolkit uses three safety levels.

## GREEN — Read-Only / Observation

Normally safe diagnostic activities include:

* system information
* hardware identification
* storage health inspection
* network diagnostics
* device-error inspection
* process inspection
* startup inspection
* security-status inspection
* copying important files to a separate destination

## YELLOW — Stop and Confirm

Examples include:

* changing network settings
* changing startup configuration
* filesystem repair
* changing permissions
* installing software
* mounting unfamiliar filesystems
* deleted-file recovery

Understand the situation and obtain appropriate authorization before proceeding.

## RED — Potentially Destructive

Examples include:

* formatting drives
* deleting partitions
* changing partition tables
* overwriting disks
* reinstalling Windows
* resetting passwords
* bypassing security controls
* disabling security software
* removing encryption
* destructive filesystem operations

These operations are outside the normal novice workflow.

---

# Golden Rule

When helping with a computer:

**OBSERVE → PRESERVE → DIAGNOSE → CONFIRM → REPAIR**

Do not begin by changing things.

First determine:

1. Who owns the computer?
2. Do you have permission to inspect it?
3. What problem was reported?
4. Is important data backed up?
5. What operating system is installed?
6. Which physical storage device contains the data?
7. What does read-only inspection show?

Only then consider changes.

---

# Privacy

Diagnostic reports can contain information about a computer, including:

* computer model
* operating-system information
* storage identifiers
* network information
* installed hardware
* security configuration

Treat generated reports as private.

Do not publish someone else's diagnostic reports without authorization.

Do not store:

* passwords
* authentication codes
* browser sessions
* private keys
* credentials

in the toolkit.

---

# Using the Toolkit on Someone Else's Computer

Only use the toolkit when you are authorized to do so.

Respect:

* the owner's instructions
* organizational policies
* school/library policies
* workplace policies
* security controls
* privacy requirements

Do not use the toolkit to bypass access controls or obtain data you are not authorized to access.

Do not install software or make system changes without appropriate permission.

---

# USB Safety

A toolkit USB may also contain personal storage.

Before performing recovery or disk operations, identify the physical source and destination disks.

Never assume:

```text
C: = Disk 0
D: = Disk 1
```

Drive letters can change.

Always verify the physical disk before performing recovery, repair, imaging, formatting, or other disk operations.

If Windows asks:

> "You need to format the disk before you can use it."

**Cancel. Do not format the drive unless you have deliberately identified the drive and intend to format it.**

---

# Advanced Tools

Some powerful tools are intentionally separated from the normal workflow.

They may be capable of:

* modifying systems
* terminating processes
* suspending processes
* changing identifiers
* deleting data
* installing system components
* performing administrative actions

They should not be treated as ordinary troubleshooting utilities.

The toolkit prioritizes safe diagnostics over maximum capability.

---

# Third-Party Software Policy

This project does not attempt to replace or redistribute third-party software.

When a tool is required or recommended:

1. Use the official publisher.
2. Obtain the current version.
3. Review its license.
4. Keep the software in its supplied package where practical.
5. Do not obtain tools from suspicious download sites.
6. Do not redistribute third-party software through this repository unless its license explicitly permits it.

Third-party software remains subject to its own licenses and terms.

---

# Recommended Preparation

For a more complete emergency USB, consider having:

* this toolkit
* Microsoft Sysinternals
* TestDisk/PhotoRec
* sufficient free USB storage
* a separate backup destination
* access to official Windows recovery media when appropriate
* access to the computer manufacturer's official support resources

For serious failing-drive recovery, a larger separate storage device is strongly recommended.

---

# Linux Rescue Environments

This project does not bundle a Linux rescue operating system.

A Linux rescue environment such as Linux Mint or SystemRescue can be useful for situations where Windows cannot boot or where offline recovery is necessary.

Obtain Linux distributions directly from their official publishers and verify downloaded images when appropriate.

For a multi-boot rescue USB containing multiple operating systems, a tool such as Ventoy may be considered separately.

Installing such tools onto a USB can modify or erase that USB, so always read the documentation and identify the correct target device first.

---

# Troubleshooting Philosophy

A computer problem should be treated as an investigation rather than a list of random fixes.

A useful sequence is:

```text
Problem reported
       ↓
Permission confirmed
       ↓
Important data identified
       ↓
Backup/preservation considered
       ↓
System identified
       ↓
Read-only diagnostics
       ↓
Evidence reviewed
       ↓
Likely cause classified
       ↓
Repair proposed
       ↓
Repair confirmed
       ↓
Repair performed
       ↓
Result verified
       ↓
Session documented
```

This reduces the chance of turning a recoverable problem into a data-loss event.

---

# Intended Users

This project is intended for:

* computer owners
* authorized helpers
* technicians
* students learning computer diagnostics
* people building portable troubleshooting kits
* community computer-support projects

---

# Non-Goals

This project is not intended to be:

* a password-cracking toolkit
* a security-bypass toolkit
* a malware-distribution toolkit
* an unauthorized data-extraction toolkit
* a privacy-invasive monitoring toolkit
* a collection of questionable system cleaners
* a collection of questionable driver-updater utilities

---

# License

Original scripts and documentation in this repository are released under the MIT License.

Third-party software remains under its respective license.

---

# Project Status

This is an evolving practical computer first-aid toolkit.

The project prioritizes:

* safety
* clarity
* portability
* reproducibility
* data preservation
* minimal unnecessary system changes

The objective is not to collect every possible computer utility.

The objective is to provide a **small, understandable, trustworthy first-aid system that someone can carry with them and use responsibly.**

If a procedure is uncertain or potentially destructive:

**STOP. IDENTIFY. CONFIRM. THEN ACT.**
