//
//  FactsInfo.swift
//  FactsInfo
//
//  Created by devika.ramadasi on 03/09/19.
//  Copyright © 2019 devika.ramadasi. All rights reserved.
//

import Foundation
class Facts {
    var title:String?
    var descreption :String?
    var imageHref : String?
    init(withInfo info:[String:AnyObject]) {
        if let title = info["title"] as? String
        {
            self.title = title
        }
        if let descreption = info["description"]  as? String
        {
            self.descreption = descreption
        }
        if let imageHref = info["imageHref"]  as? String
        {
            self.imageHref = imageHref
        }
    }
    
}
class FactsInfo {
    var title : String?
    var rows = [Facts]()
    init(withInfo info:[String:Any]) {
       if let title = info["title"] as? String
       {
            self.title = title
        }
        if let rowsInfo = info["rows"] as? [[String:AnyObject]]
        {
            for rowItem in rowsInfo
            {
                rows.append(Facts(withInfo: rowItem))
            }
        }
    }
}
