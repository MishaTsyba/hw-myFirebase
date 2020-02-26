//
//  UserAddController.swift
//  hw-myFirebase
//
//  Created by Mykhailo Tsyba on 2/26/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserAddController: UIViewController {

	@IBOutlet weak var headerView: UIView!
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var nameView: UIView!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var surnameView: UIView!
	@IBOutlet weak var surnameTextField: UITextField!
	@IBOutlet weak var ageView: UIView!
	@IBOutlet weak var ageTextField: UITextField!
	@IBOutlet weak var cityView: UIView!
	@IBOutlet weak var cityTextField: UITextField!
	@IBOutlet weak var addStudentButton: UIButton!
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!

	var ref: DatabaseReference = Database.database().reference(fromURL: "https://hw-myfirebase.firebaseio.com/")

	var user = UserFirebase()
	var usersDataBaseSnapshot: [String: Any] = [:]

	override func viewDidLoad() {
		super.viewDidLoad()
		designUI()
		nameTextField.delegate = self
		surnameTextField.delegate = self
		ageTextField.delegate = self
		cityTextField.delegate = self
	}

	@IBAction func didTapAddButton(_ sender: Any) {
		user = makeDefaultUser()
		addUserToFirebase(user: user)
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: "UserListController") as! UserListController
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction func didTapBackButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
}

extension UserAddController {
	//MARK: - Add User to Firebase
	func addUserToFirebase(user: UserFirebase) {
		ref.observe(.value, with: { (snapshot) in

            if let value = snapshot.value as? [String: Any] {
                if let users = value["Users"] as? [String: Any] {
                    self.usersDataBaseSnapshot = users
					guard let newUserProperties = user.properties else {return}
					guard let newUserId = user.id else {return}
					self.usersDataBaseSnapshot[newUserId] = newUserProperties
					self.ref.child("Users").setValue(self.usersDataBaseSnapshot)
                }
            }
          }) { (error) in
            print(error.localizedDescription)
        }
	}

	func makeDefaultUser() -> (UserFirebase) {
		let user = UserFirebase()
		let property = UserProperty()
		var dictionary = [String: Any]()

		user.id = getCurrentFormattedDate()

		property.key = "Id"
		property.value = getCurrentFormattedDate()
		if let key = property.key, let value = property.value {
			dictionary[key] = value
		}

		property.key = "Name"
		property.value = nameTextField.text ?? ""
		if let key = property.key, let value = property.value {
			dictionary[key] = value
		}

		property.key = "Surname"
		property.value = surnameTextField.text ?? ""
		if let key = property.key, let value = property.value {
			dictionary[key] = value
		}

		property.key = "Age"
		property.value = ageTextField.text ?? ""
		if let key = property.key, let value = property.value {
			dictionary[key] = value
		}

		property.key = "City"
		property.value = cityTextField.text ?? ""
		if let key = property.key, let value = property.value {
			dictionary[key] = value
		}

		user.properties = dictionary
		return user
	}

	//MARK: - Get Current Date in ISO 8601 as String
	func getCurrentFormattedDate() -> String {
		let date = Date()
		let dateFormatter = DateFormatter()
		let currentDateFormat = "yyyyMMddHHmmss"
		dateFormatter.dateFormat = currentDateFormat
		return dateFormatter.string(from: date)
	}
}

//MARK: - UITextFieldDelegate
extension UserAddController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		scrollViewBottomConstraint.constant = 280
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {

		switch textField {
		case nameTextField:
			surnameTextField.becomeFirstResponder()
		case surnameTextField:
			ageTextField.becomeFirstResponder()
		case ageTextField:
			cityTextField.becomeFirstResponder()
		case cityTextField:
			cityTextField.resignFirstResponder()
			scrollViewBottomConstraint.constant = 0
		default:
			break
		}
		return true
	}
}

extension UserAddController {
	//MARK: - DesignUI
	func designUI() {
		designView(view: headerView)
		designView(view: nameView)
		designView(view: surnameView)
		designView(view: ageView)
		designView(view: cityView)
		designView(view: addStudentButton)
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
