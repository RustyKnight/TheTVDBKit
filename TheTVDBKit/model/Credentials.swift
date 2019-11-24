//
//  Login.swift
//  iOS
//
//  Created by Shane Whitehead on 23/11/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import Foundation

public struct Credentials {
	var apiKey: String
	var userKey: String
	var userName: String
}

struct CredentialsRequest: Codable {
	
	enum CodingKeys: String, CodingKey {
		case apiKey = "apikey"
		case userKey = "userkey"
		case userName = "username"
	}

	var apiKey: String
	var userKey: String
	var userName: String
	
	init(from copy: Credentials) {
		apiKey = copy.apiKey
		userKey = copy.userKey
		userName = copy.userName
	}

}
