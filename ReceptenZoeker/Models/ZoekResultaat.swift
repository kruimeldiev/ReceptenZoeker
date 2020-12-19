//
//  ZoekResultaat.swift
//  ReceptenZoeker
//
//  Created by Casper Daris on 15/12/2020.
//

import Foundation

struct ZoekResultaat: Decodable {
    
    var q: String
    var from: Int
    var to: Int
    var more: Bool
    var count: Int
    var hits: [ZoekHit]
}

struct ZoekHit: Decodable {
    
    var recipe: Recept
    var bookmarked: Bool
    var bought: Bool
}
