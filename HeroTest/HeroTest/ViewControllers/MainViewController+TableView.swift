//
//  MainViewController+TableView.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit

//extension MainViewController: UITableViewDelegate, UITableViewDataSource {
//
//	func configureTableView() {
//		self.vwTable.dataSource = self
//		self.vwTable.delegate 	= self
//	}
//
//	// MARK: - UITableViewDataSource & UITableViewDelegate
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//		if self.searchControl.data.count > 0 {
//			return self.searchControl.data.count
//		}
//		return self.pageControl.data.count
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//		var model: HeroViewModel! = nil
//
//		if self.searchControl.data.count > 0 {
//			model = self.searchControl.data[indexPath.row]
//		} else {
//			model = self.pageControl.data[indexPath.row]
//		}
//
//
//		if let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? HeroTableViewCell {
//
//			cell.network = self.network
//			cell.model = model
//			return cell
//		}
//
//		fatalError("Unable to create cell")
//	}
//
//	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		return 100
//	}
//
//	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//		//do not apply load data if displaying search items
//		if self.searchControl.data.count == 0 {
//			//call load next page if about display last row
//			if indexPath.row == self.pageControl.data.count - 2 && !self.pageControl.isBusy {
//				self.loadData(page: self.pageControl.page + 1)
//			}
//		}
//	}
//
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		//hide keyboard
//		self.view.endEditing(true)
//
//		var model: HeroViewModel! = nil
//
//		//select model from search or the main list
//		if self.searchControl.data.count > 0 {
//			model = self.searchControl.data[indexPath.row]
//		} else {
//			model = self.pageControl.data[indexPath.row]
//		}
//
//		if let cell = self.vwTable.cellForRow(at: indexPath) as? HeroTableViewCell {
//
//			//disable previous cells
//			lastHeroCollectionCell?.isHeroEnabled = false
//			lastHeroTableCell?.isHeroEnabled = false
//			lastHeroTableCell = cell
//
//			cell.isHeroEnabled = true
//		}
//
//		self.openDetails(model: model)
//	}
//}
