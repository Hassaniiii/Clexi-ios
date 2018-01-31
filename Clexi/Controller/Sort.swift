//
//  Sort.swift
//  Clexi
//
//  Created by Hassan Shahbazi on 2018-01-30.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

enum SortType: String {
    case Title = "Title"
    case Popularity = "Popularity"
    case LastUsed = "LastUsed"
}

extension Array where Iterator.Element == BLECloneModel {
    
    func Sort(By: SortType, Order: ComparisonResult = .orderedDescending) -> [BLECloneModel] {
        if By == .Title {
            return SortByTitle(Order: Order)
        }
        if By == .Popularity {
            return SortByPopularity(Order: Order)
        }
        if By == .LastUsed {
            return SortByLastUsed(Order: Order)
        }
        return self
    }
    
    private func SortByTitle(Order: ComparisonResult) -> [BLECloneModel] {
        return self.sorted(by: {$0.title.compare($1.title) == Order})
    }
    private func SortByPopularity(Order: ComparisonResult) -> [BLECloneModel] {
        if Order == .orderedAscending {
            return self.sorted(by: {$0.attributes!.popularity < $1.attributes!.popularity})
        }
        return self.sorted(by: {$0.attributes!.popularity > $1.attributes!.popularity})
    }
    private func SortByLastUsed(Order: ComparisonResult) -> [BLECloneModel] {
        return self.sorted(by: {$0.attributes!.lastused!.compare($1.attributes!.lastused!) == Order})
    }
}
