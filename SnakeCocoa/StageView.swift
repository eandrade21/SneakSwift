//
//  StageView.swift
//  SnakeSwift
//
//  Created by eandrade21 on 3/17/15.
//  Copyright (c) 2015 PartyLand. All rights reserved.
//

import UIKit

class StageView: UIView {

    var elementsSubviews = [String: [UIView]]()
    
    let viewTransform: StageViewTransform
    
    init(frame: CGRect, viewTransform: StageViewTransform) {
        self.viewTransform = viewTransform
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    func drawElements(elementType: String, inStage stage: Stage) {
        
        // Remove elementSubviews of the specified type
        if let elementSubviews = elementsSubviews[elementType] {
            for elementSubview in elementSubviews {
                elementSubview.removeFromSuperview()
            }
        }
        
        elementsSubviews.removeValueForKey(elementType)
        
        
        // Draw elementSubviews of the specified type
        
        if let elements = stage.elements[elementType] {
            
            var elementSubviews = [UIView]()
            
            for element in elements {
                let elementFrame = viewTransform.getFrame(element.location!)
                
                var elementView: UIView
                
                // TODO: Extract class creation logic to a factory
                switch elementType {
                case "Obstacle":
                    elementView = ObstacleView(frame: elementFrame)
                //case "LoopHole":
                //    LoopHoleView(frame: elementFrame)
                case "Apple":
                    elementView = AppleView(frame: elementFrame)
                case "Snake":
                    elementView = SnakeView(frame: elementFrame)
                default:
                    elementView = ObstacleView(frame: elementFrame)
                }
                
                addSubview(elementView)
                elementSubviews.append(elementView)
            }
            
            elementsSubviews[elementType] = elementSubviews
        }
    }
    
    
    func drawElement(element: StageElement, inStage stage: Stage) {
        
    }
}
