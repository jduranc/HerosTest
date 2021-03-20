//
//  HeroPhotoView.swift
//  HeroTest
//
//  Created by Luis Duran on 19/03/21.
//

import UIKit

class HeroPhotoView: UIView {

	@IBOutlet var contentView: UIView?
	@IBOutlet weak var imPhoto: UIImageView?
	
	@IBInspectable var image : UIImage? {
		didSet {
			self.imPhoto?.image = image
		}
	}
	
	override var backgroundColor: UIColor? {
		didSet {
			self.imPhoto?.backgroundColor = backgroundColor
			self.contentView?.backgroundColor = backgroundColor
		}
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.setup()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}
	
	/**
	Perform the setup for loading the XIB and attaching to the owner view.
	*/
	private func setup() {
		
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
		
		self.clipsToBounds = true
		self.rounded()
		self.imPhoto?.contentMode = .scaleAspectFill
		
		//update background color
		let backcolor = self.backgroundColor
		self.backgroundColor = backcolor
	}
	
	/**
	Perform load image from `URL`, then apply fadein effect
	- Parameters:
		- url: The url of the image.
		- time: duration to appear, default value 1
	*/
	public func load(url: URL, time: Double = 1.0) {
		
		if let data = try? Data(contentsOf: url),
		   let image = UIImage(data: data) {
			
			DispatchQueue.main.async {
				self.imPhoto?.alpha = 0
				self.image = image
				self.imPhoto?.fadeIn(time: time)
			}
		}
	}
}
