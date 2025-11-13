classdef Input < handle
    properties
         mode InputMode
         stream int8
         size (1, 2) int8
    end

    methods
        function inputObj = Input
            inputObj.mode = InputMode.RAW;
            inputObj.stream = [];
            inputObj.size = [0 0];
        end

        function updateSize(inputObj)
            inputObj.size(1) = length(inputObj.stream);
            inputObj.size(2) = length(inputObj.stream)/8;
        end
    end
end