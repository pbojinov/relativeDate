angular.module('relativeDate',[])
  .provider 'relativeDate', ->
    _defaultFallbackFormat_ = "MMM d, yyyy" # Apr 18, 2014
    _cutoffDay_ = 22 # 3 weeks
    this.defaultFallbackFormat = (format) ->
      _defaultFallbackFormat_ = format

    this.cutoffDayCount = (numDays) ->
      _cutoffDay_ = numDays

    this.$get = [ 'dateFilter', (dateFilter) ->
      fallbackFormat = (formatOverride) ->
        if typeof formatOverride != 'undefined'
          return formatOverride
        else
          return _defaultFallbackFormat_

      time_ago = (time, override) ->
        date = new Date(time || "")
        diff = (((new Date()).getTime() - date.getTime()) / 1000)
        day_diff = Math.floor(diff / 86400)
        if ( isNaN(day_diff) || day_diff < 0 || day_diff >= _cutoffDay_ ) # if older than "_cutoffDay_" days, don't calculate a relative-time label
          return dateFilter(time, fallbackFormat(override)) # instead, use angular's dateFilter to return an absolute timestamp formated using the string assigned to "_fallbackFormat_"

        return day_diff == 0 && (
          diff < 60 && "just now" ||
          diff < 120 && "about 1 minute ago" ||
          diff < 3600 && Math.floor( diff / 60 ) + " minutes ago" ||
          diff < 7200 && "about 1 hour ago" ||
          diff < 86400 && Math.floor( diff / 3600 ) + " hours ago") ||
          day_diff == 1 && "Yesterday" ||
          day_diff < 7 && day_diff + " days ago" ||
          day_diff == 7 && "a week ago" ||
          Math.ceil( day_diff / 7 ) + " weeks ago"

      return {
        set: (date, optionalFormat) ->
          relDate = time_ago(date, optionalFormat)
          return relDate  
      }
    ]
    return this
