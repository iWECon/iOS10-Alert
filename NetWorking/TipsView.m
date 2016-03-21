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
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = true;
    self.alpha = 0;
    
    self.tipsLabel.numberOfLines = 0;
    self.tipsLabel.font = [UIFont systemFontOfSize:14];
    
    [self.tipsLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)showTips:(NSString *)content cancelTarget:(cancelBlock)cancelBlock okTarget:(okBlock)okBlock {
    
    self.tipsLabel.text = content;
    self.cancelAction = cancelBlock;
    self.okAction = okBlock;
    
}


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


- (void)dealloc {
    [self.tipsLabel removeObserver:self forKeyPath:@"text"];
}


- (void)show:(BOOL)isShow {
    if (isShow) {
        
        CGSize windowSize = exObject_ScreenFrame.size;
        
        self.frame = CGRectMake(windowSize.width/2 - self.frame.size.width/2,
                                -(self.frame.size.height),
                                self.frame.size.width,
                                self.frame.size.height);
        
        self.alpha = 0;
        
        CGAffineTransform defaultTransform = CGAffineTransformMakeRotation(-M_PI);
        CGAffineTransform transform =  CGAffineTransformRotate(defaultTransform, M_PI);
        
        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn  animations:^{
            
            [self setTransform:transform];
            
            self.frame = CGRectMake(windowSize.width/2 - self.frame.size.width/2,
                                    windowSize.height/2 - self.frame.size.height/2,
                                    self.frame.size.width,
                                    self.frame.size.height);
            
            self.alpha = 1;
            
        } completion:^(BOOL finished) {
        
        
        }];
        
        
        // 隐藏
    } else {
        
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn  animations:^{
            
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }
}

- (void)hidden:(BOOL)isHidden {
    if (isHidden) {
        [self show:false];
    }
    return;
}

- (IBAction)cancel:(id)sender {
    self.cancelAction();
    [self hidden:true];
}

- (IBAction)ok:(id)sender {
    self.okAction();
    [self hidden:true];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
