//
//  ChangeCityViewController.m
//  jmportal_iphone_grid
//
//  Created by yaojun on 14-5-28.
//
//

#import "ChangeCityViewControllers.h"

#pragma mark- 常规宏定义
#define WIDTH_SCREEN    [UIScreen mainScreen].bounds.size.width   //屏幕宽度
#define HEIGHT_SCREEN   [UIScreen mainScreen].bounds.size.height  //屏幕高度

//字体的定义
#define FONT(F) [UIFont systemFontOfSize:F]

//获取RGB颜色
#define RGBAA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r,g,b) RGBAA(r,g,b,1.0f)


@interface ChangeCityViewControllers ()

@end

@implementation ChangeCityViewControllers
@synthesize citydataSource;
@synthesize contactTableView;
@synthesize delegate;
@synthesize cityArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];

    [self createTableView];
    
}

-(void)createTableView
{
    contactTableView = [[BATableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
    contactTableView.delegate = self;
    [self.view addSubview:self.contactTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToHomeViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView {
    NSMutableArray * indexTitles = [NSMutableArray array];
    for (NSDictionary * sectionDictionary in self.cityArray) {
        [indexTitles addObject:sectionDictionary[@"province"]];
    }
    return indexTitles;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary    *dic=self.cityArray [section];
    NSArray         *array=[dic objectForKey:@"citys" ];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    
    cell.textLabel.text =   [self.cityArray[indexPath.section][@"citys"][indexPath.row] objectForKey:@"city_name"];
    cell.textLabel.textColor=RGBAA(69, 69, 69, 1);
    cell.textLabel.font=FONT(14);
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView  *titleView=[[UIView  alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    titleView.backgroundColor=RGBAA(226, 226, 226, 1);
    UILabel *titleLable=[[UILabel    alloc]initWithFrame:CGRectMake(10, 0, 100, 20)];
    titleLable.text=self.cityArray[section][@"province"];
    titleLable.textColor=RGBAA(0, 129, 246, 1);
    titleLable.font=FONT(12);
    
    [titleView addSubview:titleLable];
    
    return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dic = self.cityArray[indexPath.section][@"citys"][indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"responseAgreefail" object:dic userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)back:(id)sender {
      [self.navigationController popViewControllerAnimated:YES];
}
@end
