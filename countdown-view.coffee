Polymer "countdown-view",
  
  refreshSec: 60 * 60
  periodicReload: ->
    @countdowns = []

    # move to a new init-once method
    store = new rdfstore.Store({}, -> )

    store.registerDefaultProfileNamespaces()
    store.registerDefaultNamespace('ev', 'http://bigasterisk.com/event#')

    store.load "remote", "/countdown/countdowns.json", (success, results) =>
      #store.load "remote", "gcalendarwatch/events?t1=2012-12-27T15:00:00-08:00", (success, results) ->
        store.execute "SELECT ?time ?label WHERE { ?ev ev:time ?time; rdfs:label ?label . } ORDER BY ?time", (success, results) =>
          console.log('countdowns', results)
          @countdowns = results
          # rerun this more often, to keep the fromNow times right, for short countdowns
          @countdowns.forEach (r) =>
            m = moment(new Date(r.time.value))
            r.fromNow = m.fromNow()
            r.soonDays = []
            days = moment.duration(m.valueOf() - moment().valueOf()).as('days')
            if days < 7
              r.soonDays.push('d') for d in [0...days]

        store.execute "SELECT ?title ?start WHERE { ?ev ev:title ?title; ev:start ?start . }", (success, results) =>
          $.each results, (i, row) =>
            console.log "cal", JSON.stringify(row)
