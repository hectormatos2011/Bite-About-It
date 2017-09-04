//
//  ViewController.swift
//  Bite About It
//
//  Created by Hector Matos on 8/2/17.
//  Copyright © 2017 Hector Matos. All rights reserved.
//

import UIKit

class EdLopez83ViewController: UIViewController {
    @IBOutlet weak var restaurantLabel: UILabel!
    var anotherView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapFetchRestaurantButton() {
        let authenticationOperation = Kwelly8AuthenticationOperation()
        authenticationOperation.start { result in
            switch result {
            case .success(let accessToken):
                print(accessToken)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
