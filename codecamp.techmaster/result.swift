//
//  result.swift
//  codecamp.techmaster
//
//  Created by chuongmd on 8/19/18.
//  Copyright © 2018 chuongmd. All rights reserved.
//

import Foundation

struct Result: Codable {
    let results: [Item]
}

struct Item: Codable {
    
    var artworkUrl: URL?
    var artistName: String
    var trackName: String
    var previewUrl: URL?
    var trackPrice: Double?
    var country: String
    var type: MediaType
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case trackName
        case artistName
        case artworkUrl = "artworkUrl100"
        case previewUrl
        case trackPrice
        case country
        case type = "kind"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.artistName = try values.decode(String.self, forKey: .artistName)
        self.trackName = try values.decode(String.self, forKey: .trackName)
        self.artworkUrl = try? values.decode(URL.self, forKey: .artworkUrl)
        self.previewUrl = try? values.decode(URL.self, forKey: .previewUrl)
        self.trackPrice = try? values.decode(Double.self, forKey: .trackPrice)
        self.country = try values.decode(String.self, forKey: .country)
        self.type = try values.decode(MediaType.self, forKey: .type)
    }
}
