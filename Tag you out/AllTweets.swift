//
//  AllTweets.swift
//  Tag you out
//
//  Created by Ruizhe Wang on 11/08/2021.
//

import Foundation
import SwiftCSV

class AllTweets {
    
    static var asiansTweets: [Tweet] = []
    static var chchTweets: [Tweet] = []
    static var whoreTweets: [Tweet] = []
    static var retardTweets: [Tweet] = []
    static var womenTweets: [Tweet] = []
    static var whiteTweets: [Tweet] = []
    static var blackTweets: [Tweet] = []
    
    init() {
        var tweets = getCSVData(name: "final_asians")
        for tweet in tweets {
            AllTweets.asiansTweets.append(Tweet(bodyText: tweet[0], dateText: tweet[1], nameText: tweet[2]))
        }
        tweets = getCSVData(name: "final_chch")
        for tweet in tweets {
            AllTweets.chchTweets.append(Tweet(bodyText: tweet[0], dateText: tweet[1], nameText: tweet[2]))
        }
        tweets = getCSVData(name: "final_retard")
        for tweet in tweets {
            AllTweets.retardTweets.append(Tweet(bodyText: tweet[0], dateText: tweet[1], nameText: tweet[2]))
        }
        tweets = getCSVData(name: "final_african_descent")
        for tweet in tweets {
            AllTweets.blackTweets.append(Tweet(bodyText: tweet[0], dateText: tweet[1], nameText: tweet[2]))
        }
        tweets = getCSVData(name: "final_whore")
        for tweet in tweets {
            AllTweets.whoreTweets.append(Tweet(bodyText: tweet[0], dateText: tweet[1], nameText: tweet[2]))
        }
        tweets = getCSVData(name: "final_women")
        for tweet in tweets {
            AllTweets.womenTweets.append(Tweet(bodyText: tweet[0], dateText: tweet[1], nameText: tweet[2]))
        }
        tweets = getCSVData(name: "final_white trash")
        for tweet in tweets {
            AllTweets.whiteTweets.append(Tweet(bodyText: tweet[0], dateText: tweet[1], nameText: tweet[2]))
        }
    }
    
    func getCSVData(name: String) -> [[String]] {
        do {
            let tweets = try CSV(name: name, extension: "csv", bundle: .main, delimiter: ";", loadColumns: false)
            return tweets!.enumeratedRows
        } catch let error {
            print(error)
            return []
        }
    }
    
}
