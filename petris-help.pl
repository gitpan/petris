#!/usr/bin/perl -w

# $Id: petris-help.pl,v 1.4 1999/03/13 12:49:37 root Exp root $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package help ;


my $HelpWin ; 
my $TextBox ;


sub help {
    package main ;

    # Set up the help window and some bindings to close it.
    $HelpWin = $Win->Toplevel() ; 
    $HelpWin->title( 'Petris Help' ) ;
    $HelpWin->protocol( "WM_DELETE_WINDOW", \&help::close ) ;
    $HelpWin->bind( '<q>',         \&help::close ) ;
    $HelpWin->bind( '<Alt-q>',     \&help::close ) ;
    $HelpWin->bind( '<Control-q>', \&help::close ) ;
    $HelpWin->bind( '<Escape>',    \&help::close ) ;

    # Set up the text widget.
    $TextBox = $HelpWin->Scrolled( 'Text', 
                    -background => 'white', 
                    -wrap       => 'word',
                    -scrollbars => 'e',
                    -width      => 80, 
                    -height     => 40,
                    )->pack( -fill => 'both', -expand => 'y' ) ;
    my $text = $TextBox->Subwidget( 'text' ) ;
    $text->configure( -takefocus => 1 ) ;
    $text->focus ;

    &help::text_tags ;

    # Print the help text.

    &help::title( "Petris Help\n" ) ;

    &help::body( "\n(Press " ) ;
    &help::code( "<Escape>" ) ;
    &help::body( " or " ) ;
    &help::code( "q" ) ;
    &help::body( " to close this help window, " ) ; 

    &help::body( " and scroll using the scrollbar, arrow keys or " ) ;
    &help::code( "<Page Up>" ) ;
    &help::body( " or " ) ;
    &help::code( "<Page Down>" ) ;
    &help::body( ".)\n" ) ; 

    &help::heading( "\nAim\n\n", 'heading' ) ;
    &help::body( 
  "This is a standard Tetris game. The aim is to gain the highest possible"
. " score.\n" 
    ) ;

    &help::heading( "\nPlay\n\n" ) ;
    &help::body( 
  "You must fit the dropping blocks together so as to completely fill rows."
. " Each filled row is removed from the board and the score is increased"
. " for every removed row. The dropping blocks can be moved from side to side"
. " and rotated - but they cannot overlap the edges or the blocks that have"
. " gone before. Game ends when you cannot place another block on the board.\n"
    ) ;

    &help::heading( "\nKeystrokes\n\n" ) ;
    &help::code( "s                   " ) ;
    &help::body( "Start a new game.\n" ) ;
    &help::code( "[SPACEBAR]          " ) ;
    &help::body( "Pause/resume the game.\n" ) ;
    &help::code( "o                   " ) ;
    &help::body( "Change the options.\n" ) ;
    &help::code( "a                   " ) ;
    &help::body( "About box.\n") ;
    &help::code( "[F1]                " ) ;
    &help::body( "Invoke this help window.\n" ) ;
    &help::code( "q                   " ) ;
    &help::body( "Quit the game.\n" ) ;
    &help::code( "[UP ARROW]    or k  " ) ;
    &help::body( "Rotate the block. (Resumes if paused.)\n" ) ;
    &help::code( "[DOWN ARROW]  or j  " ) ;
    &help::body( "Drop the block immediately. (Resumes if paused.)\n" ) ;
    &help::code( "[LEFT ARROW]  or h  " ) ;
    &help::body( "Move the block left. (Resumes if paused.)\n" ) ;
    &help::code( "[RIGHT ARROW] or l  " ) ;
    &help::body( "Move the block right. (Resumes if paused.)\n" ) ;
    &help::body( "\nThere are more keystrokes which provide these commands - see " ) ;
    &help::code( "$RealBin/petris-keys.pl" ) ;
    &help::body( " for full details.\n" ) ;

    &help::heading( "\nOptions\n\n", 'heading' ) ;
    &help::body( "Options should be set using the Options dialogue.\n\n" ) ;
    &help::body( "User options are stored in " ) ;
    &help::code( "$Const{OPTS_FILE}" ) ; 
    &help::body(  
  ". Any options you change"
. " in this file take precedence over the default options. To reinstate"
. " a default option delete or comment out (with ",
    ) ;
    &help::code( "#" ) ;
    &help::body( 
  ") the option(s) you"
. " wish to reinstate - the next time you run the game the defaults"
. " will be back.\n"
    ) ;

    &help::heading( "\nCopyright\n\n" ) ;
    &help::code( "petris v $VERSION.\n\n" ) ;
    &help::body( "Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.\n" ) ;
    &help::body( "Petris may be used/distributed under the same terms as Perl.\n" ) ;
    &help::body( 
  "\nPetris is a clone of Tetris which was invented by Alexey"
. " Paszhitnov, Dmitry Pavlovsky and Vadim Gerasimov."
    ) ;

    $text->configure( -state => 'disabled' ) ;
    &window_centre( $HelpWin ) ;
}


sub title {
    $TextBox->insert( 'end', shift, 'title' ) ;
}


sub heading {
    $TextBox->insert( 'end', shift, 'heading' ) ;
}


sub body {
    $TextBox->insert( 'end', shift, 'body' ) ;
}


sub code {
    $TextBox->insert( 'end', shift, 'code' ) ;
}


sub text_tags {

    # Set up some text styles for the help text. If any fonts are not
    # available or are missing we ignore the fact.
    eval {
        $TextBox->tagConfigure( 'title',
            -font    => "-*-helvetica-bold-r-normal-*-*-240-*-*-*-*-*",
            -justify => 'center',
            ) ;
    } ;
    $TextBox->tagConfigure( 'title', -foreground => 'darkblue' ) ;

    eval {
        $TextBox->tagConfigure( 'heading',
        -font => "-*-helvetica-bold-r-normal-*-*-180-*-*-*-*-*" 
        ) ;
    } ;
    $TextBox->tagConfigure( 'heading', -foreground => 'darkgreen' ) ;

    eval {
        $TextBox->tagConfigure( 'body',
        -font => "-*-times-medium-r-normal-*-*-180-*-*-*-*-*" 
        ) ;
    } ;

    eval {
        $TextBox->tagConfigure( 'code',
        -font => "-*-lucidatypewriter-medium-r-normal-*-*-140-*-*-*-*-*" 
        ) ;
    } ;
    $TextBox->tagConfigure( 'code', -font => 'fixed' ) if $@ ;
}
 

sub close {

    &board::status( 'Paused' ) ;
    $HelpWin->destroy ;
}


1 ;
