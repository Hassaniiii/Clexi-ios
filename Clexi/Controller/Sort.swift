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
        return self
//        return self.sorted(by: {DBController.GetBLEItemAttribute(With: Int($0.id)).compare(DBController.GetBLEItemAttribute(With: Int($1.id))) == Order})
    }
    private func SortByLastUsed(Order: ComparisonResult) -> [BLECloneModel] {
        return self
    }
}
