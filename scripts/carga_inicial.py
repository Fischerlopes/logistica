import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

# Carregar variáveis do .env
load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

# Conexão com o PostgreSQL
engine = create_engine(f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}")

# Leitura do CSV
print("Lendo o CSV...")
df = pd.read_csv(
    "data/Base_Geral.csv",
    sep=",",           # separador padrão, ajustamos se necessário
    encoding="latin-1",  # encoding padrão, ajustamos se necessário
    low_memory=False
)

print(f"Total de linhas: {len(df)}")
print(f"Colunas: {list(df.columns)}")
print(df.head())

# Carga no PostgreSQL
print("\nCarregando no PostgreSQL...")
df.to_sql(
    name="base_geral",        # nome da tabela no banco
    con=engine,
    schema="public",
    if_exists="replace",      # substitui se já existir
    index=False,
    chunksize=10000           # carrega em blocos de 10k linhas (arquivo grande)
)

print("✅ Carga concluída com sucesso!")