//
//  ViewController.swift
//  BitcoinPrice
//
//  Created by Kanwar Sudeep Singh Sandhu on 19/05/18.
//  Copyright © 2018 Kanwar Sudeep Singh Sandhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
 

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imageCoin: UIImageView!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let url = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
     let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let symbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalSymbol = ""
var finalURL = ""
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        self.imageCoin.layer.cornerRadius = self.imageCoin.frame.size.width / 2;
        lblPrice.isHidden = true
        
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = url + currencyArray[row]
        finalSymbol = symbolArray[row]
       // print(finalSymbol)
       // print (finalURL)
        getPrice()
    }

    func getPrice() {
        let url = URL(string: finalURL)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in do
        { if error == nil {
            
            let result = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSMutableDictionary
            
           // print(result!)
            
            var bitCoin : BitcoinModel? = BitcoinModel.init(result!)
            
           let averageDays = bitCoin?.averages.value(forKey: "day")
           
          //  print("bitCoin averages day:", (bitCoin?.averages.value(forKey: "day"))!)
            
            print("bitCoin ask:", (bitCoin?.ask)!)
            
            //print ("bitcoin open month_3", (bitCoin?.open.value(forKey: "month_3"))!)
            
            //print("Price year:",(bitCoin?.open.value(forKey: "year"))!)
         //   print("changes - price -year:", (bitCoin?.price.value(forKey: "year"))!)
            
            
         //   print("Percent day by key mapping: ", ((bitCoin?.changes.value(forKey: "percent") as! NSDictionary).value(forKey: "day"))!)
        
            
           // print("Percent day: ", (bitCoin?.percent.value(forKey: "day"))!)
        
            bitCoin = nil
            DispatchQueue.main.async {
                self.lblPrice.text = "\(self.finalSymbol) \(averageDays!)"
                self.lblPrice.isHidden = false
            }
          
 
            }
            
        }
        catch{
                print(error)
            }
           
        }.resume()
    }

}

