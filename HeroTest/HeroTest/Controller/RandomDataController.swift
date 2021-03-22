//
//  RandomController.swift
//  HeroTest
//
//  Created by Luis Duran on 3/21/21.
//

import Foundation

class RandomDataController : DataController {
	
	public private(set) var data = [HeroViewModel]()

	private var isLoading = false
	override var isBusy: Bool {
		get {
			return isLoading
		}
		set { }
	}
	
	/**
	Load a list of random Heros data.
	- Parameters:
		- count: number the Heros to load.
		- onStart: handler called before start the update request.
		- onComplete: handler called when the request completes successfully.
	*/
	func load(count: Int, onStart: OnStartHandler = nil, onComplete: OnCompleteHandler) {
		
		self.isLoading = true
		
		DispatchQueue.main.async {
			onStart?()
		}
		
		DispatchQueue.global(qos: .background).async {
			
			self.network.getRandomHeros(count: count, handler: { [weak self] (data, error) in
				guard let self = self else {
					return
				}
				
				if error != nil || data == nil || data?.count == 0 {
					//retry
					self.load(count: count, onStart: onStart, onComplete: onComplete)
					return
				}
				
				self.data.removeAll()
				
				var newIdxs = [IndexPath]()
				for item in data! {
					let model = HeroViewModel(model: item)
					self.data.append(model)
					newIdxs.append(IndexPath(row: self.data.count - 1, section: 0))
				}
				
				self.isLoading = false
				DispatchQueue.main.async {
					onComplete?(newIdxs)
				}
			})
		}
	}
}
