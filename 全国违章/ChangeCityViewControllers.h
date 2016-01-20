//
//  ChangeCityViewController.h
//  jmportal_iphone_grid
//
//  Created by yaojun on 14-5-28.
//
//

#import <UIKit/UIKit.h>
#import "BATableView.h"


@protocol ChangeCityViewControllerDelegate <NSObject>
-(void)changeButtonTag;
@end

@interface ChangeCityViewControllers : UIViewController<BATableViewDelegate>
{
    NSArray * citydataSource;
    BATableView *contactTableView;
    id<ChangeCityViewControllerDelegate>delegate;
    
    
}
@property (nonatomic, retain) NSArray * citydataSource;
@property (nonatomic, retain) BATableView *contactTableView;
@property (nonatomic, retain) NSString *webName;
@property (nonatomic) id<ChangeCityViewControllerDelegate>delegate;
@property(nonatomic,weak)NSMutableArray *cityArray;
- (IBAction)back:(id)sender;
@end
