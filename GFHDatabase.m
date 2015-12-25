//
//  GFHDatabase.m
//  GoFish
//
//  Created by Roy Miller on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHDatabase.h"
#import "User.h"
#import "MatchPerspective.h"

static GFHDatabase *_sharedDatabase;

@implementation GFHDatabase

+ (instancetype)sharedDatabase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDatabase = [self new];
    });
    return _sharedDatabase;
}

- (NSMutableArray *)players {
    if (!_players) {
        _players = [NSMutableArray new];
    }
    return _players;
}

@end
