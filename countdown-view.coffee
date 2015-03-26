Polymer "countdown-view",
  
  refreshSec: 60 * 60
  periodicReload: ->
    @countdowns = []

    # move to a new init-once method
    store = new rdfstore.Store({}, -> )

    store.registerDefaultProfileNamespaces()
    store.registerDefaultNamespace('ev', 'http://bigasterisk.com/event#')

    # using this instead of store.load('remote', url, ...) only
    # because the server isn't putting a good content-type on the
    # reponse.
    $.getJSON "/countdown/countdowns.json", (d) =>
      store.load "application/ld+json", d, (success, results) =>
        #store.load "remote", "gcalendarwatch/events?t1=2012-12-27T15:00:00-08:00", (success, results) ->
          store.execute "SELECT ?time ?label WHERE { ?ev ev:time ?time; rdfs:label ?label . } ORDER BY ?time", (success, results) =>
            @results = results
            @setCurrentCountdowns()
            
          store.execute "SELECT ?title ?start WHERE { ?ev ev:title ?title; ev:start ?start . }", (success, results) =>
            $.each results, (i, row) =>
              console.log "cal", JSON.stringify(row)
