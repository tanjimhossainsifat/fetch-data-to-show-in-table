//
//  MainViewController.m
//  Fetch-Data-And-Show-In-Table
//
//  Created by Arafat Mahmood Rahat on 30/3/18.
//  Copyright © 2018 Tanjim.org. All rights reserved.
//

#import "MainViewController.h"
#import "DatabaseHelper.h"
#import "TableViewCell.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    NSArray *infoList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"TableViewCell"];
    
    infoList = [[NSArray alloc] init];
    [self fetchDataByAPI];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchDataByAPI {
    
    FetchInfoHelper *fetchInfoHelper = [[FetchInfoHelper alloc] init];
    fetchInfoHelper.delegate = self;
    [fetchInfoHelper fetchInfo];
}

#pragma mark - NewInfoAddedDelegate

- (void) newInfoAdded {
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    infoList = [[DatabaseHelper sharedInstance] getAllInfo];
    
    if(!infoList) {
        return 0;
    }
    
    return infoList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    
    TableViewCell *cell = (TableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Info *info = [infoList objectAtIndex:indexPath.row];
    
    cell.info1.text = [NSString stringWithFormat:@"%@", info.info1 ];
    cell.info2.text = [NSString stringWithFormat:@"%@", info.info2 ];
    cell.info3.text = [NSString stringWithFormat:@"%@", info.info3 ];
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
