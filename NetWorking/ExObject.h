//
//  ExObject.h
//  NetWorking
//
//  Created by iWe on 2016/3/18.
//  Copyright © 2016年 iWe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^afterDelayBlock)();

extern CGRect exObject_ScreenFrame;
extern CGSize exObject_tipsViewSize;
extern UIView * windowView;

/// 延迟运行
void performAfterDelay(NSTimeInterval delay, afterDelayBlock block);

/// 0为黑色  其它为白色
void setStatusStyle(int styleIndex);


void setBlurBackGroundView(UIView * rootView, BOOL isShow);