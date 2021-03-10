//
//  MainViewController+TableView.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	
	func configureTableView() {
		self.vwTable.dataSource = self
		self.vwTable.delegate 	= self
	}
	
	// MARK: - UITableViewDataSource & UITableViewDelegate
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if self.searchItems.count > 0 {
			return self.searchItems.count
		}
		return self.data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var model: HeroViewModel! = nil
		
		if self.searchItems.count > 0 {
			model = self.searchItems[indexPath.row]
		} else {
			model = self.data[indexPath.row]
		}
		
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? HeroTableViewCell {
			cell.network = self.network
			cell.model = model
			return cell
		}
		
		fatalError("Unable to create cell")
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
		//do not apply load data if displaying search items
		if self.searchItems.count == 0 {
			//call load next page if about display last row
			if indexPath.row == self.data.count - 1 && !self.isLoading {
				self.loadData(page: self.currentPage + 1)
			}
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//hide keyboard
		self.view.endEditing(true)
		
		var model: HeroViewModel! = nil
		
		//select model from search or the main list
		if self.searchItems.count > 0 {
			model = self.searchItems[indexPath.row]
		} else {
			model = self.data[indexPath.row]
		}

		let control = DetailsViewController.viewController()
		control.model = model
		
		self.present(control, animated: true, completion: nil)
	}
}
