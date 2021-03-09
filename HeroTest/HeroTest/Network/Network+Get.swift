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
	public func get(page: Int, handler: IDsHandler) {
		
		let idx = page * 10;
		var pages: [Int] = []
		for i in 0..<10 {
			pages.append(idx+i)
		}
		
		handler?(pages, nil)
	}
}
