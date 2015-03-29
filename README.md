[![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)](https://github.com/andresbrun/ABFullScrollViewController/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/andresbrun/ABFullScrollViewController.png?branch=master)](https://github.com/andresbrun/ABFullScrollViewController)
[![Build Platform](https://cocoapod-badges.herokuapp.com/p/ABFullScrollViewController/badge.png)](https://github.com/andresbrun/ABFullScrollViewController)
[![Build Version](https://cocoapod-badges.herokuapp.com/v/ABFullScrollViewController/badge.png)](https://github.com/andresbrun/ABFullScrollViewController)

![alt tag](https://raw.githubusercontent.com/andresbrun/ABFullScrollViewController/master/ABFullScrollViewControllerExample/Demo/ABMFullScroll_logo.png)

Component that provide the behavior of hidding a header view while the user makes scroll. It is inspiring in Facebook table scroll style. For sake of simplicity this component follows `Behavioral Object Pattern` [Objc.io](http://www.objc.io/issue-13/behaviors.html).

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like ABMFullScrollBehavior in your projects.

#### Podfile

```ruby
pod "ABMFullScrollBehavior"
```

### Manual Installation 
If you don't want to use cocoapods you just need to copy `ABMFullScrollBehavior` folder in your project.

### Configuration
In order to apply this behaviour to your scroll based view you just need to follow next steps:
- Create a new Object in your ViewController using the .xib.

![alt tag](https://raw.githubusercontent.com/andresbrun/ABFullScrollViewController/master/ABFullScrollViewControllerExample/Demo/instructions_1.png)

- Change the class to `ABMFullScrollBehavior`

![alt tag](https://raw.githubusercontent.com/andresbrun/ABFullScrollViewController/master/ABFullScrollViewControllerExample/Demo/instructions_3.png)

- Connect the different IBOutlets:
  - `delegate`
  - `headerView`
  - `scrollView`

- This object have a couple of `IBInspectable` properties that you can set from the storyboard:
  - `Imantate` in case you want to avoid the user leave the header in a non-end state.
  - `MinVisibleHeightHeader` to define how much header view height will remain visible.

![alt tag](https://raw.githubusercontent.com/andresbrun/ABFullScrollViewController/master/ABFullScrollViewControllerExample/Demo/instructions_2.png)

- And that is! You got your scroll hiding the header when the user makes scroll!

### I want to use my scroll base element delegate
Most likely you will want your UITableView reacts when the user press a cell and for that you need to use its delegate for instance. But I need it too to know when the user is doing scroll. Fine, let's solve this!

Inside of the component there is another class called `ABMMultiplexerProxyBehavior`. That is used for connect one delegate and forward every call to every target we connect to it. So the steps would be:

- Create a `ABMMultiplexerProxyBehavior` object in our ViewController using the storyboard or .xib editor.
- Instead of connecting our scroll base element delegate to `ABMFullScrollBehavior` object we should connect it to this new object.
- `ABMMultiplexerProxyBehavior` has and IBOutlet called `targets`. This is a `IBOutletCollection` so we can connect our `ABMFullScrollBehavior` object and the ViewController as well.

### I want to customize the animation
You can provide a delegate for `ABMFullScrollBehavior` and implement it like the example:

```objective-c
- (void)scroll:(UIScrollView *)scroll animationForHeaderView:(UIView *)view percent:(CGFloat)percent {
    [self.headerContainerView setAlpha:percent];
    
    CGFloat transform = MIN(percent+0.5, 1);
    [self.headerContainerView setTransform:CGAffineTransformMakeScale(transform, transform)];
}
```

## Architecture

Let's do an small summarize of how is design all the connections between the different objects.

#### Without ABMMultiplexerProxyBehavior

![alt tag](https://raw.githubusercontent.com/andresbrun/ABFullScrollViewController/master/ABFullScrollViewControllerExample/Demo/ABMFullScroll_scheme_simple.png)

#### With ABMMultiplexerProxyBehavior

![alt tag](https://raw.githubusercontent.com/andresbrun/ABFullScrollViewController/master/ABFullScrollViewControllerExample/Demo/ABMFullScroll_scheme_multiplexer.png)

## Features
- This components supports `Size classes` and `Autolayout`.
- Also supports `Navigation Item`.
- It works with any UI element that inherate from `UIScrollView` class.
  - `UICollectionView`
  - `UITableView`
  - `UIScrollView`
- Everthing is configured just using storyboard of .xib editor. That make more encapsulate this code and it is painless to integrate and modify.

## Examples

![alt tag](https://raw.githubusercontent.com/andresbrun/ABFullScrollViewController/master/ABFullScrollViewControllerExample/Demo/ABFullScrollVC_screen_1.png)

## License

ABMFullScrollBehavior is available under the MIT license. See the LICENSE file for more info.
