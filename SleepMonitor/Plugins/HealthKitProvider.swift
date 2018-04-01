//
//  HealthKitProvider.swift
//  SleepMonitor
//
//  Created by Min Zeng on 27/03/2018.
//  Copyright © 2018 Min Zeng. All rights reserved.
//

import Foundation
import HealthKit

typealias SleepAnalysisHandler = (_ data: [HKSample]?) -> Void

class HealthKitProvider {
    private static let _instance = HealthKitProvider()
    private init() {}
    static var Instance: HealthKitProvider {
        return _instance
    }
    
    private let healthStore = HKHealthStore()
    
    func requestAuthorization() {
        let typestoRead = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
            ])
        
        let typestoShare = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
            ])
        
        self.healthStore.requestAuthorization(toShare: typestoShare, read: typestoRead) { (success, error) -> Void in
            if success == false {
                NSLog(" Display not allowed")
            }
        }
    }
    
    func retrieveSleepAnalysis(handler: SleepAnalysisHandler?) {
        // first, we define the object type we want
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            // Use a sortDescriptor to get the recent data first
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            // we create our query with a block completion to execute
            let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 30, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                
                if error != nil {
                    // something happened
                    
                    handler?(nil)
                    return
                }
                
                if let result = tmpResult {
                    // do something with my data
                    for item in result {
                        if let sample = item as? HKCategorySample {
                            let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                            print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                        }
                    }
                    
                    handler?(result)
                }
            }
            
            // finally, we execute our query
            healthStore.execute(query)
        }
    }
}
