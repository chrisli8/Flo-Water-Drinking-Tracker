//
//  GraphView.swift
//  Flo
//
//  Created by Chris Li on 6/6/18.
//  Copyright © 2018 Chris Li. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {

    //set start and end colors for gradient so changable in storyboard
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    
    
    override func draw(_ rect: CGRect) {
        //tell CG drawing functions which context
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        //use RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //define color stops for when gradient change over
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        //create gradient
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        //draw gradient
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
    

}
