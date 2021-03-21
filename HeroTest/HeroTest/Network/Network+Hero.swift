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
	
	/**
	Function to retrieve a random number of Heros.
	- Parameters:
		- count: number of random elements to retrieve for Heros
		- handler: Closure function to handle `HeroArrayHandler` the response of request.
	*/
	public func getRandomHeros(count: Int, max: Int = 100, handler: HeroArrayHandler) {
		
		let ids = (1...count).map( {_ in Int.random(in: 1...max) })
		
		// retrieve array data for items
		self.getIdx(ids: ids, handler: { (data, error) in
			
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
		})
	}
}
