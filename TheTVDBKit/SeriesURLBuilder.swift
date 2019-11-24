//
//  SeriesURLBuilder.swift
//  iOSTests
//
//  Created by Shane Whitehead on 24/11/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import Foundation
import Cadmus

class SeriesURLBuilder: URLBuilder {
	
	enum SeriesAPIPath: String {
		case actors = "/actors"
		case episodes = "/episodes"
		case episodesQuery = "/episodes/query"
		case episodesQueryParams = "/episodes/query/params"
		case episodesSummary = "/episodes/summary"
		case filter = "/filter"
		case filterParams = "/filter/params"
		case images = "/images"
		case imagesQuery = "/images/query"
		case imagesQueryParams = "/images/query/params"
	}

	fileprivate let id: Int
	fileprivate var subAPIPath: SeriesAPIPath?
	
	init(id: Int) {
		self.id = id
	}
	
	func with(_ subAPIPath: SeriesAPIPath) -> Self {
		self.subAPIPath = subAPIPath
		return self
	}
	
	func build() -> URL {
		var requestPath = TheTVDB.baseAPIPath + TheTVDB.APIPath.series.rawValue + "/\(id)"
		
		log(debug: "subPath = \(subAPIPath)")
		if let subPath = subAPIPath {
			requestPath += subPath.rawValue
		}

		log(debug: "requestPath = \(requestPath)")

		return URL(string: requestPath)!
	}
	
}
