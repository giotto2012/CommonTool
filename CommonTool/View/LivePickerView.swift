//
//  LiveSpecificationPickerView.swift
//  LiveBid
//
//  Created by Taco on 2018/10/2.
//  Copyright © 2018年 Taco. All rights reserved.
//

import UIKit

public protocol LivePickerViewDelegate {
    
    func selectIndex(index:NSInteger,indexPath:IndexPath?)
}


public class LivePickerView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak public var selectPickerView: UIPickerView!

    
    public var dataArray:[String] = [] {
        
        didSet {
            selectPickerView.reloadAllComponents()
        }
    }
    
    public var delegate:LivePickerViewDelegate?
    
    public var indexPath:IndexPath?
    
    public override func awakeFromNib() {
        
        super.awakeFromNib()
        
       

    }
    
   
   
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataArray.count
    }
    public func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int, forComponent component: Int)
        -> String? {
           
            return dataArray[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int, inComponent component: Int) {
        
        
        delegate?.selectIndex(index:row,indexPath: indexPath)

    }
}
