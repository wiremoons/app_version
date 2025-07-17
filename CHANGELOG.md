## v0.2.4
- Use `context.temp_allocator` for temporary string builder proc usage. 
- Fix memory leak errors with use of `delete_string` for proc returned cloned strings.
- ensure project version stated matches in `mod.pkg` and `VERSION` files.
- minor adjustments to `README.md` to improve clarity in use instructions.
- fix in `version.odin` as Odin procedure call changed from `info.cpu_name` to `info.cpu.name`.
- Correct spelling for file name: `CHANGELOG.md` (ie was missing 'E').
- Update copyright years stated in `LICENSE` file.

## v0.2.3
- cosmetic update to header comments formatting in source file `version.odin`.
- code checks for memory handling - commented out while `valgrind` checks are used.

## v0.2.2
- add 'build.bat' for Windows users
- fix hostname look up for Windows platform
- improve output when GPU info exists

## v0.2.1
- reformat 'mod.pkg' to valid JSON due to errors with 'opm' cli publish attempts.

## v0.2.0
- add header info to 'main.odin' example usage file.
- add additional comments to 'main.odin' to help with example usage.
- update 'VERSION' file to 'v0.2.0'
- add 'mod.pkg' to support [Odin Package Manager](https://pkg-odin.org/)
- add '-strict-style' to 'build.sh' script.

## v0.1.0
- Initial version created currently tested on macOS (arm64) and Linux aarch64 (RPi4).
