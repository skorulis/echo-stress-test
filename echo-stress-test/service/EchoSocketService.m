//  Created by Alexander Skorulis on 22/03/2015.
//  Copyright (c) 2015 com.skorulis. All rights reserved.

#import "EchoSocketService.h"
#import "EchoSocket.h"

@interface EchoSocketService () {
    NSMutableArray* _echoSockets;
}

@end

@implementation EchoSocketService

- (instancetype) init {
    self = [super init];
    _echoSockets = [[NSMutableArray alloc] init];
    [self addSocket];
    return self;
}

- (void) addSocket {
    EchoSocket* socket = [[EchoSocket alloc] init];
    [_echoSockets addObject:socket];
}

@end
