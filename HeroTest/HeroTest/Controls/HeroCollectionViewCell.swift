//
//  HeroCollectionViewCell.swift
//  HeroTest
//
//  Created by Luis Duran on 3/19/21.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var lbName: UILabel!
	@IBOutlet weak var vwFrame: HeroPhotoView!
	@IBOutlet weak var imIcon: UIImageView!
	
	var model : HeroViewModel? {
		didSet {
			
			if let url = model?.localImage {
				self.vwFrame.load(url: url)
			}
			
			self.imIcon.image = self.model?.icon
			self.lbName.text = self.model?.name
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.vwFrame.rounded()
	}
	
	override func prepareForReuse() {
		self.vwFrame.image = nil
		self.imIcon.image = nil
	}
	
//	func prepareForHero(sufix: String?) {
//		let name = sufix ?? "_"
//		self.vwFrame.prepareForHero(sufix: name)
//	}
	
}
