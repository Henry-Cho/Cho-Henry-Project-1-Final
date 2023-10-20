//
//  Array+AllCompare.swift
//  Cho Henry Project 1
//
//  Created by Henry Cho on 10/16/23.
//

import Foundation

extension Array where Element == Card {
    enum ComparisonResult {
        case allSame
        case allDifferent
        case none
    }

    func allCompare<T: Hashable>(_ featureKeyPath: KeyPath<Element, T>) -> ComparisonResult {
            let featureValues = self.map { $0[keyPath: featureKeyPath] }
            let uniqueValues = Set(featureValues)

            switch uniqueValues.count {
            case 1:
                return .allSame
            case self.count:
                return .allDifferent
            default:
                return .none
            }
    }
}
