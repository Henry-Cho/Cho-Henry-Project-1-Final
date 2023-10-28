//
//  Array+AllCompare.swift
//  Practice SetGame
//
//  Created by Henry Cho on 10/24/23.
//

import Foundation

extension Array where Element == Card {
    enum ComparisonResult {
        case allSame
        case allDifferent
        case none
    }

    // dictionary -> set
    // if only one element -> the selected cards's featureKeyPath (shape, shading, number, etc) all the same
    // if the set has the same size with the original self -> all different
    // if not none
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
