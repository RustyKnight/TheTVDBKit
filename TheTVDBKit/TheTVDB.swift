//
//  TheTVDB.swift
//  iOS
//
//  Created by Shane Whitehead on 23/11/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import Foundation
import AlamofireHttpEngineKit
import Hydra
import HttpEngineCore
import Cadmus

class DefaultApiURLBuilder: URLBuilder {
	
	fileprivate let apiPath: TheTVDB.APIPath
	fileprivate var subPath: String?
	
	init(apiPath: TheTVDB.APIPath) {
		self.apiPath = apiPath
	}
	
	func with(subPath: String) -> Self {
		self.subPath = subPath
		return self
	}
	
	func build() -> URL {
		var requestPath = TheTVDB.baseAPIPath + apiPath.rawValue
		if let subPath = subPath {
			requestPath += "/" + subPath
		}
		
		return URL(string: requestPath)!
	}
}

public class TheTVDB {
	
	public static let shared = TheTVDB()
	
	static let baseAPIPath = "https://api.thetvdb.com"
	
	enum APIPath: String {
		case login = "/login"
		case refreshToken = "/refresh_token"
		
		case searchSeries = "/search/series"
		case series = "/series"
	}
	
	fileprivate var token: String?
	
	var apiVersion = "3.0.0"
	
	fileprivate init() { }
	
	// MARK: - API
	
	// MARK: Authentication
	public func login(using credentials: Credentials) -> Promise<Void> {
		return Promise<Data>(in: .userInitiated) { (fulfill, fail, _) in
			let request = CredentialsRequest(from: credentials)
			let data = try self.encode(request)
			fulfill(data)
		}.then { (data) -> Promise<RequestResponse> in
			self.post(data, to: .login)
		}.then { (response) -> Void in
			let data = try response.successWithData()
			guard let response = String(data: data, encoding: .utf8) else {
				throw TheTVDBApiError.decodingResponseFailed
			}

			log(debug: "login responded with\n\t\(response)")
			
			self.token = try data.decode(APITokenResponse.self).token
		}
	}
	
	public func refreshAuthentication() -> Promise<Void> {
		return get(from: .refreshToken).then { (response) -> Void in
			let data = try response.successWithData()
			guard let response = String(data: data, encoding: .utf8) else {
				throw TheTVDBApiError.decodingResponseFailed
			}

			log(debug: "Refresh responded with\n\t\(response)")
			
			self.token = try data.decode(APITokenResponse.self).token
		}
	}
	
	// MARK: - Search
	
	enum SeriesSearchParameter: String {
		case name = "name"
		case imdbid = "imdbid"
		case zap2itId = "zap2itId"
		case slug = "slug"
	}
	
	public func search(seriesByName name: String) -> Promise<[SeriesSearchResult]> {
		return searchBy(.name, value: name)
	}
	
	public func search(seriesByImdId name: String) -> Promise<[SeriesSearchResult]> {
		return searchBy(.imdbid, value: name)
	}
	
	public func search(seriesByZap2itId name: String) -> Promise<[SeriesSearchResult]> {
		return searchBy(.zap2itId, value: name)
	}
	
	public func search(seriesBySlug name: String) -> Promise<[SeriesSearchResult]> {
		return searchBy(.slug, value: name)
	}

	func searchBy(_ name: SeriesSearchParameter, value: String) -> Promise<[SeriesSearchResult]> {
		let builder = self.builder(for: .searchSeries)
			.with(queryNamed: name.rawValue, value: value)

		return get(using: builder).then(in: .userInitiated) { (response) -> [SeriesSearchResult] in
			let data = try response.successWithData()
			guard let response = String(data: data, encoding: .utf8) else {
				throw TheTVDBApiError.decodingResponseFailed
			}

			log(debug: "search responded with\n\t\(response)")

			let results = try data.decode(SeriesSearchResponse.self)
			
			return results.results
		}
	}
	
	// MARK: - Series
	
	public func series(for search: SeriesSearchResult) -> Promise<Series> {
		return series(withId: search.id)
	}
	
