//
//  CutsomTabBar.swift
//  Tourista
//
//  Created by prog_zidane on 11/3/19.
//  Copyright © 2019 prog_zidane. All rights reserved.
//

import UIKit
class CutsomTabBar: UIView {
    
    
    @IBOutlet weak var bellManMenuButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var hotspotButton: UIButton!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var attractionButton: UIButton!
    @IBOutlet weak var map: UIStackView!
    @IBOutlet weak var attractions: UIStackView!
    @IBOutlet weak var events: UIStackView!
    @IBOutlet weak var hotspots: UIStackView!
    @IBOutlet var containerView: UIView!
    var didMenuOpened:((Bool)->())!
    var isMenuOpened = false
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("It is working")
        commonInit()
    }
    
    func commonInit(){
        if let nibView = Bundle.main.loadNibNamed("CustomTabBar", owner: self, options: nil)?.first as? UIView{
            nibView.frame = self.bounds
            self.addSubview(nibView)
            containerView = nibView
            attractionButton.setRadiusWithShadow()
            
            mapButton.setRadiusWithShadow()
            hotspotButton.setRadiusWithShadow()
            eventsButton.setRadiusWithShadow()
            
        }
    }
    @IBAction func didBellMenuButtonPressed(_ sender: Any) {
        AnimationsFactory.animate(bellManMenuButton, animationType: .glow(from: 0.6))
        
        if isMenuOpened{
            hideMenu()
            didMenuOpened(isMenuOpened)
        }else {
            showMenuButtons()
            didMenuOpened(isMenuOpened)
        }
        isMenuOpened = !isMenuOpened
    }
    
    
    func showMenuButtons(){
        self.events.isHidden = false
        self.hotspots.isHidden = false
        self.attractions.isHidden = false
        self.map.isHidden = false
        
        UIView.animate(withDuration: 0.8, delay: 0 , usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4
            , options: .curveEaseInOut  , animations: {
                
                self.hotspots.transform = CGAffineTransform(translationX: -100, y: 0)
                self.events.transform = CGAffineTransform(translationX: -40, y: -70)
                self.attractions.transform = CGAffineTransform(translationX:40, y: -70)
                self.map.transform = CGAffineTransform(translationX: 110, y: 0)
                AnimationsFactory.animate(self.events, animationType: .glow(from: 0.4))
                AnimationsFactory.animate(self.hotspots, animationType: .glow(from: 0.4))
                AnimationsFactory.animate(self.attractions, animationType: .glow(from: 0.4))
                AnimationsFactory.animate(self.map, animationType: .glow(from: 0.4))
                
        }, completion: { _ in
            
        })
        
    }
    func hideMenu(){
        
        self.events.isHidden = true
        self.hotspots.isHidden = true
        self.attractions.isHidden = true
        self.map.isHidden = true
        UIView.animate(withDuration: 0.8, delay: 0 , usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4
            , options: .curveEaseInOut  , animations: {
                
                self.hotspots.transform = CGAffineTransform.identity
                self.events.transform = CGAffineTransform.identity
                self.attractions.transform = CGAffineTransform.identity
                self.map.transform = CGAffineTransform.identity
                
                
                
        }, completion: nil)
        
    }
    
}
