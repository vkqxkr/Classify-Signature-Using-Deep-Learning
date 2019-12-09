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
    
    var brushColor = UIColor.black.cgColor
    var brushWidth: CGFloat = 1.0

    var lastPoint = CGPoint.zero
    var isDrawing = false

    var isPen = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
                lastPoint = touch.location(in: DrawingSignature_ImageView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
                let force = touch.force/touch.maximumPossibleForce
                print(force)
            let currentPoint = touch.location(in: DrawingSignature_ImageView)
                    drawLine(from: lastPoint, to: currentPoint, force: force)
                    lastPoint = currentPoint

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let force = touch.force/touch.maximumPossibleForce
            print(force)
            if !isDrawing {
                drawLine(from: lastPoint, to: lastPoint, force: force)
            }
            isDrawing = false
        }
    }
    
    func drawLine(from: CGPoint, to: CGPoint, force: CGFloat) {
        UIGraphicsBeginImageContext(DrawingSignature_ImageView.frame.size)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        DrawingSignature_ImageView.image?.draw(in: DrawingSignature_ImageView.bounds)

        if isPen {
            context.setBlendMode(.normal)
        } else {
            context.setBlendMode(.clear)
        }

        context.setLineCap(.round)
        context.setLineWidth(force * 10)
        context.setStrokeColor(brushColor)
        context.move(to: from)
        context.addLine(to: to)

        context.strokePath()

        DrawingSignature_ImageView.image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
    }
    
    func Eraser() {
        DrawingSignature_ImageView.image = nil
        return
    }
}

