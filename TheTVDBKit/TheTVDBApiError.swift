//
//  TheTVDBApiError.swift
//  iOS
//
//  Created by Shane Whitehead on 23/11/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import Foundation

enum TheTVDBApiError: Error {
	case invalidURL(url: String)
	case unsuccessful(code: Int, description: String)
	case missingExpectedPayload
	case decodingResponseFailed
}
