//
//  API.swift
//  SberTeleCom
//
//  Created by Mikhail Seregin on 18.12.2018.
//  Copyright © 2018 Mikhail Seregin. All rights reserved.
//

import Foundation

var phoneNumber = "9953454763"
var ePassword = "Forever$4"

class API {

    private let scheme = "https"
    private let host = "vats-bw-001.sberbank-tele.com"
    private var session = URLSession(configuration: URLSessionConfiguration.default)
    
    private let decoder = JSONDecoder()
    
    func getCalls(completion:(([CallItem])->Void)?) {
        if let url = getURL(endPoint: "/vr_callrec/api/v1/records") {
            let request = getRequest(url: url, method: "GET")
            
            print("tttt")
            makeNetworkTask(request: request) { (data, response, error) in
//                if let data = data {
                guard let _data = data else { return }
                    if let callItems = try? self.decoder.decode([CallItem].self, from: _data) {
                        
                        completion?(callItems)
                    } else {
                        print("*****")
                    }
//                }
            }
        }
    }
    
    func recognizeCall(id: String,completion:((String)->Void)?) {
        
            if let url = getURLForRecognize(endPoint: "/todo/api/v1.0/recognize/\(id)") {
            let request = getRequest(url: url, method: "GET")
            print(url)
            makeNetworkTask(request: request) { (data, response, error) in
                
                if error != nil {
                    completion?(error?.localizedDescription ?? "")
                }
                
                guard let _data = data else { return }
                
                if let txt = String(data: _data, encoding: String.Encoding.utf8) {
                    completion?(txt)
                } else {
                    if let err = error?.localizedDescription {
                        completion?(err + "IP: " + Settings.ipForRecognize)
                    } else {
                        completion?("IP: " + Settings.ipForRecognize)
                    }
                    
                }
            }
        }
    }
    
    static var shared: API {
        return API()
    }
    
    private init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func getURL(endPoint: String)->URL? {
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.scheme = scheme
        urlComponents.path = endPoint
        
        return urlComponents.url
    }
    
    func getURLForRecognize(endPoint: String) -> URL? {
        var urlComponents = URLComponents()

        urlComponents.host = Settings.ipForRecognize
        urlComponents.port = 5000
        urlComponents.scheme = "http"
        urlComponents.path = endPoint
        
        return urlComponents.url
    }
    
    private func getRequest(url: URL, method: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        let username = phoneNumber
        let password = ePassword
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func makeNetworkTask(request: URLRequest, completion:((Data?, URLResponse?, Error?)->Void)?) {
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                completion?(data, response, nil)
            }
            
            if let response = response {
//                print("******")
                print(response)
            }
            
            if let error = error {
//                print("******")
                
                completion?(nil, nil, error)
            }
        }.resume()
    }
}
