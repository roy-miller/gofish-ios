//
//  GFHDatabase.h
//  GoFish
//
//  Created by Roy Miller on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@class MatchPerspective;

@interface GFHDatabase : NSObject

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, strong) MatchPerspective *matchPerspective;
@property (nonatomic, strong) User *user;

+ (instancetype)sharedDatabase;

@end
