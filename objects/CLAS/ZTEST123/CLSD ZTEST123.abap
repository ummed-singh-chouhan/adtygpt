class-pool .
*"* class pool for class ZTEST123

*"* local type definitions
include ZTEST123======================ccdef.

*"* class ZTEST123 definition
*"* public declarations
  include ZTEST123======================cu.
*"* protected declarations
  include ZTEST123======================co.
*"* private declarations
  include ZTEST123======================ci.
endclass. "ZTEST123 definition

*"* macro definitions
include ZTEST123======================ccmac.
*"* local class implementation
include ZTEST123======================ccimp.

*"* test class
include ZTEST123======================ccau.

class ZTEST123 implementation.
*"* method's implementations
  include methods.
endclass. "ZTEST123 implementation
