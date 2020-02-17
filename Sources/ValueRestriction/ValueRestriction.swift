import Foundation

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

    public func applied(to value: Value) -> Value? {
        switch self {

        case .unrestricted:
            return value

        case let .equalToOneOf(values):
            for other in values {
                if value == other { return value }
            }
            return nil

        case let .notEqualToAnyOf(values):
            for other in values {
                if value == other { return nil }
            }
            return value

        case let .smallerThan(other):
            return value < other ? value : nil

        case let .smallerThanOrEqualTo(other):
            return value <= other ? value : nil

        case let .largerThan(other):
            return value > other ? value : nil

        case let .largerThanOrEqualTo(other):
            return value >= other ? value : nil

        case let .inOpenRange(range):
            return range.lowerBound < value && value < range.upperBound ? value : nil

        case let .inOpenClosedRange(range):
            return range.lowerBound < value && value <= range.upperBound ? value : nil

        case let .inClosedOpenRange(range):
            return range.lowerBound <= value && value < range.upperBound ? value : nil

        case let .inClosedRange(range):
            return range.lowerBound <= value && value <= range.upperBound ? value : nil

        }
    }

    public var isUnrestricted: Bool {
        switch self {
        case .unrestricted:
            return true
        default:
            return false
        }
    }

    public var argumentOfEqualToOneOf: [Value]? {
        guard case let .equalToOneOf(v) = self else { return nil }
        return v
    }

    public var argumentOfNotEqualToAnyOf: [Value]? {
        guard case let .notEqualToAnyOf(v) = self else { return nil }
        return v
    }

    public var argumentOfSmallerThan: Value? {
        guard case let .smallerThan(v) = self else { return nil }
        return v
    }

    public var argumentOfSmallerThanOrEqualTo: Value? {
        guard case let .smallerThanOrEqualTo(v) = self else { return nil }
        return v
    }

    public var argumentOfLargerThan: Value? {
        guard case let .largerThan(v) = self else { return nil }
        return v
    }

    public var argumentOfLargerThanOrEqualTo: Value? {
        guard case let .largerThanOrEqualTo(v) = self else { return nil }
        return v
    }

    public var argumentOfInOpenRange: ClosedRange<Value>? {
        guard case let .inOpenRange(r) = self else { return nil }
        return r
    }

    public var argumentOfInOpenClosedRange: ClosedRange<Value>? {
        guard case let .inOpenClosedRange(r) = self else { return nil }
        return r
    }

    public var argumentOfInClosedOpenRange: ClosedRange<Value>? {
        guard case let .inClosedOpenRange(r) = self else { return nil }
        return r
    }

    public var argumentOfInClosedRange: ClosedRange<Value>? {
        guard case let .inClosedRange(r) = self else { return nil }
        return r
    }

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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {

        case .unrestricted:
            break // equivalent to encoding null

        case let .equalToOneOf(values):
            try container.encode(values, forKey: .equalToOneOf)

        case let .notEqualToAnyOf(values):
            try container.encode(values, forKey: .notEqualToAnyOf)

        case let .smallerThan(value):
            try container.encode(value, forKey: .smallerThan)

        case let .smallerThanOrEqualTo(value):
            try container.encode(value, forKey: .smallerThanOrEqualTo)

        case let .largerThan(value):
            try container.encode(value, forKey: .largerThan)

        case let .largerThanOrEqualTo(value):
            try container.encode(value, forKey: .largerThanOrEqualTo)

        case let .inOpenRange(value):
            try container.encode([value.lowerBound, value.upperBound], forKey: .inOpenRange)

        case let .inOpenClosedRange(value):
            try container.encode([value.lowerBound, value.upperBound], forKey: .inOpenClosedRange)

        case let .inClosedOpenRange(value):
            try container.encode([value.lowerBound, value.upperBound], forKey: .inClosedOpenRange)

        case let .inClosedRange(value):
            try container.encode([value.lowerBound, value.upperBound], forKey: .inClosedRange)

        }
    }

    // Todo: Ugly code... must find a better way!
    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            let values =  try container.decode([Value].self, forKey: .equalToOneOf)
            self = .equalToOneOf(values)
        } catch {
        do {
            let values =  try container.decode([Value].self, forKey: .notEqualToAnyOf)
            self = .notEqualToAnyOf(values)
        } catch {
        do {
            let value =  try container.decode(Value.self, forKey: .smallerThan)
            self = .smallerThan(value)
        } catch {
        do {
            let value =  try container.decode(Value.self, forKey: .smallerThanOrEqualTo)
            self = .smallerThanOrEqualTo(value)
        } catch {
        do {
            let value =  try container.decode(Value.self, forKey: .largerThan)
            self = .largerThan(value)
        } catch {
        do {
            let value =  try container.decode(Value.self, forKey: .largerThanOrEqualTo)
            self = .largerThanOrEqualTo(value)
        } catch {
        do {
            let values =  try container.decode([Value].self, forKey: .inOpenRange)
            guard values.count == 2 else { fatalError() }
            self = .inOpenRange(values[0]...values[1])
        } catch {
        do {
            let values =  try container.decode([Value].self, forKey: .inOpenClosedRange)
            guard values.count == 2 else { fatalError() }
            self = .inOpenClosedRange(values[0]...values[1])
        } catch {
        do {
            let values =  try container.decode([Value].self, forKey: .inClosedOpenRange)
            guard values.count == 2 else { fatalError() }
            self = .inClosedOpenRange(values[0]...values[1])
        } catch {
        do {
            let values =  try container.decode([Value].self, forKey: .inClosedRange)
            guard values.count == 2 else { fatalError() }
            self = .inClosedRange(values[0]...values[1])
        } catch {
            self = .unrestricted // equivalent to null
        } } } } } } } } } }

    }

}
