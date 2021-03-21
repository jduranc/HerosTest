//
//  HeroTableViewCell.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

	@IBOutlet weak var lbName: UILabel!
	@IBOutlet weak var lbFullname: UILabel!
//	@IBOutlet weak var imPicture: UIImageView!
	@IBOutlet weak var vwFrame: HeroPhotoView!
	@IBOutlet weak var imIcon: UIImageView!
	
	public var network : Network!
	public var model: HeroViewModel! {
		didSet {
			self.lbName.text = model.name
			self.lbFullname.text = model.fullName
			self.imIcon.image = model.icon
			
			self.vwFrame.model = self.model
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
        // Initialization code
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		self.lbName.text = nil
		self.vwFrame.image = nil
		
		self.configureHero(enabled: false)
	}
}
