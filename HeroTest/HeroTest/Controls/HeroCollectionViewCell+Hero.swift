//
//  HeroCollectionViewCell+Hero.swift
//  HeroTest
//
//  Created by Luis Duran on 3/20/21.
//

import Foundation
extension HeroCollectionViewCell {
	/**
	Configure the views for hero animation
	*/
	public func configureHero(enabled: Bool) {
		self.isHeroEnabled = enabled
		
		self.lbName.heroID = "name"
		self.imIcon.heroID = "icon"
		self.vwFrame.heroID = "picture"
	}
}
