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
    
    // Deze boolean houdt bij of er momenteel data wordt geladen vanuit de API
    var isFetching = false
    
    // Dit getal houdt bij hoevaak er een fetch is gedaan voor deze ViewModel
    // Hiermee kan je ervoor zorgen dat dezelfde resultaten niet worden gedownload wanneer je meer recepten fetched
    var aantalFetches = 0
    
    // Dit is het aantal recepten dat wordt gedownload per keer dat er een netwerk call wordt gemaakt
    let receptenLadenPerCall = 10
    
    var recepten = [ReceptViewModel]()
    
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
    
    // Deze functie roept de NetwerkService aan om de data uit de API op te halen
    // Dankzij de completion handler kan er een functie worden uitgevoerd nadat de netwerk call gemaakt en voltooid is (zoals reloaden van TableView)
    func fetchRecepten(zoekTerm: String, vanaf: Int, tot: Int, completion: @escaping() -> ()) {
        
        self.isFetching = true
        print("Begin Fetch")
        
        NetworkService.getSearchResult(searchTerm: zoekTerm, vanafAantal: vanaf, totAantal: tot) { result in
            self.zoekResultaat = result
            
            // Recepten toevoegen aan de 'recepten' array
            self.appendRecepten()
            
            self.aantalFetches += 1
            
            self.isFetching = false
            print("Einde Fetch")
            completion()
        }
    }
    
    // Deze functie zorgt ervoor dat de data die wordt gedownload ook wordt toegevoegd aan de recepten array
    func appendRecepten() {
        
        // Unwrapping van een array vol met recepten
        guard let hits = zoekResultaat?.hits else {
            print("Geen hits gevonden")
            return
        }
        
        // Voor ieder recept in hits (zoekResultaat.hits), een nieuwe ReceptViewModel instantiëren en in receptenHits plaatsen
        for hit in hits {
            recepten.append(ReceptViewModel.init(recept: hit.recipe))
        }
    }
    
}
