//  Created by Alexander Skorulis on 22/03/2015.
//  Copyright (c) 2015 com.skorulis. All rights reserved.

#import "EchoSocketService.h"
#import "EchoSocket.h"

@interface EchoSocketService () <EchoSocketDelegate> {
    NSMutableArray* _echoSockets;
    
}

@end

@implementation EchoSocketService

@dynamic avgPingTime;

- (instancetype) init {
    self = [super init];
    _echoSockets = [[NSMutableArray alloc] init];
    [self addSocket];
    return self;
}

- (void) addSocket {
    EchoSocket* socket = [[EchoSocket alloc] initWithDelegate:self];
    [_echoSockets addObject:socket];
}

- (NSTimeInterval) avgPingTime {
    NSTimeInterval time = 0;
    NSInteger total = 0;
    for(EchoSocket* socket in _echoSockets) {
        if(socket.lastPingTime > 0) {
            time += socket.lastPingTime;
            total ++;
        }
    }
    if(total == 0) {
        return 0;
    }
    return time / total;
}

#pragma mark EchoSocketDelegate

- (void) echoSocketDidOpen:(EchoSocket*)socket {
    _openSockets++;
    [self addSocket];
}

- (void) echoSocketDidClose:(EchoSocket*)socket {
    _openSockets--;
}



@end
