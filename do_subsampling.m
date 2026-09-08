clear all
close all
clc

%% (1) Find and remove stuck pixels (a set list)
% This section saves .csv files to the savePath of the cleaned stats of the
% particles (after particles have already been identified and original
% .csv's of the stats from that are saved in the basePath)
% These stuck pixels are not true particles, they appear in multiple images
% in the same locations.
basePath = 'stats/';
savePath = 'stats_cleaned/';

% For ease of iterating through files
filePattern = fullfile(basePath, '*.csv');
fileList = dir(filePattern);

if ~exist(savePath, 'dir')
    mkdir(savePath);
end

stuck = [117.875 3461.875; 513.5 1722; 657.6 3199.2; 741.75 2190.333; 795.8 345.6; ...
    989 3121.286; 1004 3392.5; 1018.903 2414.452; 1342.5 2123.5; 1923.833 231.1667;
    2139.4 3950.8; 2190.167 2605.167; 2213.857 234.4286; 2261.5 3977.5; 2537.5 3509.5; ...
    2592.5 1907.214; 2907.636 3674.909; 3121 1788; 3123 349.2857; 3188.667 1724.524; ... 
    3434 737.5; 3451 3961.714; 3996.5 867; 4070.833 3237.833; 2683.75 1475; ...
    1501.5 4058; 2335.5 3517.3; 2966 4030.5; 3386 959];

results = {};  % store results

for k = 1:length(fileList)
    baseFilename = fileList(k).name;
    % Special case here
    if ~endsWith(baseFilename, "-20.2.csv")
        continue
    end

    filename = fullfile(fileList(k).folder, baseFilename);
    fprintf('Processing file %d of %d: %s\n', k, length(fileList), filename);

    try
        T = readtable(filename);

        stuck_rows = false(height(T), 1);

        for i = 1:height(T)
            x = T.Centroid_1(i);
            y = T.Centroid_2(i);

            for s = 1:size(stuck, 1)
                if abs(x - stuck(s,1)) < 2 && abs(y - stuck(s,2)) < 2
                    stuck_rows(i) = true;
                    break;
                end
            end
        end

        original_count = height(T);

        % Remove stuck particles
        T(stuck_rows, :) = [];
        remaining_count = height(T);
        removed_count = original_count - remaining_count;

        % Print
        fprintf('cc%s → %d remaining (%d removed)\n', ...
            baseFilename, remaining_count, removed_count);

        % Save cleaned file
        newFilename = fullfile(savePath, baseFilename);
        writetable(T, newFilename);

        % Store results
        results(end+1, :) = {baseFilename, original_count, removed_count, remaining_count};

    catch ME
        fprintf('Error processing cc%s: %s\n', baseFilename, ME.message);
    end
end

% Convert to table
results_table = cell2table(results, ...
    'VariableNames', {'FileNumber', 'OriginalCount', 'Removed', 'Remaining'});

disp(results_table);


%% (2) Run subsampling across all samples, return subsampling errors
cleanPath = 'stats_cleaned/';

layout_strings_radial = ["ring3out","ring3in", ...
    "ring4out","ring4in", ...
    "ring5out","ring5in", ...
    "spiral_2t16b","spiral_3t25b","spiral_4t64b","spiral_5t100b"];

layout_strings_other = ["grid1","grid4","grid16", ...
    "wedge2","wedge4","wedge3", ...
    "strip1","strip2","strip4", ...
    "random4","random16","random25","random64","random100"];

stuck = [117.875 3461.875; 513.5 1722; 657.6 3199.2; 741.75 2190.333; 795.8 345.6; ...
            989 3121.286; 1004 3392.5; 1018.903 2414.452; 1342.5 2123.5; 1923.833 231.1667;
            2139.4 3950.8; 2190.167 2605.167; 2213.857 234.4286; 2261.5 3977.5; 2537.5 3509.5; ...
            2592.5 1907.214; 2907.636 3674.909; 3121 1788; 3123 349.2857; 3188.667 1724.524; ... 
            3434 737.5; 3451 3961.714; 3996.5 867; 4070.833 3237.833; 2683.75 1475; ...
            1501.5 4058; 2335.5 3517.3; 2966 4030.5; 3386 959];

imgPath = 'masks/';

results = {};

for f = 5:57
    for sub = [1, 2]

        fname_base = sprintf('cc%d.%d-20.2c.PNG', f, sub);
        img_file = fullfile(imgPath, fname_base);

        if ~isfile(img_file)
            continue;
        end

        I = imread(img_file);
        fprintf('Processing: %s\n', img_file);

        % File with true MP counts
        csv_name = sprintf('cc%d.%d-20.2.csv', f, sub);
        T_true = readtable(fullfile(cleanPath, csv_name));
        true_MP_count = height(T_true);

        % Rings / Spirals (single config)
        for i = 1:length(layout_strings_radial)

            layout = imread(['layouts/' char(layout_strings_radial(i)) '.PNG']);

            stats_subsampled = run_subsampling(I, layout, stuck);

            mp_sserror = size(stats_subsampled,1) * 4 / true_MP_count * 100;

            results(end+1,:) = {csv_name, layout_strings_radial(i), "ring_spiral", mp_sserror};
        end

        % Everything else (config 2 only)
        for i = 1:length(layout_strings_other)

            layout = imread(['layouts/' char(layout_strings_other(i)) '_2.PNG']);

            stats_subsampled = run_subsampling(I, layout, stuck);

            mp_sserror = size(stats_subsampled,1) * 4 / true_MP_count * 100;

            results(end+1,:) = {csv_name, layout_strings_other(i), "other", mp_sserror};
        end

    end
end


% Helper function for above section to remove stuck pixels and use the
% layout mask to subsample
function stats_subsampled = run_subsampling(I, layout, stuck)

    stats = regionprops("table", I, "Area", "Centroid");
    
    % Remove stuck pixels
    stuck_rows = false(size(stats,1),1);
    
    for k = 1:size(stats,1)
        cx = stats{k,2}(1);
        cy = stats{k,2}(2);
    
        for s = 1:size(stuck,1)
            if abs(cx - stuck(s,1)) < 2 && abs(cy - stuck(s,2)) < 2
                stuck_rows(k) = true;
                break;
            end
        end
    end
    
    stats(stuck_rows,:) = [];
    
    % Subsample using mask
    stats_subsampled = stats([], :);
    
    for k = 1:size(stats,1)
        cx = round(stats{k,2}(1));
        cy = round(stats{k,2}(2));
    
        if layout(cy, cx) == 255
            stats_subsampled = [stats_subsampled; stats(k,:)];
        end
    end

end