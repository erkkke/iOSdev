//
//  Protocols.swift
//  AlarmApp
//
//  Created by Erkebulan on 12.03.2021.
//

import Foundation
import UIKit

protocol DeleteAlarmDelegate {
    func deleteAlarm(_ index: Int)
}

protocol EditAlarmDelegate {
    func editAlarm(_ index: Int, _ alarm: Alarm)
}

protocol AddAlarmDelegate {
    func addAlarm(_ alarm: Alarm);
}

