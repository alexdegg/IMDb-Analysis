import pandas as pd
import requests
from io import BytesIO

@data_loader
def load_data_from_api(*args, **kwargs):
    
    url = 'https://datasets.imdbws.com/name.basics.tsv.gz'

    response = requests.get(url)
    response.raise_for_status()  # Check for HTTP issues

    # Convert the content to a bytes-like object for pandas
    tsv_gz_content = BytesIO(response.content)

    schema = {
        'nconst': str,
        'primaryName': str,
        'birthYear': str,
        'deathYear': str,
        'primaryProfession': str,
        'knownForTitles': str
    }
    
    df = pd.read_csv(tsv_gz_content, sep='\t', dtype=schema, compression='gzip')

    return df
