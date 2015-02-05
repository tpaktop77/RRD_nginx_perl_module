#!/usr/bin/perl -w
use RRDs;
use warnings;
#use strict;

#$path = "/gs/www/mrtg/";
#$rrdfile = "rrd_da";


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

my @array = ();


for (my $iPeriod = 0; $iPeriod < (int @periods); $iPeriod++)
{
 if (
     (($iPeriod == 0) | ($iPeriod == 1) | ($iPeriod == 5)) |
     ($iPeriod == 2 && (($minute == 0) | ($minute == 15) | ($minute == 30) | ($minute == 45))) |
     ($iPeriod == 3 && $minute == 0) |
     ($iPeriod == 4 && $hour == 0 && $minute == 0)
    )
  {
    if ($iPeriod == 5)
    {
      RRDs::graph("/gs/www/mrtg/img_cpu_temp_".$namesOfPeriods[$iPeriod].".png",
            "--title=Each core and average temperature ".$namesOfPeriods[$iPeriod],
            "--imgformat=PNG",
            "--width=800",
            "--height=100",
            "--vertical-label=degree in Celsius (c)",
            "--start=-".$periods[$iPeriod],
            "--end=now",
            "--rigid",
            "--slope-mode",
            "--upper-limit=100",
            "--lower-limit=0",
            "DEF:C0temp=/gs/www/mrtg/rrd_cpu.rrd:C0temp:AVERAGE",
            "DEF:C1temp=/gs/www/mrtg/rrd_cpu.rrd:C1temp:AVERAGE",
            "DEF:C2temp=/gs/www/mrtg/rrd_cpu.rrd:C2temp:AVERAGE",
            "DEF:C3temp=/gs/www/mrtg/rrd_cpu.rrd:C3temp:AVERAGE",
            "DEF:CPUtemp=/gs/www/mrtg/rrd_cpu.rrd:CPUtemp:AVERAGE",
            "DEF:MBtemp=/gs/www/mrtg/rrd_fan.rrd:MBtemp:AVERAGE",
            "HRULE:75#FF0000::dashes",
            "HRULE:50#00FF0060::dashes",
            "AREA:CPUtemp#00B00060",
            "LINE1:C0temp#B000B0",#:Core #0  ",
            "LINE1:C1temp#B0B000",#:Core #1  ",
            "LINE1:C2temp#0000B0",#:Core #2  ",
            "LINE1:C3temp#00B0B0",#:Core #3  ",
            "LINE3:CPUtemp#004000B0",#:Core Avrg",
            "LINE2:MBtemp#606060"#:MB       "
           );
    }
    else
    {
        @array = ();

        push @array, "/gs/www/mrtg/img_cpu_temp_".$namesOfPeriods[$iPeriod].".png";
        push @array, "--title=Each core and average temperature ".$namesOfPeriods[$iPeriod];
        push @array, "--imgformat=PNG";
        push @array, "--width=800";
        push @array, "--height=150";
        push @array, "--vertical-label=degree in Celsius (c)";
        push @array, "--start=-".$periods[$iPeriod];
        push @array, "--end=now";
        push @array, "--rigid";
        push @array, "--slope-mode";
        push @array, "--upper-limit=100";
        push @array, "--lower-limit=0";
        push @array, "DEF:C0temp=/gs/www/mrtg/rrd_cpu.rrd:C0temp:AVERAGE";
        push @array, "DEF:C1temp=/gs/www/mrtg/rrd_cpu.rrd:C1temp:AVERAGE";
        push @array, "DEF:C2temp=/gs/www/mrtg/rrd_cpu.rrd:C2temp:AVERAGE";
        push @array, "DEF:C3temp=/gs/www/mrtg/rrd_cpu.rrd:C3temp:AVERAGE";
        push @array, "DEF:CPUtemp=/gs/www/mrtg/rrd_cpu.rrd:CPUtemp:AVERAGE";
        push @array, "DEF:MBtemp=/gs/www/mrtg/rrd_fan.rrd:MBtemp:AVERAGE";
        push @array, "HRULE:75#FF0000::dashes";
        push @array, "HRULE:50#00FF0060::dashes";
        push @array, "AREA:CPUtemp#00B00060";
        push @array, "LINE1:C0temp#B000B0:Core #0  ";
        # push @array, "GPRINT:MAX:Max \\: 1.lf";
        push @array, "LINE1:C1temp#B0B000:Core #1  ";
        push @array, "LINE1:C2temp#0000B0:Core #2  ";
        push @array, "LINE1:C3temp#00B0B0:Core #3  ";
        push @array, "LINE3:CPUtemp#004000B0:Core Avrg";
        push @array, "LINE2:MBtemp#606060:MB       ";
        RRDs::graph(@array);

        for (my $y = 0; $y < 4; $y++)
        {
            @array = ();
            push @array, "/gs/www/mrtg/img_cpu_".$y."_temp_".$namesOfPeriods[$iPeriod].".png";
            push @array, "--title=Core #".$y." temperature ".$namesOfPeriods[$iPeriod];
            push @array, "--imgformat=PNG";
            push @array, "--width=300";
            push @array, "--height=100";
            push @array, "--vertical-label=degree in Celsius (c)";
            push @array, "--start=-".$periods[$iPeriod];
            push @array, "--end=now";
            push @array, "--rigid";
            push @array, "--slope-mode";
            push @array, "--upper-limit=100";
            push @array, "--lower-limit=0";
            push @array, "DEF:Ctemp=/gs/www/mrtg/rrd_cpu.rrd:C".$y."temp:AVERAGE";
            push @array, "HRULE:75#FF0000::dashes";
            push @array, "HRULE:50#00FF0060::dashes";
            push @array, "LINE1:Ctemp#004000";
            push @array, "GPRINT:Ctemp:MIN: Min\\:%2.2lf";
            push @array, "GPRINT:Ctemp:MAX: Max\\:%2.2lf";
            push @array, "GPRINT:Ctemp:AVERAGE: Avrg\\:%2.2lf";
            push @array, "GPRINT:Ctemp:LAST: Last\\:%2.2lf";
            RRDs::graph(@array);
        }
        
        @array = ();
        push @array, "/gs/www/mrtg/img_mbtemp_".$namesOfPeriods[$iPeriod].".png";
        push @array, "--title=Motherboard temperature ".$namesOfPeriods[$iPeriod];
        push @array, "--imgformat=PNG";
        push @array, "--width=300";
        push @array, "--height=100";
        push @array, "--vertical-label=degree in Celsius (c)";
        push @array, "--start=-".$periods[$iPeriod];
        push @array, "--end=now";
        push @array, "--rigid";
        push @array, "--slope-mode";
        push @array, "--upper-limit=100";
        push @array, "--lower-limit=0";
        push @array, "DEF:MBtemp=/gs/www/mrtg/rrd_fan.rrd:MBtemp:AVERAGE";
        push @array, "HRULE:75#FF0000::dashes";
        push @array, "HRULE:50#00FF0060::dashes";
        push @array, "LINE1:MBtemp#004000";
        push @array, "GPRINT:MBtemp:MIN: Min\\:%2.2lf";
        push @array, "GPRINT:MBtemp:MAX: Max\\:%2.2lf";
        push @array, "GPRINT:MBtemp:AVERAGE: Avrg\\:%2.2lf";
        push @array, "GPRINT:MBtemp:LAST: Last\\:%2.2lf";
        RRDs::graph(@array);
    }
  }
}


