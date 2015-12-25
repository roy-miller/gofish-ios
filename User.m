//
//  User.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/17/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "User.h"

NSString * const GFHUserKey = @"user";
NSString * const GFHUserEmailKey = @"email";
NSString * const GFHUserTokenKey = @"authentication_token";
NSString * const GFHUserExternalIdKey = @"id";

@implementation User

+ (instancetype)newWithAttributes:(NSDictionary *)attributes inDatabase:(GFHDatabase *)database {
    User *user = [User new];
    user.email = attributes[GFHUserKey][GFHUserEmailKey];
    user.token = attributes[GFHUserTokenKey];
    user.externalId = attributes[GFHUserExternalIdKey];
    database.user = user;
    return user;
}

- (BOOL)loggedIn {
    return self.token != nil;
}

@end
