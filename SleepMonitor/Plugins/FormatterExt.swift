//
//  FormatterExt.swift
//  SleepMonitor
//
//  Created by Min Zeng on 01/04/2018.
//  Copyright © 2018 Min Zeng. All rights reserved.
//

import Foundation

extension Formatter {
    // create static date formatters for your date representations
    static let localTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    static let localDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
