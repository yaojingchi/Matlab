function s = image_states(f)
    s.dm = size(f);
    s.AI = mean2(f);
    s.AIrows = mean(f,2);
    s.AIclos = mean(f,1);