//
//  DetailsViewController.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit
import Charts

class DetailsViewController: UIViewController {

	@IBOutlet weak var vwFrame: HeroPhotoView!
	@IBOutlet weak var lbName: UILabel!
	
	@IBOutlet weak var lbFullname: UILabel!
	@IBOutlet weak var lbAlterEgo: UILabel!
	@IBOutlet weak var lbPlaceOfBirth: UILabel!
	@IBOutlet weak var lbFirstAppearance: UILabel!
	@IBOutlet weak var lbPublisher: UILabel!
	@IBOutlet weak var imIcon: UIImageView!
	
	
	@IBOutlet weak var lbOcupation: UILabel!
	@IBOutlet weak var lbBase: UILabel!
	@IBOutlet weak var btClose: UIButton!
	@IBOutlet weak var vwChart: BarChartView!
	@IBOutlet weak var vwCollection: HeroCollectionView!
	
	public var model : HeroViewModel!
	public var network : Network!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.btClose.rounded()
		
		self.configureHero()
		self.configureChart()
		
		self.update()
		self.loadRandom()
    }
    
	func update() {
	
		self.lbName.text = model.name
		self.lbFullname.text = model.fullName
		self.lbAlterEgo.text = model.alterEgos
		self.lbPlaceOfBirth.text = model.placeOfBirth
		self.lbFirstAppearance.text = model.firstAppearance
		self.lbPublisher.text = model.publisher
		self.imIcon.image = model.icon
		
		self.lbOcupation.text = model.occupation
		self.lbBase.text = model.base

		self.vwFrame.model = self.model
	}
	
	/**
	Load a list of random Heros data for top collection
	*/
	func loadRandom() {
		DispatchQueue.global(qos: .background).async {
			
			self.network.getRandomHeros(count: 10, handler: { [weak self] (data, error) in
				guard let self = self else {
					return
				}
				
				if error != nil || data == nil || data?.count == 0 {
					//retry
					self.loadRandom()
					return
				}
				
				var models = [HeroViewModel]()
				for item in data! {
					let model = HeroViewModel(model: item)
					models.append(model)
				}
				
				DispatchQueue.main.async {
					self.vwCollection.data = models
				}
			})
		}
	}

	@IBAction func onClickClose(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
}
