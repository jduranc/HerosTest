//
//  DetailsViewController.swift
//  HeroTest
//
//  Created by Luis Duran on 09/03/21.
//

import UIKit

class DetailsViewController: UIViewController {

	@IBOutlet weak var vwFrame: UIView!
	@IBOutlet weak var imPicture: UIImageView!
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
	
	public var model : HeroViewModel!
	public var network : Network!
	
	var initialized = false
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		initialized = true
		self.btClose.rounded()
		self.vwFrame.rounded()
		self.imPicture.contentMode = .scaleAspectFill
		update()
    }
    
	func update() {
	
		self.lbName.text = model.name
//			self.imPicture.image =
		self.lbFullname.text = model.fullName
		self.lbAlterEgo.text = model.alterEgos
		self.lbPlaceOfBirth.text = model.placeOfBirth
		self.lbFirstAppearance.text = model.firstAppearance
		self.lbPublisher.text = model.publisher
//		self.lbAlignment.text = model.alignment
		
		self.imIcon.image = model.icon
		
		self.lbOcupation.text = model.occupation
		self.lbBase.text = model.base
		
		if let local = model.localImage {
			self.imPicture.load(url: local)
			
//			} else if let url = model.image {
//				self.imPicture.alpha = 0
//				self.downloadImage(url: url)
//			} else {
//				self.imPicture.alpha = 1
		}
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	@IBAction func onClickClose(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
}

extension DetailsViewController {
	
	public static func viewController() -> DetailsViewController {
		return DetailsViewController.viewController(identifier: String(describing: self))
	}
	
	public static func viewController(identifier: String, storyboard: String = "Main") -> DetailsViewController {
		let storyboard = UIStoryboard(name: storyboard, bundle: nil)
		let control = storyboard.instantiateViewController(withIdentifier: identifier) as! DetailsViewController
		return control
	}
}
