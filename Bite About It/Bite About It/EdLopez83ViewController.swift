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
        let operation = Kwelly8AuthenticationOperation()
        operation.completionBlock = {
            print(operation.accessToken)
        }
        operation.start()
    }
}