	public func series(withId id: Int) -> Promise<Series> {
		let urlBuilder = SeriesURLBuilder(id: id)

		return get(using: urlBuilder).then(in: .userInitiated) { (response) -> Series in
			let data = try response.successWithData()
			guard let response = String(data: data, encoding: .utf8) else {
				throw TheTVDBApiError.decodingResponseFailed
			}

			log(debug: "series responded with\n\t\(response)")
			
			let result = try data.decode(SeriesResponse.self)
			
			return result.data
		}
	}

	public func actors(for series: Series) -> Promise<[Actor]> {
		return actors(forSeriesId: series.id)
	}

	public func actors(forSeriesId id: Int) -> Promise<[Actor]> {
		let urlBuilder = SeriesURLBuilder(id: id).with(.actors)

		return get(using: urlBuilder).then(in: .userInitiated) { (response) -> [Actor] in
			let data = try response.successWithData()
			guard let response = String(data: data, encoding: .utf8) else {
				throw TheTVDBApiError.decodingResponseFailed
			}

			log(debug: "series actors responded with\n\t\(response)")
			
			let result = try data.decode(SeriesActorResponse.self)
			
			return result.data
		}
	}
	
	public func episodes(for series: Series) -> Promise<[Episode]> {
		return episodes(forSeriesId: series.id)
	}

	public func episodes(forSeriesId id: Int) -> Promise<[Episode]> {
		let urlBuilder = SeriesURLBuilder(id: id).with(.episodes)

		return get(using: urlBuilder).then(in: .userInitiated) { (response) -> [Episode] in
			let data = try response.successWithData()
			guard let response = String(data: data, encoding: .utf8) else {
				throw TheTVDBApiError.decodingResponseFailed
			}

			log(debug: "series episode responded with\n\t\(response)")
			
			let result = try data.decode(SeriesEpisodeResponse.self)
			
			return result.data
		}
	}

	// MARK: - Support
	
	func encode<T>(_ value: T) throws -> Data where T : Encodable {
		let encoder = JSONEncoder()
		return try encoder.encode(value)
	}
	
	func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
		let decoder = JSONDecoder()
		return try decoder.decode(type.self, from: data)
	}
	
//	func url(for path: APIPath, withSubPath subPath: String? = nil) -> URL {
//
//		var requestPath = TheTVDB.baseAPIPath + path.rawValue
//		if let subPath = subPath {
//			requestPath += "/" + subPath
//		}
//
//		return URL(string: requestPath)!
//	}
	
	func builder(for apiPath: APIPath) -> DefaultHttpURLBuilder {
		return builder(for: DefaultApiURLBuilder(apiPath: apiPath))
	}
	
	func builder(for urlBuilder: URLBuilder) -> DefaultHttpURLBuilder {
		let builder = DefaultHttpURLBuilder()
		
		builder.with(url: urlBuilder.build())
			.withHeader(key: "Content-Type", value: "application/json")
			.withHeader(key: "accept", value: "application/json")
			.withHeader(key: "accept", value: "application/vnd.thetvdb.v\(apiVersion)")

		if let token = token {
			builder.withHeader(key: "Authorization", value: "Bearer \(token)")
		}
		
		return builder
	}
//
//	func builder(for urlBuilder: UrlBuilder) -> DefaultHttpURLBuilder {
//		let builder = DefaultHttpURLBuilder()
//
//		builder.with(url: builder.build())
//			.withHeader(key: "Content-Type", value: "application/json")
//			.withHeader(key: "accept", value: "application/json")
//			.withHeader(key: "accept", value: "application/vnd.thetvdb.v\(apiVersion)")
//
//		if let token = token {
//			builder.withHeader(key: "Authorization", value: "Bearer \(token)")
//		}
//
//		return builder
//	}
	
	// MARK: Http
	
	func post(_ data: Data, to path: APIPath) -> Promise<RequestResponse> {
		return HttpService.shared.post(data: data, to: builder(for: path))
	}
	
	func get(from path: APIPath) -> Promise<RequestResponse> {
		return get(using: builder(for: path))
	}

	func get(using urlBuilder: URLBuilder) -> Promise<RequestResponse> {
		return get(using: builder(for: urlBuilder))
	}

	func get(using builder: DefaultHttpURLBuilder) -> Promise<RequestResponse> {
		return HttpService.shared.get(from: builder)
	}

}
