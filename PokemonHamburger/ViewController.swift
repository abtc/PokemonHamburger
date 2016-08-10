//
//  ViewController.swift
//  PokemonHamburger
//
//  Created by Kuma on 8/10/16.
//  Copyright © 2016 Windward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let ScreenWidth = UIScreen.mainScreen().bounds.width
    let ScreenHeight = UIScreen.mainScreen().bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pokemonButton = PokemonHamburgerButton(frame: CGRectMake(0, 0, 200, 200))
        pokemonButton.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2 - 200)
        pokemonButton.addTarget(self, action: #selector(self.reverseAnimation(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(pokemonButton)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reverseAnimation(pokemonButton: PokemonHamburgerButton) {
        pokemonButton.isOn = !pokemonButton.isOn
    }
}

