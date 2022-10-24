# Copyright (C) 2022 Alexandre Umpierre
#
# This file is part of mccabe-thiele toolbox.
# mccabe-thiele toolbox is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU General Public License (GPL) version 3
# as published by the Free Software Foundation.
#
# mccabe-thiele toolbox is distributed in the hope
# that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the
# GNU General Public License along with this program
# (license GNU GPLv3.txt).
# It is also available at https://www.gnu.org/licenses/.

function [N,x,y]=stages_updown(f,X,R)
    # Syntax:
    #
    # [N,x,y]=stages_updown(f,X,R)
    #
    # stages_updown computes the number of
    #  theoretical stages of equilibrium of
    #  a distillation column using the
    #  McCabe-Thiele method, strating from
    #  the top to the bottom of the column.
    # stages_updown is an auxiliary function of
    #  the mccabe-thiele toolbox.
    xD=X(1);
    xF=X(2);
    xB=X(3);
    xi=X(4);
    yi=X(5);
    x=[xD];
    y=[xD];
    while x(end)>xB
        foo=@(x) (f(x)-y(end));
        x=[x;bissection(foo,0,1)];
        if x(end)>xi
            y=[y;R/(R+1)*x(end)+xD/(R+1)];
        else
            y=[y;(xB-yi)/(xB-xi)*(x(end)-xB)+xB];
        end
    end
    N=length(x)-1-1+(x(end-1)-xB)/(x(end-1)-x(end));
end
