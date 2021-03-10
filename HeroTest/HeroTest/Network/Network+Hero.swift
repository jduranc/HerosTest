//
//  Network+Hero.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit

extension Network {

	/// URL handler for functions on `Network` class, response is returned as `HeroModel` array data.
	typealias HeroArrayHandler = NetworkHandler<[HeroModel]>
	
	/**
	Function to retrieve HeroModels array.
	- Parameters:
		- page: page index for Heros
		- handler: Closure function to handle `HeroArrayHandler` the response of request.
	*/
	public func getHero(page: Int, handler: HeroArrayHandler) {
		
		// retrieve array data for page
		self.get(page: page) { (data, error) in
		
			if error != nil {
				handler?(nil, error)
				return
			}
			
			guard let data = data, data.count > 0 else {
				handler?(nil, NetworkError.NoDataResponse)
				return
			}
			
			//build HeroModel array with data received
			var items = [HeroModel]()
			for item in data {
				if let model = HeroModel(data: item) {
					items.append(model)
				}
			}
			
			handler?(items, nil)
		}
	}
}
