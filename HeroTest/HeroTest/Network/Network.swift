//
//  Network.swift
//  HeroTest
//
//  Created by Luis Duran on 08/03/21.
//

import UIKit

/// Netowrk handler for request to Superhero APIs.
class Network: NSObject {

	/// List of endpoints for Superhero API
	struct Endpoint {
		static let Base = "https://superheroapi.com/api/10156112965520834"
		static let Search = "/search"
	}
	
	/// Generic Network handler for funcion calls on 'Network' functions.
	typealias NetworkHandler<T> = ((T?, Error?) -> Void)?
	/// Data handler for functions on `Network` class, response is returned as `[String: AnyObject]` data.
	typealias DataHandler = NetworkHandler<[String: AnyObject]>
	
	/// Data hanlder for ids array
	typealias IDsHandler = NetworkHandler<[Int]>
	
	/// DispatchQueue where function handlers will be called. `DispatchQueue.main` by default.
	public var dispatchQueue : DispatchQueue = DispatchQueue.main
	
	/**
	Perform async request to server, the response is handled by handler parameter.
	- Parameters:
		- endpoint: String with the server end point.
		- method: String with method on server, GET, POST, DELETE, etc.
		- parameters: Dictionary with list of parameters to send in the request.
		- headers: Dictionary with list of header to include in the request. *Notice* "Accept" & "Content-Type" with values "application/json" are included by default.
		- handler: Closure function to handle the response of request. This handler will be called on preset 'dispatchQueue', mainQueue by default.
		- auth: String with access token/ Authorization bearer, if value is nil its not used (default).
	*/
	public func doRequest(endpoint: String, method: String, parameters: [String:AnyObject]?, headers: [String: String]? = nil, handler: DataHandler, auth: String? = nil) {
		guard let url = URL(string: endpoint) else {
			handler?(nil, NetworkError.InvalidURL(url: endpoint))
			return
		}

		var request = URLRequest(url: url)
		request.httpMethod = method
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		if let parameters = parameters, parameters.count > 0 {
			
			//check if used as json
			guard let body = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {
				handler?(nil, NetworkError.InvalidParameters(parameters: parameters))
				return
			}
			
			request.httpBody = body
		}
		
		if let headers = headers, headers.count > 0 {
			headers.forEach { (pair) in
				request.addValue(pair.value, forHTTPHeaderField: pair.key)
			}
		}
		
		if let token = auth, !token.isEmpty {
			request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
		}
		
		let session = URLSession.shared
		let task = session.dataTask(with: request) { (data, response, error) in
			if error != nil {
				self.dispatch(handler: handler, error:error)
				return
			}
			
			if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
				
				self.dispatch(handler: handler, error: NetworkError.ServerError(message: "Server response code: \(httpResponse.statusCode)"))
				return
			}
			
			guard let data = data, data.count > 0 else {
				self.dispatch(handler: handler, error: NetworkError.NoDataResponse)
				return
			}
			
			if let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
			   let values = json as? [String: AnyObject] {
				
//				if let content = values["content"] as? String,
//				   let code = values["code"] as? Int {
//					//do something with response
//				}
				self.dispatch(handler: handler, data: values)
			} else {
				self.dispatch(handler: handler, error: NetworkError.InvalidDataResponse(data: data))
			}
		}
		task.resume()
	}
	
	private func dispatch(handler: DataHandler, data: [String: AnyObject]? = nil, error: Error? = nil) {
		self.dispatchQueue.async {
			handler?(data, error)
		}
	}
}
