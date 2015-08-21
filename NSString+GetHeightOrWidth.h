//
//  NSString+GetHeightOrWidth.h
//  SQAlertView
//
//  Created by shu on 15/8/20.
//  Copyright (c) 2015年 shu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (GetHeightOrWidth)

- (CGFloat)getHeightWithWidth:(CGFloat)width andFont:(UIFont*)font;

- (CGFloat)getWitdhWithHeight:(CGFloat)height andFont:(UIFont*)font;

@end
