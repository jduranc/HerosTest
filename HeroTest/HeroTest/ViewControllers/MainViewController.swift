//
//  MainViewController.swift
//  HeroTest
//
//  Created by Luis Duran on 08/03/21.
//

import UIKit

class MainViewController: UIViewController {

	@IBOutlet weak var vwTable: UITableView!
	@IBOutlet weak var cnsTableBottom: NSLayoutConstraint!
	@IBOutlet weak var vwActivityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var vwSearch: UISearchBar!
	@IBOutlet weak var vwCollection: HeroCollectionView!
	
	public var data = [HeroViewModel]()
	public var searchItems = [HeroViewModel]()
	public var network = Network()
	public var currentPage = 0
	public var isLoading = true
	
	/// Reference to last HeroCell configurated to disable the effect
	public weak var lastHeroTableCell : HeroTableViewCell?
	public weak var lastHeroCollectionCell : HeroCollectionViewCell?
	//timer for search
	public var timer: Timer?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.configureTableView()
		self.configureSearchBar()
		self.loadData()
		
		self.loadRandom()
		self.vwCollection.onSelectHandler = { [weak self] model, cell in
			guard let self = self, let model = model else { return }
			
			//disable previous cells
			self.lastHeroTableCell?.isHeroEnabled = false
			self.lastHeroCollectionCell?.isHeroEnabled = false
			self.lastHeroCollectionCell = cell
			
			cell?.isHeroEnabled = true
			self.openDetails(model: model)
		}
	}
	
	/**
	Load a list of random Heros data for top collection
	*/
	func loadRandom() {
		DispatchQueue.global(qos: .background).async {
			
			self.network.getRandomHeros(count: 10, handler: { [weak self] (data, error) in
				guard let self = self else {
					return
				}
				
				if error != nil || data == nil || data?.count == 0 {
					//retry
					self.loadRandom()
					return
				}
				
				var models = [HeroViewModel]()
				for item in data! {
					let model = HeroViewModel(model: item)
					models.append(model)
				}
				
				DispatchQueue.main.async {
					self.vwCollection.data = models
				}
			})
		}
	}
	
	/**
	Load Heros data at given page. Default page is 0.
	- Parameters:
		- page: the index of page to retrieve
	*/
	func loadData(page: Int = 0) {
		
		self.isLoading = true
		self.currentPage = page
		self.showActivity(visible: true)
		
		DispatchQueue.global(qos: .background).async {
			
			self.network.getHero(page: page) { [weak self] (data, error) in
				
				guard let self = self else {
					return
				}
				
				self.showActivity(visible: false)
				
				//check for error
				if error != nil || data == nil || data?.count == 0 {
					
//					self.showAlert(message: "Verifique su conexion a internet.", title: "Error") { (action) in
//						if self.data.count == 0 {
//							self.loadData()
//						}
//					}
					if self.data.count == 0 {
						self.loadData()
					}
					return
				}
								
				//build the new rows indexs
				var newIdxs = [IndexPath]()
				for item in data! {
					let model = HeroViewModel(model: item)
					self.data.append(model)
					newIdxs.append(IndexPath(row: self.data.count - 1, section: 0))
				}
			
				//update current table rows
				DispatchQueue.main.async {
					self.vwTable.insertRows(at: newIdxs, with: .fade)
					self.showActivity(visible: false)
					self.isLoading = false
				}
			}
		}
	}
		
	/**
	Display alert dialog with message and title (optional), this is a thread safe function.
	- Parameters:
		- message: display message for the dialog
		- title: title used for the dialog
	*/
	public func showAlert(message: String, title: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
		let control = UIAlertController(title: title, message: message, preferredStyle: .alert)
		control.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
		
		DispatchQueue.main.async {
			self.present(control, animated: true, completion: nil)
		}
	}
	
	/** Show loading indicator, this is a thread safe function.
	- Parameters:
		- visible: flag to show/hide dialog
	*/
	public func showActivity(visible: Bool) {
		
		//be sure to call on main thread
		DispatchQueue.main.async {
			var posX : CGFloat = 0.0
			if visible {
				posX = -40.0
				self.vwActivityIndicator.fadeIn(time: 0.1)
				self.vwActivityIndicator.startAnimating()
			} else {
				self.vwActivityIndicator.stopAnimating()
				self.vwActivityIndicator.fadeOut(time: 0.33)
			}
		
			self.view.setNeedsLayout()
			self.cnsTableBottom.constant = posX
			UIView.animate(withDuration: 0.1) {
				self.view.layoutIfNeeded()
			}
		}
	}
}

