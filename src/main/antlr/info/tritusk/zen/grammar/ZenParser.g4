/**
 * ZenScript Grammar for Antlr v4
 * Heavily based on the original ZenScript implementation, which may be found at:
 *
 *   https://github.com/CraftTweaker/ZenScript
 */

parser grammar ZenParser ;

options { tokenVocab = ZenLexer; }

zenFile
    : zenImport* ( zenGlobalVariable | zenFunction | zenStatement )* EOF
    ;

zenPackage
    : ZEN_IDENTIFIER ( ZEN_DOT ZEN_IDENTIFIER )*
    ;

zenImport
    : ZEN_KW_IMPORT zenPackage ( ZEN_KW_AS ZEN_IDENTIFIER )? ZEN_SEMICOLON
    ;

zenGlobalVariable
    : ZEN_KW_GLOBAL ZEN_IDENTIFIER ( ZEN_KW_AS zenType )? ZEN_ASSIGN zenExpression ZEN_SEMICOLON
    | ZEN_KW_STATIC ZEN_IDENTIFIER ( ZEN_KW_AS zenType )? ZEN_ASSIGN zenExpression ZEN_SEMICOLON
    ;

zenFunction
    : ZEN_KW_FUNCTION ZEN_IDENTIFIER zenParamList ( ZEN_KW_AS zenType )? zenBlock
    ;

zenParamList
    : ZEN_PARENTHESIS_L ( zenParam ( ZEN_COMMA zenParam )* )? ZEN_PARENTHESIS_R
    ;

zenParam
    : ZEN_IDENTIFIER ( ZEN_KW_AS zenType )?
    ;

zenStatement
    : zenBlock
    | zenReturn
    | zenBreak
    | zenContinue
    | zenIf
    | zenFor
    | zenWhile
    | zenVersion
    | zenVariable
    | zenExpression? ZEN_SEMICOLON
    ;

zenBlock
    : ZEN_BRACE_L zenStatement* ZEN_BRACE_R
    ;

zenReturn
    : ZEN_KW_RETURN zenExpression? ZEN_SEMICOLON
    ;

zenBreak
    : ZEN_KW_BREAK ZEN_SEMICOLON
    ;

zenContinue
    : ZEN_KW_CONTINUE ZEN_SEMICOLON
    ;

zenIf
    : ZEN_KW_IF zenExpression zenStatement ( ZEN_KW_ELSE zenStatement )?
    ;

zenFor
    : ZEN_KW_FOR ZEN_IDENTIFIER ( ZEN_COMMA ZEN_IDENTIFIER )* ZEN_KW_IN zenExpression zenStatement
    ;

zenWhile
    : ZEN_KW_WHILE zenExpression zenStatement
    ;

zenVersion
    : ZEN_KW_VERSION ZEN_INTEGER ZEN_SEMICOLON
    ;

zenVariable
    : ZEN_KW_VAR ZEN_IDENTIFIER ( ZEN_KW_AS zenType )? ( ZEN_ASSIGN zenExpression )? ZEN_SEMICOLON
    | ZEN_KW_VAL ZEN_IDENTIFIER ( ZEN_KW_AS zenType )? ( ZEN_ASSIGN zenExpression )? ZEN_SEMICOLON
    ;

zenType
    : ZEN_KW_ANY
    | ZEN_KW_BYTE
    | ZEN_KW_SHORT
    | ZEN_KW_INT
    | ZEN_KW_LONG
    | ZEN_KW_FLOAT
    | ZEN_KW_DOUBLE
    | ZEN_KW_BOOLEAN
    | ZEN_KW_STRING
    | ZEN_KW_VOID
    | ZEN_IDENTIFIER
    | ZEN_KW_FUNCTION ZEN_PARENTHESIS_L ( zenType ( ZEN_COMMA zenType )* )? ZEN_PARENTHESIS_R
    | zenType ZEN_BRACKET_L zenType? ZEN_BRACKET_R // Array & associative array
    ;

zenExpression
    : zenExpressionAssignment
    ;

zenExpressionAssignment
    : zenExpressionCondition
    | zenExpressionCondition ZEN_ASSIGN     zenExpressionCondition
    | zenExpressionCondition ZEN_ASSIGN_ADD zenExpressionCondition
    | zenExpressionCondition ZEN_ASSIGN_SUB zenExpressionCondition
    | zenExpressionCondition ZEN_ASSIGN_CAT zenExpressionCondition
    | zenExpressionCondition ZEN_ASSIGN_MUL zenExpressionCondition
    | zenExpressionCondition ZEN_ASSIGN_DIV zenExpressionCondition
    | zenExpressionCondition ZEN_ASSIGN_MOD zenExpressionCondition
    | zenExpressionCondition ZEN_ASSIGN_AND zenExpressionCondition
    | zenExpressionCondition ZEN_ASSIGN_OR  zenExpressionCondition
    | zenExpressionCondition ZEN_ASSIGN_XOR zenExpressionCondition
    ;

zenExpressionCondition
    : zenExpressionOr
    | zenExpressionOr ZEN_QUESTION zenExpressionOr ZEN_COLON zenExpressionCondition
    ;

