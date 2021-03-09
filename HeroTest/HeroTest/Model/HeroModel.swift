//
//  HeroModel.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit

/// HeroModel for represnet hero information.
class HeroModel: NSObject {
	///current ID on server
	public var id: Int!
	public var name: String?
	public var powerstats: [String: Int]?
//	public var biography: [String: String]?
	public var aliases: [String: String]?
	public var url: String?
	
	override init() {
		
	}
	
	/**
	Init `HeroModel` with content of data. *NOTICE*, two members are requerid to be a valid model data, `id` and `name`.
	- Parameters:
		- data: dictionary with data to build the hero model
		- return: if model data is valid, return the model created, otherwise return nil.
	*/
	init?(data: [String: Any]) {
		
		guard let id = data["id"] as? Int,
			  let name = data["name"] as? String else {
			return nil
		}
		
		self.id = id
		self.name = name
		self.url = data["url"] as? String
		self.powerstats = data["powerstats"] as? [String: Int]
		self.aliases = data["aliases"] as? [String: String]
	}
}
