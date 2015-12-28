//
//  GoFishUITests.m
//  GoFishUITests
//
//  Created by Roy Miller on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GoFishUITests : XCTestCase
@property (nonatomic, strong) XCUIApplication *app;
@end

@implementation GoFishUITests

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    self.app = [XCUIApplication new];
    [self.app launch];
}

- (void)tearDown {
    // teardown code here
    [super tearDown];
}

- (void)loginWith:(NSString *)email withPassword:(NSString *)password {
    XCUIElement *emailField = self.app.textFields[@"Email"];
    [emailField tap];
    [emailField typeText:email];
    
    XCUIElement *passwordField = self.app.secureTextFields[@"Password"];
    [passwordField tap];
    [passwordField typeText:password];
    
    XCUIElement *loginButton = self.app.buttons[@"Login"];
    [loginButton tap];
}

- (void)playWithOpponentCount:(NSNumber *)opponentCount {
    [self.app.pickerWheels.element adjustToPickerWheelValue:[NSString stringWithFormat:@"%@", opponentCount]];
    XCUIElement *playButton = self.app.buttons[@"Play"];
    [playButton tap];
}

- (void)testLoginSucceedsWithGoodCreds {
    [self loginWith:@"roy.miller@rolemodelsoftware.com" withPassword:@"testpass1"];
    XCTAssertTrue(self.app.staticTexts[@"Choose opponents:"].exists);
}

- (void)testLoginFailsWithBadCreds {
    [self loginWith:@"doesnot@exist.com" withPassword:@"irrelevant"];
    XCTAssertTrue(self.app.alerts[@"Invalid Login"].exists);
}

- (void)testItWaitsForRightNumberOfPlayers {
    [self loginWith:@"roy.miller@rolemodelsoftware.com" withPassword:@"testpass1"];
    [self playWithOpponentCount:@1];
    //XCTAssertTrue([self.app.alerts[@"alert TITLE, not message, which you can't test directly"] exists]);
    XCTAssert(self.app.alerts.element.staticTexts[@"Waiting for players..."].exists);
}

- (void)testItStartsMatchWithRobotOpponent {
    [self loginWith:@"roy.miller@rolemodelsoftware.com" withPassword:@"testpass1"];
    [self playWithOpponentCount:@1];
    XCUIElement *playerName = self.app.staticTexts[@"roymiller"];
    NSPredicate *exists = [NSPredicate predicateWithFormat:@"exists == true"];
    [self expectationForPredicate:exists evaluatedWithObject:playerName handler:nil];
    [self waitForExpectationsWithTimeout:8 handler:nil];
    XCTAssertTrue(playerName.exists);
}

- (void)testItUpdatesMatchStateWhenPlayerAsksForCards {
    [self loginWith:@"roy.miller@rolemodelsoftware.com" withPassword:@"testpass1"];
    [self playWithOpponentCount:@1];
    // can I reset timeout on MatchMaker in my request?
}

@end


//BOOL keyboardShowing = [self.app.keyboards elementBoundByIndex:0].exists;
//NSLog(@"keyboardShowing = %hhd", keyboardShowing);
//[self.app.buttons[@"Hide keyboard"] tap];
//NSLog(@"keyboardShowing = %hhd", keyboardShowing);
//[self.app.buttons[@"Hide keyboard"] tap];