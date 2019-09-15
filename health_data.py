from xml.etree.ElementTree import parse
import pylab as py


#tree = parse('health_brooke_export.xml')
tree = parse('health_nick_export.xml')
root = tree.getroot()


dates = ['2019-08-30', '2019-08-31', '2019-09-01', '2019-09-02', '2019-09-03',
         '2019-09-04', '2019-09-05', '2019-09-06', '2019-09-07', '2019-09-08',
         '2019-09-09', '2019-09-10', '2019-09-11', '2019-09-12', '2019-09-13',
         '2019-09-14']

"""
## GREECE TRIP
dates = ['2019-05-30', '2019-05-31', '2019-06-01', '2019-06-02', '2019-06-03',
         '2019-06-04', '2019-06-05', '2019-06-06', '2019-06-07', '2019-06-08',
         '2019-06-09', '2019-06-10', '2019-06-11', '2019-06-12', '2019-06-13',
         '2019-06-14', '2019-06-15', '2019-06-16', '2019-06-17']
 
## MONTH OF AUGUST
dates = ['2019-08-01', '2019-08-02', '2019-08-03', '2019-08-04', '2019-08-05',
         '2019-08-06', '2019-08-07', '2019-08-08', '2019-08-09', '2019-08-10',
         '2019-08-11', '2019-08-12', '2019-08-13', '2019-08-14', '2019-08-15',
         '2019-08-16', '2019-08-17', '2019-08-18', '2019-08-19', '2019-08-20',
         '2019-08-21', '2019-08-22', '2019-08-23', '2019-08-24', '2019-08-25',
         '2019-08-26', '2019-08-27', '2019-08-28', '2019-08-29', '2019-08-30',
         '2019-08-31']
"""

entries = [0]*len(dates)
dist = [0]*len(dates)
step_counts = [0]*len(dates)

count = 0

for child in root:
    
    
    # print the export date and Me parts (first two lines)
    if(count < 1):
        print(child.tag, ' | ', child.attrib)
    
    
    # fills in the rest of the xml files
    if(count >= 2):
        temp = child.get('startDate')

        
        if(temp[:10] in dates and child.get('unit') == 'count'):
            index = dates.index(temp[:10])
            entries[index] = entries[index] + 1
            step_counts[index] = step_counts[index] + int(child.get('value'))
        
        
        if(temp[:10] in dates and child.get('unit') == 'mi'):
            index = dates.index(temp[:10])
            entries[index] = entries[index] + 1
            dist[index] = dist[index] + float(child.get('value'))
        
        
    count = count + 1
    

date = []

for d in dates:
    date.append(d.replace("2019-", ""))


py.figure(1)
py.title('Steps count')
py.plot(date, step_counts, 'r-')
py.ylabel('Steps (#)')
py.tick_params(axis='x', labelsize=7.5, labelrotation=70)
py.grid(color='grey', linestyle=':', linewidth=0.25, alpha=0.5)

py.figure(2)
py.title('Distance walked/ran')
py.plot(date, dist, 'b-')
py.ylabel('Distance travelled (miles)')
py.tick_params(axis='x', labelsize=7.5, labelrotation=70)
py.grid(color='grey', linestyle=':', linewidth=0.25, alpha=0.5)





