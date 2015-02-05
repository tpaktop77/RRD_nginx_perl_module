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
      RRDs::graph("/gs/www/mrtg/img_cpu_$namesOfPeriods[$i].png",
            "--title=CPU Utilization and Idle $namesOfPeriods[$i]",
            "--imgformat=PNG",
            "--width=800",
            "--height=100",
            "--vertical-label=Percents",
            "--start=-$periods[$i]",
            "--end=now",
            "--rigid",
            "--slope-mode",
            "--upper-limit=100",
            "--lower-limit=0",
            "DEF:Uusr=/gs/www/mrtg/rrd/localhost/snmp/percent-cpu-user.rrd:value:AVERAGE",
            "DEF:Usys=/gs/www/mrtg/rrd/localhost/snmp/percent-cpu-system.rrd:value:AVERAGE",
            "DEF:Uidle=/gs/www/mrtg/rrd/localhost/snmp/percent-cpu-idle.rrd:value:AVERAGE",
            "AREA:Usys#FF0000::STACK",
            "AREA:Uusr#0000FF::STACK",
            "AREA:Uidle#00000040::STACK"
           );
    }
    else
    {
      RRDs::graph("/gs/www/mrtg/img_cpu_$namesOfPeriods[$i].png",
            "--title=CPU Utilization and Idle $namesOfPeriods[$i]",
            "--imgformat=PNG",
            "--width=800",
            "--height=150",
            "--vertical-label=Percents",
            "--start=-$periods[$i]",
            "--end=now",
            "--rigid",
            "--slope-mode",
            "--upper-limit=100",
            "--lower-limit=0",
            "DEF:Uusr=/gs/www/mrtg/rrd/localhost/snmp/percent-cpu-user.rrd:value:AVERAGE",
            "DEF:Usys=/gs/www/mrtg/rrd/localhost/snmp/percent-cpu-system.rrd:value:AVERAGE",
            "DEF:Uidle=/gs/www/mrtg/rrd/localhost/snmp/percent-cpu-idle.rrd:value:AVERAGE",
            "AREA:Usys#FF0000:System:STACK",
            "GPRINT:Usys:MIN: Min\\:%2.lf %%",
            "GPRINT:Usys:MAX: Max\\:%2.lf %%",
            "GPRINT:Usys:AVERAGE: Avrg\\:%2.lf %%",
            "GPRINT:Usys:LAST: Last\\:%2.lf %%",
            "COMMENT:\\n",
            "AREA:Uusr#0000FF:User  :STACK",
            "GPRINT:Uusr:MIN: Min\\:%2.lf %%",
            "GPRINT:Uusr:MAX: Max\\:%2.lf %%",
            "GPRINT:Uusr:AVERAGE: Avrg\\:%2.lf %%",
            "GPRINT:Uusr:LAST: Last\\:%2.lf %%",
            "COMMENT:\\n",
            "AREA:Uidle#00000040:Idle  :STACK",
            "GPRINT:Uidle:MIN: Min\\:%2.lf %%",
            "GPRINT:Uidle:MAX: Max\\:%2.lf %%",
            "GPRINT:Uidle:AVERAGE: Avrg\\:%2.lf %%",
            "GPRINT:Uidle:LAST: Last\\:%2.lf %%",
            "COMMENT:\\n"
           );
    }
  }
}
