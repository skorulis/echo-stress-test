//
//  ViewController.m
//  echo-stress-test
//
//  Created by Alexander Skorulis on 22/03/2015.
//  Copyright (c) 2015 com.skorulis. All rights reserved.
//

#import "ViewController.h"
#import "EchoSocketService.h"

@interface ViewController () {
    EchoSocketService* _echoService;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _echoService = [[EchoSocketService alloc] init];
}


@end
