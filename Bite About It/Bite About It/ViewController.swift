//
//  ViewController.swift
//  Bite About It
//
//  Created by Hector Matos on 8/2/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var restaurantLabel: UILabel!
    var anotherView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapFetchRestaurantButton() {
        Authentication.shared.getAccessToken { result in
            switch result {
            case .success(let token):
                print(token)
            case .failure(let error):
                print("YOU SUCK, HECTOR. LIKE, REALLY. Here's why: \(String(describing: error?.localizedDescription))")
            }
        }
    }
}
