//  Created by Alexander Skorulis on 22/03/2015.
//  Copyright (c) 2015 com.skorulis. All rights reserved.

#import "EchoSocket.h"
#import <SRWebSocket.h>

//static NSString* const kServerAddress = @"ws://192.168.1.2:9000/echo";
static NSString* const kServerAddress = @"ws://peaceful-hollows-7806.herokuapp.com/echo";

@interface EchoSocket () <SRWebSocketDelegate> {
    SRWebSocket* _webSocket;
}

@end

@implementation EchoSocket

- (instancetype) init {
    self = [super init];
    [self connectSocket];
    return self;
}

- (void) connectSocket {
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:kServerAddress]];
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:request];
    _webSocket.delegate = self;
    [_webSocket open];
}

#pragma mark SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {

}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Web socket opened");
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"Web socket error %@",error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"Web socket closed");
}



@end
