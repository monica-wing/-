#import "CommandMaster.h"
#import "ControlModel.h"
#import "Utility.h"


#define kAppBarFullHeight  80
#define kAppBarMenuListHeight  192
#define kAnimationDuration 0.3

#define button_state_width 19
#define button_state_height 18
#define label_state_width 19
#define label_state_height 80
#define button_width 57
#define button_height 57

#define infoLabel_height 18

@interface CommandMaster () {
    UIView *_parentView;
    UIScrollView *sv;
    UIPageControl *pageControl;
    NSString *_currentGroup;
    UIButton *_selectedButton;
    NSMutableDictionary *_buttonContainer;
    
    UILabel *nameLabel;
    UILabel *CarnameLabel;
    UILabel *levelLabel;
    
}
@property (nonatomic,retain) UIImageView *TipImageView;
@property (nonatomic,retain) UIImage *tabBar_icon_normal;
@property (nonatomic,retain) UIImage *tabBar_icon_select;
@end

@implementation CommandMaster

static CommandMaster *_sharedInstance = nil;

@synthesize delegate = _delegate;

#pragma mark Public Functions Start

+ (CommandMaster *)sharedInstance {
    if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_sharedInstance = [[CommandMaster alloc] init];
        });
    }
    return _sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        self.backgroundColor=[UIColor clearColor];
        _buttonContainer = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc{
    [_tabBar_icon_normal release];
    [_tabBar_icon_select release];
    [_buttonContainer release];
    [_TipImageView release];
    [pageControl release];
    [sv release];
    [super dealloc];
}

