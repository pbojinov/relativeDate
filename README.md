angular-relativeDate
---

> ```relativeDate``` is an Angular.js service for replacing iso-formated, date-time stamps with relative time labels.

## Example

Turn this ISO timestamp

	Mon, 16 Jun 2014 17:00:00 -0700

into this: `6 minutes ago`, `just now`, `yesterday`


## Usage

Declare ```relativeDate``` as a dependency of your module

    angular.module("myApp",["relativeDate"])

Now you may inject the included service, ```relativeDate``` into your controllers and directives.

```relativeDate``` has one method, ```set``` which takes the following parameters.

1. *(required)* the datetime stamp to be used.
2. *(optional)* a format string to override the default. (more on this later)

Example

    var relativeTime = relativeDate.set(isoTime);
    
## About the Fork

relativeDate was not working for me when inside of a filter, so I removed the callback and interval check to make it sync.