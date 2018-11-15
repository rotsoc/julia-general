struct MyRange
    start
    stop
    step
end

function _MyRange(a::MyRange,i::Int)
    tmp = a.start + a.step*(i-1)
    if tmp > a.stop
        error("Index is out of bounds!")
    else
        return tmp
    end
end
