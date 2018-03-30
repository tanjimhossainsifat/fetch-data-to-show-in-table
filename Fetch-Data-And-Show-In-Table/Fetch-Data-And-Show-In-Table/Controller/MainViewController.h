//
//  MainViewController.h
//  Fetch-Data-And-Show-In-Table
//
//  Created by Arafat Mahmood Rahat on 30/3/18.
//  Copyright © 2018 Tanjim.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchInfoHelper.h"

@interface MainViewController : UIViewController <NewInfoAddedDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

- (IBAction)onButtonRefresh:(id)sender;

@end
