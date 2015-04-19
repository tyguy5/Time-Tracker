//
//  TTProject.h
//  Time-Tracker
//
//  Created by TYLER on 4/18/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTEntry.h"

@interface TTProject : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *entries;

- (NSDictionary *)projectDictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)projectTime;

- (void)startNewEntry;
- (void)endCurrentEntry;

- (void)addEntry:(TTEntry *)entry;
- (void)removeEntry:(TTEntry *)entry;

- (void)synchronize;

@end
