//
//  UIView+Fade.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit

extension UIView {
	func fadeOut(time: Double) {
		DispatchQueue.main.async {
			UIView.animate(withDuration: time, animations: {
				self.alpha = 0
			})
		}
	}
	
	func fadeIn(time: Double) {
		DispatchQueue.main.async {
			UIView.animate(withDuration: time, animations: {
				self.alpha = 1
			})
		}
	}
}
