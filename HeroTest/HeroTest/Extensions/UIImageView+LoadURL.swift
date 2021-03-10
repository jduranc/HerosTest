//
//  UIImageView.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit

extension UIImageView {
	
	/**
	Perform load image from URL, then apply fadein effect
	- Parameters:
		- url: The url of the image.
		- time: duration to appear, default value 1
	*/
	public func load(url: URL, time: Double = 1.0) {
		
		if let data = try? Data(contentsOf: url),
		   let image = UIImage(data: data) {
			
			DispatchQueue.main.async {
				self.image = image
				self.fadeIn(time: time)
			}
		}
	}
}
