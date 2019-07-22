# JXPageControl

[![CI Status](https://img.shields.io/travis/bboyXFX/JXPageControl.svg?style=flat)](https://travis-ci.org/bboyXFX/JXPageControl)
[![Version](https://img.shields.io/cocoapods/v/JXPageControl.svg?style=flat)](https://cocoapods.org/pods/JXPageControl)
[![License](https://img.shields.io/cocoapods/l/JXPageControl.svg?style=flat)](https://cocoapods.org/pods/JXPageControl)
[![Platform](https://img.shields.io/cocoapods/p/JXPageControl.svg?style=flat)](https://cocoapods.org/pods/JXPageControl)


##### (JXPageControl supports multiple animation transformations, content layout transformations, and Xib layouts ) 

---

##### 

* Development environment: Xcode 7 
* Running condition: iOS(8.0+) 
* Open source framework ：[github地址](https://github.com/Code-TanJX/JXPageControl)
* [ Chinese is introduced [ 中文介绍 ]](https://blog.csdn.net/TanJiaXiang/article/details/95796616)

&nbsp;

（If there is any problem, you can leave a message, welcome to study together, welcome star ）

--- 
### Installation
To install, simply add the following code to your Podfile   : 

```ruby

platform :ios, '8.0'

target 'TargetName' do
    pod 'JXPageControl'
end

```

---

### The UI effect 

JXPageControlChameleon          |   JXPageControlExchange     |        JXPageControlFill 
:-: | :-: | :-:   
<img src="Images/chamelon.gif" width="144" height="88"> | <img src="Images/exchange.gif" width="260" height="124"> | <img src="Images/fill.gif" width="128" height="104">


&nbsp;

JXPageControlJump | JXPageControlScale
:-: | :-: 
<img src="Images/jump.gif" width="128" height="328"> | <img src="Images/scare.gif" width="128" height="300">

---

### Frame set 
* Common   Framework common class files 
* Jump  - Jump animation effects class file  
* Transform  - Transition animation class file

---

---

####  JXPageControl introduction [ JXPageControl 介绍 ]

JXPageControl ADAPTS to Swift and objective-c

&nbsp;

* JXPageControlBase -   Base class for all pageControl 
* JXPageControlType -  All pageControl protocols, it provides a number of custom apis for developers to use 

&nbsp;

######  JXPageControlType - provides - API 

&nbsp;

* numberOfPages --->  Number of indicators. 
* currentPage --->  Current indicator page number. 
* progress --->  Current indicator page numbering process. 
* hidesForSinglePage ---> Whether to hide when there is only one indicator. 
* inactiveColor --->  Inactive indicator color
* activeColor ---> Active indicator color  
* inactiveSize --->  Inactive indicator size 
* activeSize --->   Active indicator size 
* indicatorSize --->  All indicator sizes 
* columnSpacing --->  Horizontal distance between indicators 
* contentAlignment --->  Content layout location (note that this property is easy to use!!!!! )
* contentMode --->  Content layout location, and support for transformation in Xib, real-time view of location changes (note that this property is very useful!!!!! )
* isInactiveHollow ---> Whether the inactive indicator is a hollow pattern 
* isActiveHollow ---> Whether the active indicator is a hollow pattern 
* reload() ---> Refresh data/UI 

###### Be careful  : 
JXPageControl also provides some APIs for non-JXPageControlType. You can view it in the specific classes you use 

&nbsp;

---
####  JXPageControl uses  :

&nbsp;

### Example 1

* Use (xib, storyboard for properties and layout Settings!!! )  
* Note that the module should select JXPageControl, otherwise it will not show up and the call will report an error. 
* ContentMode can be set in View to change content location 

&nbsp;


<img src="Images/Xib_01.png" width="825" height="805">

---

<img src="Images/Xib_02.png" width="810" height="750">


### Example 2

*  Write it in pure code

```

import JXPageControl

class ChamelonVC: UIViewController {

lazy var codePageControl: JXPageControlJump = {
let pageControl = JXPageControlJump(frame: CGRect(x: 0,
y: 0,
width: UIScreen.main.bounds.width,
height: 30))
pageControl.numberOfPages = 4

// JXPageControlType: default property
//        pageControl.currentPage = 0
//        pageControl.progress = 0.0
//        pageControl.hidesForSinglePage = false
//        pageControl.inactiveColor = UIColor.white.withAlphaComponent(0.5)
//        pageControl.activeColor = UIColor.white
//        pageControl.inactiveSize = CGSize(width: 10, height: 10)
//        pageControl.activeSize = CGSize(width: 10, height: 10)
//        pageControl.inactiveSize = CGSize(width: 10, height: 10)
//        pageControl.columnSpacing = 10
//        pageControl.contentAlignment = JXPageControlAlignment(.center,
//                                                              .center)
//        pageControl.contentMode = .center
//        pageControl.isInactiveHollow = false
//        pageControl.isActiveHollow = false

// JXPageControlJump: default "custom property"
pageControl.isAnimation  = true
pageControl.isFlexible = true

return pageControl
}()

override func viewDidLoad() {
super.viewDidLoad()
view.addSubview(codePageControl)
}

}

extension ChamelonVC: UIScrollViewDelegate {
func scrollViewDidScroll(_ scrollView: UIScrollView) {
let progress = scrollView.contentOffset.x / scrollView.bounds.width
let currentPage = Int(round(progress))

//  Mode one 
codePageControl.progress = progress

// Mode two 
//        codePageControl.currentPagev = currentPage

}

}

```

```


```

### Example 2 and so on ...

```

import JXPageControl
...

```

### [The Demo address](https://github.com/Code-TanJX/JXPageControl)

## Author

Code-TanJX, Code_TanJX@163.com

## License

JXPageControl is available under the MIT license. See the LICENSE file for more info.
