#include "testbench_vbase.h"
#include "cortex_m0_wrapper.h"
#include "Vcortex_m0_wrapper.h"
#include "Vcortex_m0_wrapper__Syms.h"

#include "tb_axi4_driver.h"
#include "tb_axi4_mem.h"
#include "elf_load.h"
#include <unistd.h>

//-----------------------------------------------------------------
// Module
//-----------------------------------------------------------------
class testbench: public testbench_vbase
{
public:
    //-----------------------------------------------------------------
    // Instances / Members
    //-----------------------------------------------------------------      
    cortex_m0_wrapper           *m_dut;
    tb_axi4_driver              *m_driver;
    tb_axi4_mem                 *m_mem;

    sc_signal < bool >           rst_cpu_in;

    sc_signal <axi4_master>      axi_t_in;
    sc_signal <axi4_slave>       axi_t_out;

    sc_signal <axi4_master>      axi_i_out;
    sc_signal <axi4_slave>       axi_i_in;

    sc_signal < sc_uint <32> >   intr_in;

    int                          m_argc;
    char**                       m_argv;

    //-----------------------------------------------------------------
    // process
    //-----------------------------------------------------------------
    void process(void) 
    {
        int c;
        char *filename = NULL;
        int help = 0;

        while ((c = getopt (m_argc, m_argv, "f:")) != -1)
        {
            switch(c)
            {
                case 'f':
                    filename = optarg;
                    break;
                case '?':
                default:
                    help = 1;   
                    break;
            }
        }

        if (help)
        {
            printf("./test -f filename.elf\n");
            sc_stop();
        }

        wait(10);

        printf("ELF Load %s\n", filename);
        if (!elf_load(filename, NULL, mem_load, this, NULL))
        {
            sc_assert(!"Failed to load ELF");
            return ;
        }

        // Release CPU from reset
        wait();
        rst_cpu_in.write(false);
        wait();

        m_mem->records_enable(true);
        while (1)
        {
            // Dummy UART - 0x42000004 (ULITE_TX)
            if (m_mem->records_available())
            {
                tb_mem_record item = m_mem->records_pop();
                if (item.m_addr == 0x42000004 && item.m_is_write)
                    printf("%c", item.m_data);
            }

            wait();
        }
    }

    static int mem_load(void *arg, uint32_t addr, uint8_t data)
    {
        testbench * pThis = (testbench*)arg;
        pThis->write(addr, data);
        return 1;
    }

    void set_argcv(int argc, char* argv[]) { m_argc = argc; m_argv = argv; }

    SC_HAS_PROCESS(testbench);
    testbench(sc_module_name name): testbench_vbase(name)
    {
        m_dut = new cortex_m0_wrapper("DUT");
        m_dut->clk_in(clk);
        m_dut->rst_in(rst);
        m_dut->rst_cpu_in(rst_cpu_in);
        m_dut->axi_t_out(axi_t_out);
        m_dut->axi_t_in(axi_t_in);
        m_dut->axi_i_out(axi_i_out);
        m_dut->axi_i_in(axi_i_in);
        m_dut->intr_in(intr_in);

        m_driver = new tb_axi4_driver("DRIVER");
        m_driver->axi_out(axi_t_in);
        m_driver->axi_in(axi_t_out);

        m_mem = new tb_axi4_mem("MEM");
        m_mem->clk_in(clk);
        m_mem->rst_in(rst);
        m_mem->axi_in(axi_i_out);
        m_mem->axi_out(axi_i_in);
        m_mem->add_region(0x42000000, 1 << 20);
        m_mem->enable_delays(false);

        verilator_trace_enable("verilator.vcd", m_dut);
        rst_cpu_in.write(true);
    }
    //-----------------------------------------------------------------
    // write: Write byte into memory
    //-----------------------------------------------------------------
    void write(uint32_t addr, uint8_t data)
    {
        m_driver->write(addr, data);
    }
    //-----------------------------------------------------------------
    // write: Read byte from memory
    //-----------------------------------------------------------------
    uint8_t read(uint32_t addr)
    {
        return m_driver->read(addr);
    }
};
