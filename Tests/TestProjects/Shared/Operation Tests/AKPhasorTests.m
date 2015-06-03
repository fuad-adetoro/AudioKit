//
//  AKPhasorTests.m
//  iOSObjectiveCAudioKit
//
//  Created by Aurelius Prochazka on 5/22/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import "AKTestCase.h"

#define testDuration 10.0

@interface TestPhasorInstrument : AKInstrument
@end

@implementation TestPhasorInstrument

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        AKPhasor *frequencyPhasor = [AKPhasor phasor];
        frequencyPhasor.frequency = akp(2);
        
        AKPhasor *phasor = [AKPhasor phasor];
        phasor.frequency = [[frequencyPhasor scaledBy:akp(110)] plus:akp(440)];
        
        [self setAudioOutput:phasor];
    }
    return self;
}

@end

@interface AKPhasorTests : AKTestCase
@end

@implementation AKPhasorTests

- (void)testPhasor
{
    // Set up performance
    TestPhasorInstrument *testInstrument = [[TestPhasorInstrument alloc] init];
    [AKOrchestra addInstrument:testInstrument];
    [testInstrument playForDuration:testDuration];
    
    // Render audio output
    NSString *outputFile = [self outputFileWithName:@"Phasor"];
    [[AKManager sharedManager] renderToFile:outputFile forDuration:testDuration];
    
    // Check output
    NSArray *validMD5s = @[@"14df22c359aa635b0b0188aa9e44e9f3",
                           @"cc51b66dbe340243722cfc91da47236b"];
    XCTAssertTrue([validMD5s containsObject:[self md5ForFile:outputFile]]);
}

@end