// Adds the bar to the view
- (void)addToView:(UIView *)parent  andLoadGroup:(NSString *)group{
    _currentGroup = group;
    
    _currentState = AppBarFull;
    _parentView = parent;
    
    _sharedInstance.frame = CGRectMake(0, (_parentView.frame.size.height - kAppBarFullHeight), _parentView.frame.size.width, kAppBarFullHeight);
    [_parentView addSubview:_sharedInstance];
    
    sv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, kAppBarFullHeight,_parentView.frame.size.width, kAppBarFullHeight+kAppBarMenuListHeight+10)];
    sv.contentSize=CGSizeMake(3*320, kAppBarMenuListHeight);
    sv.pagingEnabled=YES;
    sv.bounces = NO;
    sv.delegate=self;
    
    self.tabBar_icon_normal = [[[UIImage alloc]init]autorelease];
    self.tabBar_icon_select = [[[UIImage alloc]init]autorelease];
    
    
    for (int i=0; i<3; i++) {
        UIView *iv=[[UIView alloc]initWithFrame:CGRectMake(i*320, 0, 320, kAppBarMenuListHeight)];
        iv.backgroundColor = [UIColor colorWithPatternImage:[Utility getImageWithStretchableByBundlePathWithImageName:@"mainView_scroll_bg" :0 :0]];
        if (i==0) {
            [iv addSubview:[ControlModel createModelImageViewWith:@"mainView_Info_header_bg" :CGRectMake(10, 15, 70, 70)]];
            self.TipImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 60, 60)]autorelease];
            self.TipImageView.image = [UIImage imageNamed:@"public_header_default_bg"];
            [iv addSubview:self.TipImageView];
            [iv addSubview:[ControlModel createModelLabelWith:CGRectMake(90, infoLabel_height, 60, 20) :@"姓名:" :14 :[UIColor whiteColor]]];
            [iv addSubview:[ControlModel createModelLabelWith:CGRectMake(90, infoLabel_height+20, 60, 20) :@"车型:" :14 :[UIColor whiteColor]]];
            [iv addSubview:[ControlModel createModelLabelWith:CGRectMake(90, infoLabel_height+40, 60, 20) :@"级别:" :14 :[UIColor whiteColor]]];
            
            nameLabel = [ControlModel createModelLabelWith:CGRectMake(140, infoLabel_height, 110, 20) :@"" :14 :[UIColor whiteColor]];
            [iv addSubview:nameLabel];
            
            CarnameLabel = [ControlModel createModelLabelWith:CGRectMake(140, infoLabel_height+20, 180, 20) :@"" :14 :[UIColor whiteColor]];
            [iv addSubview:CarnameLabel];
            
            levelLabel = [ControlModel createModelLabelWith:CGRectMake(140, infoLabel_height+40, 100, 20) :@"" :14 :[UIColor whiteColor]];
            [levelLabel addSubview:[ControlModel createModelImageViewWith:@"" :CGRectMake(0, 0, 20, 20)]];
            [iv addSubview:levelLabel];
            
            UIButton *PersonInfoBtn = [ControlModel creatModelButtonWith:@"Person_personInfo" :nil :1:CGRectMake(button_state_width, button_state_height+80, button_width, button_height)];
            [PersonInfoBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(label_state_width, label_state_height+75, 57, 20) :@"个人信息" :12 :[UIColor whiteColor]]];
            [iv addSubview:PersonInfoBtn];
            
            UIButton *CarInfoBtn = [ControlModel creatModelButtonWith:@"car_carInfo" :nil :2:CGRectMake(button_state_width+75, button_state_height+80, button_width, button_height)];
            [CarInfoBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(button_state_width+75, label_state_height+75, 57, 20) :@"车辆信息" :12 :[UIColor whiteColor]]];
            [iv addSubview:CarInfoBtn];
            
            UIButton *settingBtn = [ControlModel creatModelButtonWith:@"Person_Setting" : nil:3:CGRectMake(button_state_width+150, button_state_height+80, button_width, button_height)];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(label_state_width+150, label_state_height+75, 57, 20) :@"设置" :12 :[UIColor whiteColor]]];
            [settingBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:settingBtn];
            
           
            
            
        }else if (i==1){
            UIButton *MaintainBtn = [ControlModel creatModelButtonWith:@"car_ appointment" :nil :4:CGRectMake(button_state_width, button_state_height, button_width, button_height)];
            [MaintainBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(label_state_width, label_state_height, button_width, 15) :@"预约保养" :12 :[UIColor whiteColor]]];
            [iv addSubview:MaintainBtn];
            
            UIButton *MaintainScoreBtn = [ControlModel creatModelButtonWith:@"car_maintenance" :nil :5:CGRectMake(button_state_width+75, button_state_height, button_width, button_height)];
            [MaintainScoreBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(button_state_width+75, label_state_height, 57, 15) :@"保养记录" :12 :[UIColor whiteColor]]];
            [iv addSubview:MaintainScoreBtn];
            
            UIButton *queryViolitionBtn = [ControlModel creatModelButtonWith:@"car_violate" :nil :9:CGRectMake(button_state_width+150, button_state_height, button_height, button_height)];
            [queryViolitionBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(label_state_width+150, label_state_height, 57, 15) :@"查询违章" :12 :[UIColor whiteColor]]];
            [iv addSubview:queryViolitionBtn];
            
            UIButton *getDangerBtn = [ControlModel creatModelButtonWith:@"car_getDanger" :nil :7:CGRectMake(button_state_width+225, button_state_height, button_height, button_height)];
            [getDangerBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(label_state_width+225, label_state_height, 57, 15) :@"出险救援" :12 :[UIColor whiteColor]]];
            [iv addSubview:getDangerBtn];
            
            UIButton *insureBtn = [ControlModel creatModelButtonWith:@"car_insure" :nil :8:CGRectMake(button_state_width, button_state_height+87, button_width, button_height)];
            [insureBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(label_state_width, label_state_height+87, button_width, 15) :@"保单查询" :12 :[UIColor whiteColor]]];
            [iv addSubview:insureBtn];
            
            UIButton *oilSetBtn = [ControlModel creatModelButtonWith:@"car_fuel" :nil :12:CGRectMake(button_state_width+75, button_state_height+87, button_width, button_height)];
            [oilSetBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(button_state_width+75, label_state_height+87, 57, 15) :@"油耗管理" :12 :[UIColor whiteColor]]];
            [iv addSubview:oilSetBtn];
            
            
            UIButton *InstructionBtn = [ControlModel creatModelButtonWith:@"car_instruction" :nil :10:CGRectMake(button_state_width+150, button_state_height+87, button_height, button_height)];
            [InstructionBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(label_state_width+150, label_state_height+87, 57, 15) :@"用车指南" :12 :[UIColor whiteColor]]];
            [iv addSubview:InstructionBtn];
            
        }else if(i==2){
            UIButton *dealerBtn = [ControlModel creatModelButtonWith:@"Shop_4SShop" :nil :13:CGRectMake(button_state_width, button_state_height, button_width, button_height)];
            [dealerBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(label_state_width, label_state_height, 57, 15) :@"4S店信息" :12 :[UIColor whiteColor]]];
            [iv addSubview:dealerBtn];
            
            UIButton *activityBtn = [ControlModel creatModelButtonWith:@"Shop_activity" :nil :14:CGRectMake(button_state_width+75, button_state_height, button_width, button_height)];
            [activityBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(button_state_width+75, label_state_height, 57, 15) :@"4S店活动" :12 :[UIColor whiteColor]]];
            [iv addSubview:activityBtn];
            
            
            UIButton *serviceCenterBtn = [ControlModel creatModelButtonWith:@"Shop_goodsShop" :nil :15:CGRectMake(button_state_width+150, button_state_height, button_height, button_height)];
            [serviceCenterBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(label_state_width+150, label_state_height, 57, 15) :@"精品商城" :12 :[UIColor whiteColor]]];
            [iv addSubview:serviceCenterBtn];
            
            UIButton *messageBtn = [ControlModel creatModelButtonWith:@"Shop_userdCar" :nil :16:CGRectMake(button_state_width+225, button_state_height, button_height, button_height)];
            [messageBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(label_state_width+225, label_state_height, 57, 15) :@"二手车店" :12 :[UIColor whiteColor]]];
            [iv addSubview:messageBtn];
            
            UIButton *carPlamtenBtn = [ControlModel creatModelButtonWith:@"Shop_Carplatform" :nil :17:CGRectMake(button_state_width, button_state_height+87, button_width, button_height)];
            [carPlamtenBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(label_state_width, label_state_height+87, button_width, 15) :@"汽车展厅" :12 :[UIColor whiteColor]]];
            [iv addSubview:carPlamtenBtn];
            
            UIButton *queryViolitionBtn = [ControlModel creatModelButtonWith:@"Shop_gift" :nil :18:CGRectMake(button_state_width+75, button_state_height+87, button_width, button_height)];
            [queryViolitionBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(button_state_width+75, label_state_height+87, 57, 15) :@"礼品兑换" :12 :[UIColor whiteColor]]];
            [iv addSubview:queryViolitionBtn];
            
            UIButton *lookDealerBtn = [ControlModel creatModelButtonWith:@"Shop_lookDealer" :nil :19:CGRectMake(button_state_width+150, button_state_height+87, button_width, button_height)];
            [lookDealerBtn addTarget:self action:@selector(buttonTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [iv addSubview:[ControlModel createCenterModelLabelWith:CGRectMake(button_state_width+150, label_state_height+87, 57, 15) :@"查经销商" :12 :[UIColor whiteColor]]];
            [iv addSubview:lookDealerBtn];
            
        }
        
        [sv addSubview:iv];
        [iv release];
    }
    [self addSubview:sv];
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(100, ( kAppBarFullHeight)+kAppBarMenuListHeight-30, 100, 40)];
    pageControl.numberOfPages=3;
    pageControl.currentPage=0;
    pageControl.hidden = YES;
    [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset=scrollView.contentOffset;
    pageControl.currentPage=offset.x/320.0f;
    [_selectedButton setSelected:NO];
    _selectedButton=(UIButton *)[_buttonContainer objectForKey:_currentGroup][pageControl.currentPage] ;
    [_selectedButton setSelected:YES];
}

