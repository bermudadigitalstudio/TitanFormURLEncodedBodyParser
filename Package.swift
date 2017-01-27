import PackageDescription

let package = Package(
    name: "TitanFormURLEncodedBodyParser",
    dependencies: [
      .Package(url: "https://github.com/bermudadigitalstudio/TitanCore.git", majorVersion: 0, minor: 3)
    ]
)
