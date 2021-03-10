//
//  HeroViewModel.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit

class HeroViewModel: NSObject {
	var model : HeroModel!
	var localImage : URL?
	
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
			
			if let local = self.localImage {
				return local
				
			} else if let path = model.image,
			   let url = URL(string: path) {
				return url
			}
			
			return nil
		}
	}
	
	/// Hero full name
	var fullName : String {
		get {
			return self.model.biography?["full-name"]  ?? "?"
		}
	}
	
	/// Hero alter egos
	var alterEgos : String {
		get {
			return self.model.biography?["alter-egos"] ?? "?"
		}
	}
	
	/// Hero place of birth
	var placeOfBirth : String {
		get {
			return self.model.biography?["place-of-birth"] ?? "?"
		}
	}
	
	/// Hero first appearance
	var firstAppearance : String {
		get {
			return self.model.biography?["first-appearance"]  ?? "?"
		}
	}
	
	/// Publisher
	var publisher : String {
		get {
			return self.model.biography?["publisher"]  ?? "?"
		}
	}
	
	/// Alignment side
	var alignment : String {
		get {
			return self.model.biography?["alignment"]  ?? "?"
		}
	}
	
	/// Occupation
	var occupation : String {
		get {
			return self.model.work?["occupation"]  ?? "?"
		}
	}
	
	/// base
	var base : String {
		get {
			return self.model.work?["base"] ?? "?"
		}
	}
	
	/// icon for Hero/Villain 
	var icon : UIImage? {
		
		get {
			let value = self.alignment
			
			if value == "good" {
				return UIImage(named: "ico_hero")
				
			} else if value == "bad" {
				return UIImage(named: "ico_villain")
			}
			
			return nil
		}
	}
}
