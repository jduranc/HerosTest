//
//  HeroTestTests.swift
//  HeroTestTests
//
//  Created by Luis Duran on 08/03/21.
//

import XCTest
@testable import HeroTest

class HeroTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		let network = Network()
		
		let expectations = XCTestExpectation()
		var pass = false
		network.get(page: 1, handler: { (pages, error) in
			
			guard let pages = pages else {
				return
			}
			
			pass = pages.first == 10 && pages.last == 19
			expectations.fulfill()
		})
		
		wait(for: [expectations], timeout: 3)
		XCTAssert(pass, "Unable to retrieve page")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
