# Storage UI

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

A powerful and user-friendly library for managing saved key-value pairs in Flutter, built on top
of "get_storage" and "flutter_secure_storage".

## Features

- Easily manage, edit, and delete saved key-value pairs
- Copy and preview keys with a simple GUI
- Customizable look and feel through the PageStyle object
- Built-in error handling through the onError callback

![alt text](https://github.com/AmrSaied/storage_ui/blob/main/Screenshot.png?raw=true)

## Installation

To use this library, add "storage_ui" as a dependency in your pubspec.yaml file:

```sh
dependencies:
  storage_ui: ^1.0.0
```

- Import the package in your dart file where you want to use it by adding the following line at the
  top of the file:

```sh
import 'package:storage_ui/storage_ui.dart';
```

## Usage

To use the library, import it and create a "CacheStorageLogPage" widget,
passing in your "GetStorage" instance and any desired PageStyle customization.
You can also provide an onError callback to handle any errors that may occur.

- To route to the Storage UI view:
```sh
     Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CacheStorageLogPage(
        cacheStorage: GetStorage(),
        pageStyle: PageStyle(
          appBarColor: Colors.blue,
          backgroundCursorColor: Colors.black26,
          confirmColor: Colors.green,
          cursorColor: Colors.black,
          textColor: Colors.black,
        ),
        onError: (message) {
          print(message);
        },
      )),
          );
```

- Example for View:

```sh
CacheStorageLogPage(
        cacheStorage: GetStorage(),
        pageStyle: PageStyle(
          appBarColor: Colors.blue,
          backgroundCursorColor: Colors.black26,
          confirmColor: Colors.green,
          cursorColor: Colors.black,
          textColor: Colors.black,
        ),
        onError: (message) {
          print(message);
        },
      )
```

## Example

To see a working example of this library, check out the example folder in the repository.


## Issues

If you encounter any issues while using the package, please file a bug report
in [the GitHub issue tracker].

## Contributing

If you would like to contribute to the package, please read the [contributing guidelines] before
submitting a pull request.


## Support

For further support or if you have any questions, please reach out to the library maintainer or the community through  [the GitHub issue tracker]

## CacheStorageLogPage Parameters

| Parameters | Usaged                                                                                                                                                                                                                                                                  |
| ------ |-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| cacheStorage | This is the required GetStorage instance you are using in your project, it is used to get the saved key-value pairs from it.                                                                                                                                            |
| pageStyle | This is an optional parameter, that accepts a PageStyle object which customize the look and feel of the page, you can customize the color of the appbar, background cursor, confirm button, cursor and text color.                                                      |
| onError  | This is an optional callback function that is triggered when an error occurs. It takes a String message as a parameter, which is the error message.                                                                                                                                                                                                                                                                        |

**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

[Example]: <https://github.com/AmrSaied/storage_ui>

[the GitHub issue tracker]: <https://github.com/AmrSaied/storage_ui/issues>

[contributing guidelines]: <https://github.com/AmrSaied/storage_ui/blob/main/Contributing.md>

   
   

