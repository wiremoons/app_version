# app_version
Odin package to generate and display application version information for command line applications.

## Example output

Below is an example of `app_version` output when run on *macOS*:
```
'app_version' is version 'v0.1.0' built in 'Release' mode.
Built on: 'Sun 11 Jun 2023 @ 19:09:40 BST' with Odin compiler: 'dev-2023-06'.
Executing on computer 'borrmoons' with 'macOS Unknown (build 22F66, kernel 22.5.0)'.
System information: [ RAM: 8192Gb | CPU: ARM64 | Cores: 8 ].
```

## How to include this package in your Odin project

The inclusion of `app_version` in you own project is easily performed by just adding the code from this repo to you own project. The `app_version` code is a *Odin package* to be used by your main program. The recommended approach is to add `app_version` as a [Git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules). The purpose of *submodules* is to let one project clone another different Git repository into that project, and still keep the commits separate.

This will give the flexibility to allow the *Git* commits for your own project to be separate from those in the `app_version` package. The `app_version` package can still be updated independently as needed with a `git pull` if required. The installation instructions below include the commands to add `app_version` as a *submodule* to you own project.

The approach makes adding *Odin* packages to a existing project very simple and easy to manage. See the *Odin* [packages](https://odin-lang.org/docs/overview/#packages) document for more details.

## Installation

The instructions below assume you are already developing *Odin* programs, and have a working *Odin* compiler installation. Further help with *Odin* can be found here: https://odin-lang.org/


**NOTE:** The process below will add a new directory to your existing *Odin* project called: `app_version`. If you already have an existing package in your own project using that name, you will need to clone this package into a different folder - so as not to overwrite your existing package code.

From a command prompt:

1. Change directory if needed, to ensure you are in the root of your own *Odin* project.
2. Add this *Odin* `app_version` package as a *Git submodule* to your own project: `git submodule add https://github.com/wiremoons/app_version.git app_version`
3. Update the text file named: `VERSION` in the `app_package` directory, or create your own `VERSION` file in the root of your own project. Add your current applications version, for example: `v1.2.5`. Any text of a reasonable size can be used as the version number for your application by adding it to this `VERSION` file on the first line.
4. In you own *Odin* project source code import the `app_version` package: `import "app_version"`
5. To display the version output for your application use the procedure: `app_version.version_show()`
6. When you build or run you own application include the extra `-define:` parameter to ensure the compile date stamp is captured: `odin build . -define:BUILDTS="$(date '+%a %d %b %Y @ %H:%M:%S %Z')"` or `odin run . -define:BUILDTS="$(date '+%a %d %b %Y @ %H:%M:%S %Z')"`.  The `date` shell command can be adjusted to suit your own date formatting preferences in required.

For additional help, see the `build.sh` and `main.odin` files included in the `app_version` package which can be used as examples of the steps 3-6 described above.

## License

The source code is provided with a *MIT* license, a copy of which is available here: [MIT License](./LICENSE).
