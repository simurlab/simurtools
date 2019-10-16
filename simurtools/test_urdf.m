clear

% VR:
robotWorld = vrworld('robot_scene.wrl');
open(robotWorld);
rbt = importrobot('abb_irb_120d.urdf');
rbt.DataFormat = 'row';
n = vrinsertrobot(robotWorld,rbt);
vrdrawnow
view(robotWorld);


% simscape:
iiwaRBT = importrobot('abb_irb_120.urdf');
iiwaSM = smimport(iiwaRBT);