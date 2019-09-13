# ZenScript.antlr

… is a formal (?), unofficial syntax definition of [ZenScript][ref-1] written in [Antlr4][ref-2].

Currently, ZenScript.antlr is targeting [CraftTweaker/ZenScript@b88317d][ref-3].

## Motivation

There has been some in-depth documentation about the actual syntax of ZenScript, such as [the 
list of all tokens][ref-4] and [the list of all operators][ref-5]. However, it is not sufficient 
to describe the correct syntax of ZenScript.  
Oftentimes, syntax error such as missing a semi-colon or dangling bracket can even trick the
ZenScript compiler to produce malformed byte-code due to some reasons. A formalized syntax of 
ZenScript will enable us to statically analyze any given ZenScript files so that these rather 
obvious error may be eliminated as soon as possible.  
Sadly, there has not been any full documentation about the entire ZenScript syntax, which drives 
me to dig into the initial ZenScript implementation to extract it out.

[ref-1]: https://github.com/CraftTweaker/ZenScript
[ref-2]: https://github.com/antlr/antlr4
[ref-3]: https://github.com/CraftTweaker/ZenScript/commit/b88317d667ca6f937beeb2a0b1ee71cc3af642a3
[ref-4]: https://crafttweaker.readthedocs.io/en/latest/#Dev_Area/ZenTokens/
[ref-5]: https://crafttweaker.readthedocs.io/en/latest/#Dev_Area/ZenOperators/