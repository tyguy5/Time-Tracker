//
//  TTEntry.h
//  Time-Tracker
//
//  Created by TYLER on 4/18/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTEntry : UIViewController

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)entryDictionary;

@end
