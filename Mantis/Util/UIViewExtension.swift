//
//  UIViewExtension.swift
//  Mantis
//
//  Created by rodoolfo gonzalez on 10-05-23.
//

import UIKit

extension UIView {
    // Borde redondo
        func round() {
            layer.cornerRadius = frame.size.height / 5
            
               
            clipsToBounds = true
            
        }
      
}
extension UIButton{
    // Borde redondo
        func rounded() {
            layer.cornerRadius = frame.size.height / 5
            
               
            clipsToBounds = true
            
        }
      
}
