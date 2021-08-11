//
//  Types.swift
//  Tag you out
//
//  Created by Ruizhe Wang on 11/08/2021.
//

import Foundation

struct ResultData: Codable {
    var result: String
//    var adultContent: AdultContent
    var people: [Person]
//    var containsNudity: Bool
}

struct Person: Codable {
    var index: Int
    var gender: Gender
    var age: Int
    var ethnicity: Ethnicity
    var location: Location
    var attractiveness: Float
}

struct Gender: Codable {
    var gender: String
    var confidence: Float
}

struct Ethnicity: Codable {
    var ethnicity: String
    var confidence: Float
}

struct Location: Codable {
    var x: Int
    var y: Int
    var width: Int
    var height: Int
}

struct Tweet {
    var bodyText: String
    var dateText: String
    var nameText: String
    
    init(bodyText: String, dateText: String, nameText: String) {
        self.bodyText = bodyText
        self.dateText = dateText
        self.nameText = nameText
    }
}

//struct AdultContent: Codable {
//    var isAdultContent: Bool
//    var isAdultContentConfidence: Float
//    var adultContentType: String
//    var adultContentTypeConfidence: Float
//}
