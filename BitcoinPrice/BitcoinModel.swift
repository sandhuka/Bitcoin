//
//  BitcoinModel.swift
//  BitcoinPrice
//
//  Created by Kanwar Sudeep Singh Sandhu on 19/05/18.
//  Copyright © 2018 Kanwar Sudeep Singh Sandhu. All rights reserved.
//

import UIKit
@objcMembers
class BitcoinModel: NSObject {
    
    var ask: Double = 0.0
    var averages = NSDictionary()
    var day = 0.0
    var changes = NSDictionary()
    var open = NSDictionary()
    //var percent = NSDictionary()
    var year = 0.0
   var price = NSDictionary()
//    "changes": {
//  "price": {
//    "hour": 28.57,
//    "day": 97.05,
//    "week": -831.14,
//    "month": -716.32,
//    "month_3": -12133.38,
//    "month_6": 545.57,
//    "year": 23461.99
//    },
//    "percent": {
//    "hour": 0.09,
//    "day": 0.32,
//    "week": -2.62
    
    
    
    override init() {
        super.init()
    }
    

    
    init(_ info: NSDictionary){
        super.init()
        
        for (key ,value) in info {
            
            var keyName = key as? String
     
            switch keyName! {
                
            case "changes":
             
                setValueForPercent(value: value as! NSDictionary)
                
                break
            case "open":

                self.setValue(value, forKey: keyName!)

                break
                
            default:
                
                if (self.responds(to:(NSSelectorFromString(keyName!)))){
                    
                    self.setValue(value, forKey: keyName!)
              
                    
                }
               
                break
               
            
        }
   
            keyName = nil
            
        }
        
    }
    
    
    
    func setValueForPercent(value: NSDictionary)  {
        
        for (key ,value) in value {
            
            var keyName = key as? String

            if (self.responds(to:(NSSelectorFromString(keyName!)))){
                
                self.setValue(value, forKey: keyName!)
                
            }
            
            keyName = nil
            
        }
        
    }

}
