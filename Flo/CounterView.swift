//
//  CounterView.swift
//  Flo
//
//  Created by Chris Li on 6/6/18.
//  Copyright © 2018 Chris Li. All rights reserved.
//

import UIKit

@IBDesignable class CounterView: UIView {

    private struct Constants {
        static let numberOfGlasses = 8
        static let lineWidth: CGFloat = 5.0
        static let arcWidth: CGFloat = 76
        
        static var halfOfLineWidth: CGFloat {
            return lineWidth / 2
        }
    }
    
    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <= Constants.numberOfGlasses {
                //the view needs to be refreshed
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    
    override func draw(_ rect: CGRect) {
        //Define the center point of the view where you'll rotate the arc around
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        //Calculate the radius based on the max dimension of the view
        let diameter: CGFloat = max(bounds.width, bounds.height)
        
        //Define the start and end engles for the arc.
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        
        //Create a path based on the center point, radius, and angles defined
        //Minus half the width of the arc thickness (for radius) so
        //fits in view bounds
        let path = UIBezierPath(arcCenter: center,
                                 radius: diameter / 2 - Constants.arcWidth / 2,
                                 startAngle: startAngle,
                                 endAngle: endAngle,
                                 clockwise: true)
        
        //Set the line width and color before stroking the path
        path.lineWidth = Constants.arcWidth
        counterColor.setStroke()
        path.stroke()
        
        //Drawing the outline for the arc
        
        //calculate the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        //calculate the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(Constants.numberOfGlasses)
        //then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //draw outer arc
        let outlinePath = UIBezierPath(arcCenter: center,
                                        radius: diameter / 2 - Constants.halfOfLineWidth,
                                        startAngle: startAngle,
                                        endAngle: outlineEndAngle,
                                        clockwise: true)
        
        //draw inner arc (auto draws a line connecting outlinePath's
        //initial arc with the start of this arc)
        outlinePath.addArc(withCenter: center,
                           radius: diameter / 2 - Constants.arcWidth + Constants.halfOfLineWidth,
                           startAngle: outlineEndAngle,
                           endAngle: startAngle,
                           clockwise: false)
        
        //close path (automatically connects start point and end point)
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = Constants.lineWidth
        outlinePath.stroke()
        
    }

}
