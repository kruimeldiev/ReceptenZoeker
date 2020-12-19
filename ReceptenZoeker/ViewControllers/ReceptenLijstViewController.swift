//
//  ReceptenLijstViewController.swift
//  ReceptenZoeker
//
//  Created by Casper Daris on 15/12/2020.
//

import UIKit

class ReceptenLijstViewController: UIViewController {
    
    @IBOutlet weak var receptenLijstTableView: UITableView!

    var zoekResultaatVM = ZoekResultaatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hier wordt de dataSource van de TableView ingesteld
        // Omdat de extension van de PlaylistViewController een UITableViewDataSource is, kun je deze als self instellen
        receptenLijstTableView.dataSource = self

        // Instellen van de delegate van de TableView
        // De delegate regelt alle user interactions in de TableView
        receptenLijstTableView.delegate = self
        
    }
}

// Extension voor het maken van de TableView
extension ReceptenLijstViewController: UITableViewDataSource, UITableViewDelegate {

    // Deze functie bepaald hoeveel rows de TableView heeft
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.zoekResultaatVM.recepten.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Instantiëren van een specifieke cell
        let cell = receptenLijstTableView.dequeueReusableCell(withIdentifier: "ReceptCell", for: indexPath) as! ReceptTableViewCell
        
        // De recept data voor in de cell
        let recept = zoekResultaatVM.recepten[indexPath.row]
        
        // Cell opvullen met de data uit recept
        cell.makeReceptTableViewCell(recept: recept)
        
        return cell
    }

}
