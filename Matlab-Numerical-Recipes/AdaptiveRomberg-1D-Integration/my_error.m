function y = my_error(upper_row, lower_row)
    y = abs(upper_row - lower_row) / max(1, abs(lower_row));
