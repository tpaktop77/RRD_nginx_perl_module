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
      RRDs::graph("/gs/www/mrtg/img_poolsize_short.png",
            "--title=Pools spaces daily",
            "--imgformat=PNG",
            "--width=800",
            "--height=150",
            "--vertical-label=Space in gigabytes",
            "--start=-1d",
            "--end=now",
            "--rigid",
            "--slope-mode",
#            "--upper-limit=100",
            "--lower-limit=0",
            "DEF:gsTotal=/gs/www/mrtg/rrd_poolsize_gs.rrd:Total:LAST",
            "DEF:gsUsed=/gs/www/mrtg/rrd_poolsize_gs.rrd:Used:LAST",
            "DEF:gsAvail=/gs/www/mrtg/rrd_poolsize_gs.rrd:Avail:LAST",
            "DEF:gsCapacity=/gs/www/mrtg/rrd_poolsize_gs.rrd:Capacity:LAST",
            "DEF:bkpTotal=/gs/www/mrtg/rrd_poolsize_bkp.rrd:Total:LAST",
            "DEF:bkpUsed=/gs/www/mrtg/rrd_poolsize_bkp.rrd:Used:LAST",
            "DEF:bkpAvail=/gs/www/mrtg/rrd_poolsize_bkp.rrd:Avail:LAST",
            "DEF:bkpCapacity=/gs/www/mrtg/rrd_poolsize_bkp.rrd:Capacity:LAST",
            "DEF:dlTotal=/gs/www/mrtg/rrd_poolsize_dl.rrd:Total:LAST",
            "DEF:dlUsed=/gs/www/mrtg/rrd_poolsize_dl.rrd:Used:LAST",
            "DEF:dlAvail=/gs/www/mrtg/rrd_poolsize_dl.rrd:Avail:LAST",
            "DEF:dlCapacity=/gs/www/mrtg/rrd_poolsize_dl.rrd:Capacity:LAST",
            "LINE2:gsTotal#006000:gs  Total  :dashes",
            "LINE2:gsUsed#00B000:gs  Used   ",
            "AREA:gsAvail#00F00060:gs  Avail  ",
            "LINE2:bkpTotal#600000:bkp Total:dashes",
            "LINE2:bkpUsed#B00000:bkp Used ",
            "AREA:bkpAvail#F0000060:bkp Avail",
            "LINE2:dlTotal#000060:dl Total  :dashes",
            "LINE2:dlUsed#0000B0:dl Used   ",
            "AREA:dlAvail#0000F060:dl Avail  ",
            "COMMENT:\\n"
           );
    }
    else
    {
      RRDs::graph("/gs/www/mrtg/img_poolsize_$namesOfPeriods[$i].png",
            "--title=Pools spaces $namesOfPeriods[$i]",
            "--imgformat=PNG",
            "--width=800",
            "--height=150",
            "--vertical-label=Space in gigabytes",
            "--start=-$periods[$i]",
            "--end=now",
            "--rigid",
            "--slope-mode",
#            "--upper-limit=100",
            "--lower-limit=0",
            "DEF:gsTotal=/gs/www/mrtg/rrd_poolsize_gs.rrd:Total:LAST",
            "DEF:gsUsed=/gs/www/mrtg/rrd_poolsize_gs.rrd:Used:LAST",
            "DEF:gsAvail=/gs/www/mrtg/rrd_poolsize_gs.rrd:Avail:LAST",
            "DEF:gsCapacity=/gs/www/mrtg/rrd_poolsize_gs.rrd:Capacity:LAST",
            "DEF:bkpTotal=/gs/www/mrtg/rrd_poolsize_bkp.rrd:Total:LAST",
            "DEF:bkpUsed=/gs/www/mrtg/rrd_poolsize_bkp.rrd:Used:LAST",
            "DEF:bkpAvail=/gs/www/mrtg/rrd_poolsize_bkp.rrd:Avail:LAST",
            "DEF:bkpCapacity=/gs/www/mrtg/rrd_poolsize_bkp.rrd:Capacity:LAST",
            "DEF:dlTotal=/gs/www/mrtg/rrd_poolsize_dl.rrd:Total:LAST",
            "DEF:dlUsed=/gs/www/mrtg/rrd_poolsize_dl.rrd:Used:LAST",
            "DEF:dlAvail=/gs/www/mrtg/rrd_poolsize_dl.rrd:Avail:LAST",
            "DEF:dlCapacity=/gs/www/mrtg/rrd_poolsize_dl.rrd:Capacity:LAST",
            "LINE2:gsTotal#006000:gs  Total  :dashes",
            "GPRINT:gsTotal:MIN: Min\\: %4.lf",
            "GPRINT:gsTotal:MAX: Max\\: %4.lf",
            "GPRINT:gsTotal:AVERAGE: Avrg\\: %4.lf",
            "GPRINT:gsTotal:LAST: Last\\: %4.lf",
            "GPRINT:gsCapacity:LAST: Capacity\\: %2.2lf",
            "COMMENT:\\n",
            "LINE2:gsUsed#00B000:gs  Used   ",
            "GPRINT:gsUsed:MIN: Min\\: %4.lf",
            "GPRINT:gsUsed:MAX: Max\\: %4.lf",
            "GPRINT:gsUsed:AVERAGE: Avrg\\: %4.lf",
            "GPRINT:gsUsed:LAST: Last\\: %4.lf",
            "COMMENT:\\n",
            "AREA:gsAvail#00F00060:gs  Avail  ",
            "GPRINT:gsAvail:MIN: Min\\: %4.lf",
            "GPRINT:gsAvail:MAX: Max\\: %4.lf",
            "GPRINT:gsAvail:AVERAGE: Avrg\\: %4.lf",
            "GPRINT:gsAvail:LAST: Last\\: %4.lf",
            "COMMENT:\\n",
            "LINE2:bkpTotal#600000:bkp Total:dashes",
            "GPRINT:bkpTotal:MIN: Min\\: %4.lf",
            "GPRINT:bkpTotal:MAX: Max\\: %4.lf",
            "GPRINT:bkpTotal:AVERAGE: Avrg\\: %4.lf",
            "GPRINT:bkpTotal:LAST: Last\\: %4.lf",
            "GPRINT:bkpCapacity:LAST: Capacity\\: %2.2lf",
            "COMMENT:\\n",
            "LINE2:bkpUsed#B00000:bkp Used ",
            "GPRINT:bkpUsed:MIN: Min\\: %4.lf",
            "GPRINT:bkpUsed:MAX: Max\\: %4.lf",
            "GPRINT:bkpUsed:AVERAGE: Avrg\\: %4.lf",
            "GPRINT:bkpUsed:LAST: Last\\: %4.lf",
            "COMMENT:\\n",
            "AREA:bkpAvail#F0000060:bkp Avail",
            "GPRINT:bkpAvail:MIN: Min\\: %4.lf",
            "GPRINT:bkpAvail:MAX: Max\\: %4.lf",
            "GPRINT:bkpAvail:AVERAGE: Avrg\\: %4.lf",
            "GPRINT:bkpAvail:LAST: Last\\: %4.lf",
            "COMMENT:\\n",
            "LINE2:dlTotal#000060:dl Total  :dashes",
            "GPRINT:dlTotal:MIN: Min\\: %4.lf",
            "GPRINT:dlTotal:MAX: Max\\: %4.lf",
            "GPRINT:dlTotal:AVERAGE: Avrg\\: %4.lf",
            "GPRINT:dlTotal:LAST: Last\\: %4.lf",
            "GPRINT:dlCapacity:LAST: Capacity\\: %2.2lf",
            "COMMENT:\\n",
            "LINE2:dlUsed#0000B0:dl Used   ",
            "GPRINT:dlUsed:MIN: Min\\: %4.lf",
            "GPRINT:dlUsed:MAX: Max\\: %4.lf",
            "GPRINT:dlUsed:AVERAGE: Avrg\\: %4.lf",
            "GPRINT:dlUsed:LAST: Last\\: %4.lf",
            "COMMENT:\\n",
            "AREA:dlAvail#0000F060:dl Avail  ",
            "GPRINT:dlAvail:MIN: Min\\: %4.lf",
            "GPRINT:dlAvail:MAX: Max\\: %4.lf",
            "GPRINT:dlAvail:AVERAGE: Avrg\\: %4.lf",
            "GPRINT:dlAvail:LAST: Last\\: %4.lf",
            "COMMENT:\\n"
      );
   } #if
  }  #if
}    #for
