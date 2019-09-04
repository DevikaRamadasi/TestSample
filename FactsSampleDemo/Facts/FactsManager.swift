//
//  FactsManager.swift
//  FactsInfo
//
//  Created by devika.ramadasi on 03/09/19.
//  Copyright © 2019 devika.ramadasi. All rights reserved.
//

import Foundation
class FactsManager {
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
