//
//  ABELTableView.m
//  ABELTableViewDemo
//
//  Created by abel on 14-4-28.
//  Copyright (c) 2014年 abel. All rights reserved.
//

#import "BATableView.h"

@interface BATableView()<BATableViewIndexDelegate>{
    UILabel           * flotageLabel;
    BATableViewIndex * tableViewIndex;
}
@end

@implementation BATableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        self.tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.tableView];
        
        tableViewIndex = [[BATableViewIndex alloc] initWithFrame:(CGRect){270,0,50,frame.size.height}];
        [self addSubview:tableViewIndex];
        tableViewIndex.tableViewIndexDelegate = self;        
        flotageLabel = [[UILabel alloc] initWithFrame:(CGRect){(self.bounds.size.width - 64 ) / 2,(self.bounds.size.height - 64) / 2,64,64}];
        flotageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"flotageBackgroud"]];
        flotageLabel.hidden = YES;
        flotageLabel.textAlignment = NSTextAlignmentCenter;
        flotageLabel.textColor = [UIColor whiteColor];
        [self addSubview:flotageLabel];
        
        
        [self setDelegate:self.delegate];
        
    }
    return self;
}

- (void)setDelegate:(id<BATableViewDelegate>)delegate
{
    _delegate = delegate;
    self.tableView.delegate = delegate;
    self.tableView.dataSource = delegate;
    tableViewIndex.indexes = [self.delegate sectionIndexTitlesForABELTableView:self];
    CGRect rect = tableViewIndex.frame;
    rect.size.height = tableViewIndex.indexes.count * 25;
    rect.origin.y = (self.bounds.size.height - rect.size.height) / 2+100;
    tableViewIndex.frame = rect;
    
    tableViewIndex.tableViewIndexDelegate = self;
}

- (void)reloadData
{
    [self.tableView reloadData];
    
    UIEdgeInsets edgeInsets = self.tableView.contentInset;
    
    tableViewIndex.indexes = [self.delegate sectionIndexTitlesForABELTableView:self];
    CGRect rect = tableViewIndex.frame;
    rect.size.height = tableViewIndex.indexes.count * 16;
    rect.origin.y = (self.bounds.size.height - rect.size.height - edgeInsets.top - edgeInsets.bottom) / 2 + edgeInsets.top + 20;
    tableViewIndex.frame = rect;
}


#pragma mark -
- (void)tableViewIndex:(BATableViewIndex *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title
{
    if ([self.tableView numberOfSections] > index && index > -1){   // for safety, should always be YES
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:NO];
        flotageLabel.text = title;
    }
}

- (void)tableViewIndexTouchesBegan:(BATableViewIndex *)tableViewIndex
{
    flotageLabel.hidden = NO;
}

- (void)tableViewIndexTouchesEnd:(BATableViewIndex *)tableViewIndex
{
    
    flotageLabel.hidden = YES;
}

- (NSArray *)tableViewIndexTitle:(BATableViewIndex *)tableViewIndex
{
    return [self.delegate sectionIndexTitlesForABELTableView:self];
}

@end
