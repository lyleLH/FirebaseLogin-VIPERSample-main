//
//  CanvasItemView.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/22.
//

import UIKit
enum CanvasItemContentType: String {
    case image = "item_image"
    case text = "item_text"
}

class CanvasItemView: UIView {
    
    // 初始化方法，设置自身的 frame，默认在父视图中心
    func setupWithDefaultFrame(inSuperview superview: UIView) {
        let size: CGFloat = 200  // 默认尺寸
        let x = (superview.bounds.width - size) / 2
        let y = (superview.bounds.height - size) / 2
        self.frame = CGRect(x: x + CGFloat(generateRandomNumber()), 
                            y: y + CGFloat(generateRandomNumber()), 
                            width: size,
                            height: size)
        
    }
    
    // 生成-100到100之间的随机整数
    func generateRandomNumber() -> Int {
        let lowerBound = -100
        let upperBound = 100
        return  Int.random(in: lowerBound...upperBound) + lowerBound
    }
    
}
