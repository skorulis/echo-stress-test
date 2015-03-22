//  Created by Alexander Skorulis on 22/03/2015.
//  Copyright (c) 2015 com.skorulis. All rights reserved.

#import <Foundation/Foundation.h>

@interface EchoSocketService : NSObject

@property (nonatomic, readonly) NSInteger openSockets;
@property (nonatomic, readonly) NSTimeInterval avgPingTime;

@end
