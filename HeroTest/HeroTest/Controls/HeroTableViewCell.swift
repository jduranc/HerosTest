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
	
	public var model: HeroViewModel! {
		didSet {
			self.lbName.text = model.name
		}
	}
	override func awakeFromNib() {
        super.awakeFromNib()
		
        // Initialization code
		self.imPicture.rounded()
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
