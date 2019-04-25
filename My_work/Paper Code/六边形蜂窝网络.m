clear;clc
rc=4;dy=2*rc;dx=rc*sqrt(3);
A=pi/3*[1:7];
rol=50;
cow=50;
colorsize=216;
        num=0;
for yk=[0:dy:100,0:-dy:-100];
    yfun=inline(['sqrt(3)*x/3+',num2str(yk)]);
    for xk=[0:dx:100,0:-dx:-100];
        xp=xk;
        yp=yfun(xp);

        if -rol<xp && xp<rol && -cow<yp && yp<cow;
           plot([xp+1i*yp]+rc*exp(1i*A)*2/sqrt(3),'k','linewidth',2);
            hold on;
            a=real([xp+1i*yp]+rc*exp(1i*A)*2/sqrt(3));
            b=imag([xp+1i*yp]+rc*exp(1i*A)*2/sqrt(3));
            fill(a(1:6),b(1:6),hsv2rgb([double(num/colorsize) 1 1]));

            text(xp,yp,num2str(num))

            num=num+1;

        end
    end
end
axis square 