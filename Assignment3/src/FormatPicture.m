function FormatPicture( varargin )

% FormatPicture: formats your 3D image for a meaningful display. Arguments:
%- none --> selects arbitrary view
%- a vector with 2 elements --> vector provides azimuth and elevation of
%  the point of view (uses "view" Matlab function)
%- 2 vectors with 3 elements --> 1st vector provides point where the
%"camera" is aiming, 2nd vector provides position of the camera


    set(gca,'visible','off');
    set(gca,'xtick',[],'ytick',[],'ztick',[]);

    % Add lights
    DL = 30;

    light('Position',DL*[1;0;-1]);
    light('Position',DL*[1;0;0]);
    light('Position',DL*[0;0;1]);

    axis equal

    % Some 3D options
    if length(varargin) == 0
        camproj('perspective')
        camtarget([12;0;4])
        campos(0.5*[84.3730  -15.8696   39.5314])
        camva(20)
    end
    if length(varargin) == 1
        view(varargin)
    end
    if length(varargin) > 1
        camproj('perspective')
        camtarget(varargin{1})
        campos(varargin{2})
        camva(20)
    end
    drawnow


end