// Used for insertion of single button with error checking for group size
// greater than 4.
- (void)addButton:(UIButton *)button forGroup:(NSString *)group {
    NSMutableArray *tempButtons = [[[NSMutableArray alloc] init]autorelease];
    if ([_buttonContainer objectForKey:group]) {
        tempButtons = [_buttonContainer objectForKey:group];
        @try {
            [tempButtons addObject:button];
        } @catch (NSException *exception) {
            return;
        }
    } else {
        [tempButtons addObject:button];
    }
    [_buttonContainer setObject:tempButtons forKey:group];
    [self setButtonFrames];
}

- (void)addButtons:(NSArray *)buttons forGroup:(NSString *)group {
    
    @try {
        [buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (![obj isKindOfClass:[UIButton class]]) {
                @throw [NSException exceptionWithName:@"CMButtonArrayException" reason:@"The array can only contain CommandButton objects" userInfo:nil];
            }
            [self addButton:obj forGroup:group];
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"error:%@: %@", exception.name, exception.reason);
        return;
    }
}

- (void)showFullAppBar {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.frame = CGRectMake(0, (_parentView.frame.size.height - ( kAppBarFullHeight)), self.frame.size.width, self.frame.size.height);
        [self animateButtonFramesToState];
    } completion:^(BOOL finished) {
        _currentState = AppBarFull;
    }];
}

