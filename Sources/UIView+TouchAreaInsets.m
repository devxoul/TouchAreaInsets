#import <objc/runtime.h>
#import "UIView+TouchAreaInsets.h"

@implementation UIView (TouchAreaInsets)

+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pointInside:withEvent:)),
                                   class_getInstanceMethod(self, @selector(_touchAreaInsets_pointInside:withEvent:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(accessibilityFrame)),
                                   class_getInstanceMethod(self, @selector(_touchAreaInsets_accessibilityFrame)));
  });
}

- (UIEdgeInsets)touchAreaInsets {
  return [objc_getAssociatedObject(self, @selector(touchAreaInsets)) UIEdgeInsetsValue];
}

- (void)setTouchAreaInsets:(UIEdgeInsets)touchAreaInsets {
  NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
  objc_setAssociatedObject(self, @selector(touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)_touchAreaInsets_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  CGRect bounds = [self expandFrame:self.bounds
                         withInsets:self.touchAreaInsets];
  return CGRectContainsPoint(bounds, point);
}

- (CGRect)_touchAreaInsets_accessibilityFrame {
  return [self expandFrame:UIAccessibilityConvertFrameToScreenCoordinates(self.bounds, self)
                withInsets:self.touchAreaInsets];
}

- (CGRect)expandFrame:(CGRect)frame withInsets:(UIEdgeInsets)insets {
  return CGRectMake(frame.origin.x - insets.left,
                    frame.origin.y - insets.top,
                    frame.size.width + insets.left + insets.right,
                    frame.size.height + insets.top + insets.bottom);
}

@end
