//
//  RequestResponse+SuccessOrFail.swift
//  BatteryCameraDeviceKit
//
//  Created by Shane Whitehead on 19/11/19.
//  Copyright © 2019 Swann Communications. All rights reserved.
//

import Foundation
import HttpEngineCore
import Cadmus


extension RequestResponse {
	
	func success() throws {
		guard statusCode == 200 else {
			throw TheTVDBApiError.unsuccessful(code: statusCode, description: statusDescription)
		}
	}
	
	func successWithData() throws -> Data {
		guard statusCode == 200 else {
			if let data = data, let response = String(data: data, encoding: .utf8) {
				log(error: "API respond with\n\t\(statusCode)\n\t\(response)")
			}
			throw TheTVDBApiError.unsuccessful(code: statusCode, description: statusDescription)
		}
		guard let data = data else {
			throw TheTVDBApiError.missingExpectedPayload
		}
		return data
	}
	
}
