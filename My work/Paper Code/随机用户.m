figure('Color', 'white')
UserLocationX = randi(50, 1, 50);
UserLocationY = randi(50, 1, 50);
plot(UserLocationX, UserLocationY, '^', 'MarkerSize', 5, 'LineWidth', 3), hold on
AccessPointX = randi(50, 1, 8);
AccessPointY = randi(50, 1, 8);
plot(AccessPointX, AccessPointY, 'go', 'MarkerSize', 5, 'LineWidth', 4), hold on
BaseStationX = 25;
BaseStationY = 25;
plot(BaseStationX, BaseStationY, 'rs', 'MarkerSize', 5, 'LineWidth', 4), hold on, grid on, grid minor
% hleg = legend('User Location', 'Access Point', 'Base Station')
hleg = legend('用户位置', '接入点', '基站')
set(hleg, 'Location', 'NorthEastOutside')