//
//  Series.swift
//  iOSTests
//
//  Created by Shane Whitehead on 24/11/19.
//  Copyright © 2019 Shane Whitehead. All rights reserved.
//

import Foundation

public protocol Series {
	var added: String { get }
	var airsDayOfWeek: String { get }
	var airsTime: String { get }
	var aliases: [String] { get }
	var banner: String { get }
	var firstAired: String { get }
	var genre: [String] { get }
	var id: Int { get }
	var imdbId: String { get }
	var lastUpdated: Int { get }
	var network: String { get }
	var networkId: String { get }
	var overview: String { get }
	var rating: String { get }
	var seriesId: String { get }
	var seriesName: String { get }
	var siteRating: Int { get }
	var siteRatingCount: Int { get }
	var slug: String { get }
	var status: String { get }
	var zap2itId: String { get }
}

struct SeriesResponse: Codable {
	var data: SeriesDataResponse
	var errors: SeriesErrorResponse?
}

struct SeriesDataResponse: Series, Codable {
	var added: String
	var airsDayOfWeek: String
	var airsTime: String
	var aliases: [String]
	var banner: String
	var firstAired: String
	var genre: [String]
	var id: Int
	var imdbId: String
	var lastUpdated: Int
	var network: String
	var networkId: String
	var overview: String
	var rating: String
	var seriesId: String
	var seriesName: String
	var siteRating: Int
	var siteRatingCount: Int
	var slug: String
	var status: String
	var zap2itId: String
}

struct SeriesErrorResponse: Codable {
	var invalidFilters: [String]
	var invalidLanguage: String
	var invalidQueryParams: [String]
}

// MARK: Series actors

public protocol Actor {
	var id: Int { get }
	var image: String { get }
	var imageAdded: String { get }
	var imageAuthor: Int? { get }
	var lastUpdated: String { get }
	var name: String { get }
	var role: String { get }
	var seriesId: Int { get }
	var sortOrder: Int { get }
}

struct SeriesActorResponse: Codable {
	var data: [SeriesActorDataResponse]
	var error: SeriesErrorResponse?
}

struct SeriesActorDataResponse: Codable, Actor {
	var id: Int
	var image: String
	var imageAdded: String
	var imageAuthor: Int?
	var lastUpdated: String
	var name: String
	var role: String
	var seriesId: Int
	var sortOrder: Int
}

// MARK: Series episodes

public protocol Episode {
	var absoluteNumber: Int? { get }
	var airedEpisodeNumber: Int { get }
	var airedSeason: Int { get }
	var airsAfterSeason: Int? { get }
	var airsBeforeEpisode: Int? { get }
	var airsBeforeSeason: Int? { get }
	var director: String? { get }
	var directors: [String] { get }
	var dvdChapter: Int? { get }
	var dvdDiscid: String? { get }
	var dvdEpisodeNumber: Int? { get }
	var dvdSeason: Int? { get }
	var episodeName: String { get }
	var filename: String { get }
	var firstAired: String { get }
	var guestStars: [String] { get }
	var id: Int { get }
	var imdbId: String { get }
	var lastUpdated: Int { get }
	var lastUpdatedBy: Int { get }
	var overview: String? { get }
	var productionCode: String { get }
	var seriesId: Int { get }
	var showUrl: String { get }
	var siteRating: Int { get }
	var siteRatingCount: Int { get }
	var thumbAdded: String { get }
	var thumbAuthor: Int? { get }
	var thumbHeight: String? { get }
	var thumbWidth: String? { get }
	var writers: [String] { get }
}

struct SeriesEpisodeResponse: Codable {
	var data: [SeriesEpisodeDataResponse]
	var error: SeriesErrorResponse?
}

struct SeriesEpisodeDataResponse: Episode, Codable {
	var absoluteNumber: Int?
	var airedEpisodeNumber: Int
	var airedSeason: Int
	var airsAfterSeason: Int?
	var airsBeforeEpisode: Int?
	var airsBeforeSeason: Int?
	var director: String?
	var directors: [String]
	var dvdChapter: Int?
	var dvdDiscid: String?
	var dvdEpisodeNumber: Int?
	var dvdSeason: Int?
	var episodeName: String
	var filename: String
	var firstAired: String
	var guestStars: [String]
	var id: Int
	var imdbId: String
	var lastUpdated: Int
	var lastUpdatedBy: Int
	var overview: String?
	var productionCode: String
	var seriesId: Int
	var showUrl: String
	var siteRating: Int
	var siteRatingCount: Int
	var thumbAdded: String
	var thumbAuthor: Int?
	var thumbHeight: String?
	var thumbWidth: String?
	var writers: [String]
}

//{
//  "data": [
//    {
//      "absoluteNumber": Int { get }
//      "airedEpisodeNumber": Int { get }
//      "airedSeason": Int { get }
//      "airsAfterSeason": Int { get }
//      "airsBeforeEpisode": Int { get }
//      "airsBeforeSeason": Int { get }
//      "director": "string",
//      "directors": [
//        "string"
//      ],
//      "dvdChapter": Int { get }
//      "dvdDiscid": "string",
//      "dvdEpisodeNumber": Int { get }
//      "dvdSeason": Int { get }
//      "episodeName": "string",
//      "filename": "string",
//      "firstAired": "string",
//      "guestStars": [
//        "string"
//      ],
//      "id": Int { get }
//      "imdbId": "string",
//      "lastUpdated": Int { get }
//      "lastUpdatedBy": "string",
//      "overview": "string",
//      "productionCode": "string",
//      "seriesId": "string",
//      "showUrl": "string",
//      "siteRating": Int { get }
//      "siteRatingCount": Int { get }
//      "thumbAdded": "string",
//      "thumbAuthor": Int { get }
//      "thumbHeight": "string",
//      "thumbWidth": "string",
//      "writers": [
//        "string"
//      ]
//    }
//  ],
//  "errors": {
//    "invalidFilters": [
//      "string"
//    ],
//    "invalidLanguage": "string",
//    "invalidQueryParams": [
//      "string"
//    ]
//  },
//  "links": {
//    "first": Int { get }
//    "last": Int { get }
//    "next": Int { get }
//    "previous": 0
//  }
//}
