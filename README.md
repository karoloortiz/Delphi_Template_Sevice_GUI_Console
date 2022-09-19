# Delphi_Template_Sevice_GUI_Console

Template for Delphi application with a clean architecture.

You only need to personalize src/App.
- Choose between 2 templates (you can create your custom applications implementing IServiceAppPort interface):
  - App.HttpServerVersion for http server applications like a rest service
  - App.ThreadVersion for a standards applications 

Features:
Windows service, GUI, console in same application.

- Dependencies:
  - https://github.com/karoloortiz/Delphi_Utils_Library.git
 
- CLONING REPO:
  - git clone https://github.com/karoloortiz/Delphi_Template_Sevice_GUI_Console.git --recurse-submodules

- USAGE:
  - Console mode:
    - run app -> Project.exe --run
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
  
  
  If you need support, add a star to the repository and don't hesitate to contact me at zitrokarol@gmail.com
