mkdir .streamlit

cat > .streamlit/secrets.toml <<EOF
[connections.postgresql]
dialect = "postgresql"
host = "postgres"
port = "5432"
database = "${DB_NAME}"
username = "${DB_USER}"
password = "${DB_PASSWORD}"
EOF