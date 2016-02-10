//
//  NotesTableViewController.m
//  Two-TwoNotes
//
//  Created by Jiang Zhou on 2/9/16.
//  Copyright © 2016 Jiang Zhou. All rights reserved.
//

#import "NotesTableViewController.h"
#import "NoteTableViewCell.h"
#import "ViewController.h"


@interface NotesTableViewController ()
@property (strong, nonatomic) Note *noteToAdd;
@end


@implementation NotesTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote:)];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.title = @"Notes";

    [self.tableView registerClass:[NoteTableViewCell class] forCellReuseIdentifier:@"note"];

}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.noteToAdd && ![self.noteToAdd isBlank]) {
        [[Model sharedModel].notes addNote:self.noteToAdd];
    }
    self.noteToAdd = nil;
    
    [self.tableView reloadData];
    [[Model sharedModel] saveNotes];

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[Model sharedModel].notes count];
}

#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"note" forIndexPath:indexPath];
    
    Note *note = [[Model sharedModel].notes getNoteAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = note.detail;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Note *note = [[Model sharedModel].notes getNoteAtIndex:indexPath.row];
    ViewController *detailViewController = [[ViewController alloc] initWithNote:note];
    [self.navigationController pushViewController:detailViewController animated:YES];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    [[Model sharedModel].notes deleteNoteAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
               withRowAnimation:UITableViewRowAnimationFade];
    [[Model sharedModel] saveNotes];

}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[Model sharedModel].notes moveFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
    [[Model sharedModel] saveNotes];


}


-(void)addNote:(id)sender {
    self.noteToAdd = [[Note alloc] initWithTitle:@"" detail:@""];
    ViewController *detailViewController = [[ViewController alloc] initWithNote:self.noteToAdd];
    [self.navigationController pushViewController:detailViewController animated:YES];
}



@end
