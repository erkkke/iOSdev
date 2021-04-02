//
//  Main.swift
//  AlarmApp
//
//  Created by Erkebulan on 12.03.2021.
//

import Foundation
import UIKit

public struct Alarm {
    var time: String
    var description: String?
}

struct Main {
    static var alarms: [Alarm] = [
        Alarm(time: "8:00", description: "Get Up"),
        Alarm(time: "12:00", description: "Time to work")
    ]
}
