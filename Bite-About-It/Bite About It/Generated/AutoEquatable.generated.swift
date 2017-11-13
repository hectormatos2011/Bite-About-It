// Generated using Sourcery 0.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}


// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - Business AutoEquatable
extension Business: Equatable {}
public func == (lhs: Business, rhs: Business) -> Bool {
    guard lhs.id == rhs.id else { return false }
    guard lhs.name == rhs.name else { return false }
    guard lhs.isClosed == rhs.isClosed else { return false }
    guard lhs.rating == rhs.rating else { return false }
    guard lhs.phoneNumber == rhs.phoneNumber else { return false }
    guard lhs.phoneNumberDisplay == rhs.phoneNumberDisplay else { return false }
    guard compareOptionals(lhs: lhs.imageURL, rhs: rhs.imageURL, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.pageURL, rhs: rhs.pageURL, compare: ==) else { return false }
    guard lhs.categories == rhs.categories else { return false }
    guard lhs.coordinate == rhs.coordinate else { return false }
    guard lhs.transactionMethod == rhs.transactionMethod else { return false }
    return true
}
// MARK: - BusinessCategory AutoEquatable
extension BusinessCategory: Equatable {}
public func == (lhs: BusinessCategory, rhs: BusinessCategory) -> Bool {
    guard lhs.alias == rhs.alias else { return false }
    guard lhs.title == rhs.title else { return false }
    return true
}
// MARK: - TransactionMethod AutoEquatable
extension TransactionMethod: Equatable {}
public func == (lhs: TransactionMethod, rhs: TransactionMethod) -> Bool {
    guard lhs.rawValue == rhs.rawValue else { return false }
    return true
}

// MARK: - AutoEquatable for Enums
