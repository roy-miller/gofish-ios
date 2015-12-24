//
//  RespositoryTests.m
//  GoFish
//
//  Created by Roy Miller on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "URLMock/URLmock.h"
#import "GFHMockServer.h"
#import "User.h"

@interface GFHRepository()
@property (nonatomic, strong) GFHDatabase *database;
@end

@interface RespositoryTests : XCTestCase
@property (nonatomic, strong) GFHRepository *repository;
@property (nonatomic, strong) NSString *validUsername;
@property (nonatomic, strong) NSString *validPassword;
@property (nonatomic, strong) NSString *validToken;
@end

@implementation RespositoryTests

- (void)setUp {
    [super setUp];
    self.repository = [GFHRepository new];
    self.repository.database = [GFHDatabase new];
    self.validUsername = @"roy.miller@rolemodelsoftware.com";
    self.validPassword = @"testpass1";
    self.validToken = @"uniquetoken123";
}

- (void)tearDown {
    [[GFHMockServer sharedServer] resetMocks];
    [super tearDown];
}

- (void)testLoginWithGoodUserInfo {
    [[GFHMockServer sharedServer] mockAuthenticationResponseWithUsername:self.validUsername withPassword:self.validPassword];
    XCTestExpectation *expectation = [self expectationWithDescription:@"login with good creds"];

    [self.repository loginWithUsername:self.validUsername password:self.validPassword success:^{
        XCTAssert(self.repository.database.user != nil);
        [expectation fulfill];
    } failure:nil];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void)testLoginWithBadUserInfo {
    [[GFHMockServer sharedServer] mockAuthenticationResponse];
    XCTestExpectation *expectation = [self expectationWithDescription:@"login with bad creds"];
    [self.repository loginWithUsername:@"doesnot@exist.com" password:@"invalid" success:nil failure:^{
        XCTAssert(self.repository.database.user == nil);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void) testStartMatchWithoutEnoughPlayers {
    [[GFHMockServer sharedServer] mockCreateMatchResponse];
    XCTestExpectation *expectation = [self expectationWithDescription:@"start without enough players"];
    [self.repository startMatchWithNumberOfOpponents:1 success:^{
        [expectation fulfill];
    } failure:^{
        XCTFail(@"api call to start match failed");
    }];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void) testStartMatchWithEnoughPlayers {
    [[GFHMockServer sharedServer] mockCreateMatchResponse];
    XCTestExpectation *expectation = [self expectationWithDescription:@"start with enough players"];
    [self.repository startMatchWithNumberOfOpponents:1 success:^{
        [expectation fulfill];
    } failure:^{
        XCTFail(@"api call to start match failed");
    }];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void)testLoadingMatchPerspective {
    [[GFHMockServer sharedServer] mockShowMatchResponse];
    self.repository.matchId = @1;
    XCTestExpectation *expectation = [self expectationWithDescription:@"load MatchPerspective"];
    [self.repository loadMatchPerspectiveWithSuccess:^{
        XCTAssert(self.repository.database.matchPerspective != nil);
        [expectation fulfill];
    } failure:nil];
    
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void)testUpdatingMatch {
    [[GFHMockServer sharedServer] mockUpdateMatchResponse];
    self.repository.matchId = @1;
    XCTestExpectation *expectation = [self expectationWithDescription:@"load MatchPerspective"];
    [self.repository updateMatchWithSuccess:^{
        [expectation fulfill];
    } failure:^{
        XCTFail(@"api call to update match failed");
    }];
    
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

@end
