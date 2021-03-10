//
//  MainViewController+SearchBar.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit

extension MainViewController: UISearchBarDelegate {
	
	/**
	Function configure the search bar control
	*/
	func configureSearchBar() {
		self.vwSearch.delegate = self
		
		//handle keyboard events
		NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	
	/**
	Cancel the search process, remove the search results items and reload table with previous loaded data
	*/
	private func cancelSearch() {
		
		self.searchItems.removeAll()
		
		DispatchQueue.main.async {
			self.vwTable.reloadData()
		}
	}
	
	// MARK: - UISearchBarDelegate
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		if let text = searchBar.text, !text.isEmpty {
			
			self.showActivity(visible: true)
			
			DispatchQueue.global(qos: .background).async {
				
				self.network.search(text: text) { [weak self] (array, error) in
					guard let self = self else {
						return
					}
					
					self.showActivity(visible: false)

					//check for error
					if error != nil {
						var networkError = true
						
						//if error is no data, do no threat erro like network error
						if let netErr = error as? NetworkError {
							networkError = (netErr != .NoDataResponse)
						}
						
						if networkError {
							self.cancelSearch()
							self.showAlert(message: "Verifique su conexion a internet.", title: "Error")
							return
						}
					}
					
					if array == nil || array?.count == 0 {
						self.showAlert(message: "No se encontraron resultados.", title: "Informacion")
						return
					}
					
					self.searchItems.removeAll()
					
					for item in array! {
						let model = HeroViewModel(model: item)
						self.searchItems.append(model)
					}
					
					DispatchQueue.main.async {
						self.vwTable.reloadData()
					}
				}
			}
		} else {
			cancelSearch()
		}
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		cancelSearch()
		self.view.endEditing(true)
	}
	
	// MARK: - Keyboard events
	@objc func onKeyboardShow(_ notificaiton: Notification) {
		if let userInfo = notificaiton.userInfo,
			let objSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey],
			let content = objSize as? CGRect {
			
			let currentInsets = self.vwTable.contentInset
			let insets = UIEdgeInsets(top: currentInsets.top, left: currentInsets.left, bottom: content.size.height, right: currentInsets.right)
			
			self.vwTable.contentInset = insets
		}
	}
	
	@objc func onKeyboardHide(_ notification: Notification) {
		let currentInsets = self.vwTable.contentInset
		let insets = UIEdgeInsets(top: currentInsets.top, left: currentInsets.left, bottom: 0, right: currentInsets.right)
		self.vwTable.contentInset = insets
	}
}
