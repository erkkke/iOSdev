//
//  Site.swift
//  WebApp
//
//  Created by Erkebulan on 25.02.2021.
//

import Foundation
import UIKit

struct Site {
    var name: String?
    var url: String?
    var isFavorite = false
}

struct Main {
    static var list: [Site] = [
        Site(name: "Google", url: "https://www.google.com/"),
        Site(name: "YouTube", url: "https://www.youtube.com/"),
    ]
}
