function material = findMaterials(materialName, csvFile)
    % findMaterials - Finds material properties based on its name from a CSV file.
    %
    % Input:
    %   materialName - Name of the material (string)
    %   csvFile      - Path to the CSV file containing material properties
    %
    % Output:
    %   material     - Struct containing material properties
    %                  (returns empty if material is not found)

    % Read the CSV file into a table
    try
        materialsTable = readtable(csvFile, 'TextType', 'string', 'VariableNamingRule', 'preserve');
    catch
        error('Error reading the CSV file: %s', csvFile);
    end

    % Check if the material exists in the table
    idx = find(strcmpi(materialsTable.Name, materialName), 1);

    if isempty(idx)
        % Material not found
        warning('Material "%s" not found in the database.', materialName);
        material = [];
        return;
    end

    % Extract the properties of the found material
    material = struct( ...
        'Name', materialsTable.Name(idx), ...
        'UTS', materialsTable.UTS(idx), ...
        'YieldStrength', materialsTable.("Yield Strength")(idx));
end