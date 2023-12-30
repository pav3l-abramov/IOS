//
//  DishDetailViewController.swift
//  FoodDelivery
//
//  Created by user252252 on 12/27/23.
//
import UIKit
import ProgressHUD

class DishDetailViewController: UIViewController {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var providerLbl: UILabel!
    
    var dish: Dish!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateView()
    }
    
    private func populateView() {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
        priceLbl.text = dish.formattedPrice
        providerLbl.text = dish.prvd.name
        
        providerLbl.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(DishDetailViewController.labelClicked))
        providerLbl.addGestureRecognizer(tap)
    }
    
    //let tap = UITapGestureRecognizer(target: DishDetailViewController.self, action: #selector(DishDetailViewController.labelClicked))
    
    //providerLbl.isUserInteractionEnabled = true
    
    
    
    @IBAction func placeOrderBtnClicked(_ sender: UIButton) {
        ProgressHUD.show("Placing Order...")
        NetworkService.shared.placeOrder(dishId: dish.id ?? "", name: dish.formattedPrice ?? "89.9$") { (result) in
            switch result {
            case .success(_):
                ProgressHUD.showSuccess("Your order has been received.")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    @objc
    func labelClicked(sender:UITapGestureRecognizer) {
        let controller = ProviderViewController.instantiate()
        controller.prov = dish.prvd
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
