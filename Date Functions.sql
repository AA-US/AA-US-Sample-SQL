# ---------------------------------------------------------------------- #
# Functions-DateTime_CodeAlong.sql
# ---------------------------------------------------------------------- #

USE northwind;



# ---------------------------------------------------------------------- #
# MySQL Reference Manual: 12.7 Date and Time Functions
# ---------------------------------------------------------------------- #

SELECT	NOW() Now,
				CURDATE() CurrentDate,
				CURTIME() CurrentTime;



# ---------------------------------------------------------------------- #
# MySQL Reference Manual: 12.7 Date and Time Functions
# ---------------------------------------------------------------------- #
# DATE_FORMAT(date,format)
#
# TIME_FORMAT(time,format)
#
# ---------------------------------------------------------------------- #
# FORMAT SPECIFIERS (partial list) 
#
# 	%Y -  Year, numeric, four digits
# 	%y -  Year, numeric (two digits)
# 	%M -  Month name (January..December)
# 	%b -  Abbreviated month name (Jan..Dec)
# 	%m -  Month, numeric (00..12)
# 	%c -  Month, numeric (0..12)
#
# 	%d -  Day of the month, numeric (00..31)
# 	%e -  Day of the month, numeric (0..31)
#
# 	%j -  Day of year (001..366)
#
# 	%H -  Hour (00..23)
# 	%h -  Hour (01..12)
# 	%I -  Hour (01..12)
#
# 	%p -  AM or PM
# 	%r -  Time, 12-hour (hh:mm:ss followed by AM or PM)
# 	%T -  Time, 24-hour (hh:mm:ss)
#
# 	%i 	- Minutes, numeric (00..59)
# 	%S - Seconds (00..59)
# 	%s -  Seconds (00..59)
# ---------------------------------------------------------------------- #



SELECT	Now() Now,
				DATE_FORMAT(Now(), '%W, %d %M %Y %T') NowFormatted,
				CURDATE() CurrentDate,
        DATE_FORMAT(CURDATE(), '%d %b %Y') CurDateFomatted,
				CURTIME() CurrentTime,
				TIME_FORMAT(CURTIME(), '%r') CurTimeFormatted_r,
        TIME_FORMAT(CURTIME(), '%T') CurTimeFormatted_T;


-- datetime formats
SET	@fmtDt_USA = GET_FORMAT(DATETIME, 'USA'),
		@fmtDt_EUR = GET_FORMAT(DATETIME, 'EUR'),
    @fmtDt_ISO = GET_FORMAT(DATETIME, 'ISO'),
    @Now = Now();
SELECT	@Now Now,
				@fmtDt_USA fmtDt_USA,
        DATE_FORMAT(@Now, @fmtDt_USA) DateTime_USA,
        @fmtDt_EUR fmtDt_EUR,
        DATE_FORMAT(@Now, @fmtDt_EUR) DateTime_EUR,
        @fmtDt_ISO fmtDt_ISO,
        DATE_FORMAT(@Now, @fmtDt_ISO) DateTime_ISO;
    
-- date formats
SET @fmtDate_USA = GET_FORMAT(DATE, 'USA'),
		@fmtDate_EUR = GET_FORMAT(DATE, 'EUR'),
    @fmtDate_ISO = GET_FORMAT(DATE, 'ISO'),
    @Now = Now();
SELECT	@Now Now,
				@fmtDate_USA fmtDate_USA,
        DATE_FORMAT(@Now, @fmtDate_USA) Date_USA,
        @fmtDate_EUR fmtDate_EUR,
        DATE_FORMAT(@Now, @fmtDate_EUR) Date_EUR,
        @fmtDate_ISO fmtDate_ISO,
        DATE_FORMAT(@Now, @fmtDate_ISO) Date_ISO;

-- time formats
SET @fmtTime_USA = GET_FORMAT(TIME, 'USA'),
		@fmtTime_EUR = GET_FORMAT(TIME, 'EUR'),
    @fmtTime_ISO = GET_FORMAT(TIME, 'ISO'),
    @Now = Now();
SELECT	@Now Now,        
        @fmtTime_USA fmtTime_USA,
        DATE_FORMAT(@Now, @fmtTime_USA) Time_USA,
        @fmtTime_EUR fmtTime_EUR,
        DATE_FORMAT(@Now, @fmtTime_EUR) Time_EUR,
        @fmtTime_ISO fmtTime_ISO,
        DATE_FORMAT(@Now, @fmtTime_ISO) Time_ISO;
	

/*
	partial list
  
  DATE_ADD() Add time values (intervals) to a date value
	DATE_SUB() Subtract a time value (interval) from a date
	DATEDIFF() Subtract two dates
	DAY() Synonym for DAYOFMONTH()
	DAYNAME() Return the name of the weekday
	DAYOFMONTH() Return the day of the month (0-31)
	DAYOFWEEK() Return the weekday index of the argument
	DAYOFYEAR() Return the day of the year (1-366)
	EXTRACT() Extract part of a date
	HOUR() Extract the hour
	LAST_DAY Return the last day of the month for the argument
	LOCALTIME(), LOCALTIME Synonym for NOW()
	LOCALTIMESTAMP, LOCALTIMESTAMP() Synonym for NOW()
	MAKEDATE() Create a date from the year and day of year
	MAKETIME() Create time from hour, minute, second
	MINUTE() Return the minute from the argument
	MONTH() Return the month from the date passed
	MONTHNAME() Return the name of the month
	NOW() Return the current date and time
	QUARTER() Return the quarter from a date argument
	SECOND() Return the second (0-59)
	STR_TO_DATE() Convert a string to a date
	SUBDATE() Synonym for DATE_SUB() when invoked with three 	arguments
	SUBTIME() Subtract times
	SYSDATE() Return the time at which the function executes
	TIME() Extract the time portion of the expression passed
	TIME_FORMAT() Format as time
	TIME_TO_SEC() Return the argument converted to seconds
	TIMEDIFF() Subtract time
	TIMESTAMP() With a single argument, this function returns the date or datetime expression; with two arguments, the sum of the arguments
	TIMESTAMPADD() Add an interval to a datetime expression
	TIMESTAMPDIFF() Return the difference of two datetime expressions, 	using the units specified
	TO_DAYS() Return the date argument converted to days
	TO_SECONDS() Return the date or datetime argument converted to seconds since Year 0
	UTC_DATE() Return the current UTC date
	UTC_TIME() Return the current UTC time
	UTC_TIMESTAMP() Return the current UTC date and time
	WEEK() Return the week number
	WEEKDAY() Return the weekday index
	WEEKOFYEAR() Return the calendar week of the date (1-53)
	YEAR() Return the year
	YEARWEEK() Return the year and week	
*/

sELECT quarter(NOW());

SELECT ShippedDate,
date_format(SHIPPEDDATE, '%m_ D _%y')
 FROM orders ; -- INCORRECT
 
 sELECT ShippedDate,
    DATE_FORMAT(ShippedDate, '%M %d, %Y ') ShippedDateFormatted
FROM Orders
WHERE ShippedDate IS NOT NULL;


 sELECT ShippedDate,
    DATE_FORMAT(ShippedDate, '%M %d, %Y ') ShippedDateFormatted,
    yEAR(sHIPPEDDATE),
    MONTH(SHIPPEDDATE),
    dayofweek(SHIPPEDDATE)
FROM Orders
WHERE ShippedDate IS NOT NULL;




