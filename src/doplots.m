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
    hold on;
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
    plot(X,Y,'--k');
    Y=R/(1+R)*X+xD/(1+R);
    plot(X,Y,'-.b','linewidth',1.2)
    plot([xD xD],[0 1],'--b');
    Y=(xB-yi)/(xB-xi)*(X-xi)+yi;
    plot(X,Y,'-.r','linewidth',1.2);
    plot([xB xB],[0 1],'--r');
    if q~=1-1e-10
        Y=q/(q-1)*X-xF/(q-1);
        plot(X,Y,'-.m','linewidth',1.2);
    end
    plot([xF xF],[0 1],'--m');
    if updown
        stairs(x,y,'g','color','#1D8B20');
    else
        stairs(flip(x),flip(y),'g','color','#1D8B20');
    end
    xlabel('{\itx}');
    ylabel('{\ity}');
    axis([0 1 0 1]);
    grid on;
    set(gca,'fontsize',14,'box','on');
    hold off;
end
