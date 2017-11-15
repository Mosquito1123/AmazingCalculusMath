//
//  ViewControllerConfig.swift
//  EasyMath
//
//  Created by Andrés Tamez on 11/14/17.
//  Copyright © 2017 Federico Miguel Huguet Mack. All rights reserved.
//

import UIKit
protocol ProtocoloConfig
{
    func setConfig(b1:Bool,b2:Bool,b3:Bool,b4:Bool) -> Void
}
class ViewControllerConfig: UIViewController {

    var bLog : Bool!
    var bPoli : Bool!
    var bExp : Bool!
    var bTrig : Bool!
    
    @IBOutlet weak var swPoli: UISwitch!
    
    @IBOutlet weak var swLog: UISwitch!
    
    @IBOutlet weak var swTrig: UISwitch!
    
    @IBOutlet weak var swExp: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swPoli.isOn = bPoli
        swLog.isOn = bLog
        swTrig.isOn = bTrig
        swExp.isOn = bExp
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cambiaConfig(_ sender: UISwitch) {
        bLog = swExp.isOn
        
    }
    
    

}