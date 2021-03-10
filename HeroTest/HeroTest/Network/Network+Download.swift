//
//  Network+Download.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit


extension Network {
	
	/// URL handler for functions on `Network` class, response is returned as `URL` array data.
	typealias URLHandler = NetworkHandler<URL>
	
	/**
	Function to retrieve Heros data array for ids passed.
	- Parameters:
		- endpoint: String value with the url path to the file to download.
		- handler: Closure function to handle `URLHandler` the response of request.
	*/
	public func download(endpoint: String, handler: URLHandler) {
		guard let url = URL(string: endpoint) else {
			handler?(nil, NetworkError.InvalidURL(url: endpoint))
			return
		}
		
		self.download(url: url, handler: handler)
	}
	
	/**
	Function to retrieve Heros data array for ids passed.
	- Parameters:
		- endpoint: URL value with the path to the file to download.
		- handler: Closure function to handle `URLHandler` the response of request.
	*/
	public func download(url: URL, handler: URLHandler) {
		
		let request = URLRequest(url: url)
		
		/// *NOTICE* downlaod taks will remove url file as soon as complete the closure. Do not call handler on diferent queue.
		let task = URLSession.shared.downloadTask(with: request) { (url, response, error) in
			if error != nil {
				handler?(nil, error)
				return
			}
			
			guard let url = url else {
				handler?(nil, NetworkError.NoDataResponse)
				return
			}
			
			handler?(url, nil)
		}
		task.resume()
	}
}
