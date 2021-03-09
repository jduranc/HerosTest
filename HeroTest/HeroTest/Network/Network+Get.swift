//
//  Network+Get.swift
//  HeroTest
//
//  Created by Luis Duran on 08/03/21.
//

import UIKit

extension Network {

	/**
	Function to retrieve Heros Ids based on pages, *NOTE* since SuperHero API doesn't provide pagination information, this function is used to simulate the API.
	- Parameters:
		- page: Int value with current page to search.
		- handler: Closure function to handle the response of request. This handler will be called on preset 'dispatchQueue', mainQueue by default.
	*/
	public func getPage(page: Int, handler: IDsHandler) {
		
		let idx = page * 10;
		var pages: [Int] = []
		for i in 0..<10 {
			pages.append(idx+i)
		}
		
		handler?(pages, nil)
	}
	
	/**
	Function to retrieve Heros data array for ids passed.
	- Parameters:
		- page: Int value with current page to search.
		- handler: Closure function to handle `ArrayDataHandler` the response of request. This handler will be called on preset 'dispatchQueue', mainQueue by default.
	*/
	public func get(page: Int, handler: ArrayDataHandler) {
		
		self.getPage(page: page) { (ids, error) in
			
			if error != nil {
				handler?(nil, error)
				return
			}
			guard let ids = ids, ids.count > 0 else {
				handler?(nil, NetworkError.NoDataResponse)
				return
			}
			
			var items = [[String: AnyObject]]()
			var requests = ids.count
			
			for id in ids {
				
				self.getId(id: id) { (data, error) in
					//sync the operations with counter and shared array results.
					Mutex.synced(requests) {
						//reduce pending requests
						requests -= 1
						guard let data = data, data.count > 0 && error == nil else {
							return
						}
						
						let item = data
						items.append(item)
					}
				}
			}
			
			//wait while pending requests
			while(requests > 0) {
				sleep(1)
			}
			
			handler?(items, nil)
		}
	}
	
	/**
	Function to retrieve Heros data array for ids passed.
	- Parameters:
		- id: Int value for character information
		- handler: Closure function to handle `DataHandler` the response of request. This handler will be called on preset 'dispatchQueue', mainQueue by default.
	*/
	public func getId(id: Int, handler: DataHandler) {
		let url = Endpoint.Base + "/\(id)"
		self.doRequest(endpoint: url, method: "GET", handler: handler)
	}
	
	
	/// Data handler for functions on `Network` class, response is returned as `[[String: AnyObject]]` array data.
	typealias ArrayHeroModelHandler = NetworkHandler<[HeroModel]>
	
	public func getTest(handler: ArrayHeroModelHandler) {
		let batman = HeroModel()
		batman.id = 69
		batman.name = "batman"
		batman.url = "https://www.superherodb.com/pictures2/portraits/10/100/10441.jpg"
		
		let superman = HeroModel()
		superman.id = 50
		superman.name = "superman"
		
		let acuaman = HeroModel()
		acuaman.id = 100
		acuaman.name = "acuaman"
		
		var results = [HeroModel]()
		results.append(batman)
		results.append(superman)
		results.append(acuaman)
		
		handler?(results, nil)
	}
}
