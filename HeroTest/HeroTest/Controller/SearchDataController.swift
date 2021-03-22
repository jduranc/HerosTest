//
//  SearchController.swift
//  HeroTest
//
//  Created by Luis Duran on 3/20/21.
//

import Foundation

class SearchDataController : DataController {
	
	public private(set) var data = [HeroViewModel]()
	private var isSearching = false
	
	private var isLoading = false
	override var isBusy: Bool {
		get {
			return isSearching
		}
		set { }
	}
	
	public func cancel() {
		self.data.removeAll()
	}
	
	/**
	Perform search proces, the API return all possible matches with the parameter.
	- Parameters:
		- text: the hero's name to search.
		- onStart: handler called before start the update request.
		- onComplete: handler called when the request completes successfully.
		- onError: hanlder called when an error occurs on the request.
	*/
	public func search(text: String, onStart: OnStartHandler = nil, onComplete: OnCompleteHandler, onError: OnErrorHandler = nil) {
		
		self.isSearching = true
		
		DispatchQueue.main.async {
			onStart?()
		}
		
		DispatchQueue.global(qos: .background).async {
			
			self.network.search(text: text) { [weak self] (data, error) in
				guard let self = self else {
					return
				}
				
				//remove the searching flag
				self.isSearching = false
				
				//check for error
				if error != nil {
					var networkError = true
					
					//if error is no data, do no threat erro like network error
					if let netErr = error as? NetworkError {
						networkError = (netErr != .NoDataResponse)
					}
					
					if networkError {
						DispatchQueue.main.async {
							onError?(error)
						}
						return
					}
				}
				
				self.data.removeAll()
				
				//build the new rows indexs
				var newIdxs = [IndexPath]()
				for item in data! {
					let model = HeroViewModel(model: item)
					self.data.append(model)
					newIdxs.append(IndexPath(row: self.data.count - 1, section: 0))
				}
				
				//call complete
				DispatchQueue.main.async {
					onComplete?(newIdxs)
				}
			}
		}
	}
}
