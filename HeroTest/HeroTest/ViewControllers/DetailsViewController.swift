//
//  DetailsViewController.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit
import Charts

class DetailsViewController: UIViewController {

	@IBOutlet weak var vwBackground: UIView!
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
	private var randomControl : RandomDataController!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.btClose.rounded()
		self.vwBackground.roundedCorner(radius: 15)
		self.vwBackground.backgroundColor = self.vwFrame.backgroundColor
		
		self.configureHero()
		self.configureChart()
		
		self.update()
		
		self.randomControl = RandomDataController(network: self.network)
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
		self.randomControl.load(count: 10) {
			self.vwCollection.showActivity = true
			
		} onComplete: { (_) in
			self.vwCollection.showActivity = false
			self.vwCollection.data = self.randomControl.data
		}
	}

	@IBAction func onClickClose(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
}
