//
//  SettingsViewController.swift
//  tips
//
//  Created by ihomev2_2 on 6/23/16.
//  Copyright © 2016 ihomev2_2. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var HelloLabel: UILabel!
    @IBOutlet weak var GoodByeLabel: UILabel!
    @IBOutlet weak var defPercentSegment: UISegmentedControl!
    var indexSegmentTransfer:NSUserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexSegmentTransfer = NSUserDefaults();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        self.HelloLabel.alpha = 0
    }
   
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        
        defPercentSegment.selectedSegmentIndex = indexSegmentTransfer.objectForKey(ViewController.KEY_TIP_PERCENT) as! intptr_t
        
        // Optionally initialize the property to a desired starting value
        
        self.GoodByeLabel.alpha = 1
        UIView.animateWithDuration(1, animations: {
            // This causes first view to fade in and second view to fade out
            self.HelloLabel.alpha = 1
            self.GoodByeLabel.alpha = 0
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    @IBAction func defTipSegmentSelected(sender: AnyObject) {
        saveDefTipPercent();
    }
    
    /*
     Store Default Tip Percent
     */
    func saveDefTipPercent(){
        //Store current percent tab
        let tipPrecentDef = NSUserDefaults.standardUserDefaults()
        tipPrecentDef.setInteger(defPercentSegment.selectedSegmentIndex, forKey: ViewController.KEY_TIP_PERCENT)
        tipPrecentDef.synchronize()
    }
}
