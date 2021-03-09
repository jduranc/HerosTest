//
//  UIView+Rounded.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit

extension UIView {
	
	/**
	Apply rounded border to the `UIView` using the minimal value between width and height
	*/
	func rounded() {
		self.clipsToBounds = true
		let minimal = min(self.frame.size.height, self.frame.size.width)
		self.layer.cornerRadius = minimal / 2
	}
}
