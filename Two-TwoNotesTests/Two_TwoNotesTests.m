//
//  Two_TwoNotesTests.m
//  Two-TwoNotesTests
//
//  Created by Jiang Zhou on 2/6/16.
//  Copyright © 2016 Jiang Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Notes.h"
#import "Note.h"

@interface Two_TwoNotesTests : XCTestCase
@property (strong, nonatomic) Note *note1;
@property (strong, nonatomic) Note *note2;
@property (strong, nonatomic) Notes *notes;

@end

@implementation Two_TwoNotesTests

- (void)setUp {
    [super setUp];
    self.note1 = [[Note alloc] initWithTitle:@"First note" detail:@"Here's some detail"];
    self.note2 = [[Note alloc] initWithTitle:@"Second note" detail:@"Here's some more detail"];
    self.notes = [[Notes alloc] initWithNotes:@[self.note1, self.note2]];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testGetNoteAtIndex {
    XCTAssertEqualObjects([self.notes getNoteAtIndex:0], self.note1,@"Unexpected item retrieved from getNoteAtIndex");
}

-(void)testAddNote {
    Note *note3 = [[Note alloc] initWithTitle:@"Third note" detail:@"Third note detail"];
    [self.notes addNote:note3];
    XCTAssertEqual(self.notes.notes.count, 3, @"Unexpected number of notes after addNote");
    XCTAssertEqualObjects(self.notes.notes.lastObject, note3, @"Unexpected last object after addNote");
}
-(void)testDeleteNoteAtIndex {
    [self.notes deleteNoteAtIndex:0];
    XCTAssertEqual(self.notes.notes.count, 1, @"Unexpected number of notes after deleteNoteAtIndex");
}
-(void)testMoveFromIndex {
    [self.notes moveFromIndex:0 toIndex:1];
    NSMutableArray *newOrderArray = [@[self.note2,self.note1] mutableCopy];
    XCTAssertEqualObjects(self.notes.notes, newOrderArray, @"Unexpected order of notes after testMoveFromIndex");
}


@end
