//
//  ReceptDetailViewController.swift
//  ReceptenZoeker
//
//  Created by Casper Daris on 23/12/2020.
//

import UIKit

class ReceptDetailViewController: UIViewController {
    
    // Omdat het recept van de VC wordt bepaald in de segue kan deze geforceerd worden
    var recept: ReceptViewModel!
    
    @IBOutlet weak var receptFoto: UIImageView!
    @IBOutlet weak var receptDetailLayer: UIView!
    @IBOutlet weak var receptServingLayer: UIView!
    @IBOutlet weak var receptNaamLabel: UILabel!
    @IBOutlet weak var receptBronLabel: UILabel!
    @IBOutlet weak var receptTijdLabel: UILabel!
    @IBOutlet weak var receptServingsLabel: UILabel!
    @IBOutlet weak var receptKcalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeDetailView(inputRecept: recept)
    }
    
    func makeDetailView(inputRecept: ReceptViewModel) {
        recept.fetchImage() { foto in
            self.receptFoto.image = foto
        }
        self.receptDetailLayer.layer.cornerRadius = 20
        self.receptServingLayer.layer.borderWidth = 0.3
        self.receptServingLayer.layer.borderColor = UIColor.lightGray.cgColor
        self.receptNaamLabel.text = recept.receptNaam
        self.receptBronLabel.text = "Source: \(recept.bron)"
        self.receptTijdLabel.text = "\(recept.bereidingTijd)'"
        self.receptServingsLabel.text = String(recept.servings)
        self.receptKcalLabel.text = "\(recept.kcal) kcal"
    }
    
    @IBAction func minServingButton(_ sender: Any) {
        if self.recept.servings > 1 {
            self.recept.servings -= 1
            viewDidLoad()
        }
    }
    
    @IBAction func plusServingButton(_ sender: Any) {
        self.recept.servings += 1
        viewDidLoad()
    }
    
}
