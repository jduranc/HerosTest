//
//  ViewController.swift
//  HeroTest
//
//  Created by Luis Duran on 08/03/21.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var vwTable: UITableView!
	
	fileprivate var data = [HeroViewModel]()
	fileprivate var network = Network()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.configureTableView()
		self.loadData()
//		self.network.getId(id: 69, handler: { (data, error) in
//
//			if data != nil {
//				print("data: \(data!)")
//			}
//		})
	}
	
	func loadData() {
//		self.network.getTest(handler: { (data, error) in
		self.network.getHero(page: 1) { (data, error) in
			
			if error != nil && data != nil && data!.count > 0 {
				return
			}
			
			self.data.removeAll()
			for item in data! {
				let model = HeroViewModel(model: item)
				self.data.append(model)
			}
		
			DispatchQueue.main.async {
				self.vwTable.reloadData()
			}
		}
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	func configureTableView() {
		self.vwTable.dataSource = self
		self.vwTable.delegate 	= self
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let model = self.data[indexPath.row]
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? HeroTableViewCell {
			cell.network = self.network
			cell.model = model
			return cell
		}
		
		fatalError("Unable to create cell")
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
}

