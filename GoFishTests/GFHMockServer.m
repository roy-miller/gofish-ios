//
//  GFHURLTestHelper.m
//  GoFish
//
//  Created on 12/18/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHMockServer.h"
#import "GFHRepository.h"
#import <OHHTTPStubs/OHHTTPStubs.h>

static GFHMockServer *_sharedHelper;

static NSString * const USERNAME_KEY = @"username";
static NSString * const PASSWORD_KEY = @"password";

@implementation GFHMockServer

+ (GFHMockServer *)sharedServer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHelper = [self new];
    });
    return _sharedHelper;
}

- (void)mockAuthenticationResponse {
    [self mockAuthenticationResponseWithUsername:@"roy.miller@rolemodelsoftware.com" withPassword:@"testpass1"];
}

- (void)mockAuthenticationResponseWithUsername:(NSString *)email withPassword:(NSString *)password {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return [request.URL.relativePath rangeOfString:@"/api/authenticate"].location != NSNotFound;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        if ([self matchesBasicAuthCredentials:request withUsername:email withPassword:password]) {
            return [self JSONResponseWithStatus:200 body:@{
                                                           @"user": @{
                                                                   @"username": email,
                                                                   @"authentication_token": @"uniquetoken123"
                                                                   }
                                                           }];
        } else {
            return [self JSONResponseWithStatus:401 body:@{
                                                           @"error": @"Invalid username or password"
                                                           }];
        }
    }];
}

- (BOOL)matchesBasicAuthCredentials:(NSURLRequest *)request withUsername:(NSString *)username withPassword:(NSString *)password {
    NSString *encoded = [request allHTTPHeaderFields][@"Authorization"];
    NSData *dataToDecode = [[NSData alloc] initWithBase64EncodedString:[encoded substringFromIndex:6] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decoded = [[NSString alloc] initWithData:dataToDecode encoding:NSUTF8StringEncoding];
    NSArray *components = [decoded componentsSeparatedByString:@":"];
    NSString *requestUsername = components[0];
    NSString *requestPassword = components[1];

    return [username isEqual:requestUsername] && [password isEqual:requestPassword];
}

- (void)mockCreateMatchResponse {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return [request.URL.relativePath rangeOfString:@"/api/create"].location != NSNotFound;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        return [self JSONResponseWithStatus:200 body:@{}];
    }];
}

- (void)mockShowMatchResponse {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return ([request.URL.relativePath rangeOfString:@"/api/matches"].location != NSNotFound &&
                [request.HTTPMethod isEqualToString:@"GET"]);
        //return [request.URL.relativePath rangeOfString:@"/api/matches/\\d+" options:NSRegularExpressionSearch].location != NSNotFound;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"match_json_fixture" ofType:@"json"];
        return [OHHTTPStubsResponse responseWithFileAtPath:path statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
}

- (void)mockUpdateMatchResponse {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return ([request.URL.relativePath rangeOfString:@"/api/matches"].location != NSNotFound &&
                [request.HTTPMethod isEqualToString:@"PATCH"]);
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        return [self JSONResponseWithStatus:200 body:@{}];
    }];
}

- (OHHTTPStubsResponse *)JSONResponseWithStatus:(int)status body:(id)body {
    NSData *data = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:NULL];
    return [OHHTTPStubsResponse responseWithData:data statusCode:status headers:@{@"Content-Type": @"application/json"}];
}

- (void)resetMocks {
    [OHHTTPStubs removeAllStubs];
}

@end