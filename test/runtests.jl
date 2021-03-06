### file: Arithmetic/test/runtests.jl

## Copyright (c) 2015 Samuel B. Johnson

## Author: Samuel B. Johnson <sabjohnso@yahoo.com>

## This file is lincesed under a two license system. For commercial use
## that is not compatible with the GPLv3, please contact the author.
## Otherwise, continue reading below.

## This file is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3, or (at your option)
## any later version.

## You should have received a copy of the GNU General Public License
## along with this program. If not, see <http://www.gnu.org/licenses/>.

### Code:

using Arithmetic
using FactCheck


import Base.==
import Arithmetic.apply_unary, Arithmetic.apply_binary

type SimpleWrapper{ T } <: AbstractArithmetic
    value::T
end

==( a::SimpleWrapper, b::SimpleWrapper ) = a.value == b.value

apply_unary{ T }( f::Function, x::SimpleWrapper{ T } ) =
    SimpleWrapper( f( x.value ))

apply_binary{ T }( f::Function, x::SimpleWrapper{ T }, y::SimpleWrapper{ T }) =
    SimpleWrapper( f( x.value, y.value ))


facts( "Arithmetic" ) do
    
    @fact isArithmetic( "Hello, World" ) --> false
    @fact isArithmetic( typeof( "Hello, World!" )) --> false

    a = SimpleWrapper( 1 )

    @fact isArithmetic( a ) --> true
    @fact isArithmetic( typeof( a )) --> true
    @fact apply_unary( -, a ) --> SimpleWrapper( -a.value )
    @fact +a --> a
    @fact -a --> SimpleWrapper( -a.value )

    b = SimpleWrapper( 2 )

    @fact isArithmetic( b ) --> true
    @fact a+b --> SimpleWrapper( a.value + b.value )
    @fact a-b --> SimpleWrapper( a.value - b.value )
    @fact a*b --> SimpleWrapper( a.value * b.value )
    @fact a/b --> SimpleWrapper( a.value / b.value )
    @fact a^b --> SimpleWrapper( a.value ^ b.value )
    @fact a%b --> SimpleWrapper( a.value % b.value )
        
end
