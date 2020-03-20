function [ output_args ] = DrawRectangle( pos, M, varargin )

    propertyNames = {'edgeColor','facealpha','FaceLighting','SpecularStrength','Diffusestrength','AmbientStrength','SpecularExponent'};
    propertyValues = {'k',0.5,'gouraud',1,0.5,0.7,5};    
 
    %% evaluate property specifications   
    for argno = 1:2:nargin-2
        switch varargin{argno}
            case 'color'
                propertyNames = {propertyNames{:},'facecolor'};
                propertyValues = {propertyValues{:},varargin{argno+1}};
            otherwise
                propertyNames = {propertyNames{:},varargin{argno}};
                propertyValues = {propertyValues{:},varargin{argno+1}};
        end

    end
    
    %% Body:
    vert       = [  -1, -1, -1;  %1
                     1, -1, -1;  %2
                     1,  1, -1;  %3
                    -1,  1, -1;  %4
                    -1, -1,  1;  %5
                     1, -1,  1;  %6
                     1,  1,  1;  %7
                    -1,  1,  1]; %8

    fac       = [ 1 2 3 4;
                  5 6 7 8;
                  1 4 8 5;
                  1 2 6 5;
                  2 3 7 6;
                  3 4 8 7];

    h = patch('faces',fac,'vertices',vert*M.' + (ones(length(vert),1)*pos.'));
    
    for propno = 1:numel(propertyNames)
        try
            set(h,propertyNames{propno},propertyValues{propno});
        catch
            disp(lasterr)
        end
    end    
end

