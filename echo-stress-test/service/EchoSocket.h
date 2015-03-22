//  Created by Alexander Skorulis on 22/03/2015.
//  Copyright (c) 2015 com.skorulis. All rights reserved.

#import <Foundation/Foundation.h>

@class EchoSocket;

@protocol EchoSocketDelegate <NSObject>

- (void) echoSocketDidOpen:(EchoSocket*)socket;
- (void) echoSocketDidClose:(EchoSocket*)socket;

@end

@interface EchoSocket : NSObject

@property (nonatomic, weak, readonly) id<EchoSocketDelegate> delegate;
@property (nonatomic, readonly) NSTimeInterval lastPingTime;

- (instancetype) initWithDelegate:(id<EchoSocketDelegate>)delegate;

@end
