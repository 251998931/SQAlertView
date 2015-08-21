//
//  NSString+GetHeightOrWidth.m
//  SQAlertView
//
//  Created by shu on 15/8/20.
//  Copyright (c) 2015年 shu. All rights reserved.
//

#import "NSString+GetHeightOrWidth.h"
#define MAXFLOAT    0x1.fffffep+127f
static inline CGFLOAT_TYPE CGFloat_ceil(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
    return ceil(cgfloat);
#else
    return ceilf(cgfloat);
#endif
}
@implementation NSString (GetHeightOrWidth)

-(CGFloat)getHeightWithWidth:(CGFloat)width andFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGRect frame = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil];
    
    return CGFloat_ceil(frame.size.height)+20;
}

- (CGFloat)getWitdhWithHeight:(CGFloat)height andFont:(UIFont*)font{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGRect frame = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil];
    return CGFloat_ceil(frame.size.width);
}




@end
