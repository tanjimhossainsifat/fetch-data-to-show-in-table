//
//  FetchInfoHelper.m
//  Fetch-Data-And-Show-In-Table
//
//  Created by Arafat Mahmood Rahat on 30/3/18.
//  Copyright © 2018 Tanjim.org. All rights reserved.
//

#import "FetchInfoHelper.h"
#include "Config.h"
#include "Info.h"
#import "DatabaseHelper.h"

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
          NSArray *infoList = [self parseInfoList:data];
          
          BOOL isInserted = [[DatabaseHelper sharedInstance] insertInfoList:infoList];
          if(isInserted) {
              
              NSLog(@"Data inserted or updated in database");
              
              if(self.delegate && [self.delegate respondsToSelector:@selector(newInfoAdded)]) {
                  [self.delegate newInfoAdded];
              }
          }
          else {
              NSLog(@"Data not inserted or updated in database");
              
              if(self.delegate && [self.delegate respondsToSelector:@selector(noInfoAdded)]) {
                  [self.delegate noInfoAdded];
              }
          }
          
          
      }] resume];
}

- (NSArray *) parseInfoList:(NSData *)jsonData {
    
    NSError *localError = nil;
    NSArray *parsedObjectList = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&localError];
    
    if (localError != nil) {
        return nil;
    }
    
    NSMutableArray *infoList = [[NSMutableArray alloc] init];
    
    for(NSDictionary *eachObject in parsedObjectList) {
        
        Info *eachInfo = [[Info alloc] init];
        eachInfo.id = [[eachObject valueForKey:@"id"] integerValue];
        eachInfo.info1 = [eachObject valueForKey:@"info1"];
        eachInfo.info2 = [eachObject valueForKey:@"info2"];
        eachInfo.info3 = [eachObject valueForKey:@"info3"];
        
        [infoList addObject:eachInfo];
    }
    
    return  infoList;
    
}

@end
