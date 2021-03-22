//
//  MainViewController.swift
//  HeroTest
//
//  Created by Luis Duran on 08/03/21.
//

import UIKit

class MainViewController: UIViewController {

//	@IBOutlet weak var vwTable: UITableView!
	
	@IBOutlet weak var vwCollection: ListGridCollectionView!
	@IBOutlet weak var cnsTableBottom: NSLayoutConstraint!
	@IBOutlet weak var vwActivityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var vwSearch: UISearchBar!
	@IBOutlet weak var vwRandomHeros: HeroCollectionView!
	@IBOutlet weak var btSwitch: UIButton!
	
	public var network = Network()
	public var pageControl : PageDataController!
	public var searchControl : SearchDataController!
	public var randomControl : RandomDataController!
	
	/// Reference to last HeroCell configurated to disable the effect
	public weak var lastHeroCollectionCell : HeroCollectionViewCell?
	
	//timer for search
	public var timer: Timer?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.configureCollection()
		self.configureSearchBar()
		
		self.pageControl = PageDataController(network: self.network)
		self.searchControl = SearchDataController(network: self.network)
		self.randomControl = RandomDataController(network: self.network)
		
		self.loadData()
		self.loadRandom()
		
		self.vwRandomHeros.onSelectHandler = { [weak self] model, cell in
			guard let self = self, let model = model else { return }
			
			//disable previous cells
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
		
		self.randomControl.load(count: 10) {
			self.vwRandomHeros.showActivity = true
			
		} onComplete: { (_) in
			self.vwRandomHeros.showActivity = false
			self.vwRandomHeros.data = self.randomControl.data
		}
	}
	
	/**
	Load Heros data at given page. Default page is 0.
	- Parameters:
		- page: the index of page to retrieve
	*/
	func loadData(page: Int = 0) {
		
		self.pageControl.load(page: page) { [weak self] in
			self?.showActivity(visible: true)
			
		} onComplete: { [weak self] (newIdx) in
			guard let self = self, let newIdx = newIdx  else { return }
			
//			self.vwCollection.insertRows(at: newIdx, with: .fade)
			self.vwCollection.insertItems(at: newIdx)
			self.showActivity(visible: false)
			
		} onError: { [weak self] (error) in
			guard let self = self else { return }
			
			self.showActivity(visible: false)
//			self.showAlert(message: "Verifique su conexion a internet.", title: "Error") { (action) in
////				if self.data.count == 0 {
////					self.loadData()
////				}
//			}
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
				posX = 40.0
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
	
	/**
	Open screen details with the information for given Hero.
	- Parameters:
		- model: Hero model to display
	*/
	public func openDetails(model: HeroViewModel) {
		
		let control = DetailsViewController.viewController()
		control.model = model
		control.network = self.network
		control.modalPresentationStyle = .fullScreen
		
		self.present(control, animated: true, completion: nil)
	}
	
	@IBAction func onClickSwitch(_ sender: Any) {
		
		let mode : ListGridCollectionView.Mode = self.vwCollection.mode == .List ? .Grid : .List
		
		if self.vwCollection.changeTo(mode: mode) {
			let icon = self.vwCollection.mode == .List ? UIImage(systemName: "square.grid.2x2.fill") :  UIImage(systemName: "list.bullet")
			btSwitch.setImage(icon, for: .normal)
		}
	}
	
}

