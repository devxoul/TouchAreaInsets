UIButton-TouchAreaInsets
========================

Set UIButton's touch area insets.

The code below expands button's touch area for 20px.

```objc
UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
button.touchAreaInsets = UIEdgeInsetsMake(20, 20, 20, 20);
```