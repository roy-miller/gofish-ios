//
//  Player.h
//  GoFish
//
//  Created by Roy Miller on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GFHDatabase;

@interface Player : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSNumber *externalId;

+ (instancetype)newWithAttributes:(NSDictionary *)attributes;

@end