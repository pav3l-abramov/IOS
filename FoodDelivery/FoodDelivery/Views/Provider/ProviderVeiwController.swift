//
//  ProviderVeiwController.swift
//  FoodDelivery
//
//  Created by user252252 on 12/27/23.
//

import Foundation
import UIKit

class ProviderViewController: UIViewController {
    
    @IBOutlet weak var providerImg: UIImageView!
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var prioviderPhone: UILabel!
    @IBOutlet weak var providerDescription: UILabel!
    @IBOutlet weak var providerEmail: UILabel!
    @IBOutlet weak var providerSite: UILabel!
    
    var prov: Provider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateView()
    }
    
    private func populateView() {
        //providerImg.kf.setImage(with: prov.logo.asUrl)
//        if let fPath = Bundle.main.path(forResource: prov.logo, ofType: "jpg"), let image = UIImage(contentsOfFile: fPath) {
//            providerImg.contentMode = .scaleAspectFit
//            providerImg.image = image
//        }
        
        providerImg.image = UIImage(named: prov.logo)
        providerName.text = prov.name
        prioviderPhone.text = prov.phone
        providerDescription.text = prov.description
        providerEmail.text = prov.eMail
        providerSite.text = prov.site

    }
}
