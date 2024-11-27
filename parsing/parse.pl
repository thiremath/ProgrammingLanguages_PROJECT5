
%%%%%%%%%%%%%%%%%
% Your code here:

% Base case: No input left to process.
parse_lines([], []).

% Recursive case: Process each line and continue with the rest.
parse_lines(Input, Remaining) :-
    process_line(Input, Processed),
    process_semi_col(Processed, AfterSemiCol),
    parse_lines(AfterSemiCol, Remaining).

% Alternative case: Single line without further processing.
parse_lines(Input, Processed) :-
    process_line(Input, Processed).

% Process individual line components.
process_line(Input, Remaining) :-
    parse_number(Input, Next),
    process_comma(Next, AfterComma),
    process_line(AfterComma, Remaining).

% Alternative case: Single number in a line.
process_line(Input, Processed) :-
    parse_number(Input, Processed).

% Parse single or multiple numerals.
parse_number(Input, Remaining) :- parse_digit(Input, Remaining).
parse_number(Input, Final) :-
    parse_digit(Input, Intermediate),
    parse_number(Intermediate, Final).

% Handle semicolon as line terminator.
process_semi_col([';' | Tail], Tail).

% Handle comma as a delimiter within a line.
process_comma([',' | Tail], Tail).

% Parse a single digit.
parse_digit([Char | Tail], Tail) :-
    member(Char, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']).
%%%%%%%%%%%%%%%%%

parse(X) :- parse_lines(X, []).

% Example execution:
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2']).
% true.
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2', ',']).
% false.
% ?- parse(['3', '2', ',', ';', '0']).
% false.
