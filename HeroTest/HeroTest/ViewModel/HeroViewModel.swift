//
//  HeroViewModel.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit

class HeroViewModel: NSObject {
	var model : HeroModel!
	
	/**
	Init `HeroViewModel` with model reference.
	- Parameters:
		- model: object reference to `HeroModel`
	*/
	init(model: HeroModel) {
		self.model = model
	}
	
	/**
	Init `HeroViewModel` with model reference.
	- Parameters:
		- data: dictonary to build `HeroModel`, *NOTICE*, that data must fullfit the conditions to build `HeroModel` instance.
		- return: `HeroViewModel` instance if data is valid, otherwise return nil.
	*/
	init?(data: [String: Any]) {
		guard let model = HeroModel(data: data) else {
			return nil
		}
		
		self.model = model
	}
	
	
	/// Hero name
	var name : String {
		get {
			return self.model.name!
		}
	}
	
	/// Hero id
	var id : Int {
		get {
			return self.model.id!
		}
	}
	
	/// the URL to hero image if model url is valid, otherwise return nil
	var image : URL? {
		get {
			if let path = model.image,
			   let url = URL(string: path) {
				return url
			}
			
			return nil
		}
	}
}
