//
//  NetworkTests.swift
//  HeroTestTests
//
//  Created by Luis Duran on 3/8/21.
//

import XCTest
@testable import HeroTest

class NetworkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testGetPage() throws {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
		let network = Network()
		
		let expectations = XCTestExpectation()
		var pass = false
		network.getPage(page: 1, handler: { (pages, error) in
			
			if pages != nil {
				pass = pages!.first == 10 && pages!.last == 19
			}
			expectations.fulfill()
		})
		
		wait(for: [expectations], timeout: 3)
		XCTAssert(pass, "Error: network.getPage")
	}
	
	func testGetID() throws {
		let network = Network()
		
		let expectations = XCTestExpectation()
		var pass = false
		
		network.getId(id: 69, handler: { (data, error) in
			
			if data != nil {
				print("data: \(data!)")
				pass = data!.count > 0
			}
			expectations.fulfill()
		})
		
		wait(for: [expectations], timeout: 3)
		XCTAssert(pass, "Error: network.getId")
	}
	
	func testGetPageArray() throws {
		let network = Network()
		
		let expectations = XCTestExpectation()
		var pass = false
		
		network.get(page: 1) { (array, error) in
			
			if array != nil {
				for item in array! {
					print("item: \(item)")
				}
				
				pass = array!.count > 0
			}
			expectations.fulfill()
		}
		
		wait(for: [expectations], timeout: 3)
		XCTAssert(pass, "Error: network.get(page: 1)")
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
