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
	}
}
