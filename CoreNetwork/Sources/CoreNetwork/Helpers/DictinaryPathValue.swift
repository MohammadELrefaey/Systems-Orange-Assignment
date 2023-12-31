//
//  DictinaryPathValue.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation

class DictinaryPath {
    
    static func value(_ dict:[String: Any]?, path:String)->Any?{
           let arr = path.components(separatedBy: ".")
           if(arr.count == 1){
               return dict?[String(arr[0])]
           }
           else if (arr.count > 1){
               let p = arr[1...arr.count-1].joined(separator: ".")
               let d = dict?[String(arr[0])] as? [String: Any]
               if (d != nil){
                return value(d!, path:p)
               }
           }
           return nil
       }
}
