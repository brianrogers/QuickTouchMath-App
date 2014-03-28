//
//  QuickTouchMath2_Tests.m
//  QuickTouchMath2 Tests
//
//  Created by Brian Rogers on 3/23/14.
//  Copyright (c) 2014 Brian Rogers. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuizData.h"

@interface QuickTouchMath2_Tests : XCTestCase

@end

@implementation QuickTouchMath2_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testQuizData
{
    NSLog(@"%lu",(unsigned long)[QuizData getAdditionQuestions].count);
    XCTAssertEqual([QuizData getAdditionQuestions].count, 167, @"Correct number of addition question fetched");
    XCTAssertNotEqual([QuizData getAdditionQuestions].count, 168, @"Correct number of addition question fetched");
    //subtraction
    XCTAssertEqual([QuizData getSubtractionQuestions].count, 90, @"Correct number of subtraction question fetched");
    XCTAssertNotEqual([QuizData getSubtractionQuestions].count, 168, @"Correct number of subtraction question fetched");
    //multiplication
    XCTAssertEqual([QuizData getMultiplicationQuestions].count, 169, @"Correct number of multiplication question fetched");
    XCTAssertNotEqual([QuizData getMultiplicationQuestions].count, 168, @"Correct number of multiplication question fetched");
    //division
    XCTAssertEqual([QuizData getDivisionQuestions].count, 156, @"Correct number of division question fetched");
    XCTAssertNotEqual([QuizData getDivisionQuestions].count, 168, @"Correct number of division question fetched");
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    
}

- (void)testEasyLevelQuestions
{
    [QuizData getAdditionQuestionsEasyLevel];
}

@end
