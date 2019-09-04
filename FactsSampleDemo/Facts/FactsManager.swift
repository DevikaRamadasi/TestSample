//
//  FactsManager.swift
//  FactsInfo
//
//  Created by devika.ramadasi on 03/09/19.
//  Copyright © 2019 devika.ramadasi. All rights reserved.
//

import Foundation
class FactsManager {
    /// Fetchs the Facts from API and returs FactsInfo or Error based on response
    /// - Parameter onCompletion: Completion clousre which will be executed once we receive the responce , if succesful then result will have data other wise error will be avilable 
    class func getFacts(_ onCompletion:@escaping (FactsInfo?,Error?)->Void)  {
        Service.shared.getDetailsFor(endpoint: .facts) { (result:Any?,error: Error?) in
            guard result != nil else
            {
                if let errorInfo = error
                {
                    print(errorInfo)
                    onCompletion(nil,error)

                }
                return
            }
            print(result)
            if let info = result as? [String :Any]
            {
                let factsInfo = FactsInfo(withInfo: info)
                onCompletion(factsInfo,nil)
            }
            
        }

    }
}
