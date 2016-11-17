% cleanup.m
% consolidate startx, starty, vectx and vecty into a nicer format

startxc = zeros(12, 50);
startyc = zeros(12, 50);
vectxc = zeros(20, 12, 50); % frames, dots, movies
vectyc = zeros(20, 12, 50);
maxxc = zeros(12, 50);
maxyc = zeros(12, 50);

for movie = 1:50
    for dot = 1:12
        initx = -10000;
        inity = -10000;
        for frame = 1:20
            xval = startx(1, dot, movie) + vectx(frame, dot, movie);
            if (xval > 100) & (xval < 500)
                if initx == -10000
                    initx = xval - 320;
                end
                vectxc(frame, dot, movie) = xval - 320 - initx;
                if abs(vectxc(frame, dot, movie)) > abs(maxxc(dot, movie))
                    maxxc(dot, movie) = vectxc(frame, dot, movie);
                end
            else
                vectxc(frame, dot, movie) = -10000;
            end
            
            yval = starty(1, dot, movie) + vecty(frame, dot, movie);
            if (yval > 100) & (yval < 500)
                if inity == -10000
                    inity = yval - 240;
                end
                vectyc(frame, dot, movie) = yval - 240 - inity;
                if abs(vectyc(frame, dot, movie)) > abs(maxyc(dot, movie))
                    maxyc(dot, movie) = vectyc(frame, dot, movie);
                end
            else
                vectyc(frame, dot, movie) = -10000;
            end
        end
        if initx == -10000
            initx = 0;
        end
        startxc(dot, movie) = initx;
        if inity == -10000
            inity = 0;
        end
        startyc(dot, movie) = inity;
    end
end
