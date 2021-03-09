//
//  HeroTableViewCell+Image.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit

extension HeroTableViewCell {
	
	public func downloadImage(url: URL) {
		
		let fm = FileManager.init()
		let dst = fm.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("\(self.model.id).jpg")
		//TODO: implement check for already downloaded images
		
		//request download the image from the url
		self.network.download(url: url) { [weak self] (url, error) in
			guard let self = self, let url = url, error == nil else {
				return
			}
			
			do {
				try? fm.removeItem(at: dst)
				try fm.moveItem(at: url, to: dst)
				
				self.updateImage(url: dst)
			} catch { //let error {
				//print("downloadImage Error: \(error)")
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
