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
       RRDs::graph("/gs/www/mrtg/img_fan_$namesOfPeriods[$i].png",
            "--title=Every Fans RPM $namesOfPeriods[$i]",
            "--imgformat=PNG",
            "--width=800",
            "--height=100",
            "--vertical-label=RPM",
            "--start=-$periods[$i]",
            "--end=now",
            "--rigid",
            "--slope-mode",
#            "--upper-limit=100",
            "--lower-limit=0",
            "DEF:FAN1=/gs/www/mrtg/rrd_fan.rrd:FAN1:LAST",
            "DEF:FAN2=/gs/www/mrtg/rrd_fan.rrd:FAN2:LAST",
            "DEF:FAN3=/gs/www/mrtg/rrd_fan.rrd:FAN3:LAST",
            "DEF:FAN4=/gs/www/mrtg/rrd_fan.rrd:FAN4:LAST",
            "DEF:FANA=/gs/www/mrtg/rrd_fan.rrd:FANA:LAST",
            "LINE1:FAN1#B0B000",#:'FAN 1'",
            "LINE1:FAN2#00B0B0",#:'FAN 2'",
            "LINE1:FAN3#00B000",#:'FAN 3'",
            "LINE1:FAN4#0000B0",#:'FAN 4'",
            "LINE1:FANA#B00000"#:'FAN A'",
           );
    }
    else
    {
       RRDs::graph("/gs/www/mrtg/img_fan_$namesOfPeriods[$i].png",
            "--title=Every Fans RPM $namesOfPeriods[$i]",
            "--imgformat=PNG",
            "--width=800",
            "--height=150",
            "--vertical-label=RPM",
            "--start=-$periods[$i]",
            "--end=now",
            "--rigid",
            "--slope-mode",
#            "--upper-limit=100",
            "--lower-limit=0",
            "DEF:FAN1=/gs/www/mrtg/rrd_fan.rrd:FAN1:LAST",
            "DEF:FAN2=/gs/www/mrtg/rrd_fan.rrd:FAN2:LAST",
            "DEF:FAN3=/gs/www/mrtg/rrd_fan.rrd:FAN3:LAST",
            "DEF:FAN4=/gs/www/mrtg/rrd_fan.rrd:FAN4:LAST",
            "DEF:FANA=/gs/www/mrtg/rrd_fan.rrd:FANA:LAST",
            "LINE1:FAN1#B0B000:'FAN 1'",
            "GPRINT:FAN1:MIN: Min\\:%5.lf",
            "GPRINT:FAN1:MAX: Max\\:%5.lf",
            "GPRINT:FAN1:AVERAGE: Avrg\\:%5.lf",
            "GPRINT:FAN1:LAST: Last\\:%5.lf",
            "COMMENT:\\n",
            "LINE1:FAN2#00B0B0:'FAN 2'",
            "GPRINT:FAN2:MIN: Min\\:%5.lf",
            "GPRINT:FAN2:MAX: Max\\:%5.lf",
            "GPRINT:FAN2:AVERAGE: Avrg\\:%5.lf",
            "GPRINT:FAN2:LAST: Last\\:%5.lf",
            "COMMENT:\\n",
            "LINE1:FAN3#00B000:'FAN 3'",
            "GPRINT:FAN3:MIN: Min\\:%5.lf",
            "GPRINT:FAN3:MAX: Max\\:%5.lf",
            "GPRINT:FAN3:AVERAGE: Avrg\\:%5.lf",
            "GPRINT:FAN3:LAST: Last\\:%5.lf",
            "COMMENT:\\n",
            "LINE1:FAN4#0000B0:'FAN 4'",
            "GPRINT:FAN4:MIN: Min\\:%5.lf",
            "GPRINT:FAN4:MAX: Max\\:%5.lf",
            "GPRINT:FAN4:AVERAGE: Avrg\\:%5.lf",
            "GPRINT:FAN4:LAST: Last\\:%5.lf",
            "COMMENT:\\n",
            "LINE1:FANA#B00000:'FAN A'",
            "GPRINT:FANA:MIN: Min\\:%5.lf",
            "GPRINT:FANA:MAX: Max\\:%5.lf",
            "GPRINT:FANA:AVERAGE: Avrg\\:%5.lf",
            "GPRINT:FANA:LAST: Last\\:%5.lf",
            "COMMENT:\\n"
           );

    }
  }
}


