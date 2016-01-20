//
//  ControlModel.h
//  Buickhousekeeper
//
//  Created by 李黎明 on 13-6-21.
//  Copyright (c) 2013年 calinks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControlModel : NSObject
//创建按钮
+ (UIButton *)creatModelButtonWith:(NSString *)normalImage :(NSString *)heigLightedImage :(int)aTag :(CGRect)aframe;
//创建背景图片
+ (UIImageView *) createModelImageViewWith :(NSString *)aimage :(CGRect)aframe;
//创建参数图片
+ (UIImageView *) createParameterImageViewWith :(UIImage *)aimage :(CGRect)aframe;
//创建标签
+ (UILabel *) createModelLabelWith :(CGRect)aframe :(NSString *)astring :(float)afont :(UIColor *)acolor;

//创建标签
+ (UILabel *) createCenterModelLabelWith :(CGRect)aframe :(NSString *)astring :(float)afont :(UIColor *)acolor;
//创建textField
+ (UITextField *)createModelTextFieldWith :(CGRect)aframe :(int)atag :(int)afont :(NSString *)astring;
+ (UIButton *)creatStreachModelButtonWith:(NSString *)normalImage :(NSString *)heigLightedImage :(int)aTag :(CGRect)aframe :(float)leftCap :(float)tpCap;

//创建标签
+ (UILabel *) createModelLabelWith :(CGRect)aframe :(NSString *)astring :(float)afont :(UIColor *)acolor :(NSInteger)aInteger;
@end
