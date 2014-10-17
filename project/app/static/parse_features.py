import json

features = json.load(open('features4326.json'))
ffeatures = []
for f in features:
    form_values = json.loads(f["properties"]["form_values"])
    if len(form_values) != 1:
        print form_values
    assert form_values[0]["name"].startswith("Kerro-lis")
    ffeatures.append({
            "type" : "Feature",
            "properties" : {
                "comment" : form_values[0]["value"],
                "name" : f["properties"]["name"],
                "createtime" : json.loads(f["properties"]["time"])["create_time"]
                },
            "geometry" : f["geometry"]
            })
outf = open('features.json','w')
outf.write(json.dumps(ffeatures))
outf.close()

