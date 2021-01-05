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
    
    var originalHeight: CGFloat!
    
    @IBOutlet weak var receptFotoView: UIImageView!
    @IBOutlet weak var receptFotoViewHeight: NSLayoutConstraint!
    @IBOutlet weak var receptFotoVIewTop: NSLayoutConstraint!
    @IBOutlet weak var detailViewScrollView: UIScrollView!
    @IBOutlet weak var receptInfoView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailViewScrollView.delegate = self
        
        recept.fetchImage() { foto in
            self.receptFotoView.image = foto
        }
        
        self.receptInfoView.layer.cornerRadius = 20
        
        originalHeight = receptFotoViewHeight.constant
    }
    
    
}

extension ReceptDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = detailViewScrollView.contentOffset.y
        let defaultTop = CGFloat(0)
        var currentTop = defaultTop
        
        if offset < 0 {
             currentTop = offset
            receptFotoViewHeight.constant = originalHeight - offset
        } else {
            receptFotoViewHeight.constant = originalHeight
        }
        
        receptFotoVIewTop.constant = currentTop
        
    }
    
}
