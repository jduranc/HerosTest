//
//  DataController.swift
//  HeroTest
//
//  Created by Luis Duran on 3/20/21.
//

import Foundation

class DataController {
	/// Event handler for start request data
	typealias OnStartHandler = (()->Void)?
	
	/// Event handler for report erroron the request
	typealias OnErrorHandler = ((Error?)->Void)?
	
	/// Event handler for completion, returning the new index added to the data.
	typealias OnCompleteHandler = (([IndexPath]?)->Void)?
	
	var network : Network!
	
	public var isBusy = false
	
	init() {
		self.network = Network()
	}
	
	init(network: Network!) {
		self.network = network
	}
}
