//
//  DetailsViewController+Storyboard.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit


extension DetailsViewController {
	
	public static func viewController() -> DetailsViewController {
		return DetailsViewController.viewController(identifier: String(describing: self))
	}
	
	public static func viewController(identifier: String, storyboard: String = "Main") -> DetailsViewController {
		let storyboard = UIStoryboard(name: storyboard, bundle: nil)
		let control = storyboard.instantiateViewController(withIdentifier: identifier) as! DetailsViewController
		return control
	}
}
