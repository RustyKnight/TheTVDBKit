//
//  Data+Codable.swift
//  iOS
//
//  Created by Shane Whitehead on 23/11/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import Foundation


extension Data {
	
	func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
		let decoder = JSONDecoder()
		return try decoder.decode(type.self, from: self)
	}

}
