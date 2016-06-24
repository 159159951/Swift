//
//  ViewController.swift
//  tips
//
//  Created by ihomev2_2 on 6/23/16.
//  Copyright © 2016 ihomev2_2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static var KEY_TIP_PERCENT = "key_tip_percent"
    static var KEY_TOTAL_BILL = "key_total_bill"
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    var indexSegmentTransfer:NSUserDefaults!
    
    
    override func viewDidLoad() {
        print("view did load")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        indexSegmentTransfer = NSUserDefaults()
        
        //Remember the bill amount
        let defaults = NSUserDefaults.standardUserDefaults()
        do{
            billField.text = String(defaults.integerForKey(ViewController.KEY_TOTAL_BILL))
            tipControl.selectedSegmentIndex = defaults.integerForKey(ViewController.KEY_TIP_PERCENT)
        }
        catch{
            billField.text = "0"
        }
        onEditingChanged(billField)
        billField.becomeFirstResponder()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        
        //Load save tip percent
        let defaults = NSUserDefaults.standardUserDefaults()
        //When come to the view for the first time, intIndexValue = 0
        let intIndexStore = defaults.integerForKey(ViewController.KEY_TIP_PERCENT)
        tipControl.selectedSegmentIndex = intIndexStore;
        onEditingChanged(tipControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPerentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPerentages[tipControl.selectedSegmentIndex]
        var billAmount = NSString(string: billField.text!).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale() // This is the default
        formatter.stringFromNumber(total) // "$123.44"
        
        //        tipLabel.text = "$\(tip)"
        //        totalLabel.text = "$\(total)"
        //        tipLabel.text = String(format: "$%.2f", tip)
        //        totalLabel.text = String(format: "$%.2f", total)
        
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
        saveCurrbillAmount();
    }
    
    func saveCurrbillAmount(){
        //Store current bill amount
        let currBillAmount = NSUserDefaults.standardUserDefaults()
        currBillAmount.setObject(billField.text, forKey: ViewController.KEY_TOTAL_BILL)
        currBillAmount.setObject(tipControl.selectedSegmentIndex, forKey: ViewController.KEY_TIP_PERCENT)
        currBillAmount.synchronize()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SettingsViewController" {
            if segue.destinationViewController is SettingsViewController {
                indexSegmentTransfer.setInteger(tipControl.selectedSegmentIndex, forKey: ViewController.KEY_TIP_PERCENT);
            }
        }
    }
}