//
//  MainViewController+CollectionView.swift
//  HeroTest
//
//  Created by Luis Duran on 3/21/21.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {

	func configureCollection() {
//		let grid = UINib.init(nibName: "HeroCollectionViewCell", bundle: nil)
//		self.vwCollection.register(grid, forCellWithReuseIdentifier: "HeroGrid")
		
		let row = UINib.init(nibName: "HeroListCollectionViewCell", bundle: nil)
		self.vwCollection.register(row, forCellWithReuseIdentifier: "HeroRow")

		self.vwCollection.dataSource = self
		self.vwCollection.delegate = self
	}

	// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		if self.searchControl.data.count > 0 {
			return self.searchControl.data.count
		}
		return self.pageControl.data.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		var model: HeroViewModel! = nil
		
		//select model from search or the main list
		if self.searchControl.data.count > 0 {
			model = self.searchControl.data[indexPath.row]
		} else {
			model = self.pageControl.data[indexPath.row]
		}
		
//		let id = self.vwCollection.mode == .Grid ? "HeroGrid" : "HeroRow"
		let id = "HeroRow"
		if let cell = self.vwCollection.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? HeroCollectionViewCell {
			cell.model = model
			cell.setMode(grid: self.vwCollection.mode == .Grid)
			return cell
		}

		fatalError()
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		//hide keyboard
		self.view.endEditing(true)
		
		var model: HeroViewModel! = nil
		
		//select model from search or the main list
		if self.searchControl.data.count > 0 {
			model = self.searchControl.data[indexPath.row]
		} else {
			model = self.pageControl.data[indexPath.row]
		}
		
		if let cell = self.vwCollection.cellForItem(at: indexPath) as? HeroCollectionViewCell {
			
			//disable previous cells
			lastHeroCollectionCell?.isHeroEnabled = false
			lastHeroCollectionCell = cell
			cell.isHeroEnabled = true
		}
		
		self.openDetails(model: model)
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		//do not apply load data if displaying search items
		if self.searchControl.data.count == 0 {
			//call load next page if about display last row
			if indexPath.row == self.pageControl.data.count - 2 && !self.pageControl.isBusy {
				self.loadData(page: self.pageControl.page + 1)
			}
		}
	}
}
