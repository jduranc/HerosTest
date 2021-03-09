//
//  ViewController.swift
//  HeroTest
//
//  Created by Luis Duran on 08/03/21.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		
		let network = Network()
		
		network.getId(id: 69, handler: { (data, error) in
			
			if data != nil {
				print("data: \(data!)")
			}
		})
	}


}

