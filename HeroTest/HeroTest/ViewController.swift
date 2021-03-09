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
		network.get(page: 1) { (pages, error) in
			print(pages)
		}
		
		network.get(page: 3) { (pages, error) in
			print(pages)
		}
	}


}

