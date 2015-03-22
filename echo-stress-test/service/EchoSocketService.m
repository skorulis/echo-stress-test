//  Created by Alexander Skorulis on 22/03/2015.
//  Copyright (c) 2015 com.skorulis. All rights reserved.

#import "EchoSocketService.h"
#import "EchoSocket.h"

static NSInteger const kConcurrentOpens = 30;
static NSInteger const kMaxSockets = 1000;

@interface EchoSocketService () <EchoSocketDelegate> {
    NSMutableArray* _echoSockets;
}

@end

@implementation EchoSocketService

@dynamic avgPingTime;
@dynamic openingSockets;

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

- (void) addSocketsUpToMax {
    NSInteger required = kConcurrentOpens - self.openingSockets;
    required = MIN(required, kMaxSockets - _echoSockets.count);
    for(int i = 0; i < required; ++i) {
        [self addSocket];
    }
}

- (NSInteger) openingSockets {
    return _echoSockets.count - _openSockets;
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
    [self addSocketsUpToMax];
}

- (void) echoSocketDidClose:(EchoSocket*)socket {
    _openSockets--;
    [_echoSockets removeObject:socket];
}



@end
