import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct PrintMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        PrintMacro.self,
    ]
}
