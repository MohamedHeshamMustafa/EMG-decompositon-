function templates_matrix = hdetection(data,peaks,T,DiffTher)
distance = T/2;
[no_peaks,~] = size(peaks);
templates_matrix  = zeros(1,no_peaks);
templates_matrix(1,1)  = 1;
templates_matrix_count  = 1;
for i = 2:size(peaks)
    matched = 0;
    template= data((peaks(i)-distance):(peaks(i)+distance));
    [no_templates,~] = size(templates_matrix);
    for j = 1:no_templates
        current_template = data((peaks(templates_matrix(j,1))-distance):(peaks(templates_matrix(j,1))+distance));
        diff = sum((template - current_template).^2);
        if diff < DiffTher
            templates_matrix(j,templates_matrix_count(j)) = i;
            templates_matrix_count(j) = templates_matrix_count(j) + 1;
            matched = 1;
            break;
        end
    end
    if ~matched
        templates_matrix = [templates_matrix ; [i zeros(1,no_peaks-1)]];
        templates_matrix_count = [templates_matrix_count 2];
    end
end
end