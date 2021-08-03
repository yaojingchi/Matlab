function countfcn = makecounter(initvalue)
    %MAKECOUNTER Used by NESTEDDEMO
    currentCount = initvalue;
    countfcn = @getCounter;

    function count = getCounter
    currentCount = currentCount +1;
    count = currentCount;
    end
end