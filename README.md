### Cortex-M0 DesignStart Wrapper

Github:   [https://github.com/ultraembedded/cortex_m0_wrapper](https://github.com/ultraembedded/cortex_m0_wrapper)

This wrapper takes the Cortex-M0 DesignStart IP from ARM and wraps it with some small memories (32KB Instruction, 32KB Data), and adds AXI-4 slave and master interfaces.

This makes it very easy to instance on FPGA and to hookup the Cortex-M0 to various Xilinx AXI-4 IP cores.

This requires the Cortex-M0 DesignStart core from ARM (specifically CORTEXM0INTEGRATION.v/CORTEXM0DS.v and cortexm0ds_logic.v);
* https://developer.arm.com/products/processors/cortex-m/cortex-m0

##### Features
* 32KB Instruction Memory (0x00000000 - 0x00007fff)
* 32KB Data Memory (0x20000000 - 0x20007fff)
* AXI-4 slave for accessing instruction / data memory (e.g. for loading code / data)
* AXI-4 master for external peripherals / memory (0x40000000 - 0xffffffff)

##### Configuration / Ports
* Top: cortex_m0_wrapper
* clk_i - Clock
* rst_i - Asynchronous reset, active high (AXI-4 Slave / memory access logic)
* rst_cpu_i: Asynchronous reset, active high (CPU)
* axi_i: AXI-4 initiator (CPU access to peripherals / memory).
* axi_t: AXI-4 target (external access to instruction and data memories).
* intr_i: Interrupt sources

##### References
* [Cortex-M0 DesignStart](https://developer.arm.com/products/processors/cortex-m/cortex-m0)
* [Xilinx AXI Reference Guide](https://www.xilinx.com/support/documentation/ip_documentation/ug761_axi_reference_guide.pdf)

Note: ARM, Cortex-M0, AXI-4 and DesignStart are trademarks of ARM Holdings.
