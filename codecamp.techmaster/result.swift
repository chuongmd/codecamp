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
    
    enum CodingKeys: String, CodingKey {
        case trackName
        case artistName
        case artworkUrl = "artworkUrl100"
        case previewUrl
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.artistName = try values.decode(String.self, forKey: .artistName)
        self.trackName = try values.decode(String.self, forKey: .trackName)
        self.artworkUrl = try? values.decode(URL.self, forKey: .artworkUrl)
        self.previewUrl = try? values.decode(URL.self, forKey: .previewUrl)
    }
}
