//
//  GFHRepository.h
//  GoFish
//
//  Created by Roy Miller on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@import AFNetworking;

typedef void (^EmptyBlock)();
typedef void (^BlockWithString)(NSString *);

extern NSString * const GFHBaseUrl;

@interface GFHRepository : AFHTTPSessionManager

//@property (nonatomic, strong) NSNumber *matchId;

+ (instancetype)sharedRepository;

- (void)loadMatchPerspectiveWithId:(NSNumber *)matchId success:(EmptyBlock)success failure:(EmptyBlock)failure;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(EmptyBlock)success failure:(EmptyBlock)failure;

- (void)startMatchWithNumberOfOpponents:(NSInteger)numberOfOpponents success:(EmptyBlock)success failure:(EmptyBlock)failure;

- (void)updateMatchWithId:(NSNumber *)matchId requestorId:(NSNumber *)requestorId requestedId:(NSNumber *)requestedId rank:(NSString *)rank success:(EmptyBlock)success failure:(EmptyBlock)failure;

- (id)serializeFailure:(NSError *)error;

@end