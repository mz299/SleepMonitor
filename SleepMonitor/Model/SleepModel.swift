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
    
    var _rawData = Array<SleepData>()
    var RawData: Array<SleepData> {
        get {
            return _rawData
        }
    }
    var _data = [String:[SleepData]]()
    var Data: [String:[SleepData]] {
        get {
            return _data
        }
    }
    var _date = [String]()
    var Date: [String] {
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
//                 convert HKSample to SleepData
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
    
    private func rawDataToData(){
        var data = [String:[SleepData]]()
        for item in _rawData {
            let formatter = Formatter.localDate
            let dateString = formatter.string(from: item.endDate)
            if data[dateString] == nil {
                _date.append(dateString)
                data[dateString] = [SleepData]()
            }
            data[dateString]?.append(item)
        }
        self._data = data
    }
}
