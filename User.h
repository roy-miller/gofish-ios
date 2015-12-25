//
//  User.h
//  GoFishIOS
//
//  Created by Roy Miller on 12/24/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFHDatabase.h"

extern NSString * const GFHUserKey;
extern NSString * const GFHUserEmailKey;
extern NSString * const GFHUserTokenKey;
extern NSString * const GFHUserExternalIdKey;

@interface User : NSObject
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *externalId;

+ (instancetype)newWithAttributes:(NSDictionary *)attributes inDatabase:(GFHDatabase *)database;

- (BOOL)loggedIn;
@end
