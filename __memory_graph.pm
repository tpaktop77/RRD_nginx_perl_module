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

for (my $i = 0; $i < (int @periods); $i++)
{
 if (
     (($i == 0) | ($i == 1) | ($i == 5)) |
     ($i == 2 && (($minute == 0) | ($minute == 15) | ($minute == 30) | ($minute == 45))) |
     ($i == 3 && $minute == 0) |
     ($i == 4 && $hour == 0 && $minute == 0)
    )
  {
    if ($i == 5)
    {
       RRDs::graph("/gs/www/mrtg/img_memory_$namesOfPeriods[$i].png",
            "--title=Memory Utilization $namesOfPeriods[$i]",
            "--imgformat=PNG",
            "--width=800",
            "--height=100",
            "--vertical-label=Bytes",
            "--start=-$periods[$i]",
            "--end=now",
            "--rigid",
            "--base=1024",
            "--slope-mode",
#            "--upper-limit=100",
            "--lower-limit=0",
            "--units-exponent=6",
            "DEF:All=/gs/www/mrtg/rrd_memory.rrd:All:LAST",
            "DEF:Active=/gs/www/mrtg/rrd_memory.rrd:Active:LAST",
            "DEF:Inact=/gs/www/mrtg/rrd_memory.rrd:Inact:LAST",
            "DEF:Wired=/gs/www/mrtg/rrd_memory.rrd:Wired:LAST",
            "DEF:Cache=/gs/www/mrtg/rrd_memory.rrd:Cache:LAST",
            "DEF:Buf=/gs/www/mrtg/rrd_memory.rrd:Buf:LAST",
            "DEF:Free=/gs/www/mrtg/rrd_memory.rrd:Free:LAST",
            "GPRINT:All:LAST:  All   memory      \\:%6.2lf %sbytes",
            "COMMENT:\\n",
            "GPRINT:Wired:LAST:  Wired memory (ARC)\\:%6.2lf %sbytes",
            "COMMENT:\\n",
            "AREA:Active#A00000",#:Active  ",
            "LINE2:Inact#0000A0",#:Inactive",
            "LINE2:Cache#B0B000",#:Cache   ",
            "LINE2:Buf#6060FF",#:Buffered",
            "LINE2:Free#006000"#:Free    ",
            );
    }
    else
    {
       RRDs::graph("/gs/www/mrtg/img_memory_$namesOfPeriods[$i].png",
            "--title=Memory Utilization $namesOfPeriods[$i]",
            "--imgformat=PNG",
            "--width=800",
            "--height=150",
            "--vertical-label=Bytes",
            "--start=-$periods[$i]",
            "--end=now",
            "--rigid",
            "--base=1024",
            "--slope-mode",
#            "--upper-limit=100",
            "--lower-limit=0",
            "--units-exponent=6",
            "DEF:All=/gs/www/mrtg/rrd_memory.rrd:All:LAST",
            "DEF:Active=/gs/www/mrtg/rrd_memory.rrd:Active:LAST",
            "DEF:Inact=/gs/www/mrtg/rrd_memory.rrd:Inact:LAST",
            "DEF:Wired=/gs/www/mrtg/rrd_memory.rrd:Wired:LAST",
            "DEF:Cache=/gs/www/mrtg/rrd_memory.rrd:Cache:LAST",
            "DEF:Buf=/gs/www/mrtg/rrd_memory.rrd:Buf:LAST",
            "DEF:Free=/gs/www/mrtg/rrd_memory.rrd:Free:LAST",
#            "LINE1:All#00F000:All     ",
#            "GPRINT:All:MIN: Min\\:%6.2lf %sbytes",
#            "GPRINT:All:MAX: Max\\:%6.2lf %sbytes",
#            "GPRINT:All:AVERAGE: Avrg\\:%6.2lf %sbytes",
#            "GPRINT:All:LAST: Last\\:%6.2lf %sbytes",
            "GPRINT:All:LAST:  All   memory      \\:%6.2lf %sbytes",
            "COMMENT:\\n",
            "GPRINT:Wired:LAST:  Wired memory (ARC)\\:%6.2lf %sbytes",
            "COMMENT:\\n",
            "AREA:Active#A00000:Active  ",
            "GPRINT:Active:MIN: Min\\:%6.2lf %sbytes",
            "GPRINT:Active:MAX: Max\\:%6.2lf %sbytes",
            "GPRINT:Active:AVERAGE: Avrg\\:%6.2lf %sbytes",
            "GPRINT:Active:LAST: Last\\:%6.2lf %sbytes",
            "COMMENT:\\n",
            "LINE2:Inact#0000A0:Inactive",
            "GPRINT:Inact:MIN: Min\\:%6.2lf %sbytes",
            "GPRINT:Inact:MAX: Max\\:%6.2lf %sbytes",
            "GPRINT:Inact:AVERAGE: Avrg\\:%6.2lf %sbytes",
            "GPRINT:Inact:LAST: Last\\:%6.2lf %sbytes",
            "COMMENT:\\n",
#            "AREA:Wired#90E0403F:Wired   ",
#            "GPRINT:Wired:MIN: Min\\:%6.2lf %sbytes",
#            "GPRINT:Wired:MAX: Max\\:%6.2lf %sbytes",
#            "GPRINT:Wired:AVERAGE: Avrg\\:%6.2lf %sbytes",
#            "GPRINT:Wired:LAST: Last\\:%6.2lf %sbytes",
            "COMMENT:\\n",
            "LINE2:Cache#B0B000:Cache   ",
            "GPRINT:Cache:MIN: Min\\:%6.2lf %sbytes",
            "GPRINT:Cache:MAX: Max\\:%6.2lf %sbytes",
            "GPRINT:Cache:AVERAGE: Avrg\\:%6.2lf %sbytes",
            "GPRINT:Cache:LAST: Last\\:%6.2lf %sbytes",
            "COMMENT:\\n",
            "LINE2:Buf#6060FF:Buffered",
            "GPRINT:Buf:MIN: Min\\:%6.2lf %sbytes",
            "GPRINT:Buf:MAX: Max\\:%6.2lf %sbytes",
            "GPRINT:Buf:AVERAGE: Avrg\\:%6.2lf %sbytes",
            "GPRINT:Buf:LAST: Last\\:%6.2lf %sbytes",
            "COMMENT:\\n",
            "LINE2:Free#006000:Free    ",
            "GPRINT:Free:MIN: Min\\:%6.2lf %sbytes",
            "GPRINT:Free:MAX: Max\\:%6.2lf %sbytes",
            "GPRINT:Free:AVERAGE: Avrg\\:%6.2lf %sbytes",
            "GPRINT:Free:LAST: Last\\:%6.2lf %sbytes",
            "COMMENT:\\n"
           );
    }
  }
}


