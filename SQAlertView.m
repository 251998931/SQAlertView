//
//  SQAlertView.m
//  SQAlertView
//
//  Created by shu on 15/8/20.
//  Copyright (c) 2015年 shu. All rights reserved.
//

#import "SQAlertView.h"
#import "NSString+GetHeightOrWidth.h"

@interface SQAlertView()

@property(nonatomic,strong)UIView* shadowView;//蒙版
@property(nonatomic,strong)UIButton* shadowBtn;
@property(nonatomic,strong)UIView* alertView;
@property(nonatomic,strong)UILabel* tittleLabel;
@property(nonatomic,strong)UILabel* messageLabel;
@property(nonatomic,strong)UIButton* cancleBtn;
@property(nonatomic,strong)NSArray* btnArray;

@property(nonatomic,strong)UITapGestureRecognizer* viewGesture;

@property(nonatomic,strong)UIView* tittleLine;
@property(nonatomic,strong)UIView* cancleBrnLine;
@property(nonatomic,strong)UIView* cancleBtnLine2;

@end

@implementation SQAlertView



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
                   delegate:(id)delegate
{
 
    
    if(self = [super initWithFrame: frame]) {
        
        //代理
        self.delegate = delegate;
        //初始化按钮数组
        self.btnArray = [NSArray array];
        
        self.shadowView = [[UIView alloc] initWithFrame:frame];
        self.shadowView.backgroundColor = [UIColor lightGrayColor];
        self.shadowView.alpha =0.6;
        [self addSubview:self.shadowView];
        
        self.viewGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewDismiss)];
        [self.shadowView addGestureRecognizer:self.viewGesture];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 8.0;
        self.alertView.layer.opacity = .95;
        self.alertView.clipsToBounds = YES;
        [self addSubview:self.alertView];
        

        self.tittleLabel = [[UILabel alloc] init];
        self.tittleLabel.text = tittle;
//        self.tittleLabel.backgroundColor = [UIColor colorWithRed:0.95f green:0.96f blue:0.96f alpha:1.00f];
        self.tittleLabel.textColor = tittleColor;
        self.tittleLabel.textAlignment = NSTextAlignmentCenter;
        self.tittleLabel.font = TittleFont;
        self.tittleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.tittleLabel.numberOfLines = 0;
        [self.alertView addSubview:self.tittleLabel];
        
        self.messageLabel = [[UILabel alloc] init];
        self.messageLabel.text = message;
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.textColor = messageColor;
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.font = messageFont;
        self.messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.messageLabel.numberOfLines = 0;
        [self.alertView addSubview:self.messageLabel];

      
        CGFloat alertViewWidth = [UIScreen mainScreen].bounds.size.width - 80;
       
        CGFloat messageLabelHeight;
        CGFloat height = [message getHeightWithWidth:alertViewWidth-20 andFont:[UIFont systemFontOfSize:15]];
        messageLabelHeight = MIN(height,400);
        
        
        self.alertView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-50);
        
        if (tittle == nil) {
            
            self.alertView.bounds = CGRectMake(0, 0,alertViewWidth , messageLabelHeight+10);
            self.tittleLabel.frame = CGRectZero;
            self.messageLabel.frame = CGRectMake(10, 10, alertViewWidth-20, messageLabelHeight);
//            self.messageLabel.backgroundColor = [UIColor redColor];
            
        }else{
            
            self.alertView.bounds = CGRectMake(0, 0,alertViewWidth , messageLabelHeight+10 +40);
            self.tittleLabel.frame = CGRectMake(0,0,alertViewWidth,40);
            self.messageLabel.frame = CGRectMake(10, CGRectGetMaxY(self.tittleLabel.frame)+5, self.alertView.frame.size.width -20, messageLabelHeight);
            
            self.tittleLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tittleLabel.frame), alertViewWidth, 1)];
            self.tittleLine.backgroundColor = [UIColor colorWithRed:0.95f green:0.96f blue:0.96f alpha:1.00f];
            [self.alertView addSubview:self.tittleLine];
            
        }
        
        if (attriButedColor !=nil && ( (attriButedRange.length + attriButedRange.location) <= message.length )) {
            
           ;
            
            NSMutableAttributedString *attriButedStr = [[NSMutableAttributedString alloc] initWithString:self.messageLabel.text];
            [attriButedStr addAttributes:@{NSForegroundColorAttributeName:attriButedColor} range:attriButedRange];
            self.messageLabel.attributedText = attriButedStr;
            
            
        }
        
      if(otherTitles.count == 0 || otherTitles == nil)
      {
        self.cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame), alertViewWidth, 50)];
        self.cancleBtn.titleLabel.font = cancelFont;
        [self.cancleBtn setTitle:cancelTitle forState:UIControlStateNormal];
        [self.cancleBtn setTitleColor:cancelTitleColor forState:UIControlStateNormal];
        [self.alertView addSubview:self.cancleBtn];
//        self.cancleBtn.backgroundColor = [UIColor redColor];
          
          self.cancleBrnLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame), alertViewWidth, 1)];
          [self.alertView addSubview:self.cancleBrnLine];
          self.cancleBrnLine.backgroundColor = [UIColor colorWithRed:0.95f green:0.96f blue:0.96f alpha:1.00f];
          
          
      }else if(otherTitles.count ==1 && (otherTitlesColor.count >= otherTitles.count))
      {
         
          self.cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame), alertViewWidth/2, 50)];
          self.cancleBtn.titleLabel.font = cancelFont;
          [self.cancleBtn setTitle:cancelTitle forState:UIControlStateNormal];
          [self.cancleBtn setTitleColor:cancelTitleColor forState:UIControlStateNormal];
          [self.alertView addSubview:self.cancleBtn];
