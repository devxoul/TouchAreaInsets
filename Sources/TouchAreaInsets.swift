//
//  TouchAreaInsets.swift
//  TouchAreaInsets
//
//  Created by Suyeol Jeon on 17/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

extension NSObject {
  static func swizzle(_ originalSelector: Selector, _ swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(self, originalSelector)
    let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
    let originalType = method_getTypeEncoding(originalMethod)
    let swizzledType = method_getTypeEncoding(swizzledMethod)
    let didAdd = class_addMethod(self, originalSelector, swizzledMethod, swizzledType)
    if didAdd {
      class_replaceMethod(self, swizzledSelector, originalMethod, originalType)
    } else {
      method_exchangeImplementations(originalMethod, swizzledMethod)
    }
  }
}

extension NSObject {
  func associatedObject(for key: UnsafeRawPointer) -> Any? {
    return objc_getAssociatedObject(self, key)
  }

  func setAssociatedObject(_ object: Any?, for key: UnsafeRawPointer) {
    objc_setAssociatedObject(self, key, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
}

private var touchAreaInsetsKey = "touchAreaInsetsKey"

extension UIView {

  open override static func initialize() {
    guard self === UIView.self else { return }
    self.swizzle(
      #selector(UIView.point(inside:with:)),
      #selector(UIView.swizzled_point(inside:with:))
    )
  }

  open var touchAreaInsets: UIEdgeInsets {
    get { return self.associatedObject(for: &touchAreaInsetsKey) as? UIEdgeInsets ?? .zero }
    set { self.setAssociatedObject(newValue, for: &touchAreaInsetsKey) }
  }

  func swizzled_point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let touchAreaInsets = self.touchAreaInsets
    let insetBounds = CGRect(
      x: self.bounds.origin.x - touchAreaInsets.left,
      y: self.bounds.origin.y - touchAreaInsets.top,
      width: self.bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
      height: self.bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom
    )
    return insetBounds.contains(point)
  }

}
