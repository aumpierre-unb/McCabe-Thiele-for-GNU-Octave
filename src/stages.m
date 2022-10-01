function N=stages(data,X,q,R,updown=true,fig=true)
    try
      data(0.5);
      f=@(x) data(x);
      dots=false;
    end
    try
      data+1;
      f=@(x) interp1(data(:,1),data(:,2),x);
      dots=true;
    end
    xD=X(1);
    xF=X(2);
    xB=X(3);
    xi=(xD/(R+1)+xF/(q-1))/(q/(q-1)-R/(R+1));
    yi=q/(q-1)*xi-xF/(q-1);
    X=[xD xF xB xi yi];
    if updown
        [N,x,y]=stages_updown(f,X,R);
    else
        [N,x,y]=stages_downup(f,X,R);
    end
    if fig
        doplots(dots,updown,f,x,y,data,X,q,R);
    end
end

#{
data=@(x) (x.^0.9.*(1-x).^1.08+x);
x=[0.88 0.55 0.11];
q=0.54;
Rmin=refmin(data,x,q)
R=2*Rmin;
N=stages(data,x,q,R,false,false)
#}

#{
data=[0.  0.;
      0.1 0.212;
      0.2 0.384;
      0.3 0.529;
      0.4 0.651;
      0.5 0.752;
      0.6 0.833;
      0.7 0.895;
      0.8 0.942;
      0.9 0.974;
      1.  1.];
x=[0.88 0.55 0.11];
q=0.54;
Rmin=refmin(data,x,q)
R=2*Rmin;
N=stages(data,x,q,R)
#}

