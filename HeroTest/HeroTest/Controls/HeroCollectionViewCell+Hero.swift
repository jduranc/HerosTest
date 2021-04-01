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
	public func configureHero() {
		self.isHeroEnabled = false
		
		self.lbName.heroID = "name"
		self.imIcon.heroID = "icon"
		self.vwFrame.heroID = "picture"
		
		self.heroModifiers = [.cascade()]
		self.imIcon.heroModifiers = [.arc(intensity: -0.85)]
		self.vwFrame.heroModifiers = [.arc(intensity: 0.35)]
	}
}
