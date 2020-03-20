function DrawBallAndBeam( x_disp, theta, vert, fac, xsim, Radius)

    FA = [1,0.7,1];
    EC = {'k','k','none'};

    pos = ones(length(vert{2}),1)*x_disp.';

    %Draw rail:
    R = [cos(theta)  0  sin(theta);
            0        1      0;
         -sin(theta) 0  cos(theta)];
     
    h{1} = patch('faces',fac{1},'vertices',vert{1}*R);
    h{2} = patch('faces',fac{2},'vertices',Radius*vert{2} + pos);


    Col = {'r','k'};
    for k = 1:2
        set(h{k},'FaceColor',Col{k},'edgecolor',EC{k},'facealpha',FA(k),'FaceLighting','gouraud','SpecularStrength',1,'Diffusestrength',0.5,'AmbientStrength',0.7,'SpecularExponent',5,'edgecolor','none')
    end

    %line([0,0],[-.5,.5],[0,0],'linewidth',2,'color','b')
    
        % Add lights
    light('Position',[1 3 2]);
    light('Position',[-3 0 3]);
    hold off
    axis equal

    set(gca,'visible','off');
    set(gca,'xtick',[],'ytick',[],'ztick',[]);

end

