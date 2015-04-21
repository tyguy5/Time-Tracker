//
//  TTDetailDataSource.h
//  Time-Tracker
//
//  Created by TYLER on 4/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTProject;

@interface TTDetailDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) TTProject *project;

@end
