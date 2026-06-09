import pandas as pd
from google.cloud import bigquery
from dotenv import load_dotenv
import os

load_dotenv()

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = os.getenv("GOOGLE_APPLICATION_CREDENTIALS")

PROJECT_ID = os.getenv("GCP_PROJECT_ID")
DATASET    = os.getenv("BQ_DATASET")
TABLE      = "base_geral"

print("Lendo o CSV...")
df = pd.read_csv(
    r"C:\Users\fisch\onedrive\documentos\neurometric\projetos_python\logistica\data\Base_Geral.csv",
    sep=",",
    encoding="latin-1",
    low_memory=False
)

print(f"Total de linhas: {len(df)}")
print(f"Colunas: {list(df.columns)}")

# Padroniza nomes das colunas (BigQuery não aceita espaços e caracteres especiais)
df.columns = (
    df.columns
    .str.strip()
    .str.lower()
    .str.replace(" ", "_")
    .str.replace(r"[^a-z0-9_]", "_", regex=True)
)

print("\nCarregando no BigQuery...")
client = bigquery.Client(project=PROJECT_ID)

table_id = f"{PROJECT_ID}.{DATASET}.{TABLE}"

job_config = bigquery.LoadJobConfig(
    write_disposition="WRITE_TRUNCATE",  # substitui se já existir
    autodetect=True                       # detecta tipos automaticamente
)

job = client.load_table_from_dataframe(df, table_id, job_config=job_config)
job.result()  # aguarda finalizar

print(f"✅ {job.output_rows} linhas carregadas com sucesso!")