//          self.cancleBtn.backgroundColor = [UIColor redColor];
          
          UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.messageLabel.frame), alertViewWidth/2, 50)];
          btn.titleLabel.font = otherFont;
          [btn setTitle:otherTitles[0] forState:UIControlStateNormal];
          //          btn.backgroundColor = [UIColor yellowColor];
          [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
          [self.alertView addSubview:btn];
          if ([otherTitlesColor[0] isKindOfClass:[UIColor class]]) {
              
              [btn setTitleColor:otherTitlesColor[0] forState:UIControlStateNormal];
          }
          
          [btn addTarget:self action:@selector(anotherBtnClick) forControlEvents:UIControlEventTouchUpInside];
          
          //分割线
          self.cancleBrnLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame), alertViewWidth, 1)];
          [self.alertView addSubview:self.cancleBrnLine];
          self.cancleBrnLine.backgroundColor = [UIColor colorWithRed:0.95f green:0.96f blue:0.96f alpha:1.00f];
          
          self.cancleBtnLine2 = [[UIView alloc] initWithFrame:CGRectMake(alertViewWidth/2, CGRectGetMaxY(self.messageLabel.frame), 2, 50)];
          [self.alertView addSubview:self.cancleBtnLine2];
          self.cancleBtnLine2.backgroundColor = [UIColor colorWithRed:0.95f green:0.96f blue:0.96f alpha:1.00f];
        
      }
      else
      {
          CGRect btnFrame = self.messageLabel.frame;
          for (int i = 0; i< otherTitles.count; i++) {
              
              if (otherTitles.count <= otherTitlesColor.count) {
                
                  UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btnFrame), alertViewWidth, 50)];
                  btn.tag = i;
                  btn.titleLabel.font = otherFont;
                  [btn setTitle:otherTitles[i] forState:UIControlStateNormal];
//                  btn.backgroundColor = [UIColor yellowColor];
                  [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                  [self.alertView addSubview:btn];
                  btnFrame = btn.frame;
                  
                  UIView* viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, btnFrame.origin.y, alertViewWidth, 1)];
                  [self.alertView addSubview:viewLine];
                  viewLine.backgroundColor = [UIColor colorWithRed:0.95f green:0.96f blue:0.96f alpha:1.00f];
                  
                  if ([otherTitlesColor[i] isKindOfClass:[UIColor class]]) {
                      
                      [btn setTitleColor:otherTitlesColor[i] forState:UIControlStateNormal];
                  }
                  [btn addTarget:self action:@selector(otherBtnsClick:) forControlEvents:UIControlEventTouchUpInside];
                  
                  
                  
              }
              
            
            }
              
          self.cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btnFrame), alertViewWidth, 50)];
          self.cancleBtn.titleLabel.font = cancelFont;
          [self.cancleBtn setTitle:cancelTitle forState:UIControlStateNormal];
          [self.cancleBtn setTitleColor:cancelTitleColor forState:UIControlStateNormal];
          [self.alertView addSubview:self.cancleBtn];
          //              self.cancleBtn.backgroundColor = [UIColor redColor];
          
          //分割线
          self.cancleBrnLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btnFrame), alertViewWidth, 1)];
          [self.alertView addSubview:self.cancleBrnLine];
          self.cancleBrnLine.backgroundColor = [UIColor colorWithRed:0.95f green:0.96f blue:0.96f alpha:1.00f];
          
          
      }
        
        if (otherTitles.count == 1 || otherTitles.count == 0 || otherTitles == nil || (otherTitles.count > otherTitlesColor.count)) {
            
             self.alertView.bounds = CGRectMake(0, 0,alertViewWidth , messageLabelHeight+CGRectGetHeight(self.tittleLabel.frame)+CGRectGetHeight(self.cancleBtn.frame));
        }
        else
        {
              self.alertView.bounds = CGRectMake(0, 0,alertViewWidth , messageLabelHeight+CGRectGetHeight(self.tittleLabel.frame)+CGRectGetHeight(self.cancleBtn.frame) + otherTitles.count * 50);
        }
       
        [self.cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self show];
    }
    return self;
}


-(void)viewDismiss
{
    self.alpha =0;
    self.alertView.alpha = 0;
    self.alertView = nil;
}

-(void)show
{
    [SQAlertView animationWithView:self.alertView duration:0.3];
}


+(void)animationWithView:(UIView *)view duration:(CFTimeInterval)duration{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [view.layer addAnimation:animation forKey:nil];
}
//取消按钮点击事件
-(void)cancleBtnClick
{
    
    if(self.delegate !=nil && [self.delegate respondsToSelector:@selector(sqAlertViewCancleBtnClick:)]){
        
        [self.delegate sqAlertViewCancleBtnClick:self];
    }
}
//有两个按钮时，除了“取消”按钮，另一个按钮的点击事件
-(void)anotherBtnClick
{
    if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(sqAlertViewAnotherBtnClick:)]) {
        
        [self.delegate sqAlertViewAnotherBtnClick:self];
    }
}
//有两个以上按钮时，其他按钮的点击事件
-(void)otherBtnsClick:(UIButton*)btn
{
    if([self.delegate respondsToSelector:@selector(sqAlertViewOtherBtnsClick:otherBtnsIndex:)]){
        
        [self.delegate sqAlertViewOtherBtnsClick:self otherBtnsIndex:btn.tag];
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
