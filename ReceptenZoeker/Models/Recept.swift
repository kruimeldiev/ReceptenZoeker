//
//  Recept.swift
//  ReceptenZoeker
//
//  Created by Casper Daris on 15/12/2020.
//

import Foundation

struct Recept: Decodable {
    
    var uri: String
    var label: String
    var image: String
    var source: String
    var url: String
    var shareAs: String
    var yield: Double
    var dietLabels: [String]
    var healthLabels: [String]
    var cautions: [String]
    var ingredientLines: [String]
    var ingredients: [Ingredient]
    var calories: Float
    var totalWeight: Float
    var totalTime: Int
    
    // TOTAL NUTRIENS TOEVOEGEN
    // TOTAL DAILY TOEVOEGEN
}

struct Ingredient: Decodable {
    
    var text: String
    var weight: Double
    var image: String?
}

struct NutrientInfo: Decodable {
    
    var label: String
    var quantity: Double
    var unit: String
}
