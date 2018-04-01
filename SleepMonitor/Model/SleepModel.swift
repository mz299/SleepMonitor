//
//  SleepModel.swift
//  SleepMonitor
//
//  Created by Min Zeng on 27/03/2018.
//  Copyright © 2018 Min Zeng. All rights reserved.
//

import Foundation

class SleepModel {
    private static let _instance = SleepModel()
    private init() {}
    static var Instance: SleepModel {
        return _instance
    }
    
    var _data = Array<SleepData>()
    var Data: Array<SleepData> {
        get {
            return _data
        }
    }
    
    func loadData(handler: SleepDataHandler?) {
        _data.removeAll();
        HealthKitProvider.Instance.retrieveSleepAnalysis { (samples) in
            if samples != nil {
//                 convert HKSample to SleepData
            }
            handler?(self._data)
        }
    }
}
