//
//  Constants.h
//  WLTest
//
//  Created by Jordan Perry on 8/18/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

#import <Foundation/Foundation.h>

// Communicates with pre-processor macros (since they aren't available in swift).
@interface Constants : NSObject

// The host used for api calls
+ (NSString *)host;

// The api key
+ (NSString *)apiKey;

@end
