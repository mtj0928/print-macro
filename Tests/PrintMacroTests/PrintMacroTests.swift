import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(PrintMacroMacros)
import PrintMacroMacros

@MainActor
let testMacros: [String: Macro.Type] = [
    "print": PrintMacro.self,
]
#endif

@MainActor
final class PrintMacroTests: XCTestCase {
    func testPrintMacroWithSingleVariable() throws {
        #if canImport(PrintMacroMacros)
        assertMacroExpansion(
            """
            #print(foo)
            """,
            expandedSource: """
            {
                let __macro_local_17temporaryVariablefMu_ = foo
                print(\"\"\"
                    foo: \\(__macro_local_17temporaryVariablefMu_)
                    \"\"\"
                )
            }()
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testPrintMacroWithMultipleVariables() throws {
        #if canImport(PrintMacroMacros)
        assertMacroExpansion(
            """
            #print(foo, bar)
            """,
            expandedSource: """
            {
                let __macro_local_17temporaryVariablefMu_ = foo
                let __macro_local_17temporaryVariablefMu0_ = bar
                print(\"\"\"
                    foo: \\(__macro_local_17temporaryVariablefMu_)
                    bar: \\(__macro_local_17temporaryVariablefMu0_)
                    \"\"\"
                )
            }()
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testPrintMacroWithExpressions() throws {
        #if canImport(PrintMacroMacros)
        assertMacroExpansion(
            """
            #print(a + b, "hello world")
            """,
            expandedSource: """
            {
                let __macro_local_17temporaryVariablefMu_ = a + b
                let __macro_local_17temporaryVariablefMu0_ = "hello world"
                print(\"\"\"
                    a + b: \\(__macro_local_17temporaryVariablefMu_)
                    \"hello world\": \\(__macro_local_17temporaryVariablefMu0_)
                    \"\"\"
                )
            }()
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testPrintMacroWithComplexExpression() throws {
        #if canImport(PrintMacroMacros)
        assertMacroExpansion(
            """
            #print(a + b)
            """,
            expandedSource: """
            {
                let __macro_local_17temporaryVariablefMu_ = a + b
                print(\"\"\"
                    a + b: \\(__macro_local_17temporaryVariablefMu_)
                    \"\"\"
                )
            }()
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testPrintMacroWithFunctionCall() throws {
        #if canImport(PrintMacroMacros)
        assertMacroExpansion(
            """
            #print(foo().description + "456")
            """,
            expandedSource: """
            {
                let __macro_local_17temporaryVariablefMu_ = foo().description + "456"
                print(\"\"\"
                    foo().description + \"456\": \\(__macro_local_17temporaryVariablefMu_)
                    \"\"\"
                )
            }()
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testPrintMacroWithMultipleFunctionCalls() throws {
#if canImport(PrintMacroMacros)
        assertMacroExpansion(
            """
            #print(foo().bar().baz())
            """,
            expandedSource: """
            {
                let __macro_local_17temporaryVariablefMu_ = foo().bar().baz()
                print(\"\"\"
                    foo().bar().baz(): \\(__macro_local_17temporaryVariablefMu_)
                    \"\"\"
                )
            }()
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
}
