#!/usr/bin/perl -w

# $Id: petris-board-commands.pl,v 1.1 1999/01/23 13:03:25 root Exp $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package board ;


sub create {
    package main ;

    $Board{CANVAS}->delete( 'all' ) ;
    
    $Board{CANVAS}->configure(
        -width  => $Opt{BOARD_SQUARES_X} * $Opt{BOARD_SQUARE_LENGTH},
        -height => $Opt{BOARD_SQUARES_Y} * $Opt{BOARD_SQUARE_LENGTH},
        ) ; 

    for( my $x = 0 ; $x < $Opt{BOARD_SQUARES_X} ; $x++ ) {
        for( my $y = 0 ; $y < $Opt{BOARD_SQUARES_Y} ; $y++ ) {
            $Board{SQUARES}[$x][$y]{SQUARE} = $Board{CANVAS}->create(
                'rectangle', 
                ( $x * $Opt{BOARD_SQUARE_LENGTH} ),
                ( $y * $Opt{BOARD_SQUARE_LENGTH} ),
                ( $x * $Opt{BOARD_SQUARE_LENGTH} ) + $Opt{BOARD_SQUARE_LENGTH},
                ( $y * $Opt{BOARD_SQUARE_LENGTH} ) + $Opt{BOARD_SQUARE_LENGTH},
                -fill    => $Const{BOARD_BACKGROUND_COLOUR},
                -outline => $Const{BOARD_OUTLINE_COLOUR},
                -tag     => 'BOARD',
                ) ;
            $Board{SQUARES}[$x][$y]{TYPE}   = $BOARD ;
            $Board{SQUARES}[$x][$y]{COLOUR} = $Const{BOARD_BACKGROUND_COLOUR} ;
        }
    }

    $Board{CANVAS}->update ;
}


sub status {
    package main ;

    local $_ = shift ;

    s/ /\n/g ;
    $Board{STATUS}->configure( -text => $_ ) ;
    $Board{STATUS}->update ;
}


1 ;
