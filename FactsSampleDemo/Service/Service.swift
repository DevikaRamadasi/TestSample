//
//  Service.swift
//  FactsInfo
//
//  Created by devika.ramadasi on 03/09/19.
//  Copyright © 2019 devika.ramadasi. All rights reserved.
//

import Foundation
let baseURL  =   "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl"
/// Used to define  diffrent end points
enum EndPoint:String
{
    case facts = "/facts.json"
}
extension EndPoint
{
    /// Returns url path for mentioned EndPoint
    /// - Parameter endPoint: EndPoint object , to which API should point
    static func getPathForEndPoint(endPoint:EndPoint) -> String {
        return baseURL+endPoint.rawValue
    }
}
class Service:NSObject,URLSessionDelegate,URLSessionDataDelegate {
    static let shared = Service()
    
    /// Downloads details from provided API endpoint and
    /// - Parameter endpoint:EndPoint object , to which API should point
    /// - Parameter completion: completion block(Closure) that need to be execeuted after download completes.
    ///
    
    func getDetailsFor(endpoint:EndPoint , onCompletion completion:  @escaping (_ JSON:Any?, _ error:Error?) -> Void) {
        let session = URLSession.shared
        if let url  = URL(string: EndPoint.getPathForEndPoint(endPoint: endpoint))
        {
            var urlRequest  = URLRequest(url: url)
            urlRequest.httpMethod =  "GET"
            let task = session.downloadTask(with: url) { (stored:URL?, response:URLResponse?, error:Error?) in
                var result : Any?
                var errorInfo = error
                if stored != nil
                {
                    do
                    {
                        let data = try Data(contentsOf: stored!)
                        let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                        do {
                            let json = try JSONSerialization.jsonObject(with: utf8Data!, options: [])
                            result = json
                            //completion(json ,nil)
                           // return
                                print(json)
                        }
                        catch let parsingError
                        {
                            errorInfo = parsingError
                           // completion(nil,parsingError)
                            
                        }
                        
                    }
                    catch let readingError
                    {
                        errorInfo = readingError

                      

                    }

                    
                }
                defer{
                    DispatchQueue.main.async {
                        completion(result,errorInfo)
                        
                    }

                }
            }
           
            task.resume()
            
            
        }

    }
  

}
