# ValueRestriction
![](https://img.shields.io/badge/platforms-iOS%2010%20%7C%20tvOS%2010%20%7C%20watchOS%204%20%7C%20macOS%2010.14-red)
[![Xcode](https://img.shields.io/badge/Xcode-11-blueviolet.svg)](https://developer.apple.com/xcode)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/wltrup/ValueRestriction)
![GitHub](https://img.shields.io/github/license/wltrup/ValueRestriction)

## What

**ValueRestriction** is a Swift Package Manager package for iOS/tvOS (10.0 and above), watchOS (4.0 and above), and macOS (10.14 and above), under Swift 5.0 and above,  defining an enumeration to easily test a numerical value against some condition:
```swift
public enum ValueRestriction<Value> where Value: Comparable {

    case unrestricted

    case equalToOneOf([Value])
    case notEqualToAnyOf([Value])

    case smallerThan(Value)
    case smallerThanOrEqualTo(Value)

    case largerThan(Value)
    case largerThanOrEqualTo(Value)

    case inOpenRange(ClosedRange<Value>)
    case inOpenClosedRange(ClosedRange<Value>)
    case inClosedOpenRange(ClosedRange<Value>)
    case inClosedRange(ClosedRange<Value>)

}

extension ValueRestriction {

    public func applied(to value: Value) -> Value?

    public var isUnrestricted: Bool
    public var argumentOfEqualToOneOf: [Value]?
    public var argumentOfNotEqualToAnyOf: [Value]?
    public var argumentOfSmallerThan: Value?
    public var argumentOfSmallerThanOrEqualTo: Value?
    public var argumentOfLargerThan: Value?
    public var argumentOfLargerThanOrEqualTo: Value?
    public var argumentOfInOpenRange: ClosedRange<Value>?
    public var argumentOfInOpenClosedRange: ClosedRange<Value>?
    public var argumentOfInClosedOpenRange: ClosedRange<Value>?
    public var argumentOfInClosedRange: ClosedRange<Value>?

}

extension ValueRestriction: Equatable where Value: Equatable {}
extension ValueRestriction: Hashable where Value: Hashable {}

extension ValueRestriction: Codable where Value: Codable {

    enum CodingKeys: String, CodingKey, CaseIterable {
        case unrestricted
        case equalToOneOf
        case notEqualToAnyOf
        case smallerThan
        case smallerThanOrEqualTo
        case largerThan
        case largerThanOrEqualTo
        case inOpenRange
        case inOpenClosedRange
        case inClosedOpenRange
        case inClosedRange
    }

    public func encode(to encoder: Encoder) throws 
    public init(from decoder: Decoder) throws 

}
```

## Installation

**ValueRestriction** is provided only as a Swift Package Manager package, because I'm moving away from CocoaPods and Carthage, and can be easily installed directly from Xcode.

## Author

Wagner Truppel, trupwl@gmail.com

## License

**ValueRestriction** is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
