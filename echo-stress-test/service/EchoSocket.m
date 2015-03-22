//  Created by Alexander Skorulis on 22/03/2015.
//  Copyright (c) 2015 com.skorulis. All rights reserved.

#import "EchoSocket.h"
#import <SRWebSocket.h>
@import QuartzCore;

//static NSString* const kServerAddress = @"ws://192.168.1.2:9000/echo";
static NSString* const kServerAddress = @"ws://peaceful-hollows-7806.herokuapp.com/echo";

@interface EchoSocket () <SRWebSocketDelegate> {
    SRWebSocket* _webSocket;
    NSTimer* _timer;
    NSString* _lastMessage;
    NSTimeInterval _lastMessageSent;
    NSTimeInterval _lastPingTime;
}

@end

@implementation EchoSocket

- (instancetype) initWithDelegate:(id<EchoSocketDelegate>)delegate {
    self = [super init];
    _delegate = delegate;
    [self connectSocket];
    return self;
}

- (void) connectSocket {
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:kServerAddress]];
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:request];
    _webSocket.delegate = self;
    [_webSocket open];
}

- (void) startTimer {
    _timer = [NSTimer timerWithTimeInterval:30.0
                                             target:self
                                           selector:@selector(sendPing)
                                           userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void) sendPing {
    _lastMessage = [self getRandomCharAsNString];
    _lastMessageSent = CACurrentMediaTime();
    [_webSocket send:_lastMessage];
}

- (NSString *)getRandomCharAsNString {
    return [NSString stringWithFormat:@"%c", arc4random_uniform(26) + 'a'];
}

#pragma mark SRWebSocketDelegate


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    _lastPingTime = CACurrentMediaTime() - _lastMessageSent;
    if(![_lastMessage isEqualToString:message]) {
        NSLog(@"Echo error %@ != %@",_lastMessage,message);
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Web socket opened");
    [self sendPing];
    [self startTimer];
    [_delegate echoSocketDidOpen:self];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"Web socket error %@",error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"Web socket closed");
    [_timer invalidate];
    [_delegate echoSocketDidClose:self];
}



@end
