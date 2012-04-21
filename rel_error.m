function [s] = rel_error(v1, v2)
s = abs_error(v1, v2)/v1;