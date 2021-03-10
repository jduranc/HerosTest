//
//  UIView+Fade.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit

extension UIView {
	
	/**
	Perform fade out effect to `UIView`
	- Parameters:
		- time: duration to disapper
	*/
	func fadeOut(time: Double) {
		DispatchQueue.main.async {
			UIView.animate(withDuration: time, animations: {
				self.alpha = 0
			})
		}
	}
	
	/**
	Perform fade out effect to `UIView`
	- Parameters:
		- time: duration to appear
	*/
	func fadeIn(time: Double) {
		DispatchQueue.main.async {
			UIView.animate(withDuration: time, animations: {
				self.alpha = 1
			})
		}
	}
}
