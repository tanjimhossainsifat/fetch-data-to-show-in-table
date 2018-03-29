//
//  DatabaseHelper.h
//  Fetch-Data-And-Show-In-Table
//
//  Created by Arafat Mahmood Rahat on 30/3/18.
//  Copyright © 2018 Tanjim.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Info.h"

@interface DatabaseHelper : NSObject

+ (instancetype) sharedInstance;

- (BOOL) create;

- (BOOL) insertInfoList:(NSArray<Info *>*) infoList;

- (NSArray<Info *> *) getAllInfo;

@end
