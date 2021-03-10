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
	
	public var data = [HeroViewModel]()
	public var network = Network()
	public var currentPage = 0
	public var isLoading = true
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.configureTableView()
		self.loadData()
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
				
				guard let self = self else { return }
				
				//check for errors or no data received
				if error != nil && data != nil && data!.count > 0 {
					self.showAlert(message: "Verifique su conexion a internet.", title: "Error")
					self.isLoading = false
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
	private func showAlert(message: String, title: String? = nil) {
		let control = UIAlertController(title: title, message: message, preferredStyle: .alert)
		control.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		
		DispatchQueue.main.async {
			self.present(control, animated: true, completion: nil)
		}
	}
	
	/** Show loading indicator, this is a thread safe function.
	- Parameters:
		- visible: flag to show/hide dialog
	*/
	private func showActivity(visible: Bool) {
		
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

