//
//  ViewControllerTrigoN1.swift
//  EasyMath
//
//  Created by Federico Miguel Huguet Mack on 11/13/17.
//  Copyright © 2017 Federico Miguel Huguet Mack. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerTrigoN1: UIViewController {
    var player: AVAudioPlayer?
    var arrEquations: [String] = ["cos", "sin"]
    @IBOutlet weak var equation: UILabel!
    @IBOutlet weak var coef: UILabel!
    @IBOutlet weak var x: UILabel!
    
    //user
    @IBOutlet weak var usign: UITextField!
    @IBOutlet weak var ucoefeq: UITextField!
    @IBOutlet weak var uequation: UITextField!
    @IBOutlet weak var ucoef: UITextField!
    @IBOutlet weak var ux: UITextField!
    
    //correct
    @IBOutlet weak var csign: UILabel!
    @IBOutlet weak var ccoefeq: UILabel!
    @IBOutlet weak var cequation: UILabel!
    @IBOutlet weak var ccoef: UILabel!
    @IBOutlet weak var cx: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRand(true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func generateRand(_ sender: Any) {
        resetVals()
        equation.text = arrEquations[Int(arc4random_uniform(2))]
        coef.text = String(Int(arc4random_uniform(8)+1))
    }
    
    @IBAction func reviewAns(_ sender: Any) {
        if equation.text == "sin" {
            if (usign.text == "+" && ucoefeq.text == coef.text && uequation.text == "cos" && ucoef.text == coef.text) {
                playSound()
                //            let alert = UIAlertController(title: "Felicidades", message: "Respuesta correcta", preferredStyle: UIAlertControllerStyle.alert)
                //            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                //            self.present(alert, animated: true, completion: nil)
            }
            else {
                csign.text = "+"
                ccoefeq.text = coef.text
                cequation.text = "cos"
                ccoef.text = coef.text
                //            let alert = UIAlertController(title: "Lo sentimos", message: "Respuesta incorrecta", preferredStyle: UIAlertControllerStyle.alert)
                //            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                //            self.present(alert, animated: true, completion: nil)
                showVals()
            }
        }
        else {
            if (usign.text == "-" && ucoefeq.text == coef.text && uequation.text == "sin" && ucoef.text == coef.text) {
                playSound()
                //            let alert = UIAlertController(title: "Felicidades", message: "Respuesta correcta", preferredStyle: UIAlertControllerStyle.alert)
                //            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                //            self.present(alert, animated: true, completion: nil)
            }
            else {
                csign.text = "-"
                ccoefeq.text = coef.text
                cequation.text = "sin"
                ccoef.text = coef.text
                //            let alert = UIAlertController(title: "Lo sentimos", message: "Respuesta incorrecta", preferredStyle: UIAlertControllerStyle.alert)
                //            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                //            self.present(alert, animated: true, completion: nil)
                showVals()
            }
            
        }
    }
    func resetVals(){
        csign.isHidden = true
        ccoefeq.isHidden = true
        cequation.isHidden = true
        ccoef.isHidden = true
        cx.isHidden = true
        usign.text = ""
        uequation.text = ""
        ucoef.text = ""
        ux.text = ""
    }
    func showVals(){
        csign.isHidden = false
        ccoefeq.isHidden = false
        cequation.isHidden = false
        ccoef.isHidden = false
        cx.isHidden = false
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "winSound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}