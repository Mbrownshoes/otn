import csv
with open('build/kntm_matched_detections_2011.csv', 'rb') as f:
    with open('build/steelhead.csv', 'w+') as fp:
        reader = csv.reader(f)
        a = csv.writer(fp, delimiter=',')
        for ind, val in enumerate(reader):
            if ind ==0:
                a.writerow([val[1],val[18],val[20],val[21]])
            if "steelhead" in val[3]:
                a.writerow([val[1],val[18],val[20],val[21]])
