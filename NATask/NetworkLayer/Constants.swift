//
//  Constants.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 09/09/2021.
//

import Foundation

struct Constants {
    struct ProductionServer {
        static let baseURL = "https://api.edamam.com/api/"
        static let appKey = "b3864e067cfc1dfe5f593e18a33fe4e2"
        static let appID = "a918fe78"
    }
    
}

enum HTTPHeaderField: String {
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "application/json"
}
