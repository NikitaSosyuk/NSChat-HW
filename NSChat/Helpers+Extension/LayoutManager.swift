//
//  LayoutHelper.swift
//  NSChat
//
//  Created by Nikita Sosyuk on 03.10.2021.
//

import UIKit

enum LayoutManager {
    static func turnOffAutoresizingMaskTo(_ views: UIView...) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    static func addSubviewsTo(view: UIView, _ views: UIView...) {
        views.forEach { view.addSubview($0) }
    }    
}
