class-pool .
*"* class pool for class ZCL_GCTS_DEMO

*"* local type definitions
include ZCL_GCTS_DEMO=================ccdef.

*"* class ZCL_GCTS_DEMO definition
*"* public declarations
  include ZCL_GCTS_DEMO=================cu.
*"* protected declarations
  include ZCL_GCTS_DEMO=================co.
*"* private declarations
  include ZCL_GCTS_DEMO=================ci.
endclass. "ZCL_GCTS_DEMO definition

*"* macro definitions
include ZCL_GCTS_DEMO=================ccmac.
*"* local class implementation
include ZCL_GCTS_DEMO=================ccimp.

*"* test class
include ZCL_GCTS_DEMO=================ccau.

class ZCL_GCTS_DEMO implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_GCTS_DEMO implementation
