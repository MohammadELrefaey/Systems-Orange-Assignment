//
//  EsBridge.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 03/11/2023.
//

import Foundation
import ESPullToRefresh
import UIKit

class ESBridge {
    static func addPullToResfresh(scrollview: UIScrollView, completion: (()->())?) {
        scrollview.es.addPullToRefresh {
            completion?()
        }
    }
    
    static func stopPullToRefresh(scrollview: UIScrollView) {
        scrollview.es.stopPullToRefresh()
    }
    
    static func addInfiniteScroll(scrollview: UIScrollView, completion: (()->())?) {
        scrollview.es.addInfiniteScrolling {            
            completion?()
        }
    }
    
    static func stopInfiniteScroll(scrollview: UIScrollView) {
        scrollview.es.stopLoadingMore()
    }

}
