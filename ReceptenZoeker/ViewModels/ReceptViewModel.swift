//
//  ReceptViewModel.swift
//  ReceptenZoeker
//
//  Created by Casper Daris on 15/12/2020.
//

import UIKit

class ReceptViewModel {
    
    private var recept: Recept?
    
    init(recept: Recept) {
        self.recept = recept
    }
    
    // functie om de afbeelding te laden voor het recept
    func fetchImage(completion: @escaping(UIImage) -> ()) {

        // Eerst controlleren of de image al in de cache zit
        // De completion kan geforceerd worden omdat het in een if-statement zit welke controlleerd of het object aanwezig is
        if ImageCache.cache.object(forKey: NSString(string: self.fotoURL)) != nil {
            completion(ImageCache.cache.object(forKey: NSString(string: self.fotoURL))!)
            return
        }
        
        // Als de foto niet in de cache zit, dan netwerk aanroepen
        NetworkService.getImageFromUrl(fotoUrl: self.fotoURL) { foto in
            completion(foto)
        }
    }
    
    var receptNaam: String {
        guard let naam = recept?.label else {
            return "N/A"
        }
        return naam
    }
    
    var fotoURL: String {
        guard let url = recept?.image else {
            print("URL voor foto van recept niet aanwezig")
            return "N/A"
        }
        return url
    }
    
    var bron: String {
        guard let source = recept?.source else {
            return "N/A"
        }
        return source
    }
    
    var bronUrl: String {
        guard let url = recept?.url else {
            return "N/A"
        }
        return url
    }
    
    var servings: Int {
        guard let yield = recept?.yield else {
            return 0
        }
        return Int(yield)
    }
    
    var dieetLabels: [String] {
        guard let diet = recept?.dietLabels else {
            return []
        }
        return diet
    }
    
    var gezondheidsLabels: [String] {
        guard let health = recept?.healthLabels else {
            return []
        }
        return health
    }
    
    var waarschuwingen: [String] {
        guard let cautions = recept?.cautions else {
            return []
        }
        return cautions
    }
    
    var ingredienten: [String] {
        guard let ingr = recept?.ingredientLines else {
            return []
        }
        return ingr
    }
    
    var kcal: Float {
        guard let calories = recept?.calories else {
            return 0.0
        }
        return calories
    }
    
    var gewicht: Float {
        guard let weight = recept?.totalWeight else {
            return 0.0
        }
        return weight
    }
    
    var bereidingTijd: Int {
        guard let tijd = recept?.totalTime else {
            return 0
        }
        return tijd
    }
    
}
