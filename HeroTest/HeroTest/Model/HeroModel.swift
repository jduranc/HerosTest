//
//  HeroModel.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit

/// HeroModel for represnet hero information.
class HeroModel: NSObject {
	/// Current ID on server
	public var id: Int!
	
	/// Hero name
	@Trim
	public var name: String?
	
	/// Power status
	public var powerstats: [String: Int]?
	
	/// Information related to history of hero
	public var biography: [String: String]?
	
//	/// Another names used by Hero
//	public var aliases: [String: String]?
	
	/// Base and job
	public var work: [String: String]?
	
	/// URL with the image of hero
	@Trim
	public var image: String?
	
	override init() {
		
	}
	
	/**
	Init `HeroModel` with content of data. *NOTICE*, two members are requerid to be a valid model data, `id` and `name`.
	- Parameters:
		- data: dictionary with data to build the hero model
		- return: if model data is valid, return the model created, otherwise return nil.
	*/
	init?(data: [String: Any]) {
		
		guard let sid = data["id"] as? String,
			  let id = Int(sid),
			  let name = data["name"] as? String else {
			return nil
		}
		
		self.id = id
		self.name = name
		
		if let values = data["image"] as? [String : String] {
			self.image = values["url"]
		}
		
		if let values = data["powerstats"] as? [String: String] {
			self.powerstats = values.mapValues({ (value) -> Int in
				return Int(value) ?? 0
			})
		}
		
		if let values = data["biography"] as? [String: AnyObject] {
			self.biography = [String: String]()
			for (key, value) in values {
				if let value = value as? String {
					self.biography![key] = value
				}
				
				//TODO: extract aliases
			}
		}
		
		self.work = data["work"] as? [String: String]
		
		//TODO: read other values
	}
}
