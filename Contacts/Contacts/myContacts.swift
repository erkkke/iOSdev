//
//  myContacts.swift
//  Contacts
//
//  Created by Erkebulan on 11.02.2021.
//

import Foundation
import UIKit

class myContacts {
    var name: String?
    var number: String?
    var image: UIImage?
    
    init(_ name: String, _ number: String, _ image: UIImage) {
        self.name = name
        self.number = number
        self.image = image
    }
}
