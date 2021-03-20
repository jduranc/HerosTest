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
	
	public var model : HeroViewModel!
	public var network : Network!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.btClose.rounded()
		
		self.configureHero()
		self.configureChart()
		
		update()
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
		
		if let local = model.localImage {
			
			self.vwFrame.load(url: local, time: 0)
			
//// TODO: validate image is actually downloaded
//			} else if let url = model.image {
//				self.imPicture.alpha = 0
//				self.downloadImage(url: url)
//			} else {
//				self.imPicture.alpha = 1
		}
	}

	@IBAction func onClickClose(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
}
