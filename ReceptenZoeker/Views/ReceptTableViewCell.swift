//
//  ReceptTableViewCell.swift
//  ReceptenZoeker
//
//  Created by Casper Daris on 15/12/2020.
//

import UIKit

class ReceptTableViewCell: UITableViewCell {

    @IBOutlet weak var receptFoto: UIImageView!
    @IBOutlet weak var receptTitle: UILabel!
    @IBOutlet weak var bereidingTijdLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    
    func makeReceptTableViewCell(recept: ReceptViewModel) {
        
        // De foto die 'escaped' uit de completion handler van de fetchImage functie wordt gebruikt als receptFoto
        recept.fetchImage() { foto in
            self.receptFoto.image = foto
        }
        
        self.receptTitle.text = recept.receptNaam
        self.bereidingTijdLabel.text = String(recept.bereidingTijd)
        self.kcalLabel.text = String(recept.kcal)
        
    }
}
