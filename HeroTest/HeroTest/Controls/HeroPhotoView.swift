//
//  HeroPhotoView.swift
//  HeroTest
//
//  Created by Luis Duran on 19/03/21.
//

import UIKit
import SDWebImage

class HeroPhotoView: UIView {

	@IBOutlet var contentView: UIView?
	@IBOutlet weak var imPhoto: UIImageView?
	
	var model : HeroViewModel! {
		didSet {
			
			if let url = self.model.image {
				self.imPhoto?.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed) { [weak self] (image, error, _, url) in
					guard let self = self else { return }
					
//					self.model.localImage = url
					self.imPhoto?.alpha = 0
					self.image = image
					self.imPhoto?.fadeIn(time: 3)
				}
			}
		}
	}
	
	@IBInspectable var image : UIImage? {
		didSet {
			self.imPhoto?.image = image
		}
	}
	
	override var backgroundColor: UIColor? {
		didSet {
			self.imPhoto?.backgroundColor = backgroundColor
			self.contentView?.backgroundColor = backgroundColor
			self.layer.borderColor = backgroundColor?.cgColor
		}
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.setupNib()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupNib()
	}
	
	/**
	Perform the setup for loading the NIB and attaching to the owner view.
	*/
	private func setupNib() {
		
		#if TARGET_INTERFACE_BUILDER
		self.backgroundColor = .red
		return
		#endif

		Bundle.main.loadNibNamed("HeroPhotoView", owner: self, options: nil)
		addSubview(self.contentView!)
		
		self.contentView!.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[self.contentView!.topAnchor.constraint(equalTo: self.topAnchor),
			 self.contentView!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			 self.contentView!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			 self.contentView!.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			]
		)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.clipsToBounds = true
		self.rounded()
		self.imPhoto?.contentMode = .scaleAspectFill
		
		//update background color
		let backcolor = self.backgroundColor
		self.backgroundColor = backcolor
		
		//set border and color
		self.layer.borderWidth = 3
		self.layer.borderColor = backcolor?.cgColor
	}
}
