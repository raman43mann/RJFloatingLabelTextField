//
//  RJTextFieldWithinBorder.swift
//  RJFloatingLabelTextField
//
//  Created by Ramanjeet Singh on 20/12/23.
//

import UIKit

final class RJTextFieldWithinBorder: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak private var placeHolderLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak private var floatLabelCenterY: NSLayoutConstraint!
    
    @IBOutlet weak private var topView: UIView!
    @IBOutlet weak  private var btnRightPadding: UIButton!
    
    
    //MARK: - Right Padding  Actions
    var selectRightPadding : (()->())?
       
    @IBAction private func btnRightPaddingAction(_ sender: UIButton) {
        selectRightPadding?()
    }
    
 
    @IBOutlet weak private var paddingButtonWidthConstraint: NSLayoutConstraint!
    
//MARK: - Text Field and PlaceHolder Fonts
   private let activePlaceHolderFont = UIFont.systemFont(ofSize: 13, weight: .medium) // Up
   private let inActivePlaceHolderFont =  UIFont.systemFont(ofSize: 15, weight: .medium) // On Center
    private let textFieldFont =  UIFont.systemFont(ofSize: 15, weight: .medium)
    
    
    //MARK: - Text Field and PlaceHolder Color
   private let activePlaceHolderColor = UIColor.darkGray
   private let inActivePlaceHolderColor = UIColor.darkGray
   private let textFieldColor = UIColor.black
    
    //MARK: - View Properties
   private let  borderSelectedColor = UIColor.black
    private let borderUnSelectedColor = UIColor.lightGray.withAlphaComponent(0.5)


    //MARK: - Text Field Call Backs
    var shouldBeginEditingDelegate : (()->())?
    var didBeginEditingDelegate : (()->())?
    var shouldReturnDelegate : ((String)->Void)?
  //  var shouldChangeCahracterinRangeDelegate : ((String)->Void)?
    typealias ShouldChangeCharactersCallback = (UITextField, NSRange, String) -> Bool
    var shouldChangeCharactersCallback: ShouldChangeCharactersCallback?
        
    var didEndEditingDelegate : ((String)->Void)?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configTextField()
    }
    
    
    //MARK: -  Configuration
    private  func configTextField(){
       
       let view = viewFromNibForClass()
       view.frame = bounds
       
       // Auto-layout stuff.
       view.autoresizingMask = [
           UIView.AutoresizingMask.flexibleWidth,
           UIView.AutoresizingMask.flexibleHeight
       ]
       
       // Show the view.
       addSubview(view)
       
       
       // View Config
       self.backgroundColor = UIColor.white
       self.layer.cornerRadius = 10
       self.layer.borderWidth = 1
       self.layer.borderColor = borderUnSelectedColor.cgColor
       self.clipsToBounds = true
        
       //TextFieldConfig
       
       
       textField.font = textFieldFont
       textField.delegate = self
       setupRightPadding(image: nil)
       setText(text: "")
       setUpBorderColor(active: false)
       
       let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
       //tap.delegate = self
       tap.numberOfTapsRequired = 1
       topView.addGestureRecognizer(tap)
    }
    
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.textField.becomeFirstResponder()
    }
    
    
    
    //MARK: -  Setup View Border Color
    
    func setupKeyboardType(type:UIKeyboardType){
        textField.keyboardType = type
    }
    
    func setUpBorderColor(active:Bool){
        self.layer.borderColor = (active ? borderSelectedColor : borderUnSelectedColor).cgColor
    }
    
    //MARK: -  Setup Placeholder Text
    func setPlaceholderText(text:String){
        placeHolderLabel.text = text
    }
    
    //MARK: -  Setup Text as String or Attributed String
    func setText(text:String){
        textField.text = text
        checkPlaceHolder()
    }
    
    func setAttributedText(text:NSAttributedString){
        textField.attributedText = text
        checkPlaceHolder()
    }
    
    
    //MARK: -  Setup Right Padding
    func setupRightPadding(image:UIImage?){
        if let image {
            btnRightPadding.setImage(image, for: .normal)
            btnRightPadding.isHidden = false
            paddingButtonWidthConstraint.constant = 50
            
        }else{
            btnRightPadding.isHidden = true
            paddingButtonWidthConstraint.constant = 0
        }
    
       self.layoutIfNeeded()
    }
    
    
    //MARK: - PlaceHolder Positions change
    private func placeHolderPosition(isUp:Bool){
       
        if isUp{
            self.placeHolderLabel.font = activePlaceHolderFont
            self.floatLabelCenterY.constant = -15
            
        }else{
            if  textField.text?.isEmpty == false{
                
            }else{
                self.placeHolderLabel.font =  inActivePlaceHolderFont
                self.floatLabelCenterY.constant = 0
            }
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0,options: .curveEaseOut) {
            self.layoutIfNeeded()
        }
    }
    
    
    
    private func checkPlaceHolder(){
        
        if textField.text?.isEmpty == true{
            placeHolderPosition(isUp: false)
        }else{
            placeHolderPosition(isUp: true)
        }
    }

    
    // //MARK: - TextField Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
}


//MARK: - TextField  Delegates

extension RJTextFieldWithinBorder : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let wrapper = didBeginEditingDelegate{
            wrapper()
            
        }
        setUpBorderColor(active: true)
        placeHolderPosition(isUp: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let wrapper = didEndEditingDelegate{
            wrapper(textField.text ?? "")
        }
        setUpBorderColor(active: false)
        placeHolderPosition(isUp: false)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let wrapper = shouldBeginEditingDelegate{
            wrapper()
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let wrapper = self.shouldChangeCharactersCallback?(textField, range, string){
            return wrapper
        }
        
        
        
        
        //        let currentText = textField.text ?? ""
        //            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        // textField.text = updatedText
      //   shouldChangeCahracterinRangeDelegate?(string)
//            textField.text = item.updatedText
          
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let wrapper = shouldReturnDelegate{
            wrapper(textField.text ?? "")
            return true
        }
        return true
    }
    
    
}
