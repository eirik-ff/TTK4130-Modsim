function MakeFrame( offset, R, Scale, FS, SW, name, varargin )
%Draw reference frame:?
% - 1st argument is the frame origin
% - 2nd argument is the frame orientation (rotation matrix)
% - 3rd argument is the frame scale (cosmetic)
% - 4th argument is the thickness of the frame basis vectors
% - 5th argument is the labels of the frame basis vectors (pass '' for no label)
%

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

    E1 = offset+Scale*R(:,1);
    h{1} = mArrow3(offset,E1, 'stemWidth', 2*SW); 
    if length(name) > 0
        text(E1(1),E1(2),E1(3),['$$\textrm{',name,'}_1$$'],'verticalalignment','bottom','horizontalalignment','left','fontsize',FS,'interpreter','latex')
    end
    
    E2 = offset+Scale*R(:,2);
    h{2} = mArrow3(offset,E2, 'stemWidth', 2*SW); 
    if length(name) > 0
        text(E2(1),E2(2),E2(3),['$$\textrm{',name,'}_2$$'],'verticalalignment','bottom','horizontalalignment','right','fontsize',FS,'interpreter','latex')
    end
    
    E3 = offset+Scale*R(:,3);
    h{3} = mArrow3(offset,E3, 'stemWidth', 2*SW); 
    if length(name) > 0
        text(E3(1)-0.2,E3(2),E3(3),['$$\textrm{',name,'}_3$$'],'verticalalignment','bottom','horizontalalignment','right','fontsize',FS,'interpreter','latex')
    end
    
    for k = 1:3
        for propno = 1:numel(propertyNames)
            try
                set(h{k},propertyNames{propno},propertyValues{propno});
            catch
                disp(lasterr)
            end
        end
    end

end

