//
//  Sort_Tests.swift
//  ClexiTests
//
//  Created by Hassan Shahbazi on 2018-01-30.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import Clexi

class Sort_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func tests_0_SortEmptyList() {
        let items = DBController.GetBLECloneList()
        XCTAssertNotNil(items)
        XCTAssertEqual(items.Sort(By: .Title).count, 0)
    }
    
    func tests_1_Prepare() {
        DBManager.isMock = true
        XCTAssertTrue(InsertMockBLEClone(Count: 10))
    }
    
 
    func tests_2_SortByTitle_ASC() {
        let rawArray = DBController.GetBLECloneList()
        let sortedArray = rawArray.Sort(By: .Title, Order: .orderedAscending)
        var isSorted = true
        for index in 0..<9 {
            if sortedArray[index].id > sortedArray[index+1].id {
                isSorted = false
            }
        }
        XCTAssertTrue(isSorted)
    }
    
    func tests_3_SortByTitle_DSC() {
        let rawArray = DBController.GetBLECloneList()
        let sortedArray = rawArray.Sort(By: .Title, Order: .orderedDescending)
        var isSorted = true
        for index in 0..<9 {
            if sortedArray[index].id < sortedArray[index+1].id {
                isSorted = false
            }
        }
        XCTAssertTrue(isSorted)
    }
    
    func tests_4_SortByPopularity_ASC() {
        let rawArray = DBController.GetBLECloneList()
        let sortedArray = rawArray.Sort(By: .Popularity, Order: .orderedAscending)
        var isSorted = true
        for index in 0..<9 {
            if sortedArray[index].attributes.popularity > sortedArray[index+1].attributes.popularity {
                isSorted = false
            }
        }
        XCTAssertTrue(isSorted)
    }
    
    func tests_5_SortByPopularity_DSC() {
        let rawArray = DBController.GetBLECloneList()
        let sortedArray = rawArray.Sort(By: .Popularity, Order: .orderedDescending)
        var isSorted = true
        for index in 0..<9 {
            if sortedArray[index].attributes.popularity < sortedArray[index+1].attributes.popularity {
                isSorted = false
            }
        }
        XCTAssertTrue(isSorted)
    }
    
    func tests_6_SortByLastUsed_ASC() {
        let rawArray = DBController.GetBLECloneList()
        let sortedArray = rawArray.Sort(By: .LastUsed, Order: .orderedAscending)
        var isSorted = true
        for index in 0..<9 {
            if sortedArray[index].attributes.lastused > sortedArray[index+1].attributes.lastused {
                isSorted = false
            }
        }
        XCTAssertTrue(isSorted)
    }
    
    func tests_7_SortByLastUsed_DSC() {
        let rawArray = DBController.GetBLECloneList()
        let sortedArray = rawArray.Sort(By: .LastUsed, Order: .orderedDescending)
        var isSorted = true
        for index in 0..<9 {
            if sortedArray[index].attributes.lastused < sortedArray[index+1].attributes.lastused {
                isSorted = false
            }
        }
        XCTAssertTrue(isSorted)
    }
}

extension Sort_Tests {
    //Helper functions
    private func InsertMockBLEClone(Count: Int) -> Bool {
        var result = true
        for counter in 0..<Count {
            let item = BLECloneModel()
            item.id = Int16(counter)
            item.title = "A \(counter)"
            item.url = "URL"
            item.username = "Username"
            result = result && DBController.InsertBLECloneItem(BLEItem: item)
            result = result && UpdateAttribute(Count: counter)
        }
        return result
    }
    
    private func UpdateAttribute(Count: Int) -> Bool {
        var result = true
        Wait(for: Double(Count))
        for index in 0..<Count {
            result = result && DBController.ItemIsUsed(With: index)
        }
        return result
    }
    
    private func Wait(for second: Double) {
        let date = Date(timeIntervalSinceNow: second)
        RunLoop.current.run(until: date)
    }
}
