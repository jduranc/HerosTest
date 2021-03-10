//
//  HeroTableViewCell+Hero.swift
//  HeroTest
//
//  Created by Luis Duran on 10/03/21.
//

import UIKit
import Hero

extension HeroTableViewCell {
	
	/**
	Configure the views for hero animation
	*/
	public func configureHero(enabled: Bool) {
		self.isHeroEnabled = enabled
		
		self.lbName.heroID = "name"
		self.lbFullname.heroID = "fullname"
		self.imIcon.heroID = "icon"
		self.vwFrame.heroID = "picture"
	}
}
