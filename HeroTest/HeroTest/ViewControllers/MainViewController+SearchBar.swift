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
		
		self.searchControl.cancel()
		
		DispatchQueue.main.async {
			self.vwCollection.reloadData()
		}
	}
	
	/**
	Perform search proces, the API return all possible matches with the parameter.
	- Parameters:
		- text: the hero's name to search.
	*/
	@objc func search(text: String) {
		if self.searchControl.isBusy { return }
		
		self.searchControl.search(text: text) { [weak self] in
			self?.showActivity(visible: true)
			
		} onComplete: { [weak self] (newIdx) in
			guard let self = self else { return	}
			
			self.showActivity(visible: false)
			
			if newIdx == nil || newIdx?.count == 0 {
				self.showAlert(message: "No se encontraron resultados.", title: "Informacion")
				return
			}
			
			self.vwCollection.reloadData()
			
		} onError: { [weak self] (error) in
			guard let self = self else { return	}
			
			self.showActivity(visible: false)
			self.showAlert(message: "Verifique su conexion a internet.", title: "Error")
		}
	}
	
	// MARK: - UISearchBarDelegate
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		timer?.invalidate()
		
		if let text = searchBar.text, !text.isEmpty {
			timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] (_) in
				guard let self = self else { return }
				
				self.search(text: text)
			})
		}
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		if let text = searchBar.text, !text.isEmpty {
			self.search(text: text)
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
			
			let currentInsets = self.vwCollection.contentInset
			let insets = UIEdgeInsets(top: currentInsets.top, left: currentInsets.left, bottom: content.size.height, right: currentInsets.right)
			
			self.vwCollection.contentInset = insets
		}
	}
	
	@objc func onKeyboardHide(_ notification: Notification) {
		let currentInsets = self.vwCollection.contentInset
		let insets = UIEdgeInsets(top: currentInsets.top, left: currentInsets.left, bottom: 0, right: currentInsets.right)
		self.vwCollection.contentInset = insets
	}
}
