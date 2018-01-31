//
//  Sort_Tests.swift
//  ClexiTests
//
//  Created by Hassan Shahbazi on 2018-01-30.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import Clexi

class SearchSort_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func tests_0_1_SortEmptyList() {
        let items = DBController.GetBLECloneList()
        XCTAssertNotNil(items)
        XCTAssertEqual(items.Sort(By: .Title).count, 0)
    }
    func tests_0_2_SearchEmptyList() {
        let items = DBController.GetBLECloneList()
        XCTAssertNotNil(items)
        XCTAssertEqual(items.Search(for: "title").count, 0)
    }
    
    func tests_1_0_Prepare() {
        DBManager.isMock = true
        XCTAssertTrue(InsertMockBLEClone(Count: 10))
    }
    
    //MARK:- Sorting tests
    func tests_1_1_SortByTitle_ASC() {
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
    func tests_1_2_SortByTitle_DSC() {
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
    func tests_1_3_SortByPopularity_ASC() {
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
    func tests_1_4_SortByPopularity_DSC() {
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
    func tests_1_5_SortByLastUsed_ASC() {
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
    func tests_1_6_SortByLastUsed_DSC() {
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

    //MARK:- Searching tests
    func tests_2_1_SearchNotFound() {
        let items = DBController.GetBLECloneList()
        let searchResult = items.Search(for: "BB")
        XCTAssertEqual(searchResult.count, 0)
    }
    func tests_2_2_SearchOneResult() {
        let items = DBController.GetBLECloneList()
        let searchResult = items.Search(for: "A 1")
        XCTAssertEqual(searchResult.count, 1)
        XCTAssertEqual(searchResult.first?.id, 1)
    }
    func tests_2_3_SearchManyResults() {
        let items = DBController.GetBLECloneList()
        let searchResult = items.Search(for: "A")
        XCTAssertEqual(searchResult.count, 10)
    }
    func tests_2_4_SearchMatchWords() {
        let items = DBController.GetBLECloneList()
        let searchResult = items.Search(for: "A", matchWords: true)
        XCTAssertEqual(searchResult.count, 0)
    }
    
    //MARK:- Mixture of Search - Sort
    func tests_3_1_SearchThenSort() {
        let items = DBController.GetBLECloneList()
        let searchResult = items.Search(for: "A")
        let sortedSearch = searchResult.Sort(By: .Title, Order: .orderedAscending)
        XCTAssertEqual(sortedSearch.first?.id, 0)
    }
    func tests_3_2_SortThenSearch() {
        let items = DBController.GetBLECloneList()
        let sortedArray = items.Sort(By: .Title, Order: .orderedAscending)
        let searchResult = sortedArray.Search(for: "A")
        XCTAssertEqual(searchResult.first?.id, 0)
    }
}

extension SearchSort_Tests {
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
