//
//  SleepModel.swift
//  SleepMonitor
//
//  Created by Min Zeng on 27/03/2018.
//  Copyright © 2018 Min Zeng. All rights reserved.
//

import Foundation
import HealthKit

class SleepModel {
    private static let _instance = SleepModel()
    private init() {}
    static var Instance: SleepModel {
        return _instance
    }
    
    private var _rawData = Array<SleepData>()
    var RawData: Array<SleepData> {
        get {
            return _rawData
        }
    }
    
    private var _data = [String:[SleepData]]()
    var SData: [String:[SleepData]] {
        get {
            return _data
        }
    }
    
    private var _date = [String]()
    var SDate: [String] {
        get {
            return _date
        }
    }
    
    func loadData(handler: SleepDataHandler?) {
        _rawData.removeAll();
        _data.removeAll()
        _date.removeAll()
        HealthKitProvider.Instance.retrieveSleepAnalysis { (items) in
            if items != nil {
//                convert HKSample to SleepData
                for item in items! {
                    if let sample = item as? HKCategorySample {
                        var data = SleepData()
                        data.startDate = sample.startDate
                        data.endDate = sample.endDate
                        if sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue {
                            data.value = "inBed"
                        } else if sample.value == HKCategoryValueSleepAnalysis.asleep.rawValue {
                            data.value = "asleep"
                        } else if sample.value == HKCategoryValueSleepAnalysis.awake.rawValue {
                            data.value = "awake"
                        }
                        self._rawData.append(data)
                    }
                }
            }
            self.rawDataToData()
            handler?(self._rawData)
        }
    }
    
    func stringSleepStartEndTime(date: String, index: Int) -> String {
        if let data = _data[date] {
            let item = data[index]
            let formatter = Formatter.localTime
            let startTimeStr = formatter.string(from: item.startDate)
            let endTimeStr = formatter.string(from: item.endDate)
            return "\(startTimeStr) - \(endTimeStr)"
        }
        return ""
    }
    
    func stringValue(date: String, index: Int) -> String {
        if let data = _data[date] {
            let item = data[index]
            return item.value
        }
        return ""
    }
    
    func stringGoToBed(date: String) -> String {
        if let data = _data[date] {
            let item = data[0]
            let formatter = Formatter.localTime
            return formatter.string(from: item.startDate)
        }
        return ""
    }
    
    func stringGetUp(date: String) -> String {
        if let data = _data[date] {
            let item = data[data.count - 1]
            let formatter = Formatter.localTime
            return formatter.string(from: item.endDate)
        }
        return ""
    }
    
    func stringTotalSleepTime(date: String) -> String {
        return sleepTime(date: date).stringTime
    }
    
    func stringWokeUpTime(date: String) -> String {
        if let data = _data[date] {
            let wokeUpTime = max(0, data.count - 1)
            if wokeUpTime > 1 {
                return "\(wokeUpTime) Times"
            } else {
                return "\(wokeUpTime) Time"
            }
        }
        return ""
    }
    
    func stringAvgGoToBed(days: Int) -> String {
        let d = min(days, _date.count)
        if d == 0 {
            return ""
        }
        var time: TimeInterval = 0.0
        for date in _date[0..<d] {
            if let data = _data[date] {
                time += data[0].startDate.timeIntervalSince1970
            }
        }
        time /= Double(d)
        let avgDate = Date(timeIntervalSince1970: time)
        let formatter = Formatter.localTime
        return formatter.string(from: avgDate)
    }
    
    func stringAvgGetUp(days: Int) -> String {
        let d = min(days, _date.count)
        if d == 0 {
            return ""
        }
        var time: TimeInterval = 0.0
        for date in _date[0..<d] {
            if let data = _data[date] {
                time += data[data.count - 1].endDate.timeIntervalSince1970
            }
        }
        time /= Double(d)
        let avgDate = Date(timeIntervalSince1970: time)
        let formatter = Formatter.localTime
        return formatter.string(from: avgDate)
    }
    
    func stringAvgSleep(days: Int) -> String {
        let d = min(days, _date.count)
        if d == 0 {
            return ""
        }
        var time: TimeInterval = 0.0
        for date in _date[0..<d] {
            time += sleepTime(date: date)
        }
        time /= Double(d)
        return time.stringTime
    }
    
    func stringAvgWokeUp(days: Int) -> String {
        let d = min(days, _date.count)
        if d == 0 {
            return ""
        }
        var time: Float = 0.0
        for date in _date[0..<d] {
            time += Float(wokeUpTime(date: date))
        }
        time /= Float(d)
        if time > 1.0 {
            return String(format: "%.2f Times", time)
        } else {
            return String(format: "%.2f Time", time)
        }
    }
    
    func stringTotalSleep(days: Int) -> String {
        let d = min(days, _date.count)
        if d == 0 {
            return ""
        }
        var time: TimeInterval = 0.0
        for date in _date[0..<d] {
            time += sleepTime(date: date)
        }
        return time.stringTime
    }
    
    func stringTotalWokeUp(days: Int) -> String {
        let d = min(days, _date.count)
        if d == 0 {
            return ""
        }
        var time: Int = 0
        for date in _date[0..<d] {
            time += wokeUpTime(date: date)
        }
        if time > 1 {
            return "\(time) Times"
        } else {
            return "\(time) Time"
        }
    }
    
    private func sleepTime(date: String) -> TimeInterval {
        if let data = _data[date] {
            var totalSleepTime: TimeInterval = 0.0
            for item in data {
                totalSleepTime += item.endDate.timeIntervalSince(item.startDate)
            }
            return totalSleepTime
        }
        return 0
    }
    
    private func wokeUpTime(date: String) -> Int {
        if let data = _data[date] {
            let wokeUpTime = max(0, data.count - 1)
            return wokeUpTime
        }
        return 0
    }
    
    private func rawDataToData(){
        var data = [String:[SleepData]]()
        for item in _rawData {
            let formatter = Formatter.localDate
            let dateString = formatter.string(from: item.endDate)
            if data[dateString] == nil {
                _date.append(dateString)
                data[dateString] = [SleepData]()
            }
            data[dateString]?.insert(item, at: 0)
        }
        self._data = data
    }
}
