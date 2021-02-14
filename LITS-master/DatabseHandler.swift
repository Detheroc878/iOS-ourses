//
//  DatabseHandler.swift
//  CaloriesCounter
//
//  Created by Volodymyr Khmil on 1/16/17.
//  Copyright © 2017 BBBSamples. All rights reserved.
//

import Foundation
import RealmSwift

class DatabseHandler {
    
    private func correctDate(from date: Date) -> NSDate {
        let formatter = DateFormatters.cc_databaseTimeFormatter
        let date = formatter.date(from: formatter.string(from: date))! as NSDate
        return date
    }
        
    func save(activities: [Int : Int]) {
        DispatchQueue.global().async {
            let realm = try! Realm()
            for (key, value) in activities {
                let date = self.correctDate(from: Date())
                var activity = realm.objects(ActivityDB.self).filter("id == %i AND date == %@", key, date).first
                if activity == nil {
                    activity = ActivityDB()
                    try! realm.write {
                        realm.add(activity!)
                    }
                }
                
                try! realm.write {
                    activity?.date  = date
                    activity?.id    = key
                    activity?.time  = (activity?.time ?? 0) + value
                }
            }
        }
    }
    
    func timePerActivity(for dates: [Date], with completion : @escaping GetActivitiesCompletion) {
        DispatchQueue.global().async {
        var timePerActivity: [Int : Int] = [:]
        
        for date in dates {
            let activitiesDB = self.activities(for: date)
            for activity in activitiesDB {
                timePerActivity[activity.id] = (timePerActivity[activity.id] ?? 0) + activity.time
            }
        }
            DispatchQueue.main.async {
                completion(timePerActivity, nil)
            }
        }
    }
    
    func timePerActivity(for date: Date, with completion : @escaping GetActivitiesCompletion) {
        DispatchQueue.global().async {
            let activities: [Int : Int] = self.timePerActivity(for: date)
            
            DispatchQueue.main.async {
                completion(activities, nil)
            }
        }
    }
    
    func timePerActivityList(for dates: [Date], with completion : @escaping GetActivitiesListCompletion) {
        DispatchQueue.global().async {
            var timePerActivityList: [[Int : Int]] = []
            
            for date in dates {
                let timePerActivity = self.timePerActivity(for: date)
                timePerActivityList.append(timePerActivity)
            }
            DispatchQueue.main.async {
                completion(timePerActivityList, nil)
            }
        }
    }
    
    //MARK: Private.Methods
    
    private func timePerActivity(for date: Date) -> [Int : Int] {
        let activitiesDB = self.activities(for: date)
        var timePerActivity: [Int : Int] = [:]
        for activity in activitiesDB {
            timePerActivity[activity.id] = (timePerActivity[activity.id] ?? 0) + activity.time
        }
        
        return timePerActivity
    }
    
    private func activities(for date: Date) -> [ActivityDB] {
        let realm = try! Realm()
        let activitiesDB = Array(realm.objects(ActivityDB.self).filter("date == %@", self.correctDate(from: date)))
        
        return activitiesDB
    }
    
    //MARK: Typealias
    
    typealias GetActivitiesCompletion = (_ activities: [Int : Int]?, _ error: CCError?) -> Void
    typealias GetActivitiesListCompletion = (_ activities: [[Int : Int]]?, _ error: CCError?) -> Void
}
