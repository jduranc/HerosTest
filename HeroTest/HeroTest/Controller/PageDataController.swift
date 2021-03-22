//
//  UpdateController.swift
//  HeroTest
//
//  Created by Luis Duran on 3/20/21.
//

import Foundation

class PageDataController : DataController {
	
	public private(set) var data = [HeroViewModel]()
	public private(set) var page = 0
	
	private var isLoading = false
	override var isBusy: Bool {
		get {
			return isLoading
		}
		set { }
	}
	
	/**
	Load Heros data at given page. Default page is 0.
	- Parameters:
		- page: the index of page to retrieve
		- onStart: handler called before start the update request.
		- onComplete: handler called when the request completes successfully.
		- onError: hanlder called when an error occurs on the request.
	*/
	func load(page: Int = 0, onStart: OnStartHandler = nil, onComplete: OnCompleteHandler, onError: OnErrorHandler = nil) {
		
		self.isLoading = true
		
		DispatchQueue.main.async {
			onStart?()
		}
		
		DispatchQueue.global(qos: .background).async {
			
			self.network.getHero(page: page) { [weak self] (data, error) in
				
				guard let self = self else {
					return
				}
				
				//check for error
				if error != nil || data == nil || data?.count == 0 {
					
					DispatchQueue.main.async {
						onError?(error)
					}
					
//					// Do not retry by default, let the handler to call it
//					if self.data.count == 0 {
//						self.load(page: page, onStart: onStart, onComplete: onComplete, onError: onError)
//					}
					return
				}
								
				//build the new rows indexs
				var newIdxs = [IndexPath]()
				for item in data! {
					let model = HeroViewModel(model: item)
					self.data.append(model)
					newIdxs.append(IndexPath(row: self.data.count - 1, section: 0))
				}
			
				//update the current page and remove the loading flag
				self.page = page
				self.isLoading = false
				
				// call complete
				DispatchQueue.main.async {
					onComplete?(newIdxs)
				}
			}
		}
	}
}
