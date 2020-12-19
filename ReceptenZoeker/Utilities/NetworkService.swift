//
//  NetworkService.swift
//  ReceptenZoeker
//
//  Created by Casper Daris on 14/12/2020.
//

import Foundation
import UIKit

struct NetworkService {
    
    // Deze functie maakt gebruik van een zoekterm om recepten data te downloaden uit de API
    // De functie is static zodat deze vanuit andere klassen kan worden aangeroepen, zonder dat er iedere keer een nieuwe instantie van NetworkService moet worden aangemaakt
    static func getSearchResult(searchTerm: String, completion: @escaping(ZoekResultaat) -> ()) {
        
        // Maken van de URL en de request
        guard let url = URL(string: Constants.API_URL + searchTerm) else {
            print("API URL is niet beschikbaar")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "x-rapidapi-key")
        request.timeoutInterval = 10.0
        
        // De URLSession regelt het downloaden van de data met behulp van een URL request
        // .shared zorgt ervoor dat je geen nieuwe instanties van URLSession aanmaakt iedere keer als je de functie aanroept, dit heet 'singleton'
        // .dataTask maakt de netwerk call met behulp van de request
        // data, response en error zijn de parameters van de trailing closure
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Error handeling, als er een error aanwezig is, dan stopt de functie en wordt de error uitgeprint
            guard error == nil else {
                print(error!)
                return
            }
            
            // Als er data aanwezig is, wordt het do/catch block uitgevoerd
            if data != nil {
                do {
                    // De JSONDecoder maakt een ZoekResultaat van de ontvangen data
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ZoekResultaat.self, from: data!)
                    
                    // DispatchQueue regelt op welke 'thread' de taken worden uitgevoerd, in dit geval de main thread
                    // .async betekend dat ale taken asynchroon worden uitgevoerd
                    DispatchQueue.main.async {
                        completion(result)
                        print("Data uit API gedownload")
                    }
                } catch {
                    // Dit wordt uitgevoerd als de 'do block' faalt
                    print(error)
                    return
                }
            }
        }.resume()
    }
    
    // Deze functie download een afbeelding met behulp van een URLSession
    static func getImageFromUrl(fotoUrl: String, completion: @escaping(UIImage) -> ()) {
        
        guard let url = URL(string: fotoUrl) else {
            print("Geen foto beschikbaar voor \(fotoUrl)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            // Controlleren of er data aanwezig is zodat deze later unwrapped kan worden
            if data != nil {
                DispatchQueue.main.async {
                    ImageCache.cache.setObject(UIImage(data: data!)!, forKey: NSString(string: fotoUrl))
                    print("Foto gedownload van web")
                    completion(UIImage(data: data!)!)
                }
            }
        }.resume()
    }
}
