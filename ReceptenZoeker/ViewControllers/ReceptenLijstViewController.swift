//
//  ReceptenLijstViewController.swift
//  ReceptenZoeker
//
//  Created by Casper Daris on 15/12/2020.
//

import UIKit

class ReceptenLijstViewController: UIViewController {
    
    @IBOutlet weak var receptenLijstTableView: UITableView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    var zoekResultaatVM = ZoekResultaatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hier wordt de dataSource van de TableView ingesteld
        // Omdat de extension van de PlaylistViewController een UITableViewDataSource is, kun je deze als self instellen
        receptenLijstTableView.dataSource = self

        // Instellen van de delegate van de TableView
        // De delegate regelt alle user interactions in de TableView
        receptenLijstTableView.delegate = self
        
        self.activitySpinner.startAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Controlleren of er een row is geselecteerd door de gebruiker
        guard receptenLijstTableView.indexPathForSelectedRow != nil else {
            return
        }
        
        let geselecteerdeRecept = zoekResultaatVM.recepten[receptenLijstTableView.indexPathForSelectedRow!.row]
        
        let receptVC = segue.destination as! ReceptDetailViewController
        
        receptVC.recept = geselecteerdeRecept
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
        
        self.activitySpinner.isHidden = true
        
        return cell
    }
    
    // Deze functie wordt iedere keer wanneer de gebruiker door de TableView scrollt aangeroepen
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        // Als de gebruiker verder naar beneden scrollt dan de contentHeight min de frame height van de scrollView, wordt dit aangeroepen
        // * 2 zorgt ervoor dat de API fetch net iets eerder wordt aangeroepen
        if offsetY > contentHeight - scrollView.frame.height * 2 {
            
            // Als de data momenteel nog niet geladen wordt dan...
            if !self.zoekResultaatVM.isFetching {
                
                self.zoekResultaatVM.fetchRecepten(zoekTerm: self.zoekResultaatVM.zoekTerm,
                                                   vanaf: (self.zoekResultaatVM.receptenLadenPerCall * self.zoekResultaatVM.aantalFetches),
                                                   tot: (self.zoekResultaatVM.receptenLadenPerCall * self.zoekResultaatVM.aantalFetches + self.zoekResultaatVM.receptenLadenPerCall)) {
                    DispatchQueue.main.async {
                        self.receptenLijstTableView.reloadData()
                    }
                }
            }
        }
    }

}
