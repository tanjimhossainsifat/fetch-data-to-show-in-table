//
//  FetchInfoHelper.h
//  Fetch-Data-And-Show-In-Table
//
//  Created by Arafat Mahmood Rahat on 30/3/18.
//  Copyright © 2018 Tanjim.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewInfoAddedDelegate<NSObject>

- (void) newInfoAdded;
- (void) noInfoAdded;

@end

@interface FetchInfoHelper : NSObject

@property (nonatomic, assign) id<NewInfoAddedDelegate> delegate;


- (void) fetchInfo;

@end
