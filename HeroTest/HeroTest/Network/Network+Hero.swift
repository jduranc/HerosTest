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
	
	public func getHero(page: Int, handler: HeroArrayHandler) {
		
		self.get(page: page) { (data, error) in
		
			if error != nil {
				handler?(nil, error)
				return
			}
			guard let data = data, data.count > 0 else {
				handler?(nil, NetworkError.NoDataResponse)
				return
			}
			
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
