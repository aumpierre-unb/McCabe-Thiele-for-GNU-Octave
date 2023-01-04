#  Copyright (C) 2022 2023 Alexandre Umpierre
#
# This file is part of mccabe-thiele toolbox for GNU Octave.
# mccabe-thiele toolbox for GNU Octave is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU General Public License (GPL) version 3
# as published by the Free Software Foundation.
#
# mccabe-thiele toolbox for GNU Octave is distributed in the hope
# that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the
# GNU General Public License along with this program
# (license GNU GPLv3.txt).
# It is also available at https://www.gnu.org/licenses/.

function [N,x,y]=stages_downup(f,X,R)
    # Syntax:
    #
    # [N,x,y]=stages_downup(f,X,R)
    #
    # stages_downup computes the number of
    #  theoretical stages of equilibrium of
    #  a distillation column using the
    #  McCabe-Thiele method, strating from
    #  the bottom to the top of the column.
    # stages_downup is an auxiliary function of
    #  the mccabe-thiele toolbox for GNU Octave.
    xD=X(1);
    xF=X(2);
    xB=X(3);
    xi=X(4);
    yi=X(5);
    x=[xB];
    y=[xB];
    while x(end)<xD
        y=[y;f(x(end))];
        if y(end)<yi
            x=[x;(y(end)-yi)/((xB-yi)/(xB-xi))+xi];
        else
            x=[x;(y(end)-xD/(R+1))*(R+1)/R];
        end
    end
    N=length(x)-1-1+(xD-x(end-1))/(x(end)-x(end-1));
end
