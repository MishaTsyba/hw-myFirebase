//
//  UserProfileController.swift
//  hw-myFirebase
//
//  Created by Mykhailo Tsyba on 2/26/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {

	@IBOutlet weak var headerView: UIView!
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var propertiesTableView: UITableView!
	@IBOutlet weak var backButton: UIButton!

	var user = UserFirebase()
	var userProperties = [(key: String, value: Any)]()

	override func viewDidLoad() {
		super.viewDidLoad()
		designUI()
		propertiesTableView.delegate = self
		propertiesTableView.dataSource = self
		propertiesTableView.register(UINib(nibName: "UserPropertyCell", bundle: nil), forCellReuseIdentifier: "UserPropertyCell")
		userProperties = convertUserProperties(user: user)
		propertiesTableView.reloadData()
	}

	@IBAction func didTapBackButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
}

//MARK: - UITableViewDelegate
extension UserProfileController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return userProperties.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "UserPropertyCell", for: indexPath) as! UserPropertyCell
		cell.updateUserPropertyCell(property: userProperties[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

//MARK: - Convert User Properties
extension UserProfileController {
	func convertUserProperties(user: UserFirebase) -> [(String, Any)] {
		guard let userProperties = user.properties else {return []}
		var propertyArray = [(String, Any)]()
		for (key, value) in userProperties {
			let property = (key, value)
			if property.0 != "Id" {
				propertyArray.append(property)
			}
		}
		propertyArray.sort { (first, second) -> Bool in
			first.0 < second.0
		}
		return propertyArray
	}
}
 extension UserProfileController {
	//MARK: - DesignUI
	func designUI() {
		designView(view: headerView)
		designView(view: userImageView)
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
