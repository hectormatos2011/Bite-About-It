//
//  ViewController.swift
//  Bite About It
//
//  Created by Hector Matos on 8/2/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import UIKit

/**
 This class is dedicated to the badass EdLopez83. Thanks for the sub!!!
 */
class ViewController: UIViewController {
    @IBOutlet weak var restaurantLabel: UILabel!
    var anotherView = UIView()
    
    override final func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapFetchRestaurantButton() {
        BusinessSearchOperation().start { result in
            guard case .success(let businesses) = result else { return }
            print(businesses)
        }
    }
}







