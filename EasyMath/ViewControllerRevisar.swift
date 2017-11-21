//
//  ViewControllerRevisar.swift
//  EasyMath
//
//  Created by Federico Miguel Huguet Mack on 10/22/17.
//  Copyright © 2017 Federico Miguel Huguet Mack. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerRevisar: UIViewController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            return .portrait
        }
    }
    open override var shouldAutorotate: Bool {
        get {
            return false
        }
    }
    var player: AVAudioPlayer?
    var alertController: UIAlertController?
    var alertTimer: Timer?
    var remainingTime = 0
    //Original
    @IBOutlet weak var coef1: UILabel!
    @IBOutlet weak var exp1: UILabel!
    @IBOutlet weak var coef2: UILabel!
    @IBOutlet weak var exp2: UILabel!
    @IBOutlet weak var coef3: UILabel!
    @IBOutlet weak var exp3: UILabel!
    @IBOutlet weak var coef4: UILabel!
    
    //User answer
    @IBOutlet weak var ucoef1: UITextField!
    @IBOutlet weak var uexp1: UITextField!
    @IBOutlet weak var ucoef2: UITextField!
    @IBOutlet weak var uexp2: UITextField!
    @IBOutlet weak var ucoef3: UITextField!
    @IBOutlet weak var uexp3: UITextField!
    @IBOutlet weak var ucoef4: UITextField!
    
    //Correct answer
    @IBOutlet weak var ccoef1: UILabel!
    @IBOutlet weak var cexp1: UILabel!
    @IBOutlet weak var ccoef2: UILabel!
    @IBOutlet weak var cexp2: UILabel!
    @IBOutlet weak var ccoef3: UILabel!
    @IBOutlet weak var cexp3: UILabel!
    @IBOutlet weak var ccoef4: UILabel!
    @IBOutlet weak var x1: UILabel!
    @IBOutlet weak var mas1: UILabel!
    @IBOutlet weak var x2: UILabel!
    @IBOutlet weak var mas2: UILabel!
    @IBOutlet weak var x3: UILabel!
    @IBOutlet weak var mas3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRand(true)
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func generateRand(_ sender: Any) {
        resetVals()
        coef1.text = String(Int(arc4random_uniform(8)+1))
        exp1.text = String(Int(arc4random_uniform(8)+1))
        coef2.text = String(Int(arc4random_uniform(8)+1))
        exp2.text = String(Int(arc4random_uniform(8)+1))
        coef3.text = String(Int(arc4random_uniform(8)+1))
        exp3.text = String(Int(arc4random_uniform(8)+1))
        coef4.text = String(Int(arc4random_uniform(8)+1))
    }
    
    @IBAction func reviewAns(_ sender: Any) {
        if ucoef1.text == "" || uexp1.text == "" || ucoef2.text == "" || uexp2.text == "" || ucoef3.text == "" || uexp3.text == "" || ucoef4.text == "" {
            let alert = UIAlertController(title: "Error", message: "Llena completamente los campos", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let c1 = Int(coef1.text!)! * Int(exp1.text!)!
            let c2 = Int(coef2.text!)! * Int(exp2.text!)!
            let c3 = Int(coef3.text!)! * Int(exp3.text!)!
            
            if(String(c1)==(ucoef1.text!) && String(c2)==(ucoef2.text!) && String(c3)==(ucoef3.text!) &&
                Int(exp1.text!)!-1 == Int(uexp1.text!)! && Int(exp2.text!)!-1 == Int(uexp2.text!)! &&
                Int(exp3.text!)!-1 == Int(uexp3.text!)! && (ucoef4.text!)=="0"
                ){
                print("entro")
                playSound()
                self.alertController = UIAlertController(title: "Felicidades", message: "Respuesta correcta", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    self.alertController=nil;
                    self.alertTimer?.invalidate()
                    self.alertTimer=nil
                }
                
                self.alertController!.addAction(cancelAction)
                
                self.alertTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ViewControllerPolyN1.countDown), userInfo: nil, repeats: true)
                
                self.present(self.alertController!, animated: true, completion: nil)

            }
            else {
                let refreshAlert = UIAlertController(title: "Respuesta incorrecta", message: "¿Deseas ver la respuesta?", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Si", style: .default, handler: { (action: UIAlertAction!) in
                    self.ccoef1.text = String(c1)
                    self.ccoef2.text = String(c2)
                    self.ccoef3.text = String(c3)
                    self.cexp1.text = String(Int(self.exp1.text!)!-1)
                    self.cexp2.text = String(Int(self.exp2.text!)!-1)
                    self.cexp3.text = String(Int(self.exp3.text!)!-1)
                    self.ccoef4.text = "0"
                    self.showVals()
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "No, seguire intentando", style: .cancel, handler: nil))
                present(refreshAlert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func countDown() {
        
        self.remainingTime -= 1
        if (self.remainingTime < 0) {
            self.alertTimer?.invalidate()
            self.alertTimer = nil
            self.alertController!.dismiss(animated: true, completion: {
                self.alertController = nil
            })
        }
    }
    
    func resetVals(){
        ccoef1.isHidden = true
        cexp1.isHidden = true
        ccoef2.isHidden = true
        cexp2.isHidden = true
        ccoef3.isHidden = true
        cexp3.isHidden = true
        ccoef4.isHidden = true
        x1.isHidden = true
        x2.isHidden = true
        x3.isHidden = true
        mas1.isHidden = true
        mas2.isHidden = true
        mas3.isHidden = true
        ucoef1.text = ""
        uexp1.text = ""
        ucoef2.text = ""
        uexp2.text = ""
        ucoef3.text = ""
        uexp3.text = ""
        ucoef4.text = ""
    }
    func showVals(){
        ccoef1.isHidden = false
        cexp1.isHidden = false
        ccoef2.isHidden = false
        cexp2.isHidden = false
        ccoef3.isHidden = false
        cexp3.isHidden = false
        ccoef4.isHidden = false
        x1.isHidden = false
        x2.isHidden = false
        x3.isHidden = false
        mas1.isHidden = false
        mas2.isHidden = false
        mas3.isHidden = false
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
    @IBAction func presentInfo(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "info") as! ViewControllerInfo
        vc.backgroundIm = #imageLiteral(resourceName: "polyejen2")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
