//
//  ViewController.swift
//  Bite About It
//
//  Created by Hector Matos on 8/2/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import UIKit

let yelpClientID = "QbC-Ihegy7vTSj57N7SzxA"
// TODO: Whenever you release to the App Store, regenerate these since you're streaming and stuff.
let yelpClientSecret = "nNUNGym1XRPNigfvYQtTgtZnUUHwBgEhBc97UsCKzI6iP7Nm9hri6DX8Gy3DkWVJ"

class ViewController: UIViewController {
    @IBOutlet weak var restaurantLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func didTapFetchRestaurantButton() {
        print("BUTTON TAPPED")
    }
}

