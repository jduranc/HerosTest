//
//  NetworkError.swift
//  HeroTest
//
//  Created by Luis Duran on 08/03/21.
//

import UIKit

public enum NetworkError: Error, LocalizedError {
	case InvalidURL(url: String)
	case InvalidParameters(parameters: [String: AnyObject])
	case NoDataResponse
	case InvalidDataResponse(data: Data)
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
}
