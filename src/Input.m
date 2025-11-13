classdef Input < handle
    properties
         mode InputMode
         mod_mode 
         stream int8
         size (1, 2) int8
         path char
    end

    methods
        function inputObj = Input()
            inputObj.mode = InputMode.RAW;
            inputObj.stream = [];
            inputObj.size = [0 0];
        end

        function updateSize(inputObj)
            inputObj.size(1) = length(inputObj.stream);
            inputObj.size(2) = length(inputObj.stream)/8;
        end

        function updateContents(path, inputObj)
            arguments
                path string
                inputObj Input
            end
            
            fid = fopen(path, 'rb');

            if (fid ~= -1)
                inputObj.stream = fread(fid, "ubit1", 'b')';
                len = length(bin_stream);
                fprintf(1, "Read %s\nSize:\n   %d bits\n   %d bytes\n", path, len, len/8);
                fclose(fid);
            else 
                inputObj.stream = [];
                fprintf(2, "Error: the input file does not exist or could not be opened\n");
            end
        end

        % modulation vs source coding?
        % Implement BPSK and OOK
        % Is OOK even needed when dealing with binary data?
        function modulate(inputObj)
            inputObj.stream = [];
        end
    end
end