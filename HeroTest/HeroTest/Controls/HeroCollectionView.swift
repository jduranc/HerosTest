//
//  HeroCollectionView.swift
//  HeroTest
//
//  Created by Luis Duran on 3/19/21.
//

import UIKit

class HeroCollectionView: UIView {

	@IBOutlet weak var vwCollection: UICollectionView!
	@IBOutlet var contentView: UIView!
	
	var data : [HeroViewModel]! {
		didSet {
			self.vwCollection.reloadData()
		}
	}
	
	/// Handler for selection on cells
	public var onSelectHandler : ((HeroViewModel?, HeroCollectionViewCell?)->Void)?
	
	/// default size for cell
	let cellSize = CGSize(width: 100, height: 100)
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.setupNib()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupNib()
	}
	
	/**
	Perform the setup for loading the NIB and attaching to the owner view.
	*/
	private func setupNib() {
		#if TARGET_INTERFACE_BUILDER
		self.backgroundColor = .red
		return
		#endif
		
		Bundle.main.loadNibNamed("HeroCollectionView", owner: self, options: nil)
		addSubview(self.contentView)
		
		self.contentView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(
			[self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
			 self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			 self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			 self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			]
		)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.initCollection()
	}
}
