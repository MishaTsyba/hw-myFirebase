//
//  UserMenuController.swift
//  hw-myFirebase
//
//  Created by Mykhailo Tsyba on 2/26/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit

class UserMenuController: UIViewController {

	//MARK: - Outlet variables
	@IBOutlet weak var addUserView: UIView!
	@IBOutlet weak var addUserLabel: UILabel!
	@IBOutlet weak var listAllUserView: UIView!
	@IBOutlet weak var listAllUserLabel: UILabel!
	@IBOutlet weak var addNewUserPropertyView: UIView!
	@IBOutlet weak var addNewUserPropertyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
		designUI()
    }
    
	@IBAction func didTapAddUserButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: "UserAddController") as! UserAddController
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction func didTapListAllUsersButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: "UserListController") as! UserListController
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction func didTapAddNewUserPropertyButton(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: "UserListAddPropertyController") as! UserListAddPropertyController
		navigationController?.pushViewController(vc, animated: true)
	}
}

extension UserMenuController {
	func designUI() {
		designView(view: addUserView)
		designView(view: listAllUserView)
		designView(view: addNewUserPropertyView)
	}

	func designView(view: UIView) {
		view.layer.borderWidth = 0.8
		view.layer.borderColor = UIColor(red: 253/255, green: 203/255, blue: 110/255, alpha: 1.0).cgColor
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowRadius = 3
		view.layer.shadowOpacity = 2
		view.layer.shadowOffset = CGSize(width: 0, height: 0)
	}

}
