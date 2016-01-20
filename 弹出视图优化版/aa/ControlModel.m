//
//  ControlModel.m
//  Buickhousekeeper
//
//  Created by 李黎明 on 13-6-21.
//  Copyright (c) 2013年 calinks. All rights reserved.
//

#import "ControlModel.h"
#import "Utility.h"
#import <QuartzCore/QuartzCore.h>

@implementation ControlModel

+ (UIButton *)creatModelButtonWith:(NSString *)normalImage :(NSString *)heigLightedImage :(int)aTag :(CGRect)aframe{
    UIButton *ModelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ModelBtn.frame = aframe;
    [ModelBtn setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [ModelBtn setBackgroundImage:[UIImage imageNamed:heigLightedImage] forState:UIControlStateHighlighted];
    ModelBtn.tag = aTag;
    return ModelBtn;
}

+ (UIButton *)creatStreachModelButtonWith:(NSString *)normalImage :(NSString *)heigLightedImage :(int)aTag :(CGRect)aframe :(float)leftCap :(float)tpCap{
    UIButton *ModelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ModelBtn.frame = aframe;
    [ModelBtn setBackgroundImage:[Utility getImageWithStretchableByBundlePathWithImageName:normalImage :leftCap:tpCap] forState:UIControlStateNormal];
    [ModelBtn setBackgroundImage:[Utility getImageWithStretchableByBundlePathWithImageName:heigLightedImage :leftCap:tpCap] forState:UIControlStateHighlighted];
    ModelBtn.tag = aTag;
    return ModelBtn;
}

//创建背景图片
+ (UIImageView *) createModelImageViewWith :(NSString *)aimage :(CGRect)aframe{
    UIImageView *ModelImageView = [[UIImageView alloc]init];
    ModelImageView.frame = aframe;
    ModelImageView.image = [UIImage imageNamed:aimage];
    return [ModelImageView autorelease];
}

//创建参数图片
+ (UIImageView *) createParameterImageViewWith :(UIImage *)aimage :(CGRect)aframe{
    UIImageView *ModelImageView = [[UIImageView alloc]init];
    ModelImageView.frame = aframe;
    ModelImageView.image = aimage;
    return [ModelImageView autorelease];
}

//创建标签
+ (UILabel *) createModelLabelWith :(CGRect)aframe :(NSString *)astring :(float)afont :(UIColor *)acolor{
    UILabel *ModelLabel = [[UILabel alloc]init];
    ModelLabel.frame = aframe;
    ModelLabel.text = astring;
    ModelLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:afont];
    ModelLabel.backgroundColor = [UIColor clearColor];
    ModelLabel.textColor = acolor;
    return [ModelLabel autorelease];
}

//创建标签
+ (UILabel *) createModelLabelWith :(CGRect)aframe :(NSString *)astring :(float)afont :(UIColor *)acolor :(NSInteger)aInteger{
    UILabel *ModelLabel = [[UILabel alloc]init];
    ModelLabel.frame = aframe;
    ModelLabel.text = astring;
    ModelLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:afont];
    ModelLabel.backgroundColor = [UIColor clearColor];
    ModelLabel.textAlignment = aInteger;
    ModelLabel.textColor = acolor;
    return [ModelLabel autorelease];
}

+ (UILabel *) createCenterModelLabelWith :(CGRect)aframe :(NSString *)astring :(float)afont :(UIColor *)acolor{
    UILabel *ModelLabel = [[UILabel alloc]init];
    ModelLabel.frame = aframe;
    ModelLabel.text = astring;
    ModelLabel.textAlignment = NSTextAlignmentCenter;
    ModelLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:afont];
    ModelLabel.backgroundColor = [UIColor clearColor];
    ModelLabel.textColor = acolor;
    return [ModelLabel autorelease];
}

//创建textField
+ (UITextField *)createModelTextFieldWith :(CGRect)aframe :(int)atag :(int)afont :(NSString *)astring{
    UITextField * ModelText = [[UITextField alloc] init];
    ModelText.frame = aframe;
//    ModelText.font = [UIFont systemFontOfSize:afont];
    ModelText.text = [NSString stringWithFormat:@"%@", astring];
    ModelText.backgroundColor = [UIColor clearColor];
    ModelText.textColor = [UIColor blackColor];
    return [ModelText autorelease];
}
@end
