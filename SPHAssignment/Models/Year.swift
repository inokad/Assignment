//
//  Year.swift
//  SPHAssignment
//
//  Created by Inoka Dissanayaka on 12/20/18.
//  Copyright © 2018 Inoka Dissanayaka. All rights reserved.
//

import Foundation

struct Year {
    let year: String
    var quarters: [Quarter]
    
    /**
    * Calculate and retuns total data of all quarters of the year.
    */
    func getCalculatedTotlaData() -> Double {
        let total = self.quarters.reduce(0.0, {$0 + $1.dataUsage})
        return total
    }
    
    /**
    * Returns true if any of the quarter has data decrease comparing to the previours quarter, otherwise false.
    */
    func hasDataVolumeReduced() -> Bool {
        let sortedArray = self.quarters.sorted(by: {$0.quarter < $1.quarter})
        
        for i in 1..<sortedArray.count {
            if sortedArray[i-1].dataUsage > sortedArray[i].dataUsage {return true}
        }
        
        return false
    }
}
