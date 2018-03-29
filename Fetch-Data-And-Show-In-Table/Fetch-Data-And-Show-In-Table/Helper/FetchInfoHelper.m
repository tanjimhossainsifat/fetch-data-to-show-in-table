//
//  FetchInfoHelper.m
//  Fetch-Data-And-Show-In-Table
//
//  Created by Arafat Mahmood Rahat on 30/3/18.
//  Copyright © 2018 Tanjim.org. All rights reserved.
//

#import "FetchInfoHelper.h"
#include "Config.h"

@implementation FetchInfoHelper

- (void) fetchInfo {
    
    NSString *targetUrl = [NSString stringWithFormat:@"%@", API_URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"Data received: %@", myString);
      }] resume];
}

- (void) parseInfoList:(NSString *)responseString {
    
    
}

@end
