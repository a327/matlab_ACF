mask = pkuReadMask('.\masks\mask_dongnanmen_1_1280x720_30_R1.jpg');
img = pkuImRead('E:\hy\obj_cpp\PKU2015\eval\dongnanmen_1_1280x720_30_2\pos\0000001.jpg',mask);
imshow(img);