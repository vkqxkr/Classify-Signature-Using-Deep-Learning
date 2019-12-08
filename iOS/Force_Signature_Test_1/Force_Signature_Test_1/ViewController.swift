//
//  ViewController.swift
//  Force_Signature_Test_1
//
//  Created by JinHyuck Park on 2019/12/06.
//  Copyright © 2019 JinHyuck Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SubjectName_TextField: UITextField!
    @IBOutlet weak var GetPicture_Button: UIButton!
    @IBOutlet weak var Reset_Button: UIButton!
    @IBOutlet weak var Save_Button: UIButton!
    @IBOutlet weak var DrawingSignature_ContrainerView: UIView!
    
    var SubjectName_String: String = ""
    
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SubjectName_TextField.returnKeyType = .done
        self.SubjectName_TextField.delegate = self as? UITextFieldDelegate
        self.DrawingSignature_ContrainerView.frame.size.height = 300
        self.DrawingSignature_ContrainerView.frame.size.width = 300
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        SubjectName_String = SubjectName_TextField.text ?? ""
        return false
    }
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 330, y: self.view.frame.size.height-960, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @IBAction func GetPicture_Func_GetPicture_Button(_ sender: UIButton) {
    }
    
    @IBAction func Reset_Func_Reset_Button(_ sender: UIButton) {
    }
    
    @IBAction func Save_Func_Save_Button(_ sender: UIButton) {
        if SubjectName_String.count > 0 && SubjectName_String.trimmingCharacters(in: .whitespaces).isEmpty {
            
        }
        else {
            showToast(message: "실험자 이름을 입력하여 주세요.", font: UIFont.systemFont(ofSize: UIFont.systemFontSize))
        }
    }
}

