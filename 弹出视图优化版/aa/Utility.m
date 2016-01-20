//
//  Utility.m
//  Buickhousekeeper
//
//  Created by 李黎明 on 13-6-28.
//  Copyright (c) 2013年 calinks. All rights reserved.
//

#import "Utility.h"

@implementation Utility

//判断字符串是否为空
+(BOOL) isEmptyOrNull:(NSString *) str {
    if (!str) {
        // null object
        return NO;
    } else {
        NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            // empty string
            return NO;
        } else {
            // is neither empty nor null
            return YES;
        }
    }
}

//处理大图片内存问题
+ (UIImage *)imageNamed:(NSString *)name {
    
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], name ] ];
}

+ (UIImage *)getImageBySmallPNG:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return image;
}

+ (UIImage *)getImageWithStretchableByBundlePathWithImageName:(NSString *)name :(float)leftCap :(float) topCap{
    UIImage *image = [self getImageBySmallPNG:name];
    image = [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
    return image;
}








//判断是否为空
+(NSString *)isStringNull:(NSMutableArray *)aArray :(NSString *)aNote :(int)aTip{
    if ([aArray count]!=0) {
        NSString *aString = [NSString stringWithFormat:@"%@",[[aArray objectAtIndex:aTip]objectForKey:aNote]];
        if ([aString isEqualToString:@"(null)"]||[aString intValue]<0) {
            aString = @"";
        }
        return aString;
    }else{
        return @"";
    }
}


@end
