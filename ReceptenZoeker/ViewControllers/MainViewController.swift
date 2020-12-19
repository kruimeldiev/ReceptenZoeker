//
//  MainViewController.swift
//  ReceptenZoeker
//
//  Created by Casper Daris on 15/12/2020.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var zoekTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func zoekReceptenButton(_ sender: Any) {
        if zoekTextField.text != "" {
            performSegue(withIdentifier: "naarReceptenLijst", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // De ViewController aanmaken van de volgende view
        let viewController = segue.destination as! ReceptenLijstViewController
        
        viewController.title = self.zoekTextField.text!
        
        // De ZoekResultaatVM instantiëren van de ReceptenLijstViewController
        // De completion handler wacht tot de netwerk call fetchRecepten voltooid is, vervolgens wordt de tableView herladen
        viewController.zoekResultaatVM.fetchRecepten(zoekTerm: self.zoekTextField.text!) {
            // Het herladen van de TableView wordt uitgevoerd op de main thread omdat het een UIKit functie is
            DispatchQueue.main.async {
                viewController.receptenLijstTableView.reloadData()
            }
        }
    }
    
}
