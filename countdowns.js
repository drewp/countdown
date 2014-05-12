{
    "@context": {
        "countdown":"http://bigasterisk.com/countdown#CountdownEvent",
        "label": "http://www.w3.org/2000/01/rdf-schema#label",
        "time": {
            "@id": "http://bigasterisk.com/event#time",
            "@type": "xsd:dateTime"
        },
        "xsd": "http://www.w3.org/2001/XMLSchema#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#"
    },
    "@graph": [
        {"@type":"countdown", "time": "2014-05-17T09:30:00-07:00", "label": "maker faire"},
        {"@type":"countdown", "time": "2014-10-19T08:00:00-07:00", "label": "mini maker faire"}
    ]
}
