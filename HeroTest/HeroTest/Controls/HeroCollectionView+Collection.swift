//
//  HeroCollectionView+Collection.swift
//  HeroTest
//
//  Created by Luis Duran on 3/19/21.
//

import Foundation
import UIKit

extension HeroCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func initCollection() {
		let nib = UINib.init(nibName: "HeroCollectionViewCell", bundle: nil)
		self.vwCollection.register(nib, forCellWithReuseIdentifier: "heroCell")
		
		self.vwCollection.dataSource = self
		self.vwCollection.delegate = self
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.data != nil ? self.data.count : 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if let cell = self.vwCollection.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as? HeroCollectionViewCell {
			cell.model = self.data[indexPath.row]
//			cell.heroID = "\(self.heroBaseName)_cell_\(model.mode.rawValue)_\(indexPath.row)"
//			cell.prepareForHero(sufix: cell.heroID)
			return cell
		}
		
		fatalError()
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		
		let count = self.data.count
		
		var low : CGFloat = 15.0
		var high : CGFloat = 30.0
		
		var spacing : CGFloat = 0.0
		if let layout = self.vwCollection.collectionViewLayout as? UICollectionViewFlowLayout {
			spacing = (count <= 1) ? 0.0 : (count == 2) ? high : low
			layout.minimumInteritemSpacing = spacing
			layout.minimumLineSpacing = spacing
//			layout.invalidateLayout()
		}
		
		spacing = CGFloat((count - 1)) * spacing
		let size = (CGFloat(count) * (cellSize.width)) + spacing
		
		let width = self.vwCollection.frame.size.width
//		let height = self.vwCollection.frame.size.height
//		print("width: \(width), height: \(height)")
		
		if size < width {
			let inset = (width - size) / 2.0
			return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
		} else {
			return UIEdgeInsets.zero
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: cellSize.width, height: cellSize.height)
	}
	
}
