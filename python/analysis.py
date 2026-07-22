from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parents[1]
DATA_DIR = BASE_DIR / "data"
OUTPUT_DIR = DATA_DIR / "resultados"

OUTPUT_DIR.mkdir(exist_ok=True)


def carregar_dados() -> tuple[
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
    pd.DataFrame,
]:
    clientes = pd.read_csv(DATA_DIR / "clientes.csv", sep=";")
    categorias = pd.read_csv(DATA_DIR / "categorias.csv", sep=";")
    produtos = pd.read_csv(
        DATA_DIR / "produtos.csv",
        sep=";",
        decimal=".",
    )
    pedidos = pd.read_csv(
        DATA_DIR / "pedidos.csv",
        sep=";",
        parse_dates=["data_pedido"],
    )
    itens = pd.read_csv(
        DATA_DIR / "itens_pedido.csv",
        sep=";",
        decimal=".",
    )

    # Garante que os campos numéricos sejam interpretados corretamente
    produtos["preco"] = pd.to_numeric(
        produtos["preco"],
        errors="raise",
    )

    itens["preco_unitario"] = pd.to_numeric(
        itens["preco_unitario"],
        errors="raise",
    )

    itens["quantidade"] = pd.to_numeric(
        itens["quantidade"],
        errors="raise",
    )

    return clientes, categorias, produtos, pedidos, itens


def criar_base_vendas(
    clientes: pd.DataFrame,
    categorias: pd.DataFrame,
    produtos: pd.DataFrame,
    pedidos: pd.DataFrame,
    itens: pd.DataFrame,
) -> pd.DataFrame:
    vendas = (
        itens
        .merge(pedidos, on="id_pedido", how="inner")
        .merge(clientes, on="id_cliente", how="inner")
        .merge(produtos, on="id_produto", how="inner")
        .merge(categorias, on="id_categoria", how="inner")
    )

    vendas["valor_total"] = (
        vendas["quantidade"] * vendas["preco_unitario"]
    ).round(2)

    vendas["mes"] = (
        vendas["data_pedido"]
        .dt.to_period("M")
        .astype(str)
    )

    return vendas


def salvar_csv(
    dataframe: pd.DataFrame,
    caminho: Path,
) -> None:
    dataframe.to_csv(
        caminho,
        sep=";",
        decimal=",",
        index=False,
        encoding="utf-8-sig",
    )


def executar_analises(vendas: pd.DataFrame) -> None:
    faturamento_total = vendas["valor_total"].sum()

    valor_por_pedido = (
        vendas.groupby("id_pedido")["valor_total"]
        .sum()
    )

    ticket_medio = valor_por_pedido.mean()
    total_pedidos = vendas["id_pedido"].nunique()
    total_clientes = vendas["id_cliente"].nunique()

    faturamento_mensal = (
        vendas.groupby("mes", as_index=False)["valor_total"]
        .sum()
        .sort_values("mes")
    )

    top_produtos = (
        vendas.groupby("nome_produto", as_index=False)
        .agg(
            unidades_vendidas=("quantidade", "sum"),
            faturamento=("valor_total", "sum"),
        )
        .sort_values("faturamento", ascending=False)
        .head(10)
    )

    faturamento_categoria = (
        vendas.groupby(
            "nome_categoria",
            as_index=False,
        )["valor_total"]
        .sum()
        .sort_values("valor_total", ascending=False)
    )

    faturamento_estado = (
        vendas.groupby(
            "estado",
            as_index=False,
        )["valor_total"]
        .sum()
        .sort_values("valor_total", ascending=False)
    )

    top_clientes = (
        vendas.groupby(
            ["id_cliente", "nome", "cidade", "estado"],
            as_index=False,
        )["valor_total"]
        .sum()
        .sort_values("valor_total", ascending=False)
        .head(10)
    )

    salvar_csv(
        vendas,
        DATA_DIR / "vendas_detalhadas.csv",
    )

    salvar_csv(
        faturamento_mensal,
        OUTPUT_DIR / "faturamento_mensal.csv",
    )

    salvar_csv(
        top_produtos,
        OUTPUT_DIR / "top_10_produtos.csv",
    )

    salvar_csv(
        faturamento_categoria,
        OUTPUT_DIR / "faturamento_por_categoria.csv",
    )

    salvar_csv(
        faturamento_estado,
        OUTPUT_DIR / "faturamento_por_estado.csv",
    )

    salvar_csv(
        top_clientes,
        OUTPUT_DIR / "top_10_clientes.csv",
    )

    print("\n=== INDICADORES DA TECHSTORE BRASIL ===")
    print(f"Faturamento total: R$ {faturamento_total:,.2f}")
    print(f"Ticket médio: R$ {ticket_medio:,.2f}")
    print(f"Total de pedidos: {total_pedidos:,}")
    print(f"Clientes atendidos: {total_clientes:,}")

    print("\n=== CATEGORIA COM MAIOR FATURAMENTO ===")
    print(
        faturamento_categoria
        .head(1)
        .to_string(index=False)
    )

    print("\n=== PRODUTO COM MAIOR FATURAMENTO ===")
    print(
        top_produtos
        .head(1)
        .to_string(index=False)
    )

    print("\nAnálises concluídas com sucesso.")
    print(f"Arquivos gerados em: {OUTPUT_DIR}")


def main() -> None:
    dados = carregar_dados()
    vendas = criar_base_vendas(*dados)
    executar_analises(vendas)


if __name__ == "__main__":
    main()