//
//  HeroTableViewCell+Image.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit

extension HeroTableViewCell {
	
	/**
	Download file from URL and move to local cache files. Local URL is stored in model for next access.
	- Parameters:
		- url: URL path to file to download.
	*/
	public func downloadImage(url: URL) {
		
		let fm = FileManager.init()
		let dst = fm.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("\(self.model.id).jpg")
		//TODO: implement check for already downloaded images
		
		//request download the image from the url
		self.network.download(url: url) { [weak self] (url, error) in
			guard let self = self, let url = url, error == nil else {
				return
			}
			
			do {
				try? fm.removeItem(at: dst)
				try fm.moveItem(at: url, to: dst)
				
				self.model.localImage = dst
				self.vwFrame.load(url: dst)
				
			} catch { //let error {
				//print("downloadImage Error: \(error)")
			}
		}
	}
	
}

