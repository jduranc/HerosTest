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
		self.imPicture.rounded()
		self.imPicture.contentMode = .scaleAspectFit
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
	
	private func downloadImage(url: URL) {
		
		self.network.download(url: url) { [weak self] (url, error) in
			guard let self = self, let url = url, error == nil else {
				return
			}
			
			let fm = FileManager.init()
			let dst = fm.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("\(self.model.id).jpg")
			
			do {
				try? fm.removeItem(at: dst)
				try fm.moveItem(at: url, to: dst)
				
				self.updateImage(url: dst)
			} catch let error {
				print("Error: \(error)")
			}
		}
	}
	
	private func updateImage(url: URL) {
		if let data = try? Data(contentsOf: url),
		   let image = UIImage(data: data) {
			
			DispatchQueue.main.async {
				self.imPicture.image = image
				self.imPicture.fadeIn(time: 1)
			}
		}
	}
	
}
