/*
			Package generates and optionally displays version information for an application.
			Created: Mon 29 May 2023
			Copyright (c) 2023 Simon Rowe.
			MIT License.
			Source code: https://github.com/wiremoons/app_version.git
      Version: see projects 'VERSION' file.
*/

package app_version

import "core:fmt"
import "core:os"
import "core:path/filepath"
import "core:sys/info"
import "core:strings"

// To provide the compiled date and time use a '-define:' when building the application
// The shell `date` format can be changed as required.
// If no '-define:' is used then "UNKNOWN" will be used instead.
// Example build command on Unix / macOS systems is:
//  odin build . -define:BUILDTS="$(date '+%a %d %b %Y @ %H:%M:%S %Z')"
BUILD_TIME :: #config(BUILDTS, "UNKNOWN")

// Load the contents of the 'app_version' package file named: VERSION
// Change the contents of this file to define the version number displayed.
load_package_VERSION := #load("VERSION", string) or_else ""
//NOTE(Simon): assumes this package is in a sub directory one below ODIN_BUILD_PROJECT_NAME
load_application_VERSION := #load("../VERSION", string) or_else ""

/*
		PUBLIC PROCEDURES
*/

// Build the version output using a string buffer constructed from the private procedures
// in this package. Return a cloned string before the string buffer is destroyed.
// Example output:
//		'app_version' is version 'v0.1.0' built in 'Release' mode.
//		Built on: 'Wed 14 Jun 2023 @ 21:19:50 BST' with Odin compiler: 'dev-2023-06'.
//		Executing on computer 'borrmoons' with 'macOS Unknown (build 22F66, kernel 22.5.0)'.
//		System information: [ RAM: 8192Gb | CPU: ARM64 | Cores: 8 ].

version_string :: proc() -> string {
	sb := strings.builder_make()
	defer strings.builder_destroy(&sb)
	strings.write_string(&sb, "\n'")
	strings.write_string(&sb, application_name())
	strings.write_string(&sb, "' is version '")
	strings.write_string(&sb, application_version())
	strings.write_string(&sb, "' built in '")
	strings.write_string(&sb, build_kind())
	strings.write_string(&sb, "' mode.\n")
	strings.write_string(&sb, "Built on: '")
	strings.write_string(&sb, BUILD_TIME)
	strings.write_string(&sb, "' with Odin compiler: '")
	strings.write_string(&sb, ODIN_VERSION)
	strings.write_string(&sb, "'.\n")
	strings.write_string(&sb, "Executing on computer '")
	strings.write_string(&sb, hostname())
	strings.write_string(&sb, "' with '")
	strings.write_string(&sb, os_info())
	strings.write_string(&sb, "'.\n")
	strings.write_string(&sb, system_summary())
	strings.write_string(&sb, ".\n")
	return strings.clone(strings.to_string(sb))
}

// Print out a copy of the version string constructed by 'version_string' proc.
version_show :: proc() {
	fmt.print(version_string())
}

/*
		PRIVATE PROCEDURES BELOW
*/

// Identify a application version to use.
// Chosen in order of preference via the `switch` below as the first match will be used.
// If there was no entries provided at compile time in the 'VERSION' file then use "UNKNOWN"
@(private)
application_version :: proc() -> string {
	switch {
	case len(load_application_VERSION) > 0:
		return load_application_VERSION
	case len(load_package_VERSION) > 0:
		return load_package_VERSION
	case:
		return "UNKNOWN"
	}
}

// Returns the Odin Operating System (OS) version data.
@(private)
os_info :: proc() -> string {
	return info.os_version.as_string
}

// Returns the Odin Operating System (OS) CPU core count.
@(private)
cpu_cores :: proc() -> int {
	return os.processor_core_count()
}

// Returns the Odin System Information (sys/info) computer memory total.
@(private)
sys_ram :: proc() -> int {
	return info.ram.total_ram / 1024 / 1024
}

// Returns the Odin System Information (sys/info) computer CPU architecture name.
@(private)
cpu_kind :: proc() -> string {
	return info.cpu_name.? or_else "UNKNOWN"
}

// Returns the Odin Operating System (OS) command line arguments extracted application name.
@(private)
application_name :: proc() -> string {
	app_name := os.args[0]
	if len(app_name) < 1 {
		return ""
	}
	return filepath.base(app_name)
}

// Returns the Odin compiler build type performed when the application was created.
@(private)
build_kind :: proc() -> string {
	return ODIN_DEBUG ? "Debug" : "Release"
}

// Returns the computers hostname obtained from the environment variable 'HOSTNAME'
// Checks if any hostname ends with '.local' and removes it - as occurs on macOS.
// If the environment does not contain 'HOSTNAME' then return "UNKNOWN"
@(private)
hostname :: proc() -> string {
	when ODIN_OS == .Windows {
		host_id, ok := os.lookup_env("COMPUTERNAME")
		if !ok do return "UNKNOWN"
		idx := strings.index(host_id, ".local")
		if idx == -1 do return host_id
		return strings.cut(host_id, 0, idx)
	} else {
		host_id, ok := os.lookup_env("HOSTNAME")
		if !ok do return "UNKNOWN"
		idx := strings.index(host_id, ".local")
		if idx == -1 do return host_id
		return strings.cut(host_id, 0, idx)
	}
}

// Returns a string built from various Odin system information procedures.
// Include any GPU data if it also exists.
@(private)
system_summary :: proc() -> string {
	sb := strings.builder_make()
	defer strings.builder_destroy(&sb)
	strings.write_string(&sb, "System information: ")
	strings.write_string(&sb, "[ RAM: ")
	strings.write_int(&sb, sys_ram())
	strings.write_string(&sb, "Gb | CPU: ")
	strings.write_string(&sb, cpu_kind())
	strings.write_string(&sb, " | Cores: ")
	strings.write_int(&sb, cpu_cores())
	// include any GPU info if available
	for gpu, i in info.gpus {
		strings.write_string(&sb, "\n                    [ ")
		strings.write_string(&sb,"GPU #")
		strings.write_int(&sb, i)
		strings.write_string(&sb, ": ")
		strings.write_string(&sb, gpu.vendor_name)
		strings.write_string(&sb, " model : '")
		strings.write_string(&sb, gpu.model_name)
		strings.write_string(&sb, "' RAM '")
    		strings.write_int(&sb, gpu.total_ram / 1024 / 1024)
		strings.write_string(&sb, "'")
		strings.write_string(&sb, " ]")
	}
	return strings.clone(strings.to_string(sb))
}
