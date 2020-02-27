//
//  UserAddPropertyController.swift
//  hw-myFirebase
//
//  Created by Mykhailo Tsyba on 2/26/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserAddPropertyController: UIViewController {

	@IBOutlet weak var headerView: UIView!
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var propertyNameView: UIView!
	@IBOutlet weak var propertyNameTextField: UITextField!
	@IBOutlet weak var propertyValueView: UIView!
	@IBOutlet weak var propertyValueTextField: UITextField!
	@IBOutlet weak var addNewPropertyButton: UIButton!
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!

	var ref: DatabaseReference = Database.database().reference(fromURL: "https://hw-myfirebase.firebaseio.com/")

	var user = UserFirebase()
	var usersDataBaseSnapshot: [String: Any] = [:]

	override func viewDidLoad() {
		super.viewDidLoad()
		debugPrint("*********** UserAddPropertyController *** viewDidLoad ********")
//		debugPrint(user.properties)
		designUI()
		propertyNameTextField.delegate = self
		propertyValueTextField.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		debugPrint("*********** UserAddPropertyController *** viewWillAppear ********")
//		debugPrint(user.properties)
	}

	@IBAction func didTapAddButton(_ sender: Any) {
		addPropertyToFirebase(user: self.user)
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: "UserListController") as! UserListController
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction func didTapBackButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
}

extension UserAddPropertyController {
	//MARK: - Add User to Firebase
	func addPropertyToFirebase(user: UserFirebase) {
		ref.observeSingleEvent(of: .value, with: { (snapshot) in
			debugPrint("*********** UserAddPropertyController addPropertyToFirebase  users **************")
//			debugPrint(snapshot)
//			debugPrint(self.user.id)
			if let value = snapshot.value as? [String: Any] {
				debugPrint(value)
				if let users = value["Users"] as? [String: Any] {
					self.usersDataBaseSnapshot = users
					debugPrint("*********** UserAddPropertyController *** usersDataBaseSnapshot *** BEFORE new property **************")
					debugPrint(self.usersDataBaseSnapshot)
					debugPrint("*********** UserAddPropertyController *** user.properties *** BEFORE new property **************")
//					debugPrint(self.user.properties)
					guard let currentUserId = user.id else {return}
					debugPrint(currentUserId)
					guard var userProperties = user.properties else {return}
//					debugPrint(user.properties)
					debugPrint(userProperties)
					guard let newPropertyKey = self.propertyNameTextField.text else {return}
					guard let newPropertyValue = self.propertyValueTextField.text else {return}
					userProperties[newPropertyKey] = newPropertyValue
					self.usersDataBaseSnapshot[currentUserId] = userProperties
					self.user.properties = userProperties
					debugPrint("*********** UserAddPropertyController *** usersDataBaseSnapshot *** AFTER new property **************")
					debugPrint(self.usersDataBaseSnapshot)
					debugPrint("*********** UserAddPropertyController *** user.properties *** AFTER new property **************")
//					debugPrint(self.user.properties)
					self.ref.child("Users").setValue(self.usersDataBaseSnapshot)
				}
			}
		}) { (error) in
			print(error.localizedDescription)
		}
	}
}

//MARK: - UITextFieldDelegate
extension UserAddPropertyController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		scrollViewBottomConstraint.constant = 280
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {

		switch textField {
		case propertyNameTextField:
			propertyValueTextField.becomeFirstResponder()
		case propertyValueTextField:
			propertyValueTextField.resignFirstResponder()
			scrollViewBottomConstraint.constant = 0
		default:
			break
		}
		return true
	}
}

extension UserAddPropertyController {
	//MARK: - DesignUI
	func designUI() {
		designView(view: headerView)
		designView(view: propertyNameView)
		designView(view: propertyValueView)
		designView(view: addNewPropertyButton)
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
