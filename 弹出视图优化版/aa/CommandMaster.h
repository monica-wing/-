

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol CommandMasterDelegate
@optional
- (void)didSelectMenuListItemAtIndex:(NSInteger)index;
@end

typedef NS_ENUM(NSUInteger, AppBarState) {
    AppBarFull,
    AppBarMenuList
};

@interface CommandMaster : UIView <UIScrollViewDelegate>

+ (CommandMaster *)sharedInstance;

- (void)addToView:(UIView *)parent andLoadGroup:(NSString *)group;

- (void)addButtons:(NSArray *)buttons forGroup:(NSString *)group;

- (void)showFullAppBar;
- (void)showMenuList;

+ (UIButton *)createButtonWithImage:(UIImage *)image andTitle:(NSString *)title;

@property (nonatomic, readonly) AppBarState currentState;
@property (nonatomic, strong) id<CommandMasterDelegate> delegate;

@end
