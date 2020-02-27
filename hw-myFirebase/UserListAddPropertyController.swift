//
//  UserListAddPropertyController.swift
//  hw-myFirebase
//
//  Created by Mykhailo Tsyba on 2/26/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserListAddPropertyController: UIViewController {
	
	@IBOutlet weak var headerView: UIView!
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var usersTableView: UITableView!
	@IBOutlet weak var backButton: UIButton!

	var ref: DatabaseReference = Database.database().reference(fromURL: "https://hw-myfirebase.firebaseio.com/")

	var users = [UserFirebase]()
	var usersDataBaseSnapshot: [String: Any] = [:]
	
	override func viewDidLoad() {
		super.viewDidLoad()
//		self.users = []
		designUI()
		usersTableView.delegate = self
		usersTableView.dataSource = self
		usersTableView.register(UINib(nibName: "UserAddPropertyCell", bundle: nil), forCellReuseIdentifier: "UserAddPropertyCell")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		debugPrint("*********** UserListAddPropertyController *** viewWillAppear ********")
		users = []
		usersDataBaseSnapshot = [:]
		getUsersFromFirebase()
		usersTableView.reloadData()
	}
	
	@IBAction func didTapBackButton(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
}

//MARK: - UITableViewDelegate
extension UserListAddPropertyController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "UserAddPropertyCell", for: indexPath) as! UserAddPropertyCell
		cell.updateUserAddPropertyCell(user: users[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: "UserAddPropertyController") as! UserAddPropertyController
		vc.user = users[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

extension UserListAddPropertyController {
	//MARK: - Get Users from Firebase
	func getUsersFromFirebase() {
		ref.observe(.value, with: { (snapshot) in
			debugPrint("*********** UserListAddPropertyController ***  ref.observe(.value, with: { (snapshot) ********")
			self.usersDataBaseSnapshot = [:]
            if let value = snapshot.value as? [String: Any] {
                if let users = value["Users"] as? [String: Any] {
                    self.usersDataBaseSnapshot = users
					self.users = []
					debugPrint("users: \(self.users)")
					for (key, value) in self.usersDataBaseSnapshot {
						debugPrint("*********** UserListAddPropertyController usersDataBaseSnapshot KEY ********")
						debugPrint(key)
						debugPrint("*********** UserListAddPropertyController usersDataBaseSnapshot KEY ********")
						debugPrint("*********** UserListAddPropertyController usersDataBaseSnapshot VALUE ********")
						debugPrint(value)
						debugPrint("*********** UserListAddPropertyController usersDataBaseSnapshot VALUE ********")
						let user = UserFirebase()
						user.id = key
						user.properties = value as? [String: Any]
						self.users.append(user)
						self.users.sort { (first, second) -> Bool in
							first.id! > second.id!
						}
					}
					DispatchQueue.main.async {
						self.usersTableView.reloadData()
						debugPrint("self.users: \(self.users.count)")
						debugPrint("self.users: \(self.users)")
					}
                }
            }
          }) { (error) in
            print(error.localizedDescription)
        }
//		debugPrint(self.users.count)
	}
}

extension UserListAddPropertyController {
	//MARK: - DesignUI
	func designUI() {
		designView(view: headerView)
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
