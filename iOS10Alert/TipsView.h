//
//  TipsView.h
//  NetWorking
//
//  Created by iWe on 2016/3/18.
//  Copyright © 2016年 iWe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^cancelBlock)();
typedef void (^okBlock)();

@interface TipsView : UIView

@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;


- (void)showTips:(NSString *)content cancelTarget:(cancelBlock)cancelBlock okTarget:(okBlock)okBlock;

- (void)show:(BOOL)isShow;
- (void)hidden:(BOOL)isHidden;

@end
