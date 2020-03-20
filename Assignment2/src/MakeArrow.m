function MakeArrow( offset, v,  FS, SW, name, varargin )
%Draw a vector:
% - 1st argument is the position of the vector starting point
% - 2nd argument is the vector (not the position of the second point)
% - 3rd argument is the fontsize for text
% - 4th argument is the arrow thickness
% - 5th argument is the text (pass '' for no text)


    Scale = 1;
    propertyNames = {'edgeColor','facealpha','FaceLighting','SpecularStrength','Diffusestrength','AmbientStrength','SpecularExponent'};
    propertyValues = {'none',0.5,'gouraud',1,0.5,0.7,5};    

    %% evaluate property specifications
    for argno = 1:2:nargin-6
        switch varargin{argno}
            case 'color'
                propertyNames = {propertyNames{:},'facecolor'};
                propertyValues = {propertyValues{:},varargin{argno+1}};
            otherwise
                propertyNames = {propertyNames{:},varargin{argno}};
                propertyValues = {propertyValues{:},varargin{argno+1}};
        end

    end 

    h = mArrow3(offset,offset + Scale*v , 'stemWidth', 2*SW); 
    text(offset(1)+Scale*v(1),offset(2)+Scale*v(2),offset(3)+Scale*v(3),name,'verticalalignment','bottom','horizontalalignment','right','fontsize',FS,'interpreter','latex','color',[0,0.5,0])

    for propno = 1:numel(propertyNames)
        try
            set(h,propertyNames{propno},propertyValues{propno});
        catch
            disp(lasterr)
        end
    end

    
end


