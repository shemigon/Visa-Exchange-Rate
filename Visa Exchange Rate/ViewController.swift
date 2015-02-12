//
//  ViewController.swift
//  Visa Exchange Rate
//
//  Created by Boris Shemigon on 12.02.15.
//  Copyright (c) 2015 Boris Shemigon. All rights reserved.
//

import UIKit
import Alamofire



extension Int {
    var days: NSTimeInterval {
        return Double(self) * 24 * 3600;
    }
}


extension NSDate {
    var str: String {
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.stringFromDate(self)
    }
}


func d(days: Int = 0) -> String {
    let d = NSDate().dateByAddingTimeInterval(-days.days)
    return d.str
}


class ViewController: UIViewController {

    @IBOutlet weak var rateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getRatePressed(sender: UIButton) {
        var url = "http://usa.visa.com/personal/card-benefits/travel/exchange-rate-calculator-results.jsp"
        var data: [String: String] = [
            "homCur": "USD",
            "forCur": "RUB",
            "fee": "0",
            "date": d(),
            "rate": "0",
            "submit.x": "103",
            "submit.y": "13",
            "submit": "Calculate Exchange Rates",
            "firstDate": d(days: 364),
            "lastDate": d(),
            "actualDate": d().stringByReplacingOccurrencesOfString("/", withString: "-"),
        ]
        
        rateLabel.text = "Loading..."
        Alamofire.request(.POST, url, parameters: data)
        .responseString { (_, _, str, _) -> Void in
            let matches:[String] = (str ?? "") =~ "<strong>\\s*(0\\.\\d+)"
            if matches.count > 0 {
                var rate = (matches[1] as NSString).floatValue
                var today = NSDate()
                self.rateLabel.text = "Visa rate on \(today) is \(1/rate)"
            }
        }
    }

}

