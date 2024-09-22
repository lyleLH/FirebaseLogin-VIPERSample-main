//
//  CanvasView.swift
//  FirebaseLogin
//
//  Created by Tom.Liu on 2024/6/22.
//

import UIKit

class CanvasView: UIView {
    
    private var canvasItemViews: [CanvasItemView] = []
    private var selectedItem: CanvasItemView?
    
    init(frame: CGRect, itemViews: [CanvasItemView]) {
        super.init(frame: frame)
        self.canvasItemViews = itemViews
        
        addGestureRecognizer()
        
        configItemViews(itemViews: itemViews)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addGestureRecognizer()
        
    }
    
    private func addGestureRecognizer() {
        addTapGesture()
        addPanGesture()
        addPinchGesture()
        addLongPressGesture()
        addSwipeGesture()
        addRotationGesture()
        addDoubleTapGesture()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .lightGray

    }
    
    public func configItemViews(itemViews: [CanvasItemView]) {
        self.canvasItemViews = itemViews
        for itemView in self.canvasItemViews {
            itemView.backgroundColor = UIColor.random()
        }
    }
    
    public func relayoutItemVies() {
        setNeedsLayout()
        layoutIfNeeded()
        for itemView in self.canvasItemViews {
            itemView.setupWithDefaultFrame(inSuperview: self)
            self.addSubview(itemView)
        }
    }
    
    // 获取触摸点下的视图
    private func getItemAtPoint(_ point: CGPoint) -> CanvasItemView? {
        for subview in subviews.reversed() {
            if let item = subview as? CanvasItemView, item.frame.contains(point) {
                return item
            }
        }
        return nil
    }
    
    static func testItems() -> [CanvasItemView] {
        var itemViews = [CanvasItemView]()
        for _ in 0...10 {
            let itemView = CanvasItemView(frame: .zero)
            itemViews.append(itemView)
        }
        return itemViews
    }
    
}

extension CanvasView {
    // 添加 tap 手势识别器
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    // 添加 pan 手势识别器
    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.addGestureRecognizer(panGesture)
    }
    
    // 添加 pinch 手势识别器
    func addPinchGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        self.addGestureRecognizer(pinchGesture)
    }
    
    // 添加 rotation 手势识别器
    func addRotationGesture() {
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotationGesture(_:)))
        self.addGestureRecognizer(rotationGesture)
    }
    
    // 添加 long press 手势识别器
    func addLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        self.addGestureRecognizer(longPressGesture)
    }
    
    // 添加 swipe 手势识别器
    func addSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        self.addGestureRecognizer(swipeGesture)
    }
    
    // 添加 double tap 手势识别器
    func addDoubleTapGesture() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTapGesture)
    }
    
    //    // 添加 pan with long press 手势识别器
    //    func addPanWithLongPressGesture() {
    //        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
    //        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    //        longPressGesture.require(toFail: panGesture)
    //        self.addGestureRecognizer(longPressGesture)
    //        self.addGestureRecognizer(panGesture)
    //    }
    //
    
}

extension CanvasView {
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        // 处理 tap 手势
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
            let location = gesture.location(in: self)
            
            switch gesture.state {
            case .began:
                selectedItem = getItemAtPoint(location)
            case .changed:
                if let selectedItem = selectedItem {
                    let translation = gesture.translation(in: self)
                    selectedItem.center = CGPoint(x: selectedItem.center.x + translation.x, 
                                                  y: selectedItem.center.y + translation.y)
                    gesture.setTranslation(.zero, in: self)
                }
            case .ended, .cancelled:
                selectedItem = nil
            default:
                break
            }
        }
        
        @objc private func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
            let location = gesture.location(in: self)
            
            switch gesture.state {
            case .began:
                selectedItem = getItemAtPoint(location)
            case .changed:
                if let selectedItem = selectedItem {
                    selectedItem.transform = selectedItem.transform.scaledBy(x: gesture.scale, y: gesture.scale)
                    gesture.scale = 1.0
                }
            case .ended, .cancelled:
                selectedItem = nil
            default:
                break
            }
        }
        
        @objc private func handleRotationGesture(_ gesture: UIRotationGestureRecognizer) {
            let location = gesture.location(in: self)
            
            switch gesture.state {
            case .began:
                selectedItem = getItemAtPoint(location)
            case .changed:
                if let selectedItem = selectedItem {
                    selectedItem.transform = selectedItem.transform.rotated(by: gesture.rotation)
                    gesture.rotation = 0
                }
            case .ended, .cancelled:
                selectedItem = nil
            default:
                break
            }
        }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        // 处理 long press 手势
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        // 处理 swipe 手势
    }
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        // 处理 double tap 手势
    }
    
}
