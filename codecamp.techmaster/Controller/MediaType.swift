//
//  MediaType.swift
//  codecamp.techmaster
//
//  Created by chuongmd on 9/7/18.
//  Copyright © 2018 chuongmd. All rights reserved.
//

import Foundation

enum MediaType: String, Codable {
    case music = "song"
    case video = "music-video"
    
    var description: String {
        switch self {
        case .music:
            return "Music"
        case .video:
            return "Video"
        }
    }
}
