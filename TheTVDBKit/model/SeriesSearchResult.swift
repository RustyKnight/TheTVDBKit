//
//  SeriesSearchResult.swift
//  iOS
//
//  Created by Shane Whitehead on 24/11/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import Foundation

public protocol SeriesSearchResult {
	var aliases: [String] { get }
	var banner: String { get }
	var firstAired: String? { get }
	var id: Int { get }
	var network: String { get }
	var overview: String { get }
	var seriesName: String { get }
	var slug: String { get }
	var status: String { get }
}

struct SeriesSearchResponse: Codable {
	enum CodingKeys: String, CodingKey {
		case results = "data"
	}
	
	var results: [SeriesSearchDataResponse]
}

struct SeriesSearchDataResponse: Codable, SeriesSearchResult {
	var aliases: [String]
	var banner: String
	var firstAired: String?
	var id: Int
	var network: String
	var overview: String
	var seriesName: String
	var slug: String
	var status: String
}
