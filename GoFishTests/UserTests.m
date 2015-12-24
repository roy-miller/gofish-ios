//
//  UserTests.m
//  GoFish
//
//  Created by Roy Miller on 12/18/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GFHDatabase.h"
#import "User.h"

@interface UserTests : XCTestCase
@property (nonatomic, strong) GFHDatabase *database;
@property (nonatomic, strong) NSDictionary *userAttributes;
@end

@implementation UserTests

- (void)setUp {
    [super setUp];
    self.database = [GFHDatabase new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNewWithAttributesInDatabase {
    NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"user_login_valid_json_fixture" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    User *user = [User newWithAttributes:responseObject inDatabase:self.database];
    XCTAssertEqual(responseObject[GFHUserKey][GFHUserEmailKey], user.email);
    XCTAssertEqual(responseObject[GFHUserKey][GFHUserTokenKey], user.token);
    XCTAssertEqual(responseObject[GFHUserKey][GFHUserExternalIdKey], user.externalId);
    XCTAssertEqual(self.database.user, user);
    
//    path = [[NSBundle bundleForClass:self.class] pathForResource:@"user_login_invalid_json_fixture" ofType:@"json"];
//    data = [[NSData alloc] initWithContentsOfFile:path];
//    responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//    user = [User newWithAttributes:responseObject inDatabase:self.database];
//    XCTAssertTrue(user.email == nil);
//    XCTAssertTrue(user.token == nil);
//    XCTAssertTrue(self.database.user == nil);
}

- (void)testLoggedIn {
    User *user = [User new];
    user.email = @"test@gofish.com";
    XCTAssertFalse([user loggedIn]);
    
    user.token = @"uniquetoken";
    XCTAssertTrue([user loggedIn]);
}

@end
