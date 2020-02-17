import XCTest
@testable import ValueRestriction

final class ValueRestrictionTests: XCTestCase {

    func allcases() -> [ValueRestriction<Int>] {
        let vs = [10,20,30,40,50,60]
        var res: [ValueRestriction<Int>] = [.unrestricted]
        res.append(.equalToOneOf(vs))
        res.append(.notEqualToAnyOf(vs))
        res.append(.smallerThan(vs[0]))
        res.append(.smallerThanOrEqualTo(vs[0]))
        res.append(.largerThan(vs[0]))
        res.append(.largerThanOrEqualTo(vs[0]))
        res.append(.inOpenRange(vs[0]...vs[1]))
        res.append(.inOpenClosedRange(vs[0]...vs[1]))
        res.append(.inClosedOpenRange(vs[0]...vs[1]))
        res.append(.inClosedRange(vs[0]...vs[1]))
        return res
    }

    func test_applied_unrestricted() {
        let x = Int.random(in: 1 ... 5)
        let exp = x
        let res = ValueRestriction.unrestricted.applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    // === //

    func test_applied_equalToOneOf() {
        let vs = (0 ... Int.random(in: 0 ... 5)).map { _ in Int.random(in: 1 ... 5) }
        let x = vs.randomElement() ?? Int.random(in: 1 ... 5)
        let exp = x
        let res = ValueRestriction.equalToOneOf(vs).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_equalToOneOf_nil() {
        let vs = (0 ... Int.random(in: 0 ... 5)).map { _ in Int.random(in: 1 ... 5) }
        let x = Int.random(in: 6 ... 10)
        let exp: Int? = nil
        let res = ValueRestriction.equalToOneOf(vs).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    // === //

    func test_applied_notEqualToAnyOf() {
        let vs = (0 ... Int.random(in: 0 ... 5)).map { _ in Int.random(in: 1 ... 5) }
        let x = Int.random(in: 6 ... 10)
        let exp = x
        let res = ValueRestriction.notEqualToAnyOf(vs).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_notEqualToAnyOf_nil() {
        let vs = (0 ... Int.random(in: 0 ... 5)).map { _ in Int.random(in: 1 ... 5) }
        let x = vs.randomElement() ?? Int.random(in: 1 ... 5)
        let exp: Int? = vs.isEmpty ? x : nil
        let res = ValueRestriction.notEqualToAnyOf(vs).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    // === //

    func test_applied_smallerThan() {
        let v = Int.random(in: 1 ... 5)
        let x = v / 2
        let exp = x
        let res = ValueRestriction.smallerThan(v).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_smallerThan_nil() {
        let v = Int.random(in: 1 ... 5)
        let x = 2 * v
        let exp: Int? = nil
        let res = ValueRestriction.smallerThan(v).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    // === //

    func test_applied_smallerThanOrEqualTo_less() {
        let v = Int.random(in: 1 ... 5)
        let x = v / 2
        let exp = x
        let res = ValueRestriction.smallerThanOrEqualTo(v).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_smallerThanOrEqualTo_equal() {
        let v = Int.random(in: 1 ... 5)
        let x = v
        let exp = x
        let res = ValueRestriction.smallerThanOrEqualTo(v).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_smallerThanOrEqualTo_nil() {
        let v = Int.random(in: 1 ... 5)
        let x = 2 * v
        let exp: Int? = nil
        let res = ValueRestriction.smallerThanOrEqualTo(v).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    // === //

    func test_applied_largerThan() {
        let v = Int.random(in: 1 ... 5)
        let x = 2 * v
        let exp = x
        let res = ValueRestriction.largerThan(v).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_largerThan_nil() {
        let v = Int.random(in: 1 ... 5)
        let x = v / 2
        let exp: Int? = nil
        let res = ValueRestriction.largerThan(v).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    // === //

    func test_applied_largerThanOrEqualTo_bigger() {
        let v = Int.random(in: 1 ... 5)
        let x = 2 * v
        let exp = x
        let res = ValueRestriction.largerThanOrEqualTo(v).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_largerThanOrEqualTo_equal() {
        let v = Int.random(in: 1 ... 5)
        let x = v
        let exp = x
        let res = ValueRestriction.largerThanOrEqualTo(v).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_largerThanOrEqualTo_nil() {
        let v = Int.random(in: 1 ... 5)
        let x = v / 2
        let exp: Int? = nil
        let res = ValueRestriction.largerThanOrEqualTo(v).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    // === //

    func test_applied_inOpenRange_below_lower() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.lowerBound / 2
        let exp: Int? = nil
        let res = ValueRestriction.inOpenRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inOpenRange_equal_lower() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.lowerBound
        let exp: Int? = nil
        let res = ValueRestriction.inOpenRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inOpenRange() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = (r.lowerBound + r.upperBound) / 2
        let exp = x
        let res = ValueRestriction.inOpenRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inOpenRange_equal_upper() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.upperBound
        let exp: Int? = nil
        let res = ValueRestriction.inOpenRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inOpenRange_above_upper() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = 2 * r.upperBound
        let exp: Int? = nil
        let res = ValueRestriction.inOpenRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    // === //

    func test_applied_inOpenClosedRange_below_lower() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.lowerBound / 2
        let exp: Int? = nil
        let res = ValueRestriction.inOpenClosedRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inOpenClosedRange_equal_lower() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.lowerBound
        let exp: Int? = nil
        let res = ValueRestriction.inOpenClosedRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inOpenClosedRange() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = (r.lowerBound + r.upperBound) / 2
        let exp = x
        let res = ValueRestriction.inOpenClosedRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inOpenClosedRange_equal_upper() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.upperBound
        let exp = x
        let res = ValueRestriction.inOpenClosedRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inOpenClosedRange_above_upper() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = 2 * r.upperBound
        let exp: Int? = nil
        let res = ValueRestriction.inOpenClosedRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    // === //

    func test_applied_inClosedOpenRange_below_lower() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.lowerBound / 2
        let exp: Int? = nil
        let res = ValueRestriction.inClosedOpenRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inClosedOpenRange_equal_lower() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.lowerBound
        let exp = x
        let res = ValueRestriction.inClosedOpenRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inClosedOpenRange() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = (r.lowerBound + r.upperBound) / 2
        let exp = x
        let res = ValueRestriction.inClosedOpenRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inClosedOpenRange_equal_upper() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.upperBound
        let exp: Int? = nil
        let res = ValueRestriction.inClosedOpenRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inClosedOpenRange_above_upper() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = 2 * r.upperBound
        let exp: Int? = nil
        let res = ValueRestriction.inClosedOpenRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    // === //

    func test_applied_inClosedRange_below_lower() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.lowerBound / 2
        let exp: Int? = nil
        let res = ValueRestriction.inClosedRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inClosedRange_equal_lower() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.lowerBound
        let exp = x
        let res = ValueRestriction.inClosedRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inClosedRange() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = (r.lowerBound + r.upperBound) / 2
        let exp = x
        let res = ValueRestriction.inClosedRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inClosedRange_equal_upper() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = r.upperBound
        let exp = x
        let res = ValueRestriction.inClosedRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    func test_applied_inClosedRange_above_upper() {
        let r = Int.random(in: 1 ... 3) ... Int.random(in: 7 ... 9)
        let x = 2 * r.upperBound
        let exp: Int? = nil
        let res = ValueRestriction.inClosedRange(r).applied(to: x)
        XCTAssert(res == exp, "exp: \(String(describing: exp)), res: \(String(describing: res))")
    }

    // === //

    func test_isUnrestricted() {
        allcases().forEach { enumCase in
            XCTAssert(enumCase.isUnrestricted == (enumCase == ValueRestriction<Int>.unrestricted))
        }
    }

    func test_argumentOfEqualToOneOf() {
        allcases().forEach { enumCase in
            switch enumCase {
            case let .equalToOneOf(arg):
                XCTAssert(enumCase.argumentOfEqualToOneOf == arg)
            default:
                XCTAssert(enumCase.argumentOfEqualToOneOf == nil)
            }
        }
    }

    func test_argumentOfNotEqualToAnyOf() {
        allcases().forEach { enumCase in
            switch enumCase {
            case let .notEqualToAnyOf(arg):
                XCTAssert(enumCase.argumentOfNotEqualToAnyOf == arg)
            default:
                XCTAssert(enumCase.argumentOfNotEqualToAnyOf == nil)
            }
        }
    }

    func test_argumentOfSmallerThan() {
        allcases().forEach { enumCase in
            switch enumCase {
            case let .smallerThan(arg):
                XCTAssert(enumCase.argumentOfSmallerThan == arg)
            default:
                XCTAssert(enumCase.argumentOfSmallerThan == nil)
            }
        }
    }

    func test_argumentOfSmallerThanOrEqualTo() {
        allcases().forEach { enumCase in
            switch enumCase {
            case let .smallerThanOrEqualTo(arg):
                XCTAssert(enumCase.argumentOfSmallerThanOrEqualTo == arg)
            default:
                XCTAssert(enumCase.argumentOfSmallerThanOrEqualTo == nil)
            }
        }
    }

    func test_argumentOfLargerThan() {
        allcases().forEach { enumCase in
            switch enumCase {
            case let .largerThan(arg):
                XCTAssert(enumCase.argumentOfLargerThan == arg)
            default:
                XCTAssert(enumCase.argumentOfLargerThan == nil)
            }
        }
    }

    func test_argumentOfLargerThanOrEqualTo() {
        allcases().forEach { enumCase in
            switch enumCase {
            case let .largerThanOrEqualTo(arg):
                XCTAssert(enumCase.argumentOfLargerThanOrEqualTo == arg)
            default:
                XCTAssert(enumCase.argumentOfLargerThanOrEqualTo == nil)
            }
        }
    }

    func test_argumentOfInOpenRange() {
        allcases().forEach { enumCase in
            switch enumCase {
            case let .inOpenRange(arg):
                XCTAssert(enumCase.argumentOfInOpenRange == arg)
            default:
                XCTAssert(enumCase.argumentOfInOpenRange == nil)
            }
        }
    }

    func test_argumentOfInOpenClosedRange() {
        allcases().forEach { enumCase in
            switch enumCase {
            case let .inOpenClosedRange(arg):
                XCTAssert(enumCase.argumentOfInOpenClosedRange == arg)
            default:
                XCTAssert(enumCase.argumentOfInOpenClosedRange == nil)
            }
        }
    }

    func test_argumentOfInClosedOpenRange() {
        allcases().forEach { enumCase in
            switch enumCase {
            case let .inClosedOpenRange(arg):
                XCTAssert(enumCase.argumentOfInClosedOpenRange == arg)
            default:
                XCTAssert(enumCase.argumentOfInClosedOpenRange == nil)
            }
        }
    }

    func test_argumentOfInClosedRange() {
        allcases().forEach { enumCase in
            switch enumCase {
            case let .inClosedRange(arg):
                XCTAssert(enumCase.argumentOfInClosedRange == arg)
            default:
                XCTAssert(enumCase.argumentOfInClosedRange == nil)
            }
        }
    }

}
