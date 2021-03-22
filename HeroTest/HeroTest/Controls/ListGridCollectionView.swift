//
//  ListGridCollectionView.swift
//  HeroTest
//
//  Created by Luis Duran on 3/21/21.
//

import UIKit

class ListGridCollectionView: UICollectionView {

	/// Define the modes for the collection
	enum Mode {
		case List
		case Grid
	}
	
	/// Current mode for the collection
	public private(set)var mode : Mode = .List
	
	/// Determine the expected item width when collection is in list mode. Notice this value will be updated to the collection view width when resized.
	var listItemWidth : CGFloat = 100.0 {
		didSet {
			self.listLayout.itemSize = CGSize(width: listItemWidth, height: 140)
		}
	}
	
	/// Specify the grid item size (square)
	var gridSize : CGFloat = 120.0 {
		didSet {
			self.gridLayout.itemSize = CGSize(width: 120 , height: 120)
		}
	}
	
	private var isBusy = false
	
	/// Specify the layout for items when in `Mode` is `List`
	private var listLayout: UICollectionViewFlowLayout = {

		let collectionFlowLayout = UICollectionViewFlowLayout()
		collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		collectionFlowLayout.itemSize = CGSize(width: 375, height: 140)
		collectionFlowLayout.minimumInteritemSpacing = 0
		collectionFlowLayout.minimumLineSpacing = 0
		collectionFlowLayout.scrollDirection = .vertical
		return collectionFlowLayout
	}()

	/// Specify the layout for items when in `Mode` is `Grid`
	private var gridLayout: UICollectionViewFlowLayout = {
		
		let collectionFlowLayout = UICollectionViewFlowLayout()
		collectionFlowLayout.scrollDirection = .vertical
		collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		collectionFlowLayout.itemSize = CGSize(width: 120 , height: 120)
		collectionFlowLayout.minimumInteritemSpacing = 2
		collectionFlowLayout.minimumLineSpacing = 2
		return collectionFlowLayout
	}()
	
	
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		self.collectionViewLayout = self.listLayout
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.collectionViewLayout = self.listLayout
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		//update the width for list items
		self.listItemWidth = self.frame.width
	}
	
	/**
	Change the current mode for the collection, reloading the current visible cells.
	*/
	public func changeTo(mode: Mode) -> Bool {
		
		if self.isBusy { return false }
		
		self.isBusy = true
		self.mode = mode
		
		let visibles =  self.indexPathsForVisibleItems
		self.reloadItems(at: visibles)
		
		let layout = mode == .List ? self.listLayout : self.gridLayout
		
		self.startInteractiveTransition(to: layout) { (_, _) in
			if let first = visibles.first {
				self.scrollToItem(at: first, at: .top, animated: true)
			}
		}
		
		self.finishInteractiveTransition()
		self.isBusy = false
		
		return true
	}
}
