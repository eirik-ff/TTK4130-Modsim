function DrawStickSlip( state , col, FA  )

    FA = [FA,FA,1];
    EC = {'k','k','k'};
    scale = 1;

    %Cube
    vert{1} =   [ -1, -1, 0;  %1
                   1, -1, 0;  %2
                   1,  1, 0;  %3
                  -1,  1, 0;  %4
                  -1, -1, 2;  %5
                   1, -1, 2;  %6
                   1,  1, 2;  %7
                  -1,  1, 2]/2; %8

    fac{1} = [1 2 3 4;
              5 6 7 8;
              1 4 8 5;
              1 2 6 5;
              2 3 7 6;
              3 4 8 7];

     
    vert{2} = vert{1};fac{2} = fac{1};      
          
    Lrail = 15;

    %Rail
    a = 1;
    vert{3} = [-Lrail,-a,-0.1;
               -Lrail, a,-0.1;
                Lrail, a,-0.1;
                Lrail,-a,-0.1];
    fac{3} = [1,2,3,4];
        
    pos{1} = ones(length(vert{1}),1)*[state(1),0,0];
    pos{2} = ones(length(vert{2}),1)*[state(2),0,0]; 
    pos{3} = 0;
    
    Col = {0.3*ones(3,1),col,[0,0.2,0]};
    for k = 1:3
        h{k} = patch('faces',fac{k},'vertices',scale*vert{k}+pos{k});
        set(h{k},'FaceColor',Col{k},'edgecolor',EC{k},'facealpha',FA(k),'FaceLighting','gouraud','SpecularStrength',1,'Diffusestrength',0.5,'AmbientStrength',0.7,'SpecularExponent',5)
    end

       % Add lights
%     light('Position',[1 3 Lrail]);
%     light('Position',[-3 0 Lrail]);
    light('Position',[ 0 0 Lrail]);
    %light('Position',[-Lrail 0 Lrail]);
    hold off
    axis equal
    set(gca,'visible','off');
    set(gca,'xtick',[],'ytick',[],'ztick',[]);

    campos([0    20     10])
    camtarget([0,0,0])
    camva(30)
    camproj('perspective')


end

