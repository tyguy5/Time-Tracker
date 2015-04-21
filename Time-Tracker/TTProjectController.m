//
//  TTProjectController.m
//  Time-Tracker
//
//  Created by TYLER on 4/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TTProjectController.h"
#import "TTProject.h"

static NSString * const projectListKey = @"projectList";

@interface TTProjectController ()

@property (nonatomic, strong) NSArray *projects;

@end

@implementation TTProjectController

+ (TTProjectController *)sharedInstance {
    static TTProjectController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TTProjectController alloc] init];
        
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)setProjects:(NSArray *)projects {
    _projects = projects;
    
    [self synchronize];
}

- (void)addProject:(TTProject *)project {
    
    if (!project) {
        return;
    }
    
    NSMutableArray *mutableProject = [[NSMutableArray alloc] initWithArray:self.projects];
    [mutableProject addObject:project];
    
    self.projects = mutableProject;
}

- (void)removeProject:(TTProject *)project {
    
    if (!project) {
        return;
    }
    
    NSMutableArray *mutableProject = self.projects.mutableCopy;
    [mutableProject removeObject:project];
    
    self.projects = mutableProject;
}

- (void)loadFromDefaults {
    
    NSArray *projectDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:projectListKey];
    
    NSMutableArray *projects = [NSMutableArray new];
    for (NSDictionary *project in projectDictionaries) {
        [projects addObject:[[TTProject alloc] initWithDictionary:project]];
    }
    
    self.projects = projects;
}

- (void)synchronize {
    
    NSMutableArray *projectDictionaries = [NSMutableArray new];
    for (TTProject *project in self.projects) {
        [projectDictionaries addObject:[project projectDictionary]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:projectDictionaries forKey:projectListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
