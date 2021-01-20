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
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    @IBOutlet weak var receptFotoView: UIImageView!
    @IBOutlet weak var receptFotoViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var receptDetailView: UIView!
    @IBOutlet weak var receptDetailViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var receptNaamLabel: UILabel!
    @IBOutlet weak var receptBronLabel: UILabel!
    @IBOutlet weak var receptTijdLabel: UILabel!
    @IBOutlet weak var receptServingsLabel: UILabel!
    @IBOutlet weak var receptKcalLabel: UILabel!
    
    @IBOutlet weak var aantalPersonenView: UIView!
    
    @IBOutlet weak var receptIngredientenLabel: UILabel!
    
    var originalFotoHeight = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailScrollView.delegate = self
        
        createDetailView()
    }
    
    func createDetailView() {
        
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .white
        
        self.recept.fetchImage() { foto in
            self.receptFotoView.image = foto
        }
        
        self.receptIngredientenLabel.text = ""
        
        for i in 0..<(self.recept.ingredienten.count) {
            self.receptIngredientenLabel.text?.append("\u{2022} \(self.recept.ingredienten[i])\n")
        }
        
        originalFotoHeight = receptFotoViewHeight.constant
        
        self.receptDetailView.layer.cornerRadius = 20
        
        receptDetailViewTop.constant =  receptFotoViewHeight.constant - 20
        
        receptNaamLabel.text = recept.receptNaam
        receptBronLabel.text = "Bron: \(recept.bron)"
        receptTijdLabel.text = "\(recept.bereidingTijd)'"
        receptServingsLabel.text = "\(recept.servings)"
        receptKcalLabel.text = "\(recept.kcal)"
        
    }
    
    
}

// Deze extension regelt de scroll offset van de UIScrollView in de DEtailView
extension ReceptDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = detailScrollView.contentOffset.y
        
        if offset < 0 {
            
            self.receptFotoViewHeight.constant = originalFotoHeight - offset
            
        }
        
    }
    
}
