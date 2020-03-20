function DrawPendulum( x_disp, vert, fac, scale)
    FA = [1,0.7,1];
    EC = {'k','k','none'};
    pos{1} = ones(length(vert{1}),1)*[x_disp(1),0,0];
    pos{2} = ones(length(vert{2}),1)*[0,0,0]; 
    Col = {'r','b','k','g'};
    for k = 1:2
        h{k} = patch('faces',fac{k},'vertices',scale*vert{k}+pos{k});
        set(h{k},'FaceColor',Col{k},'edgecolor',EC{k},'facealpha',FA(k),'FaceLighting','gouraud','SpecularStrength',1,'Diffusestrength',0.5,'AmbientStrength',0.7,'SpecularExponent',5)
    end
    p_root = [x_disp(1);0;0];
    for k = 1:2
        try
            pos_m = ones(length(vert{3}),1)*x_disp(3*(k-1)+2:3*(k-1)+4).';
        catch
            keyboard
        end
        h{3} = patch('faces',fac{3},'vertices',scale*vert{3}+pos_m);
        set(h{3},'FaceColor',Col{3},'edgecolor',EC{3},'facealpha',FA(3),'FaceLighting','gouraud','SpecularStrength',1,'Diffusestrength',0.5,'AmbientStrength',0.7,'SpecularExponent',5)

        line([p_root(1),x_disp(3*(k-1)+2)],[p_root(2),x_disp(3*(k-1)+3)],[p_root(3),x_disp(3*(k-1)+4)],'color',[0.4,0.4,0.7],'linewidth',4)
        p_root = x_disp(3*(k-1)+2:3*(k-1)+4);
    end
    % Add lights
    light('Position',[1 3 2]);
    light('Position',[-3 0 3]);
    hold off
    axis equal
    set(gca,'visible','off');
    set(gca,'xtick',[],'ytick',[],'ztick',[]);
end