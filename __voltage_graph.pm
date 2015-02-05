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
      RRDs::graph("/gs/www/mrtg/img_voltage_$namesOfPeriods[$i].png",
            "--title=Voltage for different sources $namesOfPeriods[$i]",
            "--imgformat=PNG",
            "--width=800",
            "--height=100",
            "--vertical-label=Volts",
            "--start=-$periods[$i]",
            "--end=now",
            "--rigid",
            "--slope-mode",
#            "--upper-limit=100",
            "--lower-limit=0",
            "DEF:Vcore=/gs/www/mrtg/rrd_voltage.rrd:Vcore:LAST",
            "DEF:P33VCC=/gs/www/mrtg/rrd_voltage.rrd:P33VCC:LAST",
            "DEF:P12V=/gs/www/mrtg/rrd_voltage.rrd:P12V:LAST",
            "DEF:VDIMM=/gs/www/mrtg/rrd_voltage.rrd:VDIMM:LAST",
            "DEF:P5VCC=/gs/www/mrtg/rrd_voltage.rrd:P5VCC:LAST",
            "DEF:M12V=/gs/www/mrtg/rrd_voltage.rrd:M12V:LAST",
            "DEF:VBAT=/gs/www/mrtg/rrd_voltage.rrd:VBAT:LAST",
            "DEF:VSB=/gs/www/mrtg/rrd_voltage.rrd:VSB:LAST",
            "DEF:AVCC=/gs/www/mrtg/rrd_voltage.rrd:AVCC:LAST",
            "LINE1:Vcore#B0B000",#:Vcore ",
            "LINE1:P33VCC#00B0B0",#:3.3VCC",
            "LINE1:P12V#B000B0",#:12V   ",
            "LINE1:VDIMM#0000B0",#:VDIMM ",
            "LINE1:P5VCC#B00000",#:5VCC  ",
            "LINE1:M12V#00B000",#:-12V  ",
            "LINE1:VBAT#808000",#:VBAT  ",
            "LINE1:VSB#008080",#:VSB   ",
            "LINE1:AVCC#800080"#:AVCC  "
            );
    }
    else
    {
      RRDs::graph("/gs/www/mrtg/img_voltage_$namesOfPeriods[$i].png",
            "--title=Voltage for different sources $namesOfPeriods[$i]",
            "--imgformat=PNG",
            "--width=800",
            "--height=250",
            "--vertical-label=Volts",
            "--start=-$periods[$i]",
            "--end=now",
            "--rigid",
            "--slope-mode",
#            "--upper-limit=100",
            "--lower-limit=0",
            "DEF:Vcore=/gs/www/mrtg/rrd_voltage.rrd:Vcore:LAST",
            "DEF:P33VCC=/gs/www/mrtg/rrd_voltage.rrd:P33VCC:LAST",
            "DEF:P12V=/gs/www/mrtg/rrd_voltage.rrd:P12V:LAST",
            "DEF:VDIMM=/gs/www/mrtg/rrd_voltage.rrd:VDIMM:LAST",
            "DEF:P5VCC=/gs/www/mrtg/rrd_voltage.rrd:P5VCC:LAST",
            "DEF:M12V=/gs/www/mrtg/rrd_voltage.rrd:M12V:LAST",
            "DEF:VBAT=/gs/www/mrtg/rrd_voltage.rrd:VBAT:LAST",
            "DEF:VSB=/gs/www/mrtg/rrd_voltage.rrd:VSB:LAST",
            "DEF:AVCC=/gs/www/mrtg/rrd_voltage.rrd:AVCC:LAST",
            "LINE1:Vcore#B0B000:Vcore ",
            "GPRINT:Vcore:MIN: Min\\: %5.2lf",
            "GPRINT:Vcore:MAX: Max\\: %5.2lf",
            "GPRINT:Vcore:AVERAGE: Avrg\\: %5.2lf",
            "GPRINT:Vcore:LAST: Last\\: %5.2lf",
            "COMMENT:\\n",
            "LINE1:P33VCC#00B0B0:3.3VCC",
            "GPRINT:P33VCC:MIN: Min\\: %5.2lf",
            "GPRINT:P33VCC:MAX: Max\\: %5.2lf",
            "GPRINT:P33VCC:AVERAGE: Avrg\\: %5.2lf",
            "GPRINT:P33VCC:LAST: Last\\: %5.2lf",
            "COMMENT:\\n",
            "LINE1:P12V#B000B0:12V   ",
            "GPRINT:P12V:MIN: Min\\: %5.2lf",
            "GPRINT:P12V:MAX: Max\\: %5.2lf",
            "GPRINT:P12V:AVERAGE: Avrg\\: %5.2lf",
            "GPRINT:P12V:LAST: Last\\: %5.2lf",
            "COMMENT:\\n",
            "LINE1:VDIMM#0000B0:VDIMM ",
            "GPRINT:VDIMM:MIN: Min\\: %5.2lf",
            "GPRINT:VDIMM:MAX: Max\\: %5.2lf",
            "GPRINT:VDIMM:AVERAGE: Avrg\\: %5.2lf",
            "GPRINT:VDIMM:LAST: Last\\: %5.2lf",
            "COMMENT:\\n",
            "LINE1:P5VCC#B00000:5VCC  ",
            "GPRINT:P5VCC:MIN: Min\\: %5.2lf",
            "GPRINT:P5VCC:MAX: Max\\: %5.2lf",
            "GPRINT:P5VCC:AVERAGE: Avrg\\: %5.2lf",
            "GPRINT:P5VCC:LAST: Last\\: %5.2lf",
            "COMMENT:\\n",
            "LINE1:M12V#00B000:-12V  ",
            "GPRINT:M12V:MIN: Min\\: %5.2lf",
            "GPRINT:M12V:MAX: Max\\: %5.2lf",
            "GPRINT:M12V:AVERAGE: Avrg\\: %5.2lf",
            "GPRINT:M12V:LAST: Last\\: %5.2lf",
            "COMMENT:\\n",
            "LINE1:VBAT#808000:VBAT  ",
            "GPRINT:VBAT:MIN: Min\\: %5.2lf",
            "GPRINT:VBAT:MAX: Max\\: %5.2lf",
            "GPRINT:VBAT:AVERAGE: Avrg\\: %5.2lf",
            "GPRINT:VBAT:LAST: Last\\: %5.2lf",
            "COMMENT:\\n",
            "LINE1:VSB#008080:VSB   ",
            "GPRINT:VSB:MIN: Min\\: %5.2lf",
            "GPRINT:VSB:MAX: Max\\: %5.2lf",
            "GPRINT:VSB:AVERAGE: Avrg\\: %5.2lf",
            "GPRINT:VSB:LAST: Last\\: %5.2lf",
            "COMMENT:\\n",
            "LINE1:AVCC#800080:AVCC  ",
            "GPRINT:AVCC:MIN: Min\\: %5.2lf",
            "GPRINT:AVCC:MAX: Max\\: %5.2lf",
            "GPRINT:AVCC:AVERAGE: Avrg\\: %5.2lf",
            "GPRINT:AVCC:LAST: Last\\: %5.2lf",
            "COMMENT:\\n"
           );
    }
  }
}
