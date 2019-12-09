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
    @IBOutlet weak var DrawingSignature_ContainerView: UIView!
    
    var SubjectName_String: String = ""
    var ViewContoller2_UIViewContoller = ViewController2()
    
    let Picker_PickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let addViewController = storyboard.instantiateViewController(withIdentifier: "ViewController2_ID")
//        self.addChild(addViewController)
//        self.view.addSubview(addViewController.view)
//        addViewController.didMove(toParent: self)
        
        Picker_PickerController.delegate = self as  UIImagePickerControllerDelegate & UINavigationControllerDelegate
        DrawingSignature_ContainerView.frame.size.height = 300
        DrawingSignature_ContainerView.frame.size.width = 300
        DrawingSignature_ContainerView.layer.borderWidth = 1.0
        SubjectName_TextField.returnKeyType = .done
        self.SubjectName_TextField.delegate = self as? UITextFieldDelegate
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        SubjectName_String = SubjectName_TextField.text ?? ""
        return false
    }
    
    func ShowToastMessage_Func(message : String, font: UIFont) {
        
        let ToastMessageLabel_UILabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 330, y: self.view.frame.size.height-960, width: 200, height: 35))
        ToastMessageLabel_UILabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        ToastMessageLabel_UILabel.textColor = UIColor.white
        ToastMessageLabel_UILabel.font = font
        ToastMessageLabel_UILabel.textAlignment = .center;
        ToastMessageLabel_UILabel.text = message
        ToastMessageLabel_UILabel.alpha = 1.0
        ToastMessageLabel_UILabel.layer.cornerRadius = 10;
        ToastMessageLabel_UILabel.clipsToBounds  =  true
        self.view.addSubview(ToastMessageLabel_UILabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            ToastMessageLabel_UILabel.alpha = 0.0
        }, completion: {(isCompleted) in
            ToastMessageLabel_UILabel.removeFromSuperview()
        })
    }
    
    @IBAction func GetPicture_Func_GetPicture_Button(_ sender: UIButton) {
        OpenGallary_Func()
    }
    
    @IBAction func Reset_Func_Reset_Button(_ sender: UIButton) {
        ViewContoller2_UIViewContoller.ClearAll_Func()
    }
    
    @IBAction func Save_Func_Save_Button(_ sender: UIButton) {
        if SubjectName_String.count > 0 && SubjectName_String.trimmingCharacters(in: .whitespaces).isEmpty {
            
        }
        else {
            ShowToastMessage_Func(message: "실험자 이름을 입력하여 주세요.", font: UIFont.systemFont(ofSize: UIFont.systemFontSize))
        }
    }
    
    func OpenGallary_Func(){
      Picker_PickerController.sourceType = .photoLibrary
      present(Picker_PickerController, animated: false, completion: nil)
    }
}

extension ViewController : UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil {
            //이미지 추가
        }
        dismiss(animated: true, completion: nil)
    }
}
