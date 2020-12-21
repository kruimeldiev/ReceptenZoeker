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
    
    @IBOutlet weak var timeImage: UIImageView!
    @IBOutlet weak var receptTime: UILabel!
    
    @IBOutlet weak var servingsImage: UIImageView!
    @IBOutlet weak var receptServings: UILabel!
    
    @IBOutlet weak var kcalImage: UIImageView!
    @IBOutlet weak var receptKcal: UILabel!
    
    func makeReceptTableViewCell(recept: ReceptViewModel) {

        // De foto die 'escaped' uit de completion handler van de fetchImage functie wordt gebruikt als receptFoto
        recept.fetchImage() { foto in
            self.receptFoto.image = foto
        }
        self.receptFoto.layer.cornerRadius = 16
        
        self.receptTitle.text = recept.receptNaam
        
        self.timeImage.image = UIImage(systemName: "clock")
        self.receptTime.text = "\(recept.bereidingTijd)"
        
        self.servingsImage.image = UIImage(systemName: "person")
        self.receptServings.text = "\(recept.servings)"
        
        self.kcalImage.image = UIImage(systemName: "k.circle")
        self.receptKcal.text = "\(recept.kcal)"
    }
    
}
