/// A macro that prints expressions with their source code and evaluated values.
/// 
/// For example:
/// 
/// ```swift
/// let foo = 123
/// let bar = "hello"
/// #print(foo, bar + " world")
/// ```
///
/// produces output:
///
/// ```
/// foo: 123
/// bar + " world": hello world
/// ```
@freestanding(expression)
public macro print(_ values: Any...) = #externalMacro(module: "PrintMacroMacros", type: "PrintMacro")
