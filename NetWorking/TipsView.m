//
//  TipsView.m
//  NetWorking
//
//  Created by iWe on 2016/3/18.
//  Copyright © 2016年 iWe. All rights reserved.
//

#import "TipsView.h"
#import "ExObject.h"

@interface TipsView ()

@property (nonatomic, strong) cancelBlock cancelAction;
@property (nonatomic, strong) okBlock okAction;

@property (weak, nonatomic) IBOutlet UIButton *okOutlet;
@property (weak, nonatomic) IBOutlet UIButton *cancelOutlet;

@end

@implementation TipsView

- (void)awakeFromNib {
    
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(3, 3)];
    [self.layer setShadowRadius:5];
    [self.layer setShadowPath:[UIBezierPath bezierPathWithRect:self.bounds].CGPath];
    
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = NO;
    self.alpha = 0;
    
    self.tipsLabel.numberOfLines = 0;
    self.tipsLabel.font = [UIFont systemFontOfSize:14];
    
    [self.tipsLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}


#pragma mark- 初始化 设置显示信息
- (void)showTips:(NSString *)content cancelTarget:(cancelBlock)cancelBlock okTarget:(okBlock)okBlock {
    
    self.tipsLabel.text = content;
    self.cancelAction = cancelBlock;
    self.okAction = okBlock;
    
}

#pragma mark- kvo 计算视图大小
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    
    NSString * str = change[@"new"];
    
    NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize strSize = [str sizeWithAttributes:attributes];
    
    CGPoint tlPoint = self.tipsLabel.frame.origin;
    
    CGRect tipsRect = CGRectMake(tlPoint.x, tlPoint.y, strSize.width, strSize.height);
    
    self.tipsLabel.frame = tipsRect;
    
    CGRect cancelOfOriginY = self.cancelOutlet.frame;
    CGRect okOfOriginY = self.okOutlet.frame;
    cancelOfOriginY.origin.y = self.tipsLabel.frame.origin.y + self.tipsLabel.frame.size.height + 5;
    okOfOriginY.origin.y = self.tipsLabel.frame.origin.y + self.tipsLabel.frame.size.height + 5;
    
    self.cancelOutlet.frame = cancelOfOriginY;
    self.okOutlet.frame = okOfOriginY;
    
    // 新的视图大小
    CGRect newRect = self.frame;
    newRect.size = CGSizeMake(exObject_ScreenFrame.size.width/4*3,
                              self.okOutlet.frame.origin.y + self.okOutlet.frame.size.height + 5);
    self.frame = newRect;
}


#pragma mark- kvo 释放
- (void)dealloc {
    [self.tipsLabel removeObserver:self forKeyPath:@"text"];
}

- (void)hidden:(BOOL)isHidden {
    if (isHidden) {
        [self show:false];
    }
    return;
}

- (IBAction)cancel:(id)sender {
    if (self.cancelAction) {
        self.cancelAction();
    }
    [self hidden:true];
}

- (IBAction)ok:(id)sender {
    if (self.okAction) {
        self.okAction();
    }
    [self hidden:true];
}

// 显示alert, 计算内容大小
- (void)show:(BOOL)isShow {
    if (isShow) {
        
        CGSize windowSize = exObject_ScreenFrame.size;
        
        self.frame = CGRectMake(windowSize.width/2 - self.frame.size.width/2,
                                -(self.frame.size.height),
                                self.frame.size.width,
                                self.frame.size.height);
        
        self.alpha = 0;
        
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn  animations:^{
            
            [self setTransform:CGAffineTransformMakeRotation(M_PI)];
            
            self.frame = CGRectMake(windowSize.width/2 - self.frame.size.width/2,
                                    (windowSize.height/2 - self.frame.size.height/2)/4*3,
                                    self.frame.size.width,
                                    self.frame.size.height);
            
            self.alpha = 0.5;
            
        } completion:^(BOOL finished) {}];
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn  animations:^{
            
            [self setTransform:CGAffineTransformMakeRotation(0)];
            
            self.frame = CGRectMake(windowSize.width/2 - self.frame.size.width/2,
                                    windowSize.height/2 - self.frame.size.height/2,
                                    self.frame.size.width,
                                    self.frame.size.height);
            
            self.alpha = 1;
            
        } completion:^(BOOL finished) {}];
        
        // 隐藏
    } else {
        
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn  animations:^{
            
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
        
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
