import streamlit as st

from minio import Minio
from minio.error import InvalidResponseError

import os



# Initialize connection.
conn = st.connection('postgresql', type='sql')

# Perform query.
df = conn.query('SELECT * FROM league;')

st.write('Databasee connection:')
st.write(df)



st.write('Object Storage connection:')
storage_client = Minio(
    'minio:9000',
    access_key=os.getenv('STORAGE_STREAMLIT_USER'),
    secret_key=os.getenv('STORAGE_STREAMLIT_PASSWORD'),
    secure=False # Set to True for secure (HTTPS) access
)
try:
    buckets = storage_client.list_buckets()
    for bucket in buckets:
        st.write(f'- {bucket.name}')
except InvalidResponseError as err:
    st.error(f'MinIO error occurred: {err}')

bucket_name = st.text_input('Enter bucket name:')
if bucket_name:
    try:
        storage_objects = storage_client.list_objects(bucket_name)
        for obj in storage_objects:
            st.write(f'- {obj.object_name}')

            if '.jpg' in obj.object_name:
                st.image()
    except InvalidResponseError as err:
        st.error(f'MinIO error occurred: {err}')