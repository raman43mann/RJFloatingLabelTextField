//
//  RJTextViewWithinBorder.swift
//  RJFloatingLabelTextField
//
//  Created by Ramanjeet Singh on 20/12/23.
//

import UIKit

open class RJTextViewWithinBorder: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak private var placeHolderLabel: UILabel!
    @IBOutlet weak private var textView: UITextView!
    @IBOutlet weak private var floatLabelCenterYTOP: NSLayoutConstraint!
    
    @IBOutlet weak private var btnRightPadding: UIButton!
    
    @IBOutlet weak private var topView: UIView!
    
    //MARK: - Right Padding  Actions
    public var selectRightPadding : (()->())?
       
    @IBAction func btnRightPaddingAction(_ sender: UIButton) {
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
    public var shouldBeginEditingDelegate : (()->())?
    public var didBeginEditingDelegate : (()->())?
    public var shouldReturnDelegate : ((String)->Void)?
    public var shouldChangeCahracterinRangeDelegate : ((String)->Void)?
    public var didEndEditingDelegate : ((String)->())?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configTextField()
    }
    
    required public init?(coder aDecoder: NSCoder) {
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
       textView.textContainerInset = UIEdgeInsets.zero
       textView.textContainer.lineFragmentPadding = 0
       textView.font = textFieldFont
       textView.delegate = self
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
        self.textView.becomeFirstResponder()
    }
    
    
    //MARK: -  Setup View Border Color
    public func setUpBorderColor(active:Bool){
        self.layer.borderColor = (active ? borderSelectedColor : borderUnSelectedColor).cgColor
    }
    
    //MARK: -  Setup Placeholder Text
    public func setPlaceholderText(text:String){
        placeHolderLabel.text = text
    }
    
    //MARK: -  Setup Text as String or Attributed String
    public func setText(text:String){
        textView.text = text
        checkPlaceHolder()
    }
    
    public func setAttributedText(text:NSAttributedString){
        textView.attributedText = text
        checkPlaceHolder()
    }
    
    
    //MARK: -  Setup Right Padding
    //MARK: -  Setup Right Padding
    public func setupRightPadding(image:UIImage?){
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
            self.floatLabelCenterYTOP.constant = 13
            
        }else{
            if  textView.text?.isEmpty == false{
                
            }else{
                self.placeHolderLabel.font =  inActivePlaceHolderFont
                self.floatLabelCenterYTOP.constant = 25
            }
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0,options: .curveEaseOut) {
            self.layoutIfNeeded()
        }
    }
    
    
    
    private func checkPlaceHolder(){
        
        if textView.text?.isEmpty == true{
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

extension RJTextViewWithinBorder : UITextViewDelegate{
    
    //MARK: - TextField  Delegates
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if let wrapper = didBeginEditingDelegate{
            wrapper()
        }
        
        setUpBorderColor(active: true)
        placeHolderPosition(isUp: true)
    }
    public func textViewDidEndEditing(_ textView: UITextView) {
        
        if let wrapper = didEndEditingDelegate{
            wrapper(textView.text ?? "")
        
        }
      
        setUpBorderColor(active: false)
        placeHolderPosition(isUp: false)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let wrapper = shouldChangeCahracterinRangeDelegate{
            wrapper(text)
        }
        
        return true
    }
    
    
    
    
}
