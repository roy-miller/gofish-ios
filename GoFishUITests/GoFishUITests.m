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

- (void)testLoginViewWithSuccess {
    [self loginWith:@"roy.miller@rolemodelsoftware.com" withPassword:@"testpass1"];
    XCTAssertTrue([self.app.staticTexts[@"Pick a number of opponents"] exists]);
}

- (void)testLoginViewWithFailure {
    [self loginWith:@"doesnot@exist.com" withPassword:@"irrelevant"];
    XCTAssertEqualObjects(@"Invalid email or password'", [self.app.staticTexts[@"loginErrorId"] label]);
}

- (void)testSetupViewWithTwoPlayers {
    [self loginWith:@"roy.miller@rolemodelsoftware.com" withPassword:@"testpass1"];
    [self.app.pickerWheels.element adjustToPickerWheelValue:@"1"];
    
    XCUIElement *playButton = self.app.buttons[@"Play"];
    [playButton tap];
    
    XCTAssertTrue([self.app.alerts[@"Waiting for players"] exists]);
}

@end


//BOOL keyboardShowing = [self.app.keyboards elementBoundByIndex:0].exists;
//NSLog(@"keyboardShowing = %hhd", keyboardShowing);
//[self.app.buttons[@"Hide keyboard"] tap];
//NSLog(@"keyboardShowing = %hhd", keyboardShowing);
//[self.app.buttons[@"Hide keyboard"] tap];