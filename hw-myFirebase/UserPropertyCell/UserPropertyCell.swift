//
//  UserPropertyCell.swift
//  hw-myFirebase
//
//  Created by Mykhailo Tsyba on 2/26/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import UIKit

class UserPropertyCell: UITableViewCell {

	@IBOutlet weak var labelContainerView: UIView!
	@IBOutlet weak var propertyKeyLabel: UILabel!
	@IBOutlet weak var propertyValueLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		designUI()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

	}
}

extension UserPropertyCell {
	//MARK: - DesignUI
	func designUI() {
		designView(view: labelContainerView)
	}

	func designView(view: UIView) {
		view.layer.borderWidth = 0.8
		view.layer.borderColor = UIColor(red: 253/255, green: 203/255, blue: 110/255, alpha: 1.0).cgColor
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowRadius = 3
		view.layer.shadowOpacity = 2
		view.layer.shadowOffset = CGSize(width: 0, height: 0)
	}

	//MARK: - updateStudentCell
	func updateUserPropertyCell(property: (String, Any)) {
		propertyKeyLabel.text = property.0
		propertyValueLabel.text = property.1 as? String
	}
}
