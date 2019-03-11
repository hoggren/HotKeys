# Hot Keys

## For AutoHotKey 1.*

### Usage and install

`. "$env:ProgramFiles\AutoHotkey\Compiler\Ahk2Exe.exe" /in .\hotkeys.ahk /out .\hotkeys.exe /icon .\icon.ico`

This small application adds some shortcuts that is crafted just for me, pick and modify whatever you like - but as always, no warranty!

#### Shortcuts and mappings

- `Right WIN` - Mapped for nothing, disables right Windows-button
- `Ctrl-Shift-4` - Open Windows legacy Snipping Tool
- `WIN-U` - Prints a random UUID/GUID
- `WIN-S` - Search Stack Overflow with your selected text
- `WIN-G` - Search Google with your selected text
- `WIN+0` - Prints a datetime stamp (yyyyMMdd-HHmm)
- `WIN+Esc` - Disable the exit button in active windows title bar

There are some keyboard/computer specific shortcuts - but I doubt you get anything out of them.

#### Requirements

- Autohotkey 1.x <https://www.autohotkey.com/>

Compile as you like. I run it in powershell, sets a fancy icon from Windows and put it in Startup (`WIN+R` `shell:startup`).

##### Author

Patrik Höggren
p@hoggren.nu