zenExpressionOr
    : zenExpressionAnd
    | zenExpressionOr ZEN_LOGICAL_OR zenExpressionAnd
    ;

zenExpressionAnd
    : zenExpressionBitwiseOr
    | zenExpressionAnd ZEN_LOGICAL_AND zenExpressionBitwiseOr
    ;

zenExpressionBitwiseOr
    : zenExpressionBitwiseXor
    | zenExpressionBitwiseOr ZEN_BITWISE_OR zenExpressionBitwiseXor
    ;

zenExpressionBitwiseXor
    : zenExpressionBitwiseAnd
    | zenExpressionBitwiseXor ZEN_BITWISE_XOR zenExpressionBitwiseAnd
    ;

zenExpressionBitwiseAnd
    : zenExpressionComparsion
    | zenExpressionBitwiseAnd ZEN_BITWISE_AND zenExpressionComparsion
    ;

zenExpressionComparsion
    : zenExpressionAdd
    | zenExpressionAdd ZEN_EQUAL zenExpressionAdd
    | zenExpressionAdd ZEN_INEQUAL zenExpressionAdd
    | zenExpressionAdd ZEN_LT zenExpressionAdd
    | zenExpressionAdd ZEN_LEQ zenExpressionAdd
    | zenExpressionAdd ZEN_GT zenExpressionAdd
    | zenExpressionAdd ZEN_GEQ zenExpressionAdd
    | zenExpressionAdd ZEN_KW_IN zenExpressionAdd
    ;

zenExpressionAdd
    : zenExpressionMul
    | zenExpressionMul ZEN_ADD zenExpressionMul
    | zenExpressionMul ZEN_SUB zenExpressionMul
    | zenExpressionMul ZEN_CAT zenExpressionMul
    ;

zenExpressionMul
    : zenExpressionUnary
    | zenExpressionUnary ZEN_MUL zenExpressionUnary
    | zenExpressionUnary ZEN_DIV zenExpressionUnary
    | zenExpressionUnary ZEN_MOD zenExpressionUnary
    ;

zenExpressionUnary
    : zenExpressionPostfix
    | ZEN_NOT zenExpressionPostfix
    | ZEN_SUB zenExpressionPostfix
    ;

zenExpressionPostfix
    : zenExpressionPrimary
    | zenExpressionPostfix ZEN_DOT ( ZEN_IDENTIFIER | ZEN_KW_VERSION | ZEN_STRING )
    | zenExpressionPostfix ( ZEN_RANGE | ZEN_KW_TO ) zenExpressionAssignment
    | zenExpressionPostfix ZEN_BRACKET_L zenExpressionAssignment ZEN_BRACKET_R
    | zenExpressionPostfix ZEN_BRACKET_L zenExpressionAssignment ZEN_BRACKET_R ZEN_ASSIGN zenExpressionAssignment
    | zenExpressionPostfix ZEN_PARENTHESIS_L ( zenExpressionAssignment ( ZEN_COMMA zenExpressionAssignment )* )? ZEN_PARENTHESIS_R
    | zenExpressionPostfix ZEN_KW_AS zenType
    | zenExpressionPostfix ZEN_KW_INSTANCEOF zenType
    ;

zenExpressionPrimary
    : zenLiteral // See below
    | ZEN_IDENTIFIER // Variable reference
    | ZEN_KW_FUNCTION zenParamList ( ZEN_KW_AS zenType )? zenBlock // Anomynous function declaration
    | ZEN_BRACKET_L ( zenExpressionAssignment ( ZEN_COMMA zenExpressionAssignment )* )? ZEN_BRACKET_R // Array declaration
    | ZEN_BRACE_L ( zenMapEntry ( ZEN_COMMA zenMapEntry )* )? ZEN_BRACE_R // Map declaration
    | ZEN_PARENTHESIS_L zenExpressionAssignment ZEN_PARENTHESIS_R
    ;

zenMapEntry
    : zenExpressionAssignment ZEN_COLON zenExpressionAssignment
    ;

zenLiteral
    : zenLiteralNull // `null`
    | zenLiteralBoolean // `true`, `false`
    | zenLiteralString // "foo", 'bar'
    | zenLiteralInteger // -0, 1, 0xCAFE, etc.. Binary and octal are not supported.
    | zenLiteralFloat // 3.14F, 27.1828e-1d, etc.. NaN is not supported.
    | zenLiteralBracket // Bracket handler `<item:minecraft:diamond>`
    ;

zenLiteralNull
    : ZEN_KW_NULL
    ;

zenLiteralBoolean
    : ZEN_KW_TRUE
    | ZEN_KW_FALSE
    ;

zenLiteralInteger
    : ZEN_INTEGER
    ;

zenLiteralFloat
    : ZEN_FLOATING_POINT
    ;

zenLiteralString
    : ZEN_STRING
    ;

// The bracket handler, e.g. `<item:minecraft:diamond>`
// We consider bracket handler as a specialized literal here.
// TODO Is there a better description on allowed tokens inside brakctes?
zenLiteralBracket
    : ZEN_LT ( ZEN_IDENTIFIER | ZEN_COLON | ZEN_MUL )* ZEN_GT
    ;
