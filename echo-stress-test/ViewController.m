//
//  ViewController.m
//  echo-stress-test
//
//  Created by Alexander Skorulis on 22/03/2015.
//  Copyright (c) 2015 com.skorulis. All rights reserved.
//

#import "ViewController.h"
#import "EchoSocketService.h"
#import <Masonry/Masonry.h>

@interface ViewController () {
    EchoSocketService* _echoService;
    UILabel* _socketCount;
    UILabel* _pingLabel;
    CADisplayLink* _displayLink;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _echoService = [[EchoSocketService alloc] init];
    
    _socketCount = [[UILabel alloc] init];
    [self.view addSubview:_socketCount];
    
    _pingLabel = [[UILabel alloc] init];
    [self.view addSubview:_pingLabel];
    
    [self buildLayout];
    [self startDisplayLink];
}

- (void) buildLayout {
    [_socketCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    [_pingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_socketCount.mas_bottom).with.offset(20);
        make.centerX.equalTo(_socketCount);
    }];
}

- (void) startDisplayLink {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateText:)];
    _displayLink.frameInterval = 1/30;
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void) updateText:(CADisplayLink*)sender {
    _socketCount.text = [NSString stringWithFormat:@"sockets: %ld",(long)_echoService.openSockets];
    _pingLabel.text = [NSString stringWithFormat:@"avg ping: %.2f",_echoService.avgPingTime];
}

@end
