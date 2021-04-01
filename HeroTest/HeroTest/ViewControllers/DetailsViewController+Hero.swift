//
//  DetailsViewController+Hero.swift
//  HeroTest
//
//  Created by Luis Duran on 10/03/21.
//

import UIKit
import Hero

extension DetailsViewController {
	
	/**
	Configure the views for hero animation
	*/
	public func configureHero() {
		self.isHeroEnabled = true
		
		self.lbName.heroID = "name"
//		self.lbFullname.heroID = "fullname"
		self.imIcon.heroID = "icon"
		self.vwFrame.heroID = "picture"
		
		self.view.heroModifiers = [.cascade()]
		self.imIcon.heroModifiers = [.arc(intensity: 0.85), .rotate(1.5)]
		self.vwFrame.heroModifiers = [.arc(intensity: -0.95)]
	}
}
