//
//  TTProjectController.h
//  Time-Tracker
//
//  Created by TYLER on 4/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTProject.h"

@interface TTProjectController : UIViewController

@property (nonatomic, strong, readonly) NSArray *projects;

+ (TTProjectController *)sharedInstance;

- (void)addProject:(TTProject *)project;
- (void)removedObject:(TTProject *)project;

- (void)synchronize;

@end
