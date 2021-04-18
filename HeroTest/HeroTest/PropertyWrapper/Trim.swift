//
//  Trim.swift
//  HeroTest
//
//  Created by Luis Duran on 4/17/21.
//

import Foundation

@propertyWrapper
public struct Trim {
	private(set) var value : String? = ""
	
	public var wrappedValue : String? {
		get { value }
		set {
			value = newValue?.trimmingCharacters(in: .whitespacesAndNewlines)
		}
	}
	
	public init(wrappedValue initialValue: String?) {
		self.wrappedValue = initialValue
	}
}

