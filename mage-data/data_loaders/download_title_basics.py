import pandas as pd
import requests
from io import BytesIO

@data_loader
def load_data_from_api(*args, **kwargs):
    
    url = 'https://datasets.imdbws.com/title.ratings.tsv.gz'

    response = requests.get(url)
    response.raise_for_status()  # Check for HTTP issues

    # Convert the content to a bytes-like object for pandas
    tsv_gz_content = BytesIO(response.content)

    schema = {
        'tconst': str,
        'titleType': str,
        'primaryTitle': str,
        'originalTitle': str,
        'isAdult': str,
        'startYear': str,
        'endYear': str,
        'runtimeMinutes': str,
        'genres': str
    }
    
    df = pd.read_csv(tsv_gz_content, sep='\t', dtype=schema, compression='gzip')

    return df
