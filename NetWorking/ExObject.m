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
    
    if (styleIndex == 0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:true];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:true];
    }
    
};

void setBlurBackGroundView(UIView * rootView, BOOL isShow) {
    
    if (isShow) {
        
        UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        
        effectView.frame = rootView.frame;
        
        [rootView addSubview:effectView];
        
    } else {
        
        UIVisualEffectView * effectView;
        for (UIView * effect in rootView.subviews) {
            if ([effect isKindOfClass:[UIVisualEffectView class]]) {
                effectView = (UIVisualEffectView *)effect;
                break;
            }
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            effectView.alpha = 0.01;
        } completion:^(BOOL finished) {
            [effectView removeFromSuperview];
        }];
        
    }
};