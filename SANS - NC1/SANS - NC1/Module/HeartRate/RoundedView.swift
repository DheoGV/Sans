//
//  RoundedView.swift
//  SANS - NC1
//
//  Created by Dheo Gildas Varian on 05/05/21.
//

import UIKit
class RoundedView: UIView {
    let cornerRadius: CGFloat = 24.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setRounded()
    }
    
    func setRounded(){
        let masked = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let setShape = CAShapeLayer()
        setShape.path = masked.cgPath
        
        self.layer.mask = setShape
    }
}
