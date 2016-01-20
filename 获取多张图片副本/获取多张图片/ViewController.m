//
//  ViewController.m
//  获取多张图片
//
//  Created by Administrator on 15/11/1.
//  Copyright (c) 2015年 wing. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import "ImageViewController.h"
@interface ViewController ()
@property (strong, nonatomic)UIImagePickerController *picker;
@property (strong, nonatomic)UIButton *addImageBtn;
@property (strong, nonatomic)UIImageView *imageView1;
@property (strong, nonatomic)UIImageView *imageView2;
@property (strong, nonatomic)UIImageView *imageView3;
@property (strong, nonatomic)UIImageView *imageView4;
@property (strong, nonatomic)UIImageView *imageView5;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.addImageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT_SCREEN/4, WIDTH_SCREEN*10/32, HEIGHT_SCREEN*62.5/568)];
    
    [self.addImageBtn setImage:[UIImage imageNamed:@"添加图片.png"] forState:UIControlStateNormal];
    [self.addImageBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_SCREEN*105/320, HEIGHT_SCREEN/4, WIDTH_SCREEN*10/32, HEIGHT_SCREEN*62.5/568)];
    self.imageView2.userInteractionEnabled = YES;
    
    self.imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_SCREEN*210/320, HEIGHT_SCREEN/4, WIDTH_SCREEN*10/32, HEIGHT_SCREEN*62.5/568)];
    self.imageView3.userInteractionEnabled = YES;
    
    self.imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, HEIGHT_SCREEN/2, WIDTH_SCREEN*10/32, HEIGHT_SCREEN*62.5/568)];
    self.imageView4.userInteractionEnabled = YES;
    
    self.imageView5 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_SCREEN*105/320, HEIGHT_SCREEN/2, WIDTH_SCREEN*10/32, HEIGHT_SCREEN*62.5/568)];
    self.imageView5.userInteractionEnabled = YES;
    
    [self.view addSubview:self.imageView2];
    [self.view addSubview:self.imageView3];
    [self.view addSubview:self.imageView4];
    [self.view addSubview:self.imageView5];
    [self.view addSubview:self.addImageBtn];
    
}
#pragma mark - 点击添加图片按钮
- (IBAction)click:(UIButton *)sender{
    
    self.imageView2.image = [UIImage new];
    self.imageView3.image = [UIImage new];
    self.imageView4.image = [UIImage new];
    self.imageView5.image = [UIImage new];
    
//    ImagesCollectionViewController *ipvc = [[UIStoryboard storyboardWithName:@"jjj" bundle:nil]  instantiateViewControllerWithIdentifier:@"ImagesCollection"];
    
    ImageViewController *vc=[[ImageViewController alloc]init];
    
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
//    ImagesCollectionViewController *vc=[[ImagesCollectionViewController alloc]init];
    
  
}
#pragma mark - 代理带回来的图片信息
- (void)turnImages:(NSMutableArray *)selectAllImages{
    NSLog(@"---> %@",selectAllImages);
    
    if (selectAllImages.count == 1) {
        self.imageView2.image = selectAllImages[0];
    }else if(selectAllImages.count == 2){
        self.imageView2.image = selectAllImages[0];
        self.imageView3.image = selectAllImages[1];
    }else if(selectAllImages.count == 3){
        self.imageView2.image = selectAllImages[0];
        self.imageView3.image = selectAllImages[1];
        self.imageView4.image = selectAllImages[2];
    }else if(selectAllImages.count == 4){
        self.imageView2.image = selectAllImages[0];
        self.imageView3.image = selectAllImages[1];
        self.imageView4.image = selectAllImages[2];
        self.imageView5.image = selectAllImages[3];
    }else{
        NSLog(@"大哥~出错了，没看明白么？!");
    }
    
    
    
}


@end
