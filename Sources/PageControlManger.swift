//
//  PageControlManger.swift
//  FBhelper
//
//  Created by 張宇樑 on 2020/10/14.
//  Copyright © 2020 Taco. All rights reserved.
//

import Foundation
import UIKit

public protocol PageControlMangerDelegate
{
    func requestNextApi(mangerTag:Int)
    
}

public class PageControlManger
{
    
    public var page = 1
     
    public var totalPage:Int?
    
    public var isLoading = false
    
    public var delegate:PageControlMangerDelegate?
    
    public var tag = 0
    
    public init()
    {
        
    }
    
    public func nextPageDataforIndex(indexPath:IndexPath,collectionView:UICollectionView)
    {
        let lastSection = collectionView.numberOfSections-1
        
        if indexPath.section == lastSection && indexPath.row == collectionView.numberOfItems(inSection: lastSection)-2
        {
            checkNextPage()
        }
        
    }
    public func nextPageDataforIndex(indexPath:IndexPath,tableView:UITableView)
    {
        let lastSection = tableView.numberOfSections-1
        
        if indexPath.section == lastSection && indexPath.row == tableView.numberOfRows(inSection: lastSection)-2
        {
            checkNextPage()
        }
        
    }
    
    public func nextPageData(scrollView:UIScrollView)
    {
        guard !self.isLoading && self.page < self.totalPage ?? 1   else { return }
        
        let contentOffsetY = scrollView.contentOffset.y
        
        if scrollView.contentSize.height - (scrollView.frame.size.height + contentOffsetY) <= 100
        {
            checkNextPage()
            
        }
        
    }
    
    private func checkNextPage()
    {
        guard !self.isLoading && self.page < self.totalPage ?? 1   else { return }
        
        self.page += 1
        
        self.isLoading = true
                             
        delegate!.requestNextApi(mangerTag: tag)
    }
    
    
    public func apiFinish()
    {
        self.isLoading = false
    }
    
    public func clear()
    {
        page = 1
        
        totalPage = nil
        
        isLoading = false
        
    }
    
}
