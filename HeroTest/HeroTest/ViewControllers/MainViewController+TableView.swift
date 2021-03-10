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
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let model = self.data[indexPath.row]
		
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
		
		//call load next page if about display last row
		if indexPath.row == self.data.count - 1 && !self.isLoading {
			self.loadData(page: self.currentPage + 1)
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = self.data[indexPath.row]
		let control = DetailsViewController.viewController()
		control.model = model
		
		self.present(control, animated: true, completion: nil)
	}
}
