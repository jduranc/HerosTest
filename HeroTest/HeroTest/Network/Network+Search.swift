//
//  Network+Search.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit

extension Network {

	/**
	Function to search Heros by name.
	- Parameters:
		- text: the Hero's name to search.
		- handler: Closure function to handle `HeroArrayHandler` the response of request.
	*/
	public func search(text: String, handler: HeroArrayHandler) {
		
		let url = Endpoint.Base + Endpoint.Search+"/\(text)"
		
		self.doRequest(endpoint: url, method: "GET", handler: { (data, error) in
			if error != nil {
				handler?(nil, error)
				return
			}
			
			guard let data = data,
				  let results = data["results"] as? [[String: AnyObject]],
				  data.count > 0 && results.count > 0 else {
				handler?(nil, NetworkError.NoDataResponse)
				return
			}
			
			//build HeroModel array with data received
			var items = [HeroModel]()
			for item in results {
				if let model = HeroModel(data: item) {
					items.append(model)
				}
			}
			
			handler?(items, nil)
		})
	}
}
