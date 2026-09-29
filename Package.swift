// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-array",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [

        .library(name: "Array Primitive", targets: ["Array Primitive"]),

        .library(name: "Array Protocol", targets: ["Array Protocol"]),

        .library(name: "Array Small Primitive", targets: ["Array Small Primitive"]),

        .library(name: "Array", targets: ["Array"]),

        .library(name: "Array Test Support", targets: ["Array Test Support"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-store.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-span.git",
            branch: "main", traits: ["Iterator"]),
        .package(
            url: "https://github.com/swift-atoms/swift-standard-library-extensions.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-collection.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-sequence.git",
            branch: "main"
        ),

        .package(
            url: "https://github.com/swift-atoms/swift-buffer.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-buffer-linear.git",
            branch: "main"
        ),

        .package(
            url: "https://github.com/swift-atoms/swift-storage.git",
            branch: "main", traits: ["Memory"]),
        .package(
            url: "https://github.com/swift-atoms/swift-iterator.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-memory.git",
            branch: "main"
        ),

        .package(
            url: "https://github.com/swift-molecules/swift-ownership-shared.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-allocation.git",
            branch: "main", traits: ["MemorySmall", "MemoryAllocatorArena", "MemoryInline"]),
    ],
    targets: [

        .target(
            name: "Array Primitive",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Buffer", package: "swift-buffer"),
                .product(
                    name: "Buffer Linear Primitive",
                    package: "swift-buffer-linear"
                ),
                .product(name: "Store", package: "swift-store"),
                .product(
                    name: "Ownership Shared Primitive",
                    package: "swift-ownership-shared"
                ),
                .product(name: "Storage", package: "swift-storage"),
                .product(name: "Memory", package: "swift-memory"),
                .product(
                    name: "Memory Allocator",
                    package: "swift-memory-allocation"
                ),
                .product(
                    name: "Memory Allocator Protocol",
                    package: "swift-memory-allocation"
                ),
                .product(name: "Index", package: "swift-index"),
            ]
        ),

        .target(
            name: "Array Protocol",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                "Array Primitive",
                .product(name: "Collection", package: "swift-collection"),
                .product(name: "Index", package: "swift-index"),
            ]
        ),

        .target(
            name: "Array Small Primitive",
            dependencies: [
                "Array Primitive",
                .product(name: "Buffer", package: "swift-buffer"),
                .product(
                    name: "Buffer Linear Primitive",
                    package: "swift-buffer-linear"
                ),
                .product(name: "Store", package: "swift-store"),
                .product(name: "Storage", package: "swift-storage"),
                .product(
                    name: "Memory Allocator",
                    package: "swift-memory-allocation"
                ),
                .product(name: "Memory Small", package: "swift-memory-allocation"),
            ]
        ),

        .target(
            name: "Array",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
                "Array Primitive",
                "Array Protocol",
                .product(name: "Store", package: "swift-store"),
                .product(
                    name: "Ownership Shared Primitive",
                    package: "swift-ownership-shared"
                ),
                .product(
                    name: "Memory Allocator",
                    package: "swift-memory-allocation"
                ),
                .product(
                    name: "Memory Allocator Protocol",
                    package: "swift-memory-allocation"
                ),
                .product(name: "Buffer", package: "swift-buffer"),
                .product(name: "Span", package: "swift-span"),
                .product(name: "Storage", package: "swift-storage"),
                .product(name: "Memory", package: "swift-memory"),
                .product(
                    name: "Buffer Linear",
                    package: "swift-buffer-linear"
                ),
                .product(
                    name: "Buffer Linear Primitive",
                    package: "swift-buffer-linear"
                ),
                .product(name: "Collection", package: "swift-collection"),
                .product(name: "Index", package: "swift-index"),
                .product(name: "Sequence", package: "swift-sequence"),
                .product(name: "Iterator", package: "swift-iterator"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(
                    name: "Standard Library Extensions",
                    package: "swift-standard-library-extensions"
                ),
            ]
        ),

        .target(
            name: "Array Test Support",
            dependencies: [
                "Array",
                .product(
                    name: "Buffer Test Support",
                    package: "swift-buffer"
                ),
                .product(name: "Ordinal Test Support", package: "swift-ordinal"),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Array Tests",
            dependencies: [
                "Array",
                "Array Test Support",
                .product(
                    name: "Tagged",
                    package: "swift-tagged"
                ),
                .product(
                    name: "Ordinal",
                    package: "swift-ordinal"
                ),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
