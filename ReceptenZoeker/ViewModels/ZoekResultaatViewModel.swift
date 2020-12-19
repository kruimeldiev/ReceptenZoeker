//
//  ZoekResultaatViewModel.swift
//  ReceptenZoeker
//
//  Created by Casper Daris on 15/12/2020.
//

import Foundation
import UIKit

// De ViewModel moet een class zijn in plaats van een struct, dit komt omdat een struct een 'value type' is
// Value types zijn immutable omdat deze altijd gekopieerd worden wanneer ze rondgestuurd worden
// Een class is een 'reference type'
class ZoekResultaatViewModel {
    
    private var zoekResultaat: ZoekResultaat?
    
    private var imageCache = ImageCache()
    
    var zoekTerm: String {
        guard let q = zoekResultaat?.q else {
            return ""
        }
        return q
    }
    
    var aantalResultaten: Int {
        guard let count = zoekResultaat?.count else {
            return 0
        }
        return count
    }
    
    var recepten: [ReceptViewModel] {
        
        // Unwrapping van een array vol met recepten
        guard let hits = zoekResultaat?.hits else {
            return []
        }
        
        // Array maken voor ReceptViewModels
        var receptenHits = [ReceptViewModel]()
        
        // Voor ieder recept in hits (zoekResultaat.hits), een nieuwe ReceptViewModel instantiëren en in receptenHits plaatsen
        for hit in hits {
            receptenHits.append(ReceptViewModel.init(recept: hit.recipe))
        }
        
        return receptenHits
    }
    
    // Deze functie roept de NetwerkService aan om de data uit de API op te halen
    // Dankzij de completion handler kan er een functie worden uitgevoerd nadat de netwerk call gemaakt en voltooid is
    func fetchRecepten(zoekTerm: String, completion: @escaping() -> ()) {
        NetworkService.getSearchResult(searchTerm: zoekTerm) { result in
            self.zoekResultaat = result
            completion()
        }
    }
    
}
