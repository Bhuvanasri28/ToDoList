//
//  UITextView+Extension.swift
//  ToDoListApp
//
//  Created by BhuvanaR on 6/1/23.
//

import Foundation
import UIKit

extension UITextView {
    func leftSpace(amount: CGFloat) {
        self.textContainerInset = UIEdgeInsets(top: 8, left: amount, bottom: 4, right: 4)
    }
}



