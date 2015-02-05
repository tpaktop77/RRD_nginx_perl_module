#!/usr/bin/perl -w
use RRDs;
use warnings;
#use strict;

$pathToHTML    = "/gs/www/mrtg/cisco/";    # Path to HTML files.
$pathToRRD    = "/gs/www/mrtg/rrd/";        # Path to rrd files.
$debug        = 0;                        # Show debug printing.


$imgDetailedWidth = 800;
$imgDetailedHeight = 150;
$imgShortWidth = 800;
$imgShortHeight = 100;


my @common = (
    [
     "2811",
     "gw.tpaktop.com",
     [
       "FastEthernet0_0",
       "FastEthernet0_1"

     ],
     [
       "Input",          #0
       "Output"          #1
     ]
    ]
    ,
    [
     "2960G24",
     "bsw.tpaktop.com",
     [
       "GigabitEthernet0_1",
       "GigabitEthernet0_2",
       "GigabitEthernet0_3",
       "GigabitEthernet0_4",
       "GigabitEthernet0_5",
       "GigabitEthernet0_6",
       "GigabitEthernet0_7",
       "GigabitEthernet0_8",
       "GigabitEthernet0_9",
       "GigabitEthernet0_10",
       "GigabitEthernet0_11",
       "GigabitEthernet0_12",
       "GigabitEthernet0_13",
       "GigabitEthernet0_14",
       "GigabitEthernet0_15",
       "GigabitEthernet0_16",
       "GigabitEthernet0_17",
       "GigabitEthernet0_18",
       "GigabitEthernet0_19",
       "GigabitEthernet0_20",
       "GigabitEthernet0_21",
       "GigabitEthernet0_22",
       "GigabitEthernet0_23",
       "GigabitEthernet0_24"#,
#       "Vlan10",
#       "Vlan1001",
#       "Vlan30",
#       "Vlan40",
#       "Vlan4000"
     ],
     [
       "to ESW",        #1
       "None",          #2
       "2811 in",       #3
       "2811 out",      #4
       "Parents",       #5
       "1242",          #6
       "None",          #7
       "None",          #8
       "ESXi",          #9
       "ESXi",          #10
       "SLM2008",       #11
       "SLM2008",       #12
       "NASBOX",        #13
       "None",          #14
       "STB - Bedroom", #15
       "STB - Living",  #16
       "None",          #17
       "None",          #18
       "None",          #19
       "Dune",          #20
       "None",          #21
       "ATA186",        #22
       "None",          #23
       "None"           #24
     ]
    ]
    ,
    [
     "2960G8",
     "ssw.tpaktop.com",
     [
         "GigabitEthernet0_1",
         "GigabitEthernet0_2",
         "GigabitEthernet0_3",
         "GigabitEthernet0_4",
         "GigabitEthernet0_5",
         "GigabitEthernet0_6",
         "GigabitEthernet0_7",
         "GigabitEthernet0_8"
     ]
     ,
     [
       "To 2960G24",          #1
       "1242",          #2
       "Dune",          #3
       "None",          #4
       "None",          #5
       "STB",          #6
       "ATA 186",        #7
       "None"           #8
     ]
    ]
    ,
    [
     "2940",
     "esw.tpaktop.com",
     [
         "FastEthernet0_1",
         "FastEthernet0_2",
         "FastEthernet0_3",
         "FastEthernet0_4",
         "FastEthernet0_5",
         "FastEthernet0_6",
         "FastEthernet0_7",
         "FastEthernet0_8",
         "GigabitEthernet0_1"
     ]
     ,
     [
        "RMTelecom",     #1
        "None",          #2
        "None",          #3
        "None",          #4
        "None",          #5
        "None",          #6
        "None",          #7
        "To 2960G24",    #8
        "Speedyline"     #9
     ]
    ]
    ,
    [
     "12421",
     "cap.tpaktop.com",
     [
        "Dot11Radio0",
        "Dot11Radio1",
        "BVI1",
        "FastEthernet0"
     ]
     ,
     [
        "802.11.g",          #1
        "802.11.a",          #2
        "None",              #3
        "To 2960G24"         #4
     ]
    ]
    ,
    [
     "12422",
     "cap2.tpaktop.com",
     [
        "Dot11Radio0",
        "Dot11Radio1",
        "BVI1",
        "FastEthernet0"
     ]
     ,
     [
        "802.11.g",          #1
        "802.11.a",          #2
        "None",              #3
        "To 2960G8"          #4
     ]
    ]
   );


