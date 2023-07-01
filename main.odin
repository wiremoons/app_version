/*
    EXAMPLE : basic Odin source to show example usage of 'app_version' package.

    Author:  Simon Rowe <simon@wiremoons.com>
    License: MIT
    File:    main.odin

    Source:  https://www.github.com/wiremoons/app_version
*/

// See the 'README.md' for addtional help and steps for 'app_version' package usage.

package app_version

// When using in your own project include the following to import the 'app_version' package:
// import "app_version"

main :: proc () {
 // call the 'app_version' procedure. In your own projects code will be:  app_version.version_show()
 version_show()
}