//
//  ViewController.swift
//  RJFloatingLabelTextField
//
//  Created by raman43mann on 02/04/2024.
//  Copyright (c) 2024 raman43mann. All rights reserved.
//


import UIKit
import RJFloatingLabelTextField

class ViewController: UIViewController {
    @IBOutlet weak var tfEmail: RJTextFieldWithinBorder!
    
    @IBOutlet weak var tfName: RJTextFieldWithinBorder!
    
    @IBOutlet weak var textView: RJTextViewWithinBorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfEmail.setPlaceholderText(text: "Its text field Placeholder")
        tfEmail.setupKeyboardType(type: .phonePad)
        
            
        
        
        tfName.setPlaceholderText(text: "Placeholder for TextField")
        tfName.setupRightPadding(image: UIImage(named: "imageViewBelow"))
     
        textView.setText(text: "Its text View")
        
    
    }

}






