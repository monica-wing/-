//
//  Utility.h
//  Buickhousekeeper
//
//  Created by 李黎明 on 13-6-28.
//  Copyright (c) 2013年 calinks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject




+ (UIImage *)imageNamed:(NSString *)name;

//Get a UIImage with the imageNamed
+ (UIImage *)getImageBySmallPNG:(NSString *)name;

//获取一个可宽度拉伸的图片;
+ (UIImage *)getImageWithStretchableByBundlePathWithImageName:(NSString *)name :(float)leftCap :(float) topCap;


@end
