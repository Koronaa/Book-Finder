//
//  UIHelper.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import UIKit

class UIHelper{
    
    static func makeViewController<T:UIViewController>(in storyboard:UIConstants.StoryBoard = .Main,viewControllerName:UIConstants.StoryBoardID) -> T{
        return makeViewController(storyBoardName: storyboard.rawValue, viewControllerName: viewControllerName.rawValue) as! T
    }
    
    static private func makeViewController(storyBoardName:String, viewControllerName:String) -> UIViewController {
        return UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerName)
    }
    
}
