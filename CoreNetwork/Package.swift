// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreNetwork",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CoreNetwork",
            targets: ["CoreNetwork"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.6.4")
        
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CoreNetwork",
            dependencies: [.product(name: "Alamofire", package: "Alamofire")]),
        .testTarget(
            name: "CoreNetworkTests",
            dependencies: ["CoreNetwork"]),
    ]
)
