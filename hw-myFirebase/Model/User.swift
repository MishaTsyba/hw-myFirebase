//
//  User.swift
//  hw-myFirebase
//
//  Created by Mykhailo Tsyba on 2/26/20.
//  Copyright © 2020 miketsyba. All rights reserved.
//

import Foundation
import UIKit

class User {
	var id: String?
	var name: String?
	var surname: String?
	var age: String?
	var city: String?
	var imageName: String?
	var additional: [Property]?
}

class Property {
	var propertyKey: String?
	var propertyValue: Any?
}
