//
//  TestSeries.swift
//  iOSTests
//
//  Created by Shane Whitehead on 24/11/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import XCTest
@testable import TheTVDBKit
import AlamofireHttpEngineKit

class TestSeries: XCTestCase {
	
	override func setUp() {
	}
	
	override func tearDown() {
	}
	
	func testSeriesById() {
		HttpEngineConfiguration.shared.isDebugMode = true
		
		let credentials = APISecret.credentials
		
		let expectation = XCTestExpectation(description: "Login")
		TheTVDB.shared.login(using: credentials).then { () in
			TheTVDB.shared.series(withId: 332353).then { (result) in
				expectation.fulfill()
			}
		}.catch { (error) in
			XCTFail("Unexpectedly failed with: \(error)")
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 10.0)
	}
	
	func testActorsById() {
		HttpEngineConfiguration.shared.isDebugMode = true
		
		let credentials = APISecret.credentials
		
		let expectation = XCTestExpectation(description: "Login")
		TheTVDB.shared.login(using: credentials).then { () in
			TheTVDB.shared.actors(forSeriesId: 332353).then { (result) in
				expectation.fulfill()
			}
		}.catch { (error) in
			XCTFail("Unexpectedly failed with: \(error)")
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 10.0)
	}
		
	func testEpisodeById() {
		HttpEngineConfiguration.shared.isDebugMode = true
		
		let credentials = APISecret.credentials
		
		let expectation = XCTestExpectation(description: "Login")
		TheTVDB.shared.login(using: credentials).then { () in
			TheTVDB.shared.episodes(forSeriesId: 332353).then { (result) in
				expectation.fulfill()
			}
		}.catch { (error) in
			XCTFail("Unexpectedly failed with: \(error)")
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 10.0)
	}
	
}
