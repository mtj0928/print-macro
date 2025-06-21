# Print Macro
A Swift macro that provides enhanced debugging output by displaying expressions with their source code and evaluated values.

## Usage
Import the macro and use it like a regular print statement:

```swift
import PrintMacro

let foo = 123
let bar = "hello"
#print(foo, bar)
```

**Output:**
```
foo: 123
bar: hello
```

## Requirements
- Swift 6.0+

## Installation
Add this package to your Swift project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/mtj0928/print-macro", from: "0.0.1")
],
targets: [
    .target(name: "YOUR_TARGETS", dependencies: [
      .product(name: "PrintMacro", package: "print-macro")
    ]),
]
```
