//
//  ViewController.h
//  获取多张图片
//
//  Created by Administrator on 15/11/1.
//  Copyright (c) 2015年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol turnBackDelegate <NSObject>
- (void)turnImages:(NSMutableArray *)selectAllImages;
@end

@interface ViewController : UIViewController<turnBackDelegate>

@end

