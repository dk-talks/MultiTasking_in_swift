//
//  ApiClient.swift
//  MultiTasking
//
//  Created by Dinesh Sharma on 27/08/23.
//

import Foundation

class ApiClient {
    
    static func fetchDataSynchronously() -> Result<String, Error> {
        let url = URL(string: "https://httpbin.org/delay/5")!
        
        var dataResult: Result<Data, Error> = .failure(NSError(domain: "InitializationError", code: -1, userInfo: nil))
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                dataResult = .failure(error)
            } else if let data = data {
                dataResult = .success(data)
            }
            
            semaphore.signal()
        }
        
        task.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        switch dataResult {
        case .success(let data):
            if let jsonString = String(data: data, encoding: .utf8) {
                return .success(jsonString)
            } else {
                return .failure(NSError(domain: "JSONError", code: -2, userInfo: nil))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
    
    static func fetchDataWithMultiTasking() async -> String {
        let url = URL(string: "https://httpbin.org/delay/5")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url!)
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode == 200) {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        return jsonString
                    }
                }
            }
            
        } catch(let error) {
            return "An Error in fetching data from API: \(error)"
        }
        
        return "No Data Found!"
    }
    
    
}
