/**
 * @name Python Insecure Format
 * @description Python Format Vulnerability
 * @kind problem
 * @problem.severity error
 * @id py/insecure-format-vuln
 * @tags security
 *       experimental
 *       external/myql
 */

import python
import semmle.python.dataflow.new.DataFlow
import semmle.python.ApiGraphs
import semmle.python.types.Builtins
import semmle.python.dataflow.new.internal.Attributes
import semmle.python.dataflow.new.RemoteFlowSources
import semmle.python.dataflow.new.BarrierGuards
import semmle.python.dataflow.new.TaintTracking

class FormatFlowConfig extends TaintTracking::Configuration {
    FormatFlowConfig() { this = "FormatFlowConfig" }

    override predicate isSource(DataFlow::Node source) {
      source instanceof RemoteFlowSource
    }

    override predicate isSink(DataFlow::Node sink) {
        exists(AttrRef attrRef |
            attrRef.accesses(sink, "format")
        )
    }

    override predicate isSanitizer(DataFlow::Node node) {
        node instanceof StringConstCompareBarrier
    }
}


from FormatFlowConfig config, DataFlow::PathNode source, DataFlow::PathNode sink
where
    config.hasFlowPath(source, sink)
select sink.getNode(), "Sink", source, "Source"
