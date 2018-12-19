//
//  File.swift
//  SPHAssignment
//
//  Created by Inoka Dissanayaka on 12/18/18.
//  Copyright © 2018 Inoka Dissanayaka. All rights reserved.
//

import Foundation

struct RawServerResponse: Codable {
    let help: String
    let success: Bool
    let result: Result
}

struct Result: Codable {
    let resource_id: String
    let records: [Record]
}

struct Record: Codable {
    let id: Int
    let quarter: String
    let volumeOfMobileData: String
    
    enum CodingKeys: String, CodingKey {
        case quarter
        case id = "_id"
        case volumeOfMobileData = "volume_of_mobile_data"
    }
    
    func getYear() -> String {
        let year = self.quarter.components(separatedBy: "-")[0]
        return year
    }
    
    func getQauterWithoutYear() -> String {
        let quarter = self.quarter.components(separatedBy: "-")[1]
        return quarter
    }
}

