//
//  SQAlertView.h
//  SQAlertView
//
//  Created by shu on 15/8/20.
//  Copyright (c) 2015年 shu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class SQAlertView;
@protocol SQAlertViewDelegate <NSObject>

@optional
-(void)sqAlertViewCancleBtnClick:(SQAlertView*)alertView;//“取消”按钮点击事件
-(void)sqAlertViewAnotherBtnClick:(SQAlertView *)alertView;//有两个按钮时，除了“取消”按钮，另一个按钮的点击事件
-(void)sqAlertViewOtherBtnsClick:(SQAlertView *)alertView otherBtnsIndex:(NSInteger)index;//有两个以上按钮时，其他按钮的点击事件

@end

@interface SQAlertView : UIView


-(instancetype)initWithFrame:(CGRect)frame
                      Tittle:(NSString*)tittle
                  TittleFont:(UIFont*)TittleFont
                 tittleColor:(UIColor*)tittleColor
                     message:(NSString*)message
                 messageFont:(UIFont*)messageFont
                 meaageColor:(UIColor*)messageColor
             attriButedRange:(NSRange)attriButedRange
             attriButedColor:(UIColor*)attriButedColor
                 cancelTitle:(NSString*)cancelTitle
                 cancelTitleColor:(UIColor*)cancelTitleColor
                 cancelFont:(UIFont*)cancelFont
                 otherTitles:(NSArray*)otherTitles
                 otherTitlesColor:(NSArray*)otherTitlesColor
                 otherFont:(UIFont*)otherFont
                 delegate:(id)delegate;

-(void)viewDismiss;//关闭alertView

@property(nonatomic,assign)id<SQAlertViewDelegate>delegate;
@end
