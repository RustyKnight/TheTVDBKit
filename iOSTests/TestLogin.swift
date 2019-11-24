//
//  iOSTests.swift
//  iOSTests
//
//  Created by Shane Whitehead on 23/11/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import XCTest
import Foundation
@testable import TheTVDBKit

class iOSTests: XCTestCase {
	
	override func setUp() {
	}
	
	override func tearDown() {
	}
	
	func testSuccessfulLogin() {
		let credentials = APISecret.credentials
		
		let expectation = XCTestExpectation(description: "Login")
		TheTVDB.shared.login(using: credentials).then { () in
			expectation.fulfill()
		}.catch { (error) in
			XCTFail("Unexpectedly failed with: \(error)")
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 10.0)
	}
	
	func testUnsuccessfulLogin() {
		let credentials = Credentials(apiKey: "", userKey: "", userName: "")
		
		let expectation = XCTestExpectation(description: "Login")
		TheTVDB.shared.login(using: credentials).then { () in
			XCTFail("Unexpectedly succedded")
			expectation.fulfill()
		}.catch { (error) in
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 10.0)
	}
	
}
