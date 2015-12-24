//
//  GFHURLTestHelper.h
//  GoFish
//
//  Created on 12/18/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFHMockServer : NSObject

+ (GFHMockServer *)sharedServer;
- (void)mockAuthenticationResponse;
- (void)mockAuthenticationResponseWithUsername:(NSString *)email withPassword:(NSString *)password;
- (void)mockCreateMatchResponse;
- (void)mockShowMatchResponse;
- (void)mockUpdateMatchResponse;
- (void)resetMocks;

@end