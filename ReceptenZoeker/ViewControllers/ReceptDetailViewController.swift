//
//  ReceptDetailViewController.swift
//  ReceptenZoeker
//
//  Created by Casper Daris on 23/12/2020.
//

import UIKit

class ReceptDetailViewController: UIViewController {
    
    var recept: ReceptViewModel?

    @IBOutlet weak var receptFoto: UIImageView!
    @IBOutlet weak var detailTopView: UIView!
    @IBOutlet weak var receptNaamLabel: UILabel!
    @IBOutlet weak var bronDetailLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        recept!.fetchImage() { foto in
            self.receptFoto.image = foto
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailTopView.layer.cornerRadius = 20
        self.receptNaamLabel.text = recept!.receptNaam
        self.bronDetailLabel.text = "Source: \(recept!.bron)"
        self.timeLabel.text = "\(recept!.bereidingTijd) min"
        self.servingsLabel.text = "\(recept!.servings)"
        self.kcalLabel.text = "\(recept!.kcal) kcal"
    }
    
    @IBAction func minServingButton(_ sender: Any) {
        if self.recept!.servings > 0 {
            self.recept?.servings -= 1
            viewDidLoad()
        }
    }
    
    @IBAction func plusServingButton(_ sender: Any) {
        self.recept?.servings += 1
        viewDidLoad()
    }
    

}
