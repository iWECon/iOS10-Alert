//
//  ExObject.m
//  NetWorking
//
//  Created by iWe on 2016/3/18.
//  Copyright © 2016年 iWe. All rights reserved.
//

#import "ExObject.h"
#import "TipsView.h"


CGRect exObject_ScreenFrame;
CGSize exObject_tipsViewSize;
UIView * windowView = nil;

void performAfterDelay(NSTimeInterval delay, afterDelayBlock block) {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
};

void setStatusStyle(int styleIndex) {
    
    UIStatusBarStyle style;
    if (styleIndex == 0) {
        style = UIStatusBarStyleDefault;
    } else {
        style = UIStatusBarStyleLightContent;
    }
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:true];
    
};

void setBlurBackGroundView(BOOL isShow) {
    
    UIView * widnow = [UIApplication sharedApplication].windows.firstObject;
    
    if (isShow) {
        
        UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        
        effectView.frame = widnow.frame;
        effectView.alpha = 0;
        [widnow addSubview:effectView];
        
        [UIView animateWithDuration:1.0 animations:^{
            effectView.alpha = 1;
        }];
        
    } else {
        
        __block UIVisualEffectView * effectView;
        for (UIView * effect in widnow.subviews) {
            if ([effect isKindOfClass:[UIVisualEffectView class]]) {
                effectView = (UIVisualEffectView *)effect;
                break;
            }
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            effectView.alpha = 0.01;
        } completion:^(BOOL finished) {
            [effectView removeFromSuperview];
            effectView = nil;
        }];
        
    }
};