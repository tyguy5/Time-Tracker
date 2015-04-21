//
//  TTProject.m
//  Time-Tracker
//
//  Created by TYLER on 4/18/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TTProject.h"
#import "TTEntry.h"

#import "TTProjectController.h"

static NSString * const titleKey = @"title";
static NSString * const entriesKey = @"entries";

@interface TTProject ()

@property (nonatomic, strong) TTEntry *currentEntry;

@end

@implementation TTProject

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[titleKey];
        
        NSMutableArray *entries = [NSMutableArray new];
        for (NSDictionary *entry in dictionary[entriesKey]) {
            [entries addObject:[[TTEntry alloc] initWithDictionary:entry]];
            
        }
        
        _entries = entries;
    }
    return self;
    
}

- (NSDictionary *)projectDictionary {
    
    NSMutableArray *projectDictionary = [NSMutableDictionary new];
    if (self.title) {
        [projectDictionary setObject:self.title forKey:titleKey];
     
    }

    NSMutableArray *entries = [NSMutableArray new];
    for (TTEntry *entry in self.entries) {
        [entries addObject:[entry entryDictionary]];
    }
    [projectDictionary setObject:entries forKey:entriesKey];
    
    return projectDictionary;
}

- (NSString *)projectTime {
    
    NSInteger totalHours = 0;
    NSInteger totalMinutes = 0;
    
    for (TTEntry *entry in self.entries) {
        
        NSTimeInterval distanceBetweenDates = [entry.endTime timeIntervalSinceDate:entry.startTime];
        
        double secondsInAnHour = 3600;
        NSInteger minutesBetweenDates = distanceBetweenDates / secondsInAnHour;
        
        double secondsInAMinute = 60;
        NSInteger hoursBetweenDates = (distanceBetweenDates - (hoursBetweenDates * secondsInAnHour)) / secondsInAMinute;
        
        totalHours += hoursBetweenDates;
        totalMinutes += minutesBetweenDates;
}

    NSString *hourString = totalHours < 10 ? [NSString stringWithFormat:@"0%ld", (long)totalHours] : [NSString stringWithFormat:@"%ld", (long)totalHours];
    
    NSString *minuteString = totalMinutes < 10 ? [NSString stringWithFormat:@"%ld", (long)totalMinutes] : [NSString stringWithFormat:@"%ld", (long)totalMinutes];
    
    return [NSString stringWithFormat:@"%@:%@", hourString, minuteString];
}

- (void)synchronize {
    
    [[TTProjectController sharedInstance] synchronize];
}

- (void)setEntries:(NSArray *)entries {
    _entries = entries;
    
    [self synchronize];
}

- (void)startNewEntry {
    
    TTEntry *entry = [TTEntry new];
    entry.startTime = [NSDate date];
    
    self.currentEntry = entry;
    
    [self addEntry:entry];
}

- (void)endCurrentEntry {
    
    self.currentEntry.endTime = [NSDate date];
    [self synchronize];
}

- (void)addEntry:(TTEntry *)entry {
    
    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
    [mutableEntries addObject:entry];
    
    self.entries = mutableEntries;
}


- (void)removeEntry:(TTEntry *)entry {
    
    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = self.entries.mutableCopy;
    [mutableEntries removeObject:entry];
    
    self.entries = mutableEntries;
    
}


@end