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
	@IBOutlet weak var lbFullname: UILabel?
	
	var model : HeroViewModel? {
		didSet {
			
			self.vwFrame.model = self.model
			
			self.imIcon.image = self.model?.icon
			self.lbName.text = self.model?.name
			self.lbFullname?.text = self.model?.fullName
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.configureHero()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.vwFrame.rounded()
	}
	
	override func prepareForReuse() {
		self.vwFrame.image = nil
		self.imIcon.image = nil
		self.isHeroEnabled = false
	}
}
