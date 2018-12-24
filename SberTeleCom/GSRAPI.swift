//
//  GSRAPI.swift
//  SberTeleCom
//
//  Created by Mikhail Seregin on 18.12.2018.
//  Copyright © 2018 Mikhail Seregin. All rights reserved.
//

import Foundation

class GSRAPI {
    let API_KEY = "AIzaSyAmRbbpTITc-LnV_qLYDcN3H_SDOa8LrEQ"
    let SAMPLE_RATE = 8000
    var session: URLSession
    
    static var shared: GSRAPI {
        return GSRAPI()
    }
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 120
        session = URLSession.init(configuration: config)
    }
    
    func recognize(data: URL, completion: ((String)-> Void)?) {
        var service = "https://speech.googleapis.com/v1p1beta1/speech:recognize"
        service = service + ("?key=")
        service = service + (API_KEY)
        
        
        let configRequest:[String : Any] = ["encoding": "LINEAR16",
                                            "enableAutomaticPunctuation": true,
                                            "sampleRateHertz": SAMPLE_RATE,
                                            "languageCode": "ru-RU",
                                            "model": "default"
        ]
        
        let file = try? Data(contentsOf: data)
        
        let audioRequest = ["content": file!.base64EncodedString()]
        let requestDictionary = ["config": configRequest, "audio": audioRequest]

        var requestData: Data?
        do {
            requestData = try JSONSerialization.data(withJSONObject: requestDictionary, options: [])
        } catch {
            print(error)
        }
        
        
        let path = service
        let url = URL(string: path)
        var request: URLRequest? = nil
        if let anURL = url {
            request = URLRequest(url: anURL)
//            request?.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
            let contentType = "application/json"
            request?.addValue(contentType, forHTTPHeaderField: "Content-Type")
            request?.httpBody = requestData
            request?.httpMethod = "POST"
            
            
            if let request = request {
                self.session.dataTask(with: request) { (data, response, error) in
                    
                    if let aData = data {
                        guard let stringResult = String(data: aData, encoding: .utf8) else {return}
                        print(stringResult)
                        
                        guard let trueResult = try? JSONDecoder().decode(Result.self, from: aData) else {
                            
                            completion?(stringResult)
                            return
                        }
                        
                        DispatchQueue.main.async(execute: {
                            guard let transcript = trueResult.alternatives?.first?.transcript else {completion?(stringResult); return}
                            completion?(transcript)
                        })
                    }
                }.resume()
            }
            
            
        }
    }
    
}

struct Result: Codable {
    let alternatives: [Alternatives]?
    let languageCode: String?
}

struct Alternatives: Codable {
    let transcript: String
}
