# Delphi_Template_Sevice_GUI_Console

Template for Delphi applications
Windows service, GUI, console in same application.

- Dependencies:
  - https://github.com/karoloortiz/Delphi_Utils_Library.git
 
- CLONING REPO:
  - git clone https://github.com/karoloortiz/Delphi_Template_Sevice_GUI_Console.git --recurse-submodules

- USAGE:
  - Console mode:
    - install service -> Project.exe --install [service_name] [--silent]
    - uninstall service ->  Project.exe --uninstall [service_name] [--silent]
    - print help >  Project.exe --help or Project.exe -h
  - GUI mode:
    - just open the exe
  - Windows service mode:
    - install service with gui mode or console mode

- INFO
  - support for Windows Event Viewer
  - support services with custom names
  - support custom service params
  - you can use the application in GUI mode, console mode or as windows service
