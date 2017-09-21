#import <objc/runtime.h>
#import "UIView+TouchAreaInsets.h"

@implementation UIView (TouchAreaInsets)

+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pointInside:withEvent:)),
                                   class_getInstanceMethod(self, @selector(_touchAreaInsets_pointInside:withEvent:)));
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
  UIEdgeInsets touchAreaInsets = self.touchAreaInsets;
  CGRect bounds = self.bounds;
  bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                      bounds.origin.y - touchAreaInsets.top,
                      bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                      bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
  return CGRectContainsPoint(bounds, point);
}

@end