- (void)showMenuList {
    //改变中间按钮背景图片/////////////////////
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.frame = CGRectMake(0, _parentView.frame.size.height - (kAppBarFullHeight + kAppBarMenuListHeight), self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        _currentState = AppBarMenuList;
        
    }];
}
#pragma mark Private Functions Start
- (void)setButtonFrames {
    [(UIButton *)[_buttonContainer objectForKey:_currentGroup][0] setFrame:CGRectMake(0, 30, 105, 50)];
    [(UIButton *)[_buttonContainer objectForKey:_currentGroup][1] setFrame:CGRectMake(105, 0, 110, 80)];
    [(UIButton *)[_buttonContainer objectForKey:_currentGroup][2] setFrame:CGRectMake(215, 30, 105, 50)];
}

- (void)animateButtonFramesToState{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self setButtonFrames];
    }];
    
}

- (void)drawRect:(CGRect)rect
{
    for (UIButton *button in [_buttonContainer objectForKey:_currentGroup]) {
        [button addTarget:self action:@selector(openMenuList:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
-(void)pageTurn:(UIPageControl *)aPageControl
{
    NSInteger whichPage=aPageControl.currentPage;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    sv.contentOffset=CGPointMake(320*whichPage, 0);
    [UIView commitAnimations];
}

//标签栏的3个按钮的响应事件
- (void)openMenuList:(UIButton *)sender {
    //切换标签栏选中的按钮状态
    UIButton *previousSelected = _selectedButton;
    [_selectedButton setSelected:NO];
    _selectedButton = sender;
    [_selectedButton setSelected:YES];
    if (_selectedButton.frame.origin.x<105) {
        pageControl.currentPage=0;
    }else if (_selectedButton.frame.origin.x<215) {
        pageControl.currentPage=1;
    }else{
        pageControl.currentPage=2;
    }
    [self pageTurn:pageControl];
    //当前状态为AppBarFull，则显示全部菜单，如果为全部菜单状态，则判断点击的按钮是否是当前按钮
    switch (_currentState) {
        case AppBarFull: {
            [self showMenuList];
            break;
        } case AppBarMenuList: {
            if (previousSelected != _selectedButton) {
                [UIView animateWithDuration:kAnimationDuration animations:^{
                    self.frame = CGRectMake(0, _parentView.frame.size.height - (kAppBarFullHeight + kAppBarMenuListHeight) + 10 , self.frame.size.width, self.frame.size.height);
                    [self animateButtonFramesToState];
                } completion:^(BOOL finished) {
                    [self showMenuList];
                }];
            } else if (previousSelected == _selectedButton) {
                [self showFullAppBar];
                [_selectedButton setSelected:NO];
            }
            break;
        }
    }
}


-(void)buttonTagAction:(UIButton *)sender{
    [_delegate didSelectMenuListItemAtIndex:sender.tag];
}

+ (UIButton *)createButtonWithImage:(UIImage *)image andTitle:(NSString *)title {
    UIButton *temp = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
    [temp setBackgroundImage:image forState:UIControlStateNormal];
    if ([title isEqualToString:@"会员俱乐部"]) {
        [temp setBackgroundImage:[UIImage imageNamed:@"mainView_tab_club_p" ] forState:UIControlStateSelected];
        [temp setBackgroundImage:[UIImage imageNamed:@"mainView_tab_club_p" ] forState:UIControlStateHighlighted];
        
    }else if ([title isEqualToString:@"4S服务中心"]){
        [temp setBackgroundImage:[UIImage imageNamed:@"mainView_normal_car_p" ] forState:UIControlStateSelected];
    }else{
        [temp setBackgroundImage:[UIImage imageNamed:@"mainView_tab_ibuick_p1" ] forState:UIControlStateSelected];
    }
    return [temp autorelease];
}
// Handles bug that wouldn't let us touch the bottom 20px-ish of the menuList
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //所点击的位置在view的范围
    if (point.y < 0) {
        [self showFullAppBar];
        [_selectedButton setSelected:NO];
        return NO;
    }
    return YES;
}
@end
