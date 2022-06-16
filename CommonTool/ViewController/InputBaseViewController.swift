//
//  InputBaseViewController.swift
//  FBhelper
//
//  Created by 張宇樑 on 2020/9/4.
//  Copyright © 2020 Taco. All rights reserved.
//

import UIKit

public protocol InputBaseDelegate
{
    func inputContentView() -> UIView
    
    func inputScrollView() -> UIScrollView?
    
    func pickDidSelect(index:Int,pickerPath:IndexPath?)
}



open class InputBaseViewController: UIViewController {
        
    public var keyboardIsShow:Bool = false
    
    public lazy var pickerView:LivePickerView = {
        
        let view:LivePickerView = LivePickerView().loadNib() as! LivePickerView
        
        view.delegate = self
        
        return view
        
    }()
    
    public var inputViewDelegate:InputBaseDelegate? {
        
        didSet {
            
            if let scrollView = inputViewDelegate?.inputScrollView()
            {
                let scrollViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(contentViewTapped))
                
                scrollViewTapRecognizer.cancelsTouchesInView = false
                
                scrollView.addGestureRecognizer(scrollViewTapRecognizer)
            }

            let contentViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(contentViewTapped))
            
            contentViewTapRecognizer.cancelsTouchesInView = false
            
            inputViewDelegate?.inputContentView().addGestureRecognizer(contentViewTapRecognizer)
            
        }
        
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        

        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
      
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc open func contentViewTapped(sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            //bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            
            if isKeyboardShowing
            {
                keyboardIsShow = true
                
                if let scroView = inputViewDelegate?.inputScrollView()
                {
                    scroView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height+bottomPadding(), right: 0)
                }
                
            }
            else
            {
                keyboardIsShow = false

                
                if let scroView = inputViewDelegate?.inputScrollView()
                {
                    scroView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height+bottomPadding(), right: 0)
                }
            }
            
            
            
            
        }
    }
    
    open func bottomPadding() -> CGFloat
    {
        return 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension InputBaseViewController:LivePickerViewDelegate{
    
    
    open func selectIndex(index: NSInteger,indexPath:IndexPath?) {
        
        inputViewDelegate?.pickDidSelect(index: index, pickerPath: indexPath)
        
    }

}
//extension InputBaseViewController:InputBaseDelegate
//{
//    public func pickDidSelect(index:Int,pickerPath:IndexPath?)
//    {
//
//    }
//
//
//    public func inputContentView() -> UIView {
//
//        return view
//    }
//
//    public func inputScrollView() -> UIScrollView? {
//
//        return nil
//    }
//
//}
