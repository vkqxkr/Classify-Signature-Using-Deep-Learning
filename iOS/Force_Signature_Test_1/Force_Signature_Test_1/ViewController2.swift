//
//  ViewController2.swift
//  Force_Signature_Test_1
//
//  Created by JinHyuck Park on 2019/12/08.
//  Copyright © 2019 JinHyuck Park. All rights reserved.
//

import UIKit
import PencilKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var DrawingSignature_ImageView: UIImageView!
    
    var ForceValue_String: String = ""
    
    var BrushColor_UIColor = UIColor.black.cgColor
    var BrushWidth_CGFloat: CGFloat = 1.0

    var LastPoint_CGPoint = CGPoint.zero
    var IsDrawing_Boolean = false

    var IsPen_Boolean = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
                LastPoint_CGPoint = touch.location(in: DrawingSignature_ImageView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
                let force = touch.force/touch.maximumPossibleForce
                print(force)
            ForceValue_String = ForceValue_String + force.description + "\n"
            let currentPoint = touch.location(in: DrawingSignature_ImageView)
                    DrawLine_Func(from: LastPoint_CGPoint, to: currentPoint, force: force)
                    LastPoint_CGPoint = currentPoint

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let force = touch.force/touch.maximumPossibleForce
            print(force)
            if !IsDrawing_Boolean {
                DrawLine_Func(from: LastPoint_CGPoint, to: LastPoint_CGPoint, force: force)
            }
            IsDrawing_Boolean = false
        }
    }
    
    func DrawLine_Func(from: CGPoint, to: CGPoint, force: CGFloat) {
        UIGraphicsBeginImageContext(DrawingSignature_ImageView.frame.size)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        DrawingSignature_ImageView.image?.draw(in: DrawingSignature_ImageView.bounds)

        if IsPen_Boolean {
            context.setBlendMode(.normal)
        } else {
            context.setBlendMode(.clear)
        }

        context.setLineCap(.round)
        context.setLineWidth(force * 10)
        context.setStrokeColor(BrushColor_UIColor)
        context.move(to: from)
        context.addLine(to: to)

        context.strokePath()

        DrawingSignature_ImageView.image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
    }
    
    func ClearAll_Func() {
        ForceValue_String = ""
    }
    
    func GetForceValue_Func()->String {
        return ForceValue_String
    }
}

