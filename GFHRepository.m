//
//  GFHRepository.m
//  GoFishIOS
//
//  Created by Roy Miller on 12/14/15.
//  Copyright ¬© 2015 RoleModel Software. All rights reserved.
//

#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "User.h"
#import "Player.h"
#import "MatchPerspective.h"

NSString * const GFHBaseUrl = @"http://localhost:3000";
static GFHRepository *_sharedRepository = nil;
static NSString * const PLAYERS_KEY = @"players";

@interface GFHRepository()
@property (nonatomic, strong) GFHDatabase *database;
@end

@implementation GFHRepository

+ (instancetype)sharedRepository {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRepository = [self new];
    });
    return _sharedRepository;
}

+ (instancetype)new {
    GFHRepository *repository = [[self alloc] initWithBaseURL:[NSURL URLWithString:GFHBaseUrl]];
    repository.database = [GFHDatabase sharedDatabase];
    repository.responseSerializer = [AFJSONResponseSerializer serializer];
    return repository;
}

- (void)startMatchWithNumberOfOpponents:(NSInteger)numberOfOpponents success:(EmptyBlock)success failure:(EmptyBlock)failure {
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Token token=\"%@\"", self.database.user.token] forHTTPHeaderField:@"Authorization"];
    [self POST:@"/api/create" parameters:@{@"number_of_opponents":@(numberOfOpponents)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if ([self responseStatusAccepted:task]) {
            
        }
        //[self loadMatchPerspectiveWithSuccess:nil failure:nil];
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *serverError = [self serializeFailure:error];
        if (failure) {
            failure(serverError[@"error"]);
        }
    }];
}
- (void)loadMatchPerspectiveWithSuccess:(EmptyBlock)success failure:(EmptyBlock)failure {
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Token token=\"%@\"", self.database.user.token] forHTTPHeaderField:@"Authorization"];
    [self GET:[NSString stringWithFormat:@"/api/matches/%@", self.matchId] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        if (responseObject) {
            [MatchPerspective newWithAttributes:responseObject inDatabase:self.database];
        }
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure();
        }
    }];
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password success:(EmptyBlock)success failure:(EmptyBlock)failure {
    [self.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    [self POST:@"/api/authenticate" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        [User newWithAttributes:responseObject inDatabase:self.database];
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *serverError = [self serializeFailure:error];
        if (failure) {
            failure(serverError[@"error"]);
        }
    }];
}

- (void)updateMatchWithSuccess:(EmptyBlock)success failure:(EmptyBlock)failure {
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Token token=\"%@\"", self.database.user.token] forHTTPHeaderField:@"Authorization"];
    [self PATCH:[NSString stringWithFormat:@"/api/matches/%@", self.matchId] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if (responseObject) {
            self.database.matchPerspective = [MatchPerspective newWithAttributes:responseObject inDatabase:self.database];
        }
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *serverError = [self serializeFailure:error];
        if (failure) {
            failure(serverError[@"error"]);
        }
    }];
}

- (BOOL)responseStatusCreated:(NSURLSessionDataTask *)task {
    return [self responseStatusCodeWithTask:task] == 202;
}

- (BOOL)responseStatusAccepted:(NSURLSessionDataTask *)task {
    return [self responseStatusCodeWithTask:task] == 201;
}

- (NSInteger)responseStatusCodeWithTask:(NSURLSessionDataTask *)task {
    return [(NSHTTPURLResponse *)task.response statusCode];
}

- (id)serializeFailure:(NSError *)error {
    NSError *serializeError;
    id errorResponseJSON = @{@"error": @"Unable to log in at this time."};
    NSData *errorResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
    if (errorResponse) {
        errorResponseJSON = [NSJSONSerialization JSONObjectWithData:errorResponse options:NSJSONReadingMutableContainers error:&serializeError];
    }
    if (serializeError) {
        NSLog(@"Could not serialize JSON response from server: %@", serializeError);
    }
    NSLog(@"login error: %@", error);
    return errorResponseJSON;
}

@end
