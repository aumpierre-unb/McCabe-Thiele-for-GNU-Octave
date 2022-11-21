# Copyright (C) 2022 Alexandre Umpierre
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

function doplots(dots,updown,f,x,y,data,X,q,R)
    # Syntax:
    #
    # doplots(dots,updown,f,x,y,data,X,q,R)
    #
    # doplots produces a x-y diagram with
    #  a representation of the theoretical stages of equilibrium
    #  computed for a distillation column using the
    #  McCabe-Thiele method.
    # doplots is an auxiliary function of
    #  the mccabe-thiele toolbox for GNU Octave.
    xD=X(1);
    xF=X(2);
    xB=X(3);
    xi=X(4);
    yi=X(5);
    figure;
    if dots
        X=data(:,1);
        Y=data(:,2);
        plot(X,Y,'-ok','linewidth',1.2);
    else
        X=linspace(0,1,101);
        Y=f(X);
        plot(X,Y,'k','linewidth',1.2);
    end
    X=[0;1];
    Y=X;
    hold on;plot(X,Y,'--k');
    Y=R/(1+R)*X+xD/(1+R);
    hold on;plot(X,Y,'-.b','linewidth',1.2)
    hold on;plot([xD xD],[0 1],'--b');
    Y=(xB-yi)/(xB-xi)*(X-xi)+yi;
    hold on;plot(X,Y,'-.r','linewidth',1.2);
    hold on;plot([xB xB],[0 1],'--r');
    if q~=1-1e-10
        Y=q/(q-1)*X-xF/(q-1);
        hold on;plot(X,Y,'-.m','linewidth',1.2);
    end
    hold on;plot([xF xF],[0 1],'--m');
    if updown
        hold on;stairs(x,y,'g');
    else
        hold on;stairs(flip(x),flip(y),'g');
    end
    xlabel('{\itx}');
    ylabel('{\ity}');
    axis([0 1 0 1]);
    grid on;
    set(gca,'fontsize',14);
end
