//
//  ImageViewController.m
//  获取多张图片
//
//  Created by Administrator on 15/11/4.
//  Copyright (c) 2015年 wing. All rights reserved.
//

#import "ImageViewController.h"
#import "BIDContentCell.h"
@interface ImageViewController ()
@property(nonatomic, strong) NSMutableArray *assetGroups;
@property(nonatomic, assign) BOOL clickState;
@property(nonatomic, strong) UIImageView *images;
@property(strong, nonatomic) NSMutableArray *imageArr;
@property(strong, nonatomic) NSMutableDictionary *imageDic;
@property(strong, nonatomic) NSMutableArray *selectImage;
@property(nonatomic, strong) UIButton *done;
@property (strong, nonatomic)NSMutableArray *imageNumbArr;
@end

@implementation ImageViewController
static NSInteger count = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageArr = [[NSMutableArray alloc]init];
    self.imageDic = [[NSMutableDictionary alloc]init];
    self.selectImage = [[NSMutableArray alloc]init];
    self.imageNumbArr = [[NSMutableArray alloc]init];
    
    [self getAllPictures];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //    [layout setscr]
    layout.sectionInset = UIEdgeInsetsMake(10, 20, 30, 20);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.headerReferenceSize = CGSizeMake(100, 25);
    
    self.collection =[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    
    self.collection.delegate=self;
    self.collection.dataSource=self;
    
    [self.collection registerClass:[BIDContentCell class] forCellWithReuseIdentifier:@"CONTENT"];
    [self.collection registerClass:[BIDContentCell class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"HEADER"];
    
    
    
    self.collection.backgroundColor = [UIColor whiteColor];
    
    UIEdgeInsets contentInset = self.collection.contentInset;
    contentInset.top = 20;
    [self.collection setContentInset:contentInset];
    
    [self.view addSubview:self.collection];
    
    
    _done = [[UIButton alloc]initWithFrame:CGRectMake(10, 500, 300, 30)];
    [_done setTitle:@"完成按钮" forState:UIControlStateNormal];
    _done.titleLabel.textColor = [UIColor whiteColor];
    _done.titleLabel.textAlignment = NSTextAlignmentCenter;
    _done.backgroundColor = [UIColor blueColor];
    [_done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_done];
    
}

#pragma mark <UICollectionViewDataSource>
//定义展示的Section的个数
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return imageArray.count/3;
//}
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageArray.count;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BIDContentCell *cell = [self.collection
                            dequeueReusableCellWithReuseIdentifier:@"CONTENT"
                            forIndexPath:indexPath];
    ALAsset *asset = [imageArray objectAtIndex:indexPath.row];
    cell.MyImageView.image = [UIImage imageWithCGImage:[asset thumbnail]]; // [[asset defaultRepresentation] fullScreenImage]
    
    NSString *isSelectedString = self.imageDic[@(indexPath.row)];
    if ([isSelectedString isEqualToString:@"0"]) { // 未选中
        cell.selectedImageView.image = nil;
    } else if ([isSelectedString isEqualToString:@"1"]) { // 选中
        cell.selectedImageView.image = [UIImage imageNamed:@"选中"];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 110);
}
//定义每个UICollectionView 的间隙
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark <UICollectionViewDelegate>
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *isSelectedString = self.imageDic[@(indexPath.row)];
    
    NSLog(@"%ld",(long)indexPath.row);
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    if ([isSelectedString isEqualToString:@"0"]) {  // 未选中
        if(self.imageNumbArr.count < 4){
            [self.imageDic setObject:@"1" forKey:@(indexPath.row)];
            [self.imageNumbArr addObject:index];
        }else{
            NSLog(@"超出可选择的图片数,最多可选4张图片!");
        }
        
    } else if ([isSelectedString isEqualToString:@"1"]) { // 选中
        [self.imageDic setObject:@"0" forKey:@(indexPath.row)];
        
        [self.imageNumbArr removeObject:index];
    }
    
    [collectionView reloadData];
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        UICollectionViewCell *cell = [self.collection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        return cell;
    }
    return nil;
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}



-(void)getAllPictures{
    imageArray = [[NSArray alloc] init];
    mutableArray = [[NSMutableArray alloc]init];
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    library = [[ALAssetsLibrary alloc] init];
    __block NSInteger i = 0;
    __weak typeof(self) weak_self = self;
    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop){
        if(result != nil) {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]){
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                NSURL *url = (NSURL*)[[result defaultRepresentation]url];
                [library assetForURL:url resultBlock:^(ALAsset *asset){
                    [weak_self.imageDic setObject:@"0" forKey:@(i)];
                    i++;
                    [mutableArray addObject:asset];
                    if ([mutableArray count] == count)
                        
                    {
                        imageArray = [[NSArray alloc] initWithArray:mutableArray];
                        
                        [self allPhotosCollected:imageArray];
                    }
                }
                        failureBlock:^(NSError *error){
                            NSLog(@"operation was not successfull!");
                        }];
            }
        }
    };
    _assetGroups = [[NSMutableArray alloc] init];
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
            [_assetGroups addObject:group];
            count = [group numberOfAssets];
            //            NSLog(@"%ld",(long)[group numberOfAssets]);
            
        }
    };
    _assetGroups = [[NSMutableArray alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
}

-(void)allPhotosCollected:(NSArray*)imgArray{
    NSLog(@"all pictures are %@",imgArray);
    [self.collection reloadData];
}

#pragma mark - 完成按钮
-(IBAction)done:(UIButton *)sender{
    
    for(NSString *index in self.imageNumbArr){
        int n = index.intValue;
        NSLog(@"%d",index.intValue);
        UIImage *selectedImage = [UIImage imageWithCGImage:[imageArray[n] thumbnail]];
        [self.selectImage addObject:selectedImage];
    }
    if(_delegate != nil && [_delegate respondsToSelector:@selector(turnImages:)]){
        
        [self.delegate turnImages:self.selectImage];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        NSLog(@"代理方法出错！");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"程序错误，请联系客服！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
