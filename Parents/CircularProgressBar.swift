////
////  CircularProgressBar.swift
////  Holi
////
////  Created by Кирилл on 10/17/18.
////  Copyright © 2018 Kirill Esin. All rights reserved.
////
//
//import Foundation
//
//class CircularProgressBar: UIView {
//
//    //MARK: awakeFromNib
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupView()
//        label.text = "0"
//    }
//
//
//    //MARK: Public
//
//    public var lineWidth:CGFloat = 50 {
//        didSet{
//            foregroundLayer.lineWidth = lineWidth
//            backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
//        }
//    }
//
//    public var labelSize: CGFloat = 20 {
//        didSet {
//            label.font = UIFont.systemFont(ofSize: labelSize)
//            label.sizeToFit()
//            configLabel()
//        }
//    }
//
//    public var safePercent: Int = 100 {
//        didSet{
//            setForegroundLayerColorForSafePercent()
//        }
//    }
//
//    public func setProgress(to progressConstant: Double, withAnimation: Bool) {
//
//        var progress: Double {
//            get {
//                if progressConstant > 1 { return 1 }
//                else if progressConstant < 0 { return 0 }
//                else { return progressConstant }
//            }
//        }
//
//        foregroundLayer.strokeEnd = CGFloat(progress)
//
////        if withAnimation {
////            let animation = CABasicAnimation(keyPath: "strokeEnd")
////            animation.fromValue = 0
////            animation.toValue = progress
////            animation.duration = 5
////            foregroundLayer.add(animation, forKey: "foregroundAnimation")
////        }
//
////        var currentTime:Double = 0
////        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
////            if currentTime >= 2{
////                timer.invalidate()
////            } else {
////                currentTime += 0.05
////                let percent = currentTime/2 * 100
////                self.label.text = "\(Int(progress * percent))"
////                self.setForegroundLayerColorForSafePercent()
////                self.configLabel()
////            }
////        }
////        timer.fire()
//
//    }
//
//
//
//
//    //MARK: Private
//    private var label = UILabel()
//    private let foregroundLayer = CAShapeLayer()
//    private let backgroundLayer = CAShapeLayer()
//    private var radius: CGFloat {
//        get{
//            if self.frame.width < self.frame.height { return (self.frame.width - lineWidth)/2 }
//            else { return (self.frame.height - lineWidth)/2 }
//        }
//    }
//
//    private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
//    private func makeBar(){
//        self.layer.sublayers = nil
//        drawBackgroundLayer()
//        drawForegroundLayer()
//    }
//
//    private func drawBackgroundLayer(){
//        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//        self.backgroundLayer.path = path.cgPath
//        self.backgroundLayer.strokeColor = UIColor.lightGray.cgColor
//        self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 20/100)
//        self.backgroundLayer.fillColor = UIColor.clear.cgColor
//        self.layer.addSublayer(backgroundLayer)
//
//    }
//
//    private func drawForegroundLayer(){
//
//        let startAngle = (-CGFloat.pi/2)
//        let endAngle = 2 * CGFloat.pi + startAngle
//
//        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//
//        foregroundLayer.lineCap = CAShapeLayerLineCap.round
//        foregroundLayer.path = path.cgPath
//        foregroundLayer.lineWidth = lineWidth
//        foregroundLayer.fillColor = UIColor.clear.cgColor
//        foregroundLayer.strokeColor = UIColor.red.cgColor
//        foregroundLayer.strokeEnd = 0
//
//        self.layer.addSublayer(foregroundLayer)
//
//    }
//
//    private func makeLabel(withText text: String) -> UILabel {
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        label.text = text
//        label.font = UIFont.systemFont(ofSize: labelSize)
//        label.sizeToFit()
//        label.center = pathCenter
//        return label
//    }
//
//    private func configLabel(){
//        label.sizeToFit()
//        label.center = pathCenter
//    }
//
//    private func setForegroundLayerColorForSafePercent(){
//        if Int(label.text!)! >= self.safePercent {
//            self.foregroundLayer.strokeColor = UIColor.green.cgColor
//        } else {
//            self.foregroundLayer.strokeColor = UIColor.red.cgColor
//        }
//    }
//
//    private func setupView() {
//        makeBar()
//        self.addSubview(label)
//    }
//
//
//
//    //Layout Sublayers
//    private var layoutDone = false
//    override func layoutSublayers(of layer: CALayer) {
//        if !layoutDone {
//            let tempText = label.text
//            setupView()
//            label.text = tempText
//            layoutDone = true
//        }
//    }
//
//}

//
//  ProgressBarView.swift
//  progressBar
//
//  Created by ashika shanthi on 1/4/18.
//  Copyright © 2018 ashika shanthi. All rights reserved.
//
import UIKit
class CircularProgressBar: UIView {
    
    var bgPath: UIBezierPath!
    var shapeLayer: CAShapeLayer!
    var progressLayer: CAShapeLayer!
    
    var progress: Float = 0 {
        willSet(newValue)
        {
            progressLayer.strokeEnd = CGFloat(newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgPath = UIBezierPath()
        self.simpleShape()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bgPath = UIBezierPath()
        self.simpleShape()
    }
    
    func simpleShape()
    {
        createCirclePath()
        shapeLayer = CAShapeLayer()
        shapeLayer.path = bgPath.cgPath
        shapeLayer.lineWidth = 15
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        
        progressLayer = CAShapeLayer()
        progressLayer.path = bgPath.cgPath
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.lineWidth = 15
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.red.cgColor
        progressLayer.strokeEnd = 0.0
        
        
        self.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(progressLayer)
    }
    
    private func createCirclePath()
    {
        
        let x = self.frame.width/2
        let y = self.frame.height/2
        let center = CGPoint(x: x, y: y)
        print(x,y,center)
        bgPath.addArc(withCenter: center, radius: x/CGFloat(2), startAngle: CGFloat(0), endAngle: CGFloat(6.28), clockwise: true)
        bgPath.close()
    }
}
