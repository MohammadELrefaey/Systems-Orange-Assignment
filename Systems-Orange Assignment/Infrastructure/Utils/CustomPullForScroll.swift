//
//  CustomPullForScroll.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation
import UIKit

class CustomPullForScroll {
    
    static func addPullToResfresh(scrollview: UIScrollView, completion: (()->())?) {
        ESBridge.addPullToResfresh(scrollview: scrollview, completion: completion)
    }
    static func stopPullToRefresh(scrollview: UIScrollView) {
        ESBridge.stopPullToRefresh(scrollview: scrollview)
    }
    static func addInfiniteScroll(scrollview: UIScrollView, completion: (()->())?) {
        ESBridge.addInfiniteScroll(scrollview: scrollview, completion: completion)
    }
    static func stopInfiniteScroll(scrollview: UIScrollView) {
        ESBridge.stopInfiniteScroll(scrollview: scrollview)
    }


}
