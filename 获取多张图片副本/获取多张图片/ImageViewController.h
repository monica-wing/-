//
//  ImageViewController.h
//  获取多张图片
//
//  Created by Administrator on 15/11/4.
//  Copyright (c) 2015年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>
#include<AssetsLibrary/AssetsLibrary.h>
#import "ViewController.h"
@interface ImageViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    ALAssetsLibrary *library;
    NSArray *imageArray;
    NSMutableArray *mutableArray;
    
}
@property (assign, nonatomic)id<turnBackDelegate>delegate;
@property (strong, nonatomic)UICollectionView *collection;
-(void)allPhotosCollected:(NSArray*)imgArray;
@end
