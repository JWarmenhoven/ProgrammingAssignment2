def rankall(outcome, n='best'):
    if outcome not in ['heart attack', 'heart failure', 'pneumonia']:
        return('invalid outcome')
            
    df = pd.read_csv('outcome-of-care-measures.csv', usecols=[1,6,10,16,22], na_values='Not Available')
    df.columns = ['Name', 'State', 'heart attack', 'heart failure', 'pneumonia']
          
    sub = df[['Name', 'State', outcome]].dropna(axis=0, subset=[outcome]).sort(['State', outcome, 'Name'])
    grouped = sub.groupby('State')
        
    if n == 'best':
        return grouped.first().drop(outcome, axis=1)
    elif n == 'worst':
        return grouped.last().drop(outcome, axis=1)   
    elif type(n) == int:
        return grouped.nth(n).drop(outcome, axis=1)
    else:
        return('invalid ranking')
