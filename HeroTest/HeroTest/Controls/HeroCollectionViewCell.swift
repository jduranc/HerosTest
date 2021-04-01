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
	
	@IBOutlet weak var cnsFrameSize: NSLayoutConstraint!
	@IBOutlet weak var cnsIconSize: NSLayoutConstraint!
	
	@IBOutlet var cnsLayoutList: [NSLayoutConstraint]!
	@IBOutlet var cnsLayoutGrid: [NSLayoutConstraint]!
	
	var model : HeroViewModel? {
		didSet {
			
			self.vwFrame.model = self.model
			
			self.imIcon.image = self.model?.icon
			self.lbName.text = self.model?.name
			self.lbFullname?.text = self.model?.fullName
		}
	}
	
	func setMode(grid: Bool) {
		
		
		if grid {
			NSLayoutConstraint.deactivate(cnsLayoutList)
			NSLayoutConstraint.activate(cnsLayoutGrid)
		} else {
			NSLayoutConstraint.deactivate(cnsLayoutGrid)
			NSLayoutConstraint.activate(cnsLayoutList)
		}
		
	
		
		if !grid {
			self.cnsFrameSize.constant = 100
		}
		
		self.lbFullname?.isHidden = grid
		self.lbName.adjustsFontSizeToFitWidth = !grid
		self.lbName.textAlignment = grid ? .center : .left
		self.cnsIconSize.constant = grid ? 28 : 36
		
		if grid {
			self.lbName.font = UIFont.preferredFont(forTextStyle: .title3)
			self.lbName.numberOfLines = 2
		} else {
			self.lbName.font = UIFont.preferredFont(forTextStyle: .title1)
			self.lbName.numberOfLines = 1
		}
		self.superview?.layoutIfNeeded()
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
