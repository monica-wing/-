//
//  ViewController.m
//  aa
//
//  Created by 群雄 on 13-11-28.
//  Copyright (c) 2013年 凯伦圣. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
}

@end

@implementation ViewController

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
	// Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor greenColor];
    
    
    [[CommandMaster sharedInstance] addToView:self.view andLoadGroup:@"TestGroup"];
    [CommandMaster sharedInstance].delegate = self;
    [[CommandMaster sharedInstance] showFullAppBar];
}


//在这里返回
- (void)didSelectMenuListItemAtIndex:(NSInteger)index {
    NSString *str=[NSString stringWithFormat:@"index %li of button titled ", (long)index];
    NSLog(@"%@",str);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
