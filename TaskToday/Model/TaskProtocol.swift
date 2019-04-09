//
//  TaskProtocol.swift
//  TaskToday
//
//  Created by Nikita Gura on 01.01.2019.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import Foundation

protocol  TaskProtocol{
    var text: String? {get set}
    var dateFrom: NSDate? {get set}
    var dateTo: NSDate? {get set}
}
