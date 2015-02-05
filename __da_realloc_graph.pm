#!/usr/bin/perl -w
use RRDs;
use warnings;
#use strict;

do "/usr/local/etc/scripts/rrd/__disklist.pl";

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
    
      my $params = ();
     
      RRDs::graph("/gs/www/mrtg/img_disk_all_realloc_$namesOfPeriods[$i].png",
            "--title=HDD reallocated sectors $namesOfPeriods[$i]",
            "--imgformat=PNG",
            "--width=800",
            "--height=100",
            "--vertical-label=number of sectors",
            "--start=-$periods[$i]",
            "--end=now",
            "--rigid",
            "DEF:da0=/gs/www/mrtg/rrd_disk_da0.rrd:realloc:LAST",
            "DEF:da1=/gs/www/mrtg/rrd_disk_da1.rrd:realloc:LAST",
            "DEF:da2=/gs/www/mrtg/rrd_disk_da2.rrd:realloc:LAST",
            "DEF:da3=/gs/www/mrtg/rrd_disk_da3.rrd:realloc:LAST",
            "DEF:da4=/gs/www/mrtg/rrd_disk_da4.rrd:realloc:LAST",
            "DEF:da5=/gs/www/mrtg/rrd_disk_da5.rrd:realloc:LAST",
            "DEF:da6=/gs/www/mrtg/rrd_disk_da6.rrd:realloc:LAST",
            "DEF:da7=/gs/www/mrtg/rrd_disk_da7.rrd:realloc:LAST",
            "DEF:da8=/gs/www/mrtg/rrd_disk_da8.rrd:realloc:LAST",
            "DEF:da9=/gs/www/mrtg/rrd_disk_da9.rrd:realloc:LAST",
            "DEF:da10=/gs/www/mrtg/rrd_disk_da10.rrd:realloc:LAST",
            "DEF:da11=/gs/www/mrtg/rrd_disk_da11.rrd:realloc:LAST",
            "DEF:da12=/gs/www/mrtg/rrd_disk_da12.rrd:realloc:LAST",
            "DEF:da13=/gs/www/mrtg/rrd_disk_da13.rrd:realloc:LAST",
            "DEF:da14=/gs/www/mrtg/rrd_disk_da14.rrd:realloc:LAST",
            "DEF:da15=/gs/www/mrtg/rrd_disk_da15.rrd:realloc:LAST",
            "DEF:da16=/gs/www/mrtg/rrd_disk_da16.rrd:realloc:LAST",
            "DEF:da17=/gs/www/mrtg/rrd_disk_da17.rrd:realloc:LAST",
            "DEF:da18=/gs/www/mrtg/rrd_disk_da18.rrd:realloc:LAST",
            "DEF:da19=/gs/www/mrtg/rrd_disk_da19.rrd:realloc:LAST",
            "DEF:ada1=/gs/www/mrtg/rrd_disk_ada1.rrd:realloc:LAST",
            "LINE1:da0#004000",
            "LINE1:da1#006000",
            "LINE1:da2#008000",
            "LINE1:da3#00A000",
            "LINE1:da4#00C000",
            "LINE1:da5#00E000",
            "LINE1:da6#400000",
            "LINE1:da7#600000",
            "LINE1:da8#800000",
            "LINE1:da9#A00000",
            "LINE1:da10#C00000",
            "LINE1:da11#E00000",
            "LINE1:da12#404000",
            "LINE1:da13#606000",
            "LINE1:da14#808000",
            "LINE1:da15#A0A000",
            "LINE1:da16#C0C000",
            "LINE1:da17#E0E000",
            "LINE1:da18#004040",
            "LINE1:da19#004040",
            "LINE1:ada1#004040",
            "COMMENT:\\n"
           );
    }
    else
    {
#      print $namesOfPeriods[$i]."\n";
      RRDs::graph("/gs/www/mrtg/img_disk_all_realloc_$namesOfPeriods[$i].png",
            "--title=HDD reallocated sectors $namesOfPeriods[$i]",
            "--imgformat=PNG",
            "--width=800",
            "--height=150",
            "--vertical-label=number of sectors",
            "--start=-$periods[$i]",
            "--end=now",
            "--rigid",
            "DEF:da0=/gs/www/mrtg/rrd_disk_da0.rrd:realloc:LAST",
            "DEF:da1=/gs/www/mrtg/rrd_disk_da1.rrd:realloc:LAST",
            "DEF:da2=/gs/www/mrtg/rrd_disk_da2.rrd:realloc:LAST",
            "DEF:da3=/gs/www/mrtg/rrd_disk_da3.rrd:realloc:LAST",
            "DEF:da4=/gs/www/mrtg/rrd_disk_da4.rrd:realloc:LAST",
            "DEF:da5=/gs/www/mrtg/rrd_disk_da5.rrd:realloc:LAST",
            "DEF:da6=/gs/www/mrtg/rrd_disk_da6.rrd:realloc:LAST",
            "DEF:da7=/gs/www/mrtg/rrd_disk_da7.rrd:realloc:LAST",
            "DEF:da8=/gs/www/mrtg/rrd_disk_da8.rrd:realloc:LAST",
            "DEF:da9=/gs/www/mrtg/rrd_disk_da9.rrd:realloc:LAST",
            "DEF:da10=/gs/www/mrtg/rrd_disk_da10.rrd:realloc:LAST",
            "DEF:da11=/gs/www/mrtg/rrd_disk_da11.rrd:realloc:LAST",
            "DEF:da12=/gs/www/mrtg/rrd_disk_da12.rrd:realloc:LAST",
            "DEF:da13=/gs/www/mrtg/rrd_disk_da13.rrd:realloc:LAST",
            "DEF:da14=/gs/www/mrtg/rrd_disk_da14.rrd:realloc:LAST",
            "DEF:da15=/gs/www/mrtg/rrd_disk_da15.rrd:realloc:LAST",
            "DEF:da16=/gs/www/mrtg/rrd_disk_da16.rrd:realloc:LAST",
            "DEF:da17=/gs/www/mrtg/rrd_disk_da17.rrd:realloc:LAST",
            "DEF:da18=/gs/www/mrtg/rrd_disk_da18.rrd:realloc:LAST",
            "DEF:da19=/gs/www/mrtg/rrd_disk_da19.rrd:realloc:LAST",
            "DEF:ada1=/gs/www/mrtg/rrd_disk_ada1.rrd:realloc:LAST",
            "LINE2:da0#004000:da0 ",
            "GPRINT:da0:LAST: Last\\:%4.lf",
            "LINE2:da1#006000:da1 ",
            "GPRINT:da1:LAST: Last\\:%4.lf",
            "LINE2:da2#008000:da2 ",
            "GPRINT:da2:LAST: Last\\:%4.lf",
            "LINE2:da3#00A000:da3 ",
            "GPRINT:da3:LAST: Last\\:%4.lf",
            "LINE2:da4#00C000:da4 ",
            "GPRINT:da4:LAST: Last\\:%4.lf",
            "COMMENT:\\n",
            "LINE2:da5#00E000:da5 ",
            "GPRINT:da5:LAST: Last\\:%4.lf",
            "LINE2:da6#400000:da6 ",
            "GPRINT:da6:LAST: Last\\:%4.lf",
            "LINE2:da7#600000:da7 ",
            "GPRINT:da7:LAST: Last\\:%4.lf",
            "LINE2:da8#800000:da8 ",
            "GPRINT:da8:LAST: Last\\:%4.lf",
            "LINE2:da9#A00000:da9 ",
            "GPRINT:da9:LAST: Last\\:%4.lf",
            "COMMENT:\\n",
            "LINE2:da10#C00000:da10",
            "GPRINT:da10:LAST: Last\\:%4.lf",
            "LINE2:da11#E00000:da11",
            "GPRINT:da11:LAST: Last\\:%4.lf",
            "LINE2:da12#404000:da12",
            "GPRINT:da12:LAST: Last\\:%4.lf",
            "LINE2:da13#606000:da13",
            "GPRINT:da13:LAST: Last\\:%4.lf",
            "LINE2:da14#808000:da14",
            "GPRINT:da14:LAST: Last\\:%4.lf",
            "COMMENT:\\n",
            "LINE2:da15#A0A000:da15",
            "GPRINT:da15:LAST: Last\\:%4.lf",
            "LINE2:da16#C0C000:da16",
            "GPRINT:da16:LAST: Last\\:%4.lf",
            "LINE2:da17#E0E000:da17",
            "GPRINT:da17:LAST: Last\\:%4.lf",
            "LINE2:da18#004040:da18",
            "GPRINT:da18:LAST: Last\\:%4.lf",
            "LINE2:da19#004040:da19",
            "GPRINT:da19:LAST: Last\\:%4.lf",
            "COMMENT:\\n",
            "LINE2:ada1#004040:ada1",
            "GPRINT:ada1:LAST: Last\\:%4.lf",
            "COMMENT:\\n"
           );

    } #if
  }  #if
}    #for



