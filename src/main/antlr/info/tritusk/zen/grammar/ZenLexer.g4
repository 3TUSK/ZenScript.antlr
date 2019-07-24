/**
 * ZenScript Grammar for Antlr v4
 * Heavily based on the original ZenScript implementation, which may be found at:
 *
 *   https://github.com/CraftTweaker/ZenScript
 */

lexer grammar ZenLexer;

fragment ZEN_DIGIT_NO_ZERO
    : [1-9]
    ;

fragment ZEN_DIGIT
    : ( '0' | ZEN_DIGIT_NO_ZERO )
    ;

fragment ZEN_UPPER_LETTER
    : [A-Z]
    ;

fragment ZEN_LOWER_LETTER
    : [a-z]
    ;

fragment ZEN_LETTER
    : ( ZEN_UPPER_LETTER | ZEN_LOWER_LETTER )
    ;

fragment ZEN_UNICODE
    : '\\u' [0-9A-Fa-f] [0-9A-Fa-f]? [0-9A-Fa-f]? [0-9A-Fa-f]?
    ;

fragment ZEN_ESCAPE
    : '\\\'' | '\\"' | '\\\\' | '\\/' | '\\b' | '\\f' | '\\n' | '\\r' | '\\t'
    ;

ZEN_WHITESPACE
    : ( ' ' | '\t' | '\n' | '\r' )+ -> skip
    ;

ZEN_COMMENT
    : '//' .*? '\n'
    | '#' .*? '\n'
    | '/*' .*? '*/'
    ;

ZEN_KW_IMPORT
    : 'import'
    ;

ZEN_KW_FUNCTION
    : 'function'
    ;

ZEN_KW_VERSION
    : 'version'
    ;

ZEN_KW_AS
    : 'as'
    ;

ZEN_KW_INSTANCEOF
    : 'instanceof'
    ;

ZEN_KW_IF
    : 'if'
    ;

ZEN_KW_ELSE
    : 'else'
    ;

ZEN_KW_FOR
    : 'for'
    ;

ZEN_KW_WHILE
    : 'while'
    ;

ZEN_KW_BREAK
    : 'break'
    ;

ZEN_KW_RETURN
    : 'return'
    ;

ZEN_KW_VAR
    : 'var'
    ;

ZEN_KW_VAL
    : 'val'
    ;

ZEN_KW_GLOBAL
    : 'global'
    ;

ZEN_KW_STATIC
    : 'static'
    ;

ZEN_KW_NULL
    : 'null'
    ;

ZEN_KW_VOID
    : 'void'
    ;

ZEN_KW_ANY
    : 'any'
    ;

ZEN_KW_BYTE
    : 'byte'
    ;

ZEN_KW_SHORT
    : 'short'
    ;

ZEN_KW_INT
    : 'int'
    ;

ZEN_KW_LONG
    : 'long'
    ;

ZEN_KW_FLOAT
    : 'float'
    ;

ZEN_KW_DOUBLE
    : 'double'
    ;

ZEN_KW_BOOLEAN
    : 'boolean'
    ;

ZEN_KW_STRING
    : 'string'
    ;

ZEN_KW_TRUE
    : 'true'
    ;

ZEN_KW_FALSE
    : 'false'
    ;

ZEN_KW_IN
    : 'in'
    | 'has'
    ;

ZEN_KW_TO
    : 'to'
    ;

ZEN_DOT
    : '.'
    ;

ZEN_COLON
    : ':'
    ;

ZEN_SEMICOLON
    : ';'
    ;

ZEN_COMMA
    : ','
    ;

ZEN_PARENTHESIS_L
    : '('
    ;

ZEN_PARENTHESIS_R
    : ')'
    ;

ZEN_BRACKET_L
    : '['
    ;

ZEN_BRACKET_R
    : ']'
    ;

ZEN_BRACE_L
    : '{'
    ;

ZEN_BRACE_R
    : '}'
    ;

ZEN_ASSIGN
    : '='
    ;

ZEN_ASSIGN_ADD
    : '+='
    ;

ZEN_ASSIGN_SUB
    : '-='
    ;

ZEN_ASSIGN_CAT
    : '~='
    ;

ZEN_ASSIGN_MUL
    : '*='
    ;

ZEN_ASSIGN_DIV
    : '/='
    ;

ZEN_ASSIGN_MOD
    : '%='
    ;

ZEN_ASSIGN_AND
    : '&='
    ;

ZEN_ASSIGN_OR
    : '|='
    ;

ZEN_ASSIGN_XOR
    : '^='
    ;

ZEN_QUESTION
    : '?'
    ;

ZEN_LOGICAL_OR
    : '||'
    ;

ZEN_LOGICAL_AND
    : '&&'
    ;

ZEN_BITWISE_OR
    : '|'
    ;

ZEN_BITWISE_XOR
    : '^'
    ;

ZEN_BITWISE_AND
    : '&'
    ;

ZEN_EQUAL
    : '=='
    ;

ZEN_INEQUAL
    : '!='
    ;

ZEN_LT
    : '<'
    ;

ZEN_LEQ
    : '<='
    ;

ZEN_GT
    : '>'
    ;

ZEN_GEQ
    : '>='
    ;

ZEN_ADD
    : '+'
    ;

ZEN_SUB
    : '-'
    ;

ZEN_CAT
    : '~'
    ;

ZEN_MUL
    : '*'
    ;

ZEN_DIV
    : '/'
    ;

ZEN_MOD
    : '%'
    ;

ZEN_NOT
    : '!'
    ;

ZEN_RANGE
    : '..'
    ;

ZEN_IDENTIFIER
    : ( ZEN_LETTER | '_' ) ( ZEN_LETTER | ZEN_DIGIT |  '_' )*
    ;

// Matches a decimal number or a hexadecimal number.
// When matching hexadecimal number, it makes no assumption on signum.
ZEN_INTEGER
    : '-'? ( '0' | ZEN_DIGIT_NO_ZERO ZEN_DIGIT* )
    | '0x' [0-9A-Fa-f]+
    ;

ZEN_FLOATING_POINT
    : '-'? ( '0' | ZEN_DIGIT_NO_ZERO ZEN_DIGIT* ) '.' ZEN_DIGIT+ ( [eE] [+-]? ZEN_DIGIT+ )? [fFdD]?;

ZEN_STRING
    : '\'' ( ~['\\] | ZEN_ESCAPE | ZEN_UNICODE )* '\''
    | '"' ( ~["\\] | ZEN_ESCAPE | ZEN_UNICODE )* '"'
    ;