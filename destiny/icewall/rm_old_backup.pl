#!/usr/bin/perl -w

# Удаляет старые бекапы по заданному в массиве условию

use strict;
use warnings;
use Time::Local;
#Для работы требуется библиотека Date:Calc, обязательно проверить установку
#apt-get install libdate-calc-perl
use Date::Calc qw(Add_Delta_Days Day_of_Week Add_Delta_YM);

#########
# Глобальные переменные
#########

my %backup = (
#    "moswar" =>  {
#        desc => "Moswar",                                                       # Описание
#        path => "/opt/backup/mysql/ponaehali",                                  # Путь к бекапу
#        store_day => 5,                                                         # Количество ежедневных бекапов
#        store_week => 4,                                                        # Количество еженедельных бекапов (понедельник)
#        store_month => 3,                                                       # Количество ежемесечных бекапов (первое число)
#    },
#    "gargona" =>  {
#        desc => "Botva gargona",
#        path => "/opt/backup/net/botva/gargona/mysql",
#        store_day => 5,
#        store_week => 4,
#        store_month => 3,
#    },
#    "sharm" =>  {
#        desc => "Botva sharm",
#        path => "/opt/backup/net/botva/sharm/mysql",
#        store_day => 5,
#        store_week => 4,
#        store_month => 3,
#    },
#    "tetra" =>  {
#        desc => "Botva tetra",
#        path => "/opt/backup/net/botva/tetra/mysql",
#        store_day => 5,
#        store_week => 4,
#        store_month => 3,
#    },
#    "2towers" =>  {
#        desc => "2towers",
#        path => "/opt/backup/net/2towers/mysql",
#        store_day => 5,
#        store_week => 4,
#        store_month => 3,
#    },
    "biggame" =>  {
        desc => "Biggame database clean",                                         # Описание
        path => "/opt/backup/mysql/biggame",                                      # Путь к бекапу
        store_day => 5,                                                         # Количество ежедневных бекапов
        store_week => 4,                                                        # Количество еженедельных бекапов (понедельник)
        store_month => 3,                                                       # Количество ежемесечных бекапов (первое число)
    },

);
my (@data);     # Массив дат
my @prj;        # Названия проектов


#########
# Main
#########


#@prj=%backup;
#@prj=@ARGV if defined $ARGV[0];
#print $ARGV[0]."\n" if defined $ARGV[0];

foreach my $project (keys %backup) {

#Обнуляем глобальный массив дат @data и производим его заполнение по заданным условиям
    @data=();
    date_day($backup{$project}{store_day});
    date_week($backup{$project}{store_week});
    date_month($backup{$project}{store_month});
    my @list=glob("$backup{$project}{path}/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]");
    for my $listfill (@list) {
        my $delete_list;
        my $del_fl;
        $del_fl=0;
        for my $dat (@data) {
            my $dat_path=$backup{$project}{path}."/".$dat;
            if ($listfill eq $dat_path) {
                $del_fl=1;
            }
        }
        if (!$del_fl)
        {
            system("rm -rf $listfill");
        }

    }
}


exit 0;

#########
# Sub
#########

# date_day($days)
#Формирует массив дней с текущей даты в количестве $days в глобальный массив дат @data
sub date_day {
    my $days=shift;
    my ($day, $month, $year) = (localtime)[3..5];

    $year=$year+1900;$month=$month+1;

    for(my $i=0;$i<$days;$i++)
    {
        my $tmpstr;
        my ($year2, $month2, $day2) = Add_Delta_Days( $year, $month, $day, $i*(-1));
        $tmpstr=$year2."-".sprintf("%02d",$month2)."-".sprintf("%02d",$day2); push @data,$tmpstr;
    }
}

# date_week($week)
#Формирует массив недель (понедельники) в количестве $week в глобальный массив дат @data
sub date_week {
    my $week=shift;
    my ($day, $month, $year) = (localtime)[3..5];

    $year=$year+1900;$month=$month+1;

    my $wday = Day_of_Week($year, $month, $day)-1;

    ($year, $month, $day) = Add_Delta_Days( $year, $month, $day, $wday*(-1));

    for(my $i=0;$i<$week;$i++)
    {
        my $tmpstr;
        my ($year2, $month2, $day2) = Add_Delta_Days( $year, $month, $day, ($i*7)*(-1));
        $tmpstr=$year2."-".sprintf("%02d",$month2)."-".sprintf("%02d",$day2); push @data,$tmpstr;
    }
}

# date_month($mon)
#Формирует массив месяцев (первое число) в количестве $mon в глобальный массив дат @data
sub date_month {
    my $mon=shift;
    my ($day, $month, $year) = (localtime)[3..5];

    $year=$year+1900;$month=$month+1;$day=1;

    for(my $i=0;$i<$mon;$i++)
    {
        my $tmpstr;
        my ($year2, $month2, $day2) = Add_Delta_YM( $year, $month, $day, 0, $i*(-1));
        $tmpstr=$year2."-".sprintf("%02d",$month2)."-".sprintf("%02d",$day2); push @data,$tmpstr;
    }
}


__END__
