# Computer First-Aid Toolkit

A portable, safety-first toolkit for diagnosing, preserving, recovering, and repairing Windows computers without unnecessary changes.

## Purpose

This project provides reusable scripts, documentation, workflows, and guidance for computer first-aid.

Core workflow:

OBSERVE -> PRESERVE -> DIAGNOSE -> CONFIRM -> REPAIR

The default approach is read-only inspection first, followed by careful preservation and confirmation before making changes.

## What It Includes

- System information collection
- Hardware diagnostics
- Storage health inspection
- Network diagnostics
- File recovery guidance
- Windows repair assessment
- Backup and data-preservation tools
- Security assessment
- Portable-tool guidance
- Session management
- Operator checklists
- Safety documentation
- PowerShell automation

## Safety

This toolkit is intended for legitimate troubleshooting and authorized computer support.

It does not provide instructions for bypassing passwords, BitLocker, administrator restrictions, BIOS/UEFI security, or other security controls.

Do not access, copy, recover, or disclose another person's private data without authorization.

Do not perform destructive operations without identifying the correct device, understanding the consequences, and obtaining appropriate permission.

## Toolkit Structure

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

## Third-Party Tools

Third-party utilities are intentionally not redistributed in this repository when their licenses or distribution terms do not permit redistribution.

Where appropriate, documentation explains how to obtain tools directly from their official sources.

Examples include Microsoft Sysinternals and CGSecurity TestDisk/PhotoRec.

## USB Use

The toolkit can be copied to a USB drive and used as a portable computer-support collection.

Users should obtain Linux distributions and third-party software directly from their official publishers.

Do not format an existing toolkit USB simply because Windows asks to format an unfamiliar filesystem.

## Recovery

File recovery should prioritize preservation.

Do not install recovery software onto the affected drive and do not save recovered files back onto the affected drive.

For drives showing physical failure or repeated I/O errors, consider imaging the drive before filesystem repair.

## Sessions

The toolkit can create session folders for keeping diagnostic reports, notes, and related records together.

Reports may contain identifying information about a computer. Treat them as private and do not publish them without appropriate authorization.

## Intended Users

- Computer owners
- Authorized helpers
- Technicians
- Students learning computer diagnostics
- People building their own portable troubleshooting toolkit

## Non-Goals

This is not intended to be a password-cracking, security-bypass, malware-distribution, or unauthorized data-extraction toolkit.

It is also not intended to be a collection of random system cleaners or driver-updater utilities.

## License

Original scripts and documentation in this project are released under the MIT License.

Third-party software remains subject to its own licenses and distribution terms.

## Status

This is an evolving practical toolkit. Safety, clarity, portability, and reproducibility are prioritized over collecting the largest possible number of utilities.

If a procedure is uncertain or potentially destructive, stop, identify the system and data involved, and confirm before proceeding.
