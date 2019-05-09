//
//  TypeIcons.swift
//  Tatsi
//
//  Created by Rens Verhoeven on 10/07/2017.
//  Copyright © 2017 Awkward BV. All rights reserved.
//

import Foundation

// swiftlint:disable type_body_length function_body_length
final internal class TypeIcons {

    static func drawFavoriteIcon(with color: UIColor, in frame: CGRect) {
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 7.94, y: frame.minY + 14))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 1.99, y: frame.minY + 7.98))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 2.11, y: frame.minY + 3.01), controlPoint1: CGPoint(x: frame.minX + 0.62, y: frame.minY + 6.59), controlPoint2: CGPoint(x: frame.minX + 0.68, y: frame.minY + 4.33))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 2.2, y: frame.minY + 2.93))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 6.79, y: frame.minY + 2.96), controlPoint1: CGPoint(x: frame.minX + 3.51, y: frame.minY + 1.73), controlPoint2: CGPoint(x: frame.minX + 5.5, y: frame.minY + 1.74))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 7.94, y: frame.minY + 4.04))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 9.45, y: frame.minY + 2.78))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 14.01, y: frame.minY + 3), controlPoint1: CGPoint(x: frame.minX + 10.8, y: frame.minY + 1.66), controlPoint2: CGPoint(x: frame.minX + 12.77, y: frame.minY + 1.76))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 14.01, y: frame.minY + 3.01))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 14.01, y: frame.minY + 7.86), controlPoint1: CGPoint(x: frame.minX + 15.33, y: frame.minY + 4.35), controlPoint2: CGPoint(x: frame.minX + 15.33, y: frame.minY + 6.52))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 7.94, y: frame.minY + 14))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 7.94, y: frame.minY + 14))
        bezierPath.close()
        bezierPath.usesEvenOddFillRule = true
        
        color.setFill()
        bezierPath.fill()
    }
    
    static func drawSelfPortraitIcon(with color: UIColor, in frame: CGRect) {
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.84375 * frame.width, y: frame.minY + 0.28125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.78125 * frame.width, y: frame.minY + 0.28125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.68441 * frame.width, y: frame.minY + 0.16019 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.61119 * frame.width, y: frame.minY + 0.12500 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.66663 * frame.width, y: frame.minY + 0.13794 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.63969 * frame.width, y: frame.minY + 0.12500 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.38881 * frame.width, y: frame.minY + 0.12500 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.31559 * frame.width, y: frame.minY + 0.16019 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.36031 * frame.width, y: frame.minY + 0.12500 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.33341 * frame.width, y: frame.minY + 0.13794 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.21875 * frame.width, y: frame.minY + 0.28125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.15625 * frame.width, y: frame.minY + 0.28125 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.37500 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.10447 * frame.width, y: frame.minY + 0.28125 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.32322 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.71875 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.15625 * frame.width, y: frame.minY + 0.81250 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.77050 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.10447 * frame.width, y: frame.minY + 0.81250 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.84375 * frame.width, y: frame.minY + 0.81250 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.93750 * frame.width, y: frame.minY + 0.71875 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.89553 * frame.width, y: frame.minY + 0.81250 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.93750 * frame.width, y: frame.minY + 0.77050 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.93750 * frame.width, y: frame.minY + 0.37500 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.84375 * frame.width, y: frame.minY + 0.28125 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.93750 * frame.width, y: frame.minY + 0.32322 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.89553 * frame.width, y: frame.minY + 0.28125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.84375 * frame.width, y: frame.minY + 0.28125 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.67188 * frame.width, y: frame.minY + 0.62500 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.59375 * frame.width, y: frame.minY + 0.50000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.64453 * frame.width, y: frame.minY + 0.50000 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.48438 * frame.width, y: frame.minY + 0.33984 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.64453 * frame.width, y: frame.minY + 0.41169 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.57269 * frame.width, y: frame.minY + 0.33984 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.32422 * frame.width, y: frame.minY + 0.50000 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.39606 * frame.width, y: frame.minY + 0.33984 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.32422 * frame.width, y: frame.minY + 0.41169 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.48438 * frame.width, y: frame.minY + 0.66016 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.32422 * frame.width, y: frame.minY + 0.58828 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.39606 * frame.width, y: frame.minY + 0.66016 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.49884 * frame.width, y: frame.minY + 0.65884 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.48931 * frame.width, y: frame.minY + 0.66016 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.49403 * frame.width, y: frame.minY + 0.65931 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.52525 * frame.width, y: frame.minY + 0.70263 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.48438 * frame.width, y: frame.minY + 0.70703 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.51200 * frame.width, y: frame.minY + 0.70531 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.49841 * frame.width, y: frame.minY + 0.70703 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.27734 * frame.width, y: frame.minY + 0.50000 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.37003 * frame.width, y: frame.minY + 0.70703 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.27734 * frame.width, y: frame.minY + 0.61431 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.48438 * frame.width, y: frame.minY + 0.29297 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.27734 * frame.width, y: frame.minY + 0.38566 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.37003 * frame.width, y: frame.minY + 0.29297 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.69141 * frame.width, y: frame.minY + 0.50000 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.59872 * frame.width, y: frame.minY + 0.29297 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.69141 * frame.width, y: frame.minY + 0.38566 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.75000 * frame.width, y: frame.minY + 0.50000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.67188 * frame.width, y: frame.minY + 0.62500 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.21875 * frame.width, y: frame.minY + 0.21875 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.21875 * frame.width, y: frame.minY + 0.25000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.25000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.21875 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.09375 * frame.width, y: frame.minY + 0.18750 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.20147 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.07650 * frame.width, y: frame.minY + 0.18750 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.18750 * frame.width, y: frame.minY + 0.18750 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.21875 * frame.width, y: frame.minY + 0.21875 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.20475 * frame.width, y: frame.minY + 0.18750 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.21875 * frame.width, y: frame.minY + 0.20147 * frame.height))
        bezierPath.close()
        bezierPath.usesEvenOddFillRule = true
        
        color.setFill()
        bezierPath.fill()
    }
    
    static func drawPanoramaIcon(with color: UIColor, in frame: CGRect) {
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.68796 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.96875 * frame.width, y: frame.minY + 0.81250 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.68122 * frame.width, y: frame.minY + 0.68796 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.84594 * frame.width, y: frame.minY + 0.73530 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.96875 * frame.width, y: frame.minY + 0.18750 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.31207 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.84594 * frame.width, y: frame.minY + 0.26474 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.68122 * frame.width, y: frame.minY + 0.31207 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.03125 * frame.width, y: frame.minY + 0.18750 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.31878 * frame.width, y: frame.minY + 0.31207 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.15406 * frame.width, y: frame.minY + 0.26474 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.03125 * frame.width, y: frame.minY + 0.81250 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.68796 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.15406 * frame.width, y: frame.minY + 0.73530 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.31878 * frame.width, y: frame.minY + 0.68796 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.68796 * frame.height))
        bezierPath.close()
        bezierPath.usesEvenOddFillRule = true
        
        color.setFill()
        bezierPath.fill()
    }
    
    static func drawVideoIcon(with color: UIColor, in frame: CGRect) {
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.59375 * frame.width, y: frame.minY + 0.81250 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.09375 * frame.width, y: frame.minY + 0.81250 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.00000 * frame.width, y: frame.minY + 0.71382 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.04197 * frame.width, y: frame.minY + 0.81250 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.00000 * frame.width, y: frame.minY + 0.76829 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.00000 * frame.width, y: frame.minY + 0.28618 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.09375 * frame.width, y: frame.minY + 0.18750 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.00000 * frame.width, y: frame.minY + 0.23168 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.04197 * frame.width, y: frame.minY + 0.18750 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.59375 * frame.width, y: frame.minY + 0.18750 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.68750 * frame.width, y: frame.minY + 0.28618 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.64553 * frame.width, y: frame.minY + 0.18750 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.68750 * frame.width, y: frame.minY + 0.23168 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.68750 * frame.width, y: frame.minY + 0.71382 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.59375 * frame.width, y: frame.minY + 0.81250 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.68750 * frame.width, y: frame.minY + 0.76829 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.64553 * frame.width, y: frame.minY + 0.81250 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 1.00000 * frame.width, y: frame.minY + 0.74671 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.75000 * frame.width, y: frame.minY + 0.51645 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.75000 * frame.width, y: frame.minY + 0.41776 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 1.00000 * frame.width, y: frame.minY + 0.18750 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 1.00000 * frame.width, y: frame.minY + 0.74671 * frame.height))
        bezierPath.close()
        bezierPath.usesEvenOddFillRule = true
        
        color.setFill()
        bezierPath.fill()
    }
    
    static func drawHighFrameRateIcon(with color: UIColor, in frame: CGRect) {
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.09343 * frame.width, y: frame.minY + 0.69837 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.20175 * frame.width, y: frame.minY + 0.63599 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.23294 * frame.width, y: frame.minY + 0.69016 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.12461 * frame.width, y: frame.minY + 0.75253 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.09343 * frame.width, y: frame.minY + 0.69837 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.25173 * frame.width, y: frame.minY + 0.15689 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.30590 * frame.width, y: frame.minY + 0.12571 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.36827 * frame.width, y: frame.minY + 0.23405 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.31410 * frame.width, y: frame.minY + 0.26523 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.25173 * frame.width, y: frame.minY + 0.15689 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.74344 * frame.width, y: frame.minY + 0.32419 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.85176 * frame.width, y: frame.minY + 0.26181 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.88295 * frame.width, y: frame.minY + 0.31597 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.77463 * frame.width, y: frame.minY + 0.37835 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.74344 * frame.width, y: frame.minY + 0.32419 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.62798 * frame.width, y: frame.minY + 0.78609 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.68214 * frame.width, y: frame.minY + 0.75491 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.74452 * frame.width, y: frame.minY + 0.86323 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.69035 * frame.width, y: frame.minY + 0.89442 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.62798 * frame.width, y: frame.minY + 0.78609 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.46875 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.18750 * frame.width, y: frame.minY + 0.46875 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.18750 * frame.width, y: frame.minY + 0.53125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.53125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.46875 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.06250 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.53125 * frame.width, y: frame.minY + 0.06250 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.53125 * frame.width, y: frame.minY + 0.18750 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.18750 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.06250 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.81250 * frame.width, y: frame.minY + 0.46875 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.93750 * frame.width, y: frame.minY + 0.46875 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.93750 * frame.width, y: frame.minY + 0.53125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.81250 * frame.width, y: frame.minY + 0.53125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.81250 * frame.width, y: frame.minY + 0.46875 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.81250 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.53125 * frame.width, y: frame.minY + 0.81250 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.53125 * frame.width, y: frame.minY + 0.93750 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.93750 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.81250 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.25590 * frame.width, y: frame.minY + 0.87690 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.31760 * frame.width, y: frame.minY + 0.76818 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.37195 * frame.width, y: frame.minY + 0.79903 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.31025 * frame.width, y: frame.minY + 0.90775 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.25590 * frame.width, y: frame.minY + 0.87690 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.11161 * frame.width, y: frame.minY + 0.30497 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.14246 * frame.width, y: frame.minY + 0.25061 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.25117 * frame.width, y: frame.minY + 0.31231 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.22032 * frame.width, y: frame.minY + 0.36667 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.11161 * frame.width, y: frame.minY + 0.30497 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.62609 * frame.width, y: frame.minY + 0.22463 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.68780 * frame.width, y: frame.minY + 0.11592 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.74215 * frame.width, y: frame.minY + 0.14677 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.68045 * frame.width, y: frame.minY + 0.25548 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.62609 * frame.width, y: frame.minY + 0.22463 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.76387 * frame.width, y: frame.minY + 0.67516 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.79472 * frame.width, y: frame.minY + 0.62080 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.90344 * frame.width, y: frame.minY + 0.68250 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.87259 * frame.width, y: frame.minY + 0.73686 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.76387 * frame.width, y: frame.minY + 0.67516 * frame.height))
        bezierPath.close()
        bezierPath.usesEvenOddFillRule = true
        
        color.setFill()
        bezierPath.fill()
    }
    
    static func drawTimeLapseIcon(with color: UIColor, in frame: CGRect) {
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.25000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.06250 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.53128 * frame.width, y: frame.minY + 0.06250 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.53128 * frame.width, y: frame.minY + 0.25000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.25000 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.93750 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.75000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.53128 * frame.width, y: frame.minY + 0.75000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.53128 * frame.width, y: frame.minY + 0.93750 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.46875 * frame.width, y: frame.minY + 0.93750 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.53125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.46872 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.25000 * frame.width, y: frame.minY + 0.46872 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.25000 * frame.width, y: frame.minY + 0.53125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.06250 * frame.width, y: frame.minY + 0.53125 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.75000 * frame.width, y: frame.minY + 0.53125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.75000 * frame.width, y: frame.minY + 0.46872 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.93750 * frame.width, y: frame.minY + 0.46872 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.93750 * frame.width, y: frame.minY + 0.53125 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.75000 * frame.width, y: frame.minY + 0.53125 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.35759 * frame.width, y: frame.minY + 0.08514 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.41799 * frame.width, y: frame.minY + 0.06911 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.43402 * frame.width, y: frame.minY + 0.12952 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.37362 * frame.width, y: frame.minY + 0.14555 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.35759 * frame.width, y: frame.minY + 0.08514 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.56599 * frame.width, y: frame.minY + 0.87048 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.62637 * frame.width, y: frame.minY + 0.85445 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.64240 * frame.width, y: frame.minY + 0.91485 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.58199 * frame.width, y: frame.minY + 0.93088 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.56599 * frame.width, y: frame.minY + 0.87048 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.06911 * frame.width, y: frame.minY + 0.58200 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.12952 * frame.width, y: frame.minY + 0.56597 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.14555 * frame.width, y: frame.minY + 0.62638 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.08514 * frame.width, y: frame.minY + 0.64241 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.06911 * frame.width, y: frame.minY + 0.58200 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.85444 * frame.width, y: frame.minY + 0.37362 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.91485 * frame.width, y: frame.minY + 0.35759 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.93088 * frame.width, y: frame.minY + 0.41800 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.87047 * frame.width, y: frame.minY + 0.43400 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.85444 * frame.width, y: frame.minY + 0.37362 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.21375 * frame.width, y: frame.minY + 0.25574 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.16975 * frame.width, y: frame.minY + 0.21136 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.21413 * frame.width, y: frame.minY + 0.16736 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.25813 * frame.width, y: frame.minY + 0.21174 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.21375 * frame.width, y: frame.minY + 0.25574 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.78588 * frame.width, y: frame.minY + 0.83265 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.74188 * frame.width, y: frame.minY + 0.78827 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.78625 * frame.width, y: frame.minY + 0.74428 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.83025 * frame.width, y: frame.minY + 0.78865 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.78588 * frame.width, y: frame.minY + 0.83265 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.21173 * frame.width, y: frame.minY + 0.74187 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.25573 * frame.width, y: frame.minY + 0.78624 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.21135 * frame.width, y: frame.minY + 0.83024 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.16735 * frame.width, y: frame.minY + 0.78587 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.21173 * frame.width, y: frame.minY + 0.74187 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.74426 * frame.width, y: frame.minY + 0.21375 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.78864 * frame.width, y: frame.minY + 0.16975 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.83264 * frame.width, y: frame.minY + 0.21413 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.78826 * frame.width, y: frame.minY + 0.25813 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.74426 * frame.width, y: frame.minY + 0.21375 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.06978 * frame.width, y: frame.minY + 0.41463 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.08625 * frame.width, y: frame.minY + 0.35432 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.14657 * frame.width, y: frame.minY + 0.37085 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.13007 * frame.width, y: frame.minY + 0.43113 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.06978 * frame.width, y: frame.minY + 0.41463 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.85343 * frame.width, y: frame.minY + 0.62917 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.86993 * frame.width, y: frame.minY + 0.56885 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.93021 * frame.width, y: frame.minY + 0.58538 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.91374 * frame.width, y: frame.minY + 0.64563 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.85343 * frame.width, y: frame.minY + 0.62917 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.35435 * frame.width, y: frame.minY + 0.91373 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.37082 * frame.width, y: frame.minY + 0.85342 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.43113 * frame.width, y: frame.minY + 0.86995 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.41463 * frame.width, y: frame.minY + 0.93020 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.35435 * frame.width, y: frame.minY + 0.91373 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.56886 * frame.width, y: frame.minY + 0.13006 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.58536 * frame.width, y: frame.minY + 0.06978 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.64567 * frame.width, y: frame.minY + 0.08628 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.62918 * frame.width, y: frame.minY + 0.14656 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.56886 * frame.width, y: frame.minY + 0.13006 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.40234 * frame.width, y: frame.minY + 0.26775 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.34819 * frame.width, y: frame.minY + 0.29894 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.25462 * frame.width, y: frame.minY + 0.13644 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.30878 * frame.width, y: frame.minY + 0.10525 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.40234 * frame.width, y: frame.minY + 0.26775 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.59766 * frame.width, y: frame.minY + 0.73225 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.65181 * frame.width, y: frame.minY + 0.70106 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.74538 * frame.width, y: frame.minY + 0.86356 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.69122 * frame.width, y: frame.minY + 0.89475 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.59766 * frame.width, y: frame.minY + 0.73225 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.26775 * frame.width, y: frame.minY + 0.59766 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.29893 * frame.width, y: frame.minY + 0.65181 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.13643 * frame.width, y: frame.minY + 0.74538 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.10525 * frame.width, y: frame.minY + 0.69122 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.26775 * frame.width, y: frame.minY + 0.59766 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.73225 * frame.width, y: frame.minY + 0.40234 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.70107 * frame.width, y: frame.minY + 0.34819 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.86357 * frame.width, y: frame.minY + 0.25462 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.89475 * frame.width, y: frame.minY + 0.30878 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.73225 * frame.width, y: frame.minY + 0.40234 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.29852 * frame.width, y: frame.minY + 0.34874 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.26749 * frame.width, y: frame.minY + 0.40299 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.10474 * frame.width, y: frame.minY + 0.30990 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.13577 * frame.width, y: frame.minY + 0.25565 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.29852 * frame.width, y: frame.minY + 0.34874 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.70148 * frame.width, y: frame.minY + 0.65126 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.73251 * frame.width, y: frame.minY + 0.59701 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.89526 * frame.width, y: frame.minY + 0.69010 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.86423 * frame.width, y: frame.minY + 0.74435 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.70148 * frame.width, y: frame.minY + 0.65126 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.34874 * frame.width, y: frame.minY + 0.70148 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.40299 * frame.width, y: frame.minY + 0.73252 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.30990 * frame.width, y: frame.minY + 0.89527 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.25565 * frame.width, y: frame.minY + 0.86423 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.34874 * frame.width, y: frame.minY + 0.70148 * frame.height))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: frame.minX + 0.65126 * frame.width, y: frame.minY + 0.29852 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.59701 * frame.width, y: frame.minY + 0.26748 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.69013 * frame.width, y: frame.minY + 0.10473 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.74435 * frame.width, y: frame.minY + 0.13577 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.65126 * frame.width, y: frame.minY + 0.29852 * frame.height))
        bezierPath.close()
        bezierPath.usesEvenOddFillRule = true
        
        color.setFill()
        bezierPath.fill()
    }
    
}
