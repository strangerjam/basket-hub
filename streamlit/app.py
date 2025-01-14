import streamlit as st

# Initialize connection.
conn = st.connection('postgresql', type='sql')

# Perform query.
df = conn.query('SELECT * FROM league;')

# Print results.
st.write(
    df
)
