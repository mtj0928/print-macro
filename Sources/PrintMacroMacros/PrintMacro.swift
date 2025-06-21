import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct PrintMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let arguments = node.arguments
        
        guard !arguments.isEmpty else {
            return ""
        }

        let variables = createTemporaryVariables(from: arguments, context: context)
        return generateSwiftCode(variables: variables)
    }
    
    private static func createTemporaryVariables(from arguments: LabeledExprListSyntax, context: some MacroExpansionContext) -> [Variable] {
        arguments.map { argument in
            let variableName = context.makeUniqueName("temporaryVariable")
            return Variable(name: variableName.text, expression: argument.expression)
        }
    }

    private static func generateSwiftCode(variables: [Variable]) -> ExprSyntax {
        """
        {
        \(raw: variables.map({ $0.declarationInSwift() }).map({ "    " + $0 }).joined(separator: "\n"))
            print(\"\"\"
        \(raw: variables.map({ $0.outputInPrint() }).map({ "        " + $0 }).joined(separator: "\n"))
                \"\"\"
            )
        }()
        """
    }
}

private struct Variable {
    var name: String
    var expression: ExprSyntax

    func declarationInSwift() -> String {
        """
        let \(name) = \(expression)
        """
    }

    func outputInPrint() -> String {
        """
        \(expression.description.trimmingCharacters(in: .whitespacesAndNewlines)): \\(\(name))
        """
    }
}
