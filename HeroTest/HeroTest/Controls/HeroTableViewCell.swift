//
//  HeroTableViewCell.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

	@IBOutlet weak var lbName: UILabel!
	@IBOutlet weak var imPicture: UIImageView!
	@IBOutlet weak var vwFrame: UIView!
	
	public var network : Network!
	public var model: HeroViewModel! {
		didSet {
			self.lbName.text = model.name
			
			
			if let url = model.image {
				self.imPicture.alpha = 0
				self.downloadImage(url: url)
			} else {
				self.imPicture.alpha = 1
			}
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
        // Initialization code
		self.vwFrame.rounded()
		self.imPicture.contentMode = .scaleAspectFill
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.lbName.text = nil
		self.imPicture.image = nil
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
