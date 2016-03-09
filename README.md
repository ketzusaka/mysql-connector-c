# mysql-connector-c

This library is the MySQL client library (version 6.1.6), built for iOS and Mac. The original source code built pretty easily on Mac, but there were various small tweaks to get it running on iOS, so I'm sharing it! This library has i386, x86_64, armv7, and arm64 architectures built into it.

You can read all about the C api provided at [the MySQL documentation site](http://dev.mysql.com/doc/refman/5.7/en/c-api.html)

## Installation

mysql-connector-c can be installed using CocoaPods. Add the following declaration into your Podfile:

```ruby
pod ‘mysql-connector-c’, ‘~> 2.0’
```

You can also copy the files from the Sources directory into your project if you’re not using CocoaPods.

## Sample Project

Under Project Files there is a sample project demonstrating the libraries use. Most of the details you'll want are on the MySQL documenation site, though. 

The sample project simply lists the tables within a database. Update the #define statements at the top of ViewController.m to point to a database you have access to in order to see the results.