my @time = localtime(time);
my $minute = $time[1];
my $hour   = $time[2];

my @periods = (
 "1h", # 0
 "1d", # 1
 "1w", # 2
 "1m", # 3
 "1y", # 4
 "1d"  # 5
 );

my @namesOfPeriods = (
 "hourly",  # 0
 "daily",   # 1
 "weekly",  # 2
 "monthly", # 3
 "yearly",  # 4
 "short"    # 5
 );


($debug)?print "Going to generate...\n":print"";

for (my $iPeriod = 0; $iPeriod < (int @periods); $iPeriod++)                                            # Обработать все периоды времени
{
    if (
         (($iPeriod == 0) | ($iPeriod == 1) | ($iPeriod == 5)) |                                        # Если это за час, день или короткий за день.
         ($iPeriod == 2 && (($minute == 0) | ($minute == 15) | ($minute == 30) | ($minute == 45))) |    # Если за неделю и кадые 15 минут (0,15,30.45).
         ($iPeriod == 3 && $minute == 0) |                                                              # Если за месяц и каждый час (минута равна 0). 
         ($iPeriod == 4 && $hour == 0 && $minute == 0)                                                  # Если за год и каждый день (час и минута равны 0).
        )
    {
        ($debug)?print "And the period it  -  ".$namesOfPeriods[$iPeriod]."\n":print"";
        
        for (my $iCommon = 0; $iCommon < (int @common); $iCommon++)                                     # Пройтись по всем элементам основного массива.
        {
            my @partiqular   = @{$common[$iCommon]};                                                    # Получить вложенный массив.
            my $name         = $partiqular[0];                                                          # Получить имя устройства = папки в расзделе cisco.
            my $path         = $partiqular[1];                                                          # Получить имя папки с rrd collecd.
            my @interfaces   = @{$partiqular[2]};                                                       # Получить вложенный массив с интерфейсами.
            my @descriptions = @{$partiqular[3]};                  

        ($debug)?print  "The name of device - ".$name." path - ".$path.".\n":print"";

    #--------- Memory and CPU 
               if ($iPeriod == 5)       # if Short then...
               {

               ($debug)?print " -RRD for ".$name." memory ".$namesOfPeriods[$iPeriod]."\n":print"";

                RRDs::graph($pathToHTML.$name."/img_memory_".$namesOfPeriods[$iPeriod].".png",
                        "--title=Memory utilization $namesOfPeriods[$iPeriod]",
                        "--imgformat=PNG",
                        "--width=".$imgShortWidth,
                        "--height=".$imgShortHeight,
                        "--vertical-label=Bytes",
                        "--start=-$periods[$iPeriod]",
                        "--end=now",
                        "--rigid",
                        "--slope-mode",
#                        "--upper-limit=805306368",
                        "--lower-limit=0",
                        "DEF:value=".$pathToRRD.$path."/snmp/memory-cpu-memory.rrd:value:AVERAGE",
                        "AREA:value#0000FF60"
                        );
                        
                ($debug)?print " -RRD for ".$name." cpu ".$namesOfPeriods[$iPeriod]."\n":print"";
                
                RRDs::graph($pathToHTML.$name."/img_cpu_".$namesOfPeriods[$iPeriod].".png",
                        "--title=CPU utilization $namesOfPeriods[$iPeriod]",
                        "--imgformat=PNG",
                        "--width=".$imgShortWidth,
                        "--height=".$imgShortHeight,
                        "--vertical-label=Percents",
                        "--start=-$periods[$iPeriod]",
                        "--end=now",
                        "--rigid",
                        "--slope-mode",
                        "--upper-limit=100",
                        "--lower-limit=0",
                        "DEF:value=".$pathToRRD.$path."/snmp/percent-cpu-utilization.rrd:value:AVERAGE",
                        "AREA:value#0000FF60"
                        );
                }
               else
               {
               
                ($debug)?print " -RRD for ".$name." memory ".$namesOfPeriods[$iPeriod]."\n":print"";
                
                RRDs::graph("/gs/www/mrtg/cisco/$name/img_memory_$namesOfPeriods[$iPeriod].png",
                        "--title=Memory utilization $namesOfPeriods[$iPeriod]",
                        "--imgformat=PNG",
                        "--width=".$imgDetailedWidth,
                        "--height=".$imgDetailedHeight,
                        "--vertical-label=Bytes",
                        "--start=-$periods[$iPeriod]",
                        "--end=now",
                        "--rigid",
                        "--slope-mode",
#                        "--upper-limit=805306368",
                        "--lower-limit=0",
                        "DEF:value=".$pathToRRD.$path."/snmp/memory-cpu-memory.rrd:value:AVERAGE",
                        "AREA:value#0000FF60:Memory ",
                        "GPRINT:value:MIN: Min\\:%6.2lf %sbytes",
                        "GPRINT:value:MAX: Max\\:%6.2lf %sbytes",
                        "GPRINT:value:AVERAGE: Avrg\\:%6.2lf %sbytes",
                        "GPRINT:value:LAST: Last\\:%6.2lf %sbytes",
                        "COMMENT:\\n"
                    );
                    
                ($debug)?print " -RRD for ".$name." cpu ".$namesOfPeriods[$iPeriod]."\n":print"";
                
                RRDs::graph("/gs/www/mrtg/cisco/$name/img_cpu_$namesOfPeriods[$iPeriod].png",
                        "--title=CPU utilization $namesOfPeriods[$iPeriod]",
                        "--imgformat=PNG",
                        "--width=".$imgDetailedWidth,
                        "--height=".$imgDetailedHeight,
                        "--vertical-label=Percents",
                        "--start=-$periods[$iPeriod]",
                        "--end=now",
                        "--rigid",
                        "--slope-mode",
                        "--upper-limit=100",
                        "--lower-limit=0",
                        "DEF:value=".$pathToRRD.$path."/snmp/percent-cpu-utilization.rrd:value:AVERAGE",
                        "AREA:value#0000FF60:Cpu ",
                        "GPRINT:value:MIN: Min\\:%6.2lf %sbytes",
                        "GPRINT:value:MAX: Max\\:%6.2lf %sbytes",
                        "GPRINT:value:AVERAGE: Avrg\\:%6.2lf %sbytes",
                        "GPRINT:value:LAST: Last\\:%6.2lf %sbytes",
                        "COMMENT:\\n"
                    );
                }

            ($debug)?print " Now we are gouing to create interfaces... \n":print"";

            for (my $iInterface = 0; $iInterface < (int @interfaces); $iInterface++)
            {
                my $interface  = $interfaces[$iInterface];
                my $description = $descriptions[$iInterface];

                ($debug)?print " --Interface is - ".$interface." with Description  - ".$description."\n":print"";
                
#--------- Network interfaces
                 if ($iPeriod == 5)
                 {
                 
                    ($debug)?print "  --- Bytes ".$interface." with period - ".$namesOfPeriods[$iPeriod]."\n":print"";
                    
                    RRDs::graph("/gs/www/mrtg/cisco/$name/img_".$interface."_".$namesOfPeriods[$iPeriod].".png",
                        "--title=Utilization Port - $interface ($description) $namesOfPeriods[$iPeriod]",
                        "--imgformat=PNG",
                        "--width=".$imgShortWidth,
                        "--height=".$imgShortHeight,
                        "--vertical-label=Bits per second",
                        "--start=-$periods[$iPeriod]",
                        "--end=now",
                        "--rigid",
                        "--slope-mode",
#                       "--upper-limit=100",
                        "--lower-limit=0",
                        "DEF:tx=".$pathToRRD.$path."/snmp/if_octets-".$interface.".rrd:tx:AVERAGE",
                        "DEF:rx=".$pathToRRD.$path."/snmp/if_octets-".$interface.".rrd:rx:AVERAGE",
                        "CDEF:txbits=tx,8,*",
                        "CDEF:rxbits=rx,8,*",
                        "AREA:txbits#FF000060",
                        "AREA:rxbits#0000FF60",
                        "LINE1:txbits#FF0000",
                        "LINE1:rxbits#0000FF"
                        );
#-------------- Packets short
    
                    ($debug)?print "  --- Packets ".$interface." with period - ".$namesOfPeriods[$iPeriod]."\n":print"";
                    
                    RRDs::graph("/gs/www/mrtg/cisco/$name/img_".$interface."_packets_$namesOfPeriods[$iPeriod].png",
                        "--title=Packets per Port - $interface ($description) $namesOfPeriods[$iPeriod]",
                        "--imgformat=PNG",
                        "--width=".$imgShortWidth,
                        "--height=".$imgShortHeight,
                        "--vertical-label=Packets per second",
                        "--start=-$periods[$iPeriod]",
                        "--end=now",
                        "--rigid",
                        "--slope-mode",
#                       "--upper-limit=100",
                        "--lower-limit=0",
                        "DEF:tx=".$pathToRRD.$path."/snmp/if_packets-".$interface.".rrd:tx:AVERAGE",
                        "DEF:rx=".$pathToRRD.$path."/snmp/if_packets-".$interface.".rrd:rx:AVERAGE",
                        "AREA:tx#FF000060",
                        "AREA:rx#0000FF60",
                        "LINE1:tx#FF0000",
                        "LINE1:rx#0000FF"
                        );
                 }
                 else
                 {
                 
                    ($debug)?print "  --- Bytes ".$interface." with period - ".$namesOfPeriods[$iPeriod]."\n":print"";
                    
                    RRDs::graph($pathToHTML.$name."/img_".$interface."_".$namesOfPeriods[$iPeriod].".png",
                        "--title=Utilization Port - $interface ($description) $namesOfPeriods[$iPeriod]",
                        "--imgformat=PNG",
                        "--width=".$imgDetailedWidth,
                        "--height=".$imgDetailedHeight,
                        "--vertical-label=Bits per second",
                        "--start=-$periods[$iPeriod]",
                        "--end=now",
                        "--rigid",
                        "--slope-mode",
    #                    "--upper-limit=100",
                        "--lower-limit=0",
                        "DEF:tx=".$pathToRRD.$path."/snmp/if_octets-".$interface.".rrd:tx:AVERAGE",
                        "DEF:rx=".$pathToRRD.$path."/snmp/if_octets-".$interface.".rrd:rx:AVERAGE",
                        "CDEF:txbits=tx,8,*",
                        "CDEF:rxbits=rx,8,*",
                        "AREA:txbits#FF000060:Transmit",
                        "GPRINT:txbits:MIN: Min\\:%6.2lf %sbits",
                        "GPRINT:txbits:MAX: Max\\:%6.2lf %sbits",
                        "GPRINT:txbits:AVERAGE: Avrg\\:%6.2lf %sbits",
                        "GPRINT:txbits:LAST: Last\\:%6.2lf %sbits",
                        "COMMENT:\\n",
                        "AREA:rxbits#0000FF60:Receive ",
                        "GPRINT:rxbits:MIN: Min\\:%6.2lf %sbits",
                        "GPRINT:rxbits:MAX: Max\\:%6.2lf %sbits",
                        "GPRINT:rxbits:AVERAGE: Avrg\\:%6.2lf %sbits",
                        "GPRINT:rxbits:LAST: Last\\:%6.2lf %sbits",
                        "LINE1:txbits#FF0000",
                        "LINE1:rxbits#0000FF",
                        "COMMENT:\\n"
                       );
            
#-------------- Packets
    
                    ($debug)?print "  --- Packets ".$interface." with period - ".$namesOfPeriods[$iPeriod]."\n":print"";
        
                    RRDs::graph($pathToHTML.$name."/img_".$interface."_packets_".$namesOfPeriods[$iPeriod].".png",
                        "--title=Packets per Port - $interface ($description) $namesOfPeriods[$iPeriod]",
                        "--imgformat=PNG",
                        "--width=".$imgDetailedWidth,
                        "--height=".$imgDetailedHeight,
                        "--vertical-label=Packets per second",
                        "--start=-$periods[$iPeriod]",
                        "--end=now",
                        "--rigid",
                        "--slope-mode",
#                       "--upper-limit=100",
                        "--lower-limit=0",
                        "DEF:tx=".$pathToRRD.$path."/snmp/if_packets-".$interface.".rrd:tx:AVERAGE",
                        "DEF:rx=".$pathToRRD.$path."/snmp/if_packets-".$interface.".rrd:rx:AVERAGE",
                        "AREA:tx#FF000060:Transmit",
                        "GPRINT:tx:MIN: Min\\:%6.2lf %spkts",
                        "GPRINT:tx:MAX: Max\\:%6.2lf %spkts",
                        "GPRINT:tx:AVERAGE: Avrg\\:%6.2lf %spkts",
                        "GPRINT:tx:LAST: Last\\:%6.2lf %spkts",
                        "COMMENT:\\n",
                        "AREA:rx#0000FF60:Receive ",
                        "GPRINT:rx:MIN: Min\\:%6.2lf %spkts",
                        "GPRINT:rx:MAX: Max\\:%6.2lf %spkts",
                        "GPRINT:rx:AVERAGE: Avrg\\:%6.2lf %spkts",
                        "GPRINT:rx:LAST: Last\\:%6.2lf %spkts",
                        "LINE1:tx#FF0000",
                        "LINE1:rx#0000FF",
                        "COMMENT:\\n"
                    );
                }
            }
        }
    }    
}      
