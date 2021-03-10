//
//  NetworkError.swift
//  HeroTest
//
//  Created by Luis Duran on 08/03/21.
//

import UIKit

/// Represent the `Network` Error types.
public enum NetworkError: Error, LocalizedError, Equatable {
	
	///returned when the `URL` can't be formed from given string
	case InvalidURL(url: String)
	
	///returned when parameters are invalid
	case InvalidParameters(parameters: [String: AnyObject])
	
	///returned when server response with no data
	case NoDataResponse
	
	///returned when server response can't be interpreted
	case InvalidDataResponse(data: Data)
	
	///server response with some error message
	case ServerError(message: String)
	
	public var errorDescription: String? {
		
		switch self {
		
		case .InvalidURL(let url):
			return "Invalid URL: \(url)"
			
		case .InvalidParameters(let parameters):
			return "Invalid parameters: \(parameters)"
			
		case .NoDataResponse:
			return "Server returns no data"
			
		case .InvalidDataResponse(let data):
			return "Server response invalid data: \(data.count)"
		
		case .ServerError(let message):
			return "Server response with error: \(message)"
//		default:
//			return "Unknown error"
		}
	}
	
	public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
		return lhs.errorDescription == rhs.errorDescription
	}
}
