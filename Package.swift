// swift-tools-version: 6.0
import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "print-macro",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(name: "PrintMacro", targets: ["PrintMacro"]),
        .executable(
            name: "PrintMacroClient",
            targets: ["PrintMacroClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest"),
    ],
    targets: [
        .macro(
            name: "PrintMacroMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(name: "PrintMacro", dependencies: ["PrintMacroMacros"]),
        .executableTarget(name: "PrintMacroClient", dependencies: ["PrintMacro"]),

        .testTarget(
            name: "PrintMacroTests",
            dependencies: [
                "PrintMacroMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
