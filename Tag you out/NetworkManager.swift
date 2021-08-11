//
//  NetworkManager.swift
//  Let's_do_it
//
//  Created by Ruizhe Wang on 12/05/2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let host = "https://api.haystack.ai/api/"
    static let apikey = "apikey=9da12e444a1abbe0035339e81956ccb5"
    
    // 1. analyze age & ethnicity & gender $ attractiveness
    static func analyze(encodedImage: String, completion: @escaping (ResultData) -> Void) {
//        let endpoint = "\(host)image/analyze?output=json&model=age&model=attractiveness&model=ethnicity&model=gender&\(apikey)"
        let endpoint = "https://api.haystack.ai/api/image/analyze?output=json&model=age&model=attractiveness&model=ethnicity&model=gender&apikey=9da12e444a1abbe0035339e81956ccb5"
        
        let parameters: [String: Any] = [
            "image": encodedImage
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                print("Successfully get response")
                if let ResultData = try? jsonDecoder.decode(ResultData.self, from: data) {
                    completion(ResultData)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
