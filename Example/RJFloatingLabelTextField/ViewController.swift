//
//  ViewController.swift
//  RJFloatingLabelTextField
//
//  Created by @Raman Mann on 12/30/2023.
//  Copyright (c) 2023 @Raman Mann. All rights reserved.
//

import UIKit
import RJFloatingLabelTextField

class ViewController: UIViewController {
    
    @IBOutlet weak var tfEmailFld: RJTextFieldWithinBorder!
    
    @IBOutlet weak var tfName: RJTextFieldWithinBorder!
    
    @IBOutlet weak var textView: RJTextViewWithinBorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfEmailFld.setPlaceholderText(text: "Its text field Placeholder")
        tfEmailFld.setupKeyboardType(type: .phonePad)
        
            
        
        
        tfName.setPlaceholderText(text: "Placeholder for TextField")
        tfName.setupRightPadding(image: UIImage(named: "imageViewBelow"))
     
        textView.setText(text: "Its text View")
        
    
    }

}
