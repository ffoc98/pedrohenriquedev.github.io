<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Loja Variada - Seu site de vendas</title>
  <style>
    /* Reset básico */
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }
    body {
      font-family: Arial, sans-serif;
      background: #f5f5f5;
      color: #333;
      padding: 20px;
    }
    header {
      background: #2c3e50;
      color: white;
      padding: 15px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      border-radius: 5px;
    }
    header h1 {
      font-size: 24px;
    }
    nav button {
      background: #3498db;
      border: none;
      color: white;
      padding: 10px 15px;
      margin-left: 10px;
      border-radius: 4px;
      cursor: pointer;
      font-weight: bold;
      transition: background 0.3s;
    }
    nav button:hover {
      background: #2980b9;
    }

    /* Sessões */
    section {
      margin-top: 30px;
      background: white;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }
    h2 {
      margin-bottom: 15px;
      color: #2c3e50;
    }

    /* Produtos */
    .produtos-lista {
      display: grid;
      grid-template-columns: repeat(auto-fill,minmax(180px,1fr));
      gap: 20px;
    }
    .produto {
      border: 1px solid #ddd;
      border-radius: 5px;
      padding: 10px;
      background: #fafafa;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .produto img {
      max-width: 100%;
      border-radius: 5px;
      margin-bottom: 10px;
      height: 120px;
      object-fit: contain;
    }
    .produto h3 {
      font-size: 16px;
      margin-bottom: 8px;
      color: #34495e;
    }
    .produto p {
      font-size: 14px;
      color: #666;
      margin-bottom: 10px;
      flex-grow: 1;
    }
    .produto .preco {
      font-weight: bold;
      margin-bottom: 10px;
      color: #e67e22;
    }
    .produto button {
      background: #27ae60;
      border: none;
      color: white;
      padding: 8px;
      border-radius: 4px;
      cursor: pointer;
      font-weight: bold;
      transition: background 0.3s;
    }
    .produto button:hover {
      background: #219150;
    }

    /* CEP */
    .cep-container {
      margin-bottom: 15px;
    }
    .cep-container input {
      padding: 8px;
      font-size: 14px;
      width: 150px;
      border: 1px solid #ccc;
      border-radius: 4px;
      margin-right: 10px;
    }
    .cep-container button {
      padding: 8px 12px;
      background: #2980b9;
      border: none;
      color: white;
      border-radius: 4px;
      cursor: pointer;
      font-weight: bold;
      transition: background 0.3s;
    }
    .cep-container button:hover {
      background: #1c5d85;
    }
    .frete-info {
      margin-top: 10px;
      font-style: italic;
      color: #27ae60;
    }

    /* Carrinho */
    #carrinho {
      max-width: 400px;
      margin-top: 10px;
    }
    #carrinho ul {
      list-style: none;
      max-height: 200px;
      overflow-y: auto;
      margin-bottom: 10px;
    }
    #carrinho li {
      display: flex;
      justify-content: space-between;
      padding: 6px 0;
      border-bottom: 1px solid #ddd;
    }
    #carrinho button.remove-item {
      background: #c0392b;
      border: none;
      color: white;
      cursor: pointer;
      padding: 2px 6px;
      border-radius: 3px;
      font-size: 12px;
      transition: background 0.3s;
    }
    #carrinho button.remove-item:hover {
      background: #962d22;
    }
    #total {
      font-weight: bold;
      font-size: 16px;
      text-align: right;
      color: #34495e;
    }

    /* Footer */
    footer {
      margin-top: 40px;
      text-align: center;
      color: #aaa;
      font-size: 14px;
    }

    /* Responsivo */
    @media(max-width: 480px) {
      header {
        flex-direction: column;
        align-items: flex-start;
      }
      nav {
        margin-top: 10px;
        width: 100%;
      }
      nav button {
        margin-left: 0;
        margin-right: 10px;
      }
      .produtos-lista {
        grid-template-columns: 1fr 1fr;
      }
    }
  </style>
</head>
<body>
  <header>
    <h1>Loja Variada</h1>
    <nav>
      <button onclick="scrollParaSecao('promocoes')">Promoções</button>
      <button onclick="scrollParaSecao('produtos')">Produtos</button>
      <button onclick="scrollParaSecao('carrinho')">Carrinho (<span id="total-itens">0</span>)</button>
    </nav>
  </header>

  <section id="promocoes">
    <h2>Promoções da Semana</h2>
    <div class="produtos-lista" id="lista-promocoes">
      <!-- Produtos promocionais vão aqui -->
    </div>
  </section>

  <section id="cep-frete">
    <h2>Calcule o Frete</h2>
    <div class="cep-container">
      <input type="text" id="input-cep" placeholder="Digite seu CEP" maxlength="8" />
      <button onclick="calcularFrete()">Calcular</button>
    </div>
    <div id="frete-info" class="frete-info"></div>
  </section>

  <section id="produtos">
    <h2>Produtos</h2>
    <div class="produtos-lista" id="lista-produtos">
      <!-- Lista de produtos aqui -->
    </div>
  </section>

  <section id="carrinho">
    <h2>Carrinho de Compras</h2>
    <ul id="itens-carrinho"></ul>
    <div id="total">Total: R$ 0,00</div>
  </section>

  <footer>
    &copy; 2025 Loja Variada - Todos os direitos reservados
  </footer>

  <script>
    // Dados de exemplo para produtos e promoções
    const produtos = [
      { id: 1, nome: 'Camiseta Básica', descricao: 'Camiseta 100% algodão, várias cores', preco: 39.90, img: 'https://via.placeholder.com/150?text=Camiseta' },
      { id: 2, nome: 'Fone Bluetooth', descricao: 'Som de qualidade e sem fio', preco: 129.90, img: 'https://via.placeholder.com/150?text=Fone' },
      { id: 3, nome: 'Caneca Personalizada', descricao: 'Caneca com design exclusivo', preco: 25.50, img: 'https://via.placeholder.com/150?text=Caneca' },
      { id: 4, nome: 'Relógio Esportivo', descricao: 'Resistente à água e monitor de batimentos', preco: 299.00, img: 'https://via.placeholder.com/150?text=Relogio' },
      { id: 5, nome: 'Mochila para Notebook', descricao: 'Espaçosa e confortável', preco: 159.90, img: 'https://via.placeholder.com/150?text=Mochila' },
      { id: 6, nome: 'Tênis Casual', descricao: 'Confortável para o dia a dia', preco: 199.00, img: 'https://via.placeholder.com/150?text=Tenis' },
    ];

    const promocoesIds = [2, 4]; // Ids dos produtos em promoção

    // Carrinho de compras
    let carrinho = [];

    // Função para mostrar os produtos na tela
    function mostrarProdutos() {
      const lista = document.getElementById('lista-produtos');
      lista.innerHTML = '';
      produtos.forEach(prod => {
        const div = document.createElement('div');
        div.className = 'produto';
        div.innerHTML = `
          <img src="${prod.img}" alt="${prod.nome}" />
          <h3>${prod.nome}</h3>
          <p>${prod.descricao}</p>
          <div class="preco">R$ ${prod.preco.toFixed(2)}</div>
          <button onclick="adicionarAoCarrinho(${prod.id})">Adicionar ao carrinho</button>
        `;
        lista.appendChild(div);
      });
    }

    // Mostrar promoções
    function mostrarPromocoes() {
      const lista = document.getElementById('lista-promocoes');
      lista.innerHTML = '';
      promocoesIds.forEach(id => {
        const prod = produtos.find(p => p.id === id);
        if (prod) {
          const div = document.createElement('div');
          div.className = 'produto';
          div.innerHTML = `
            <img src="${prod.img}" alt="${prod.nome}" />
            <h3>${prod.nome} <span style="color:#e74c3c;">(Promoção!)</span></h3>
            <p>${prod.descricao}</p>
            <div class="preco">R$ ${prod.preco.toFixed(2)}</div>
            <button onclick="adicionarAoCarrinho(${prod.id})">Adicionar ao carrinho</button>
          `;
          lista.appendChild(div);
        }
      });
    }

    // Adicionar produto ao carrinho
    function adicionarAoCarrinho(id) {
      const produto = produtos.find(p => p.id === id);
      if (!produto) return;
      const item = carrinho.find(i => i.id === id);
      if (item) {
        item.quantidade++;
      } else {
        carrinho.push({ ...produto, quantidade: 1 });
      }
      atualizarCarrinho();
    }

    // Remover item do carrinho
    function removerDoCarrinho(id) {
      carrinho = carrinho.filter(i => i.id !== id);
      atualizarCarrinho();
    }

    // Atualizar visual do carrinho
    function atualizarCarrinho() {
      const lista = document.getElementById('itens-carrinho');
      lista.innerHTML = '';
      let total = 0;
      let totalItens = 0;
      carrinho.forEach(item => {
        total += item.preco * item.quantidade;
        totalItens += item.quantidade;
        const li = document.createElement('li');
        li.innerHTML = `
          ${item.nome} x ${item.quantidade} 
          <button class="remove-item" onclick="removerDoCarrinho(${item.id})">X</button>
        `;
        lista.appendChild(li);
      });
      document.getElementById('total').innerText = 'Total: R$ ' + total.toFixed(2);
      document.getElementById('total-itens').innerText = totalItens;
    }

    // Simulação simples de cálculo de frete por CEP
    function calcularFrete() {
      const cep = document.getElementById('input-cep').value.trim();
      const info = document.getElementById('frete-info');

      if (!/^\d{8}$/.test(cep)) {
        info.style.color = '#c0392b';
        info.innerText = 'Digite um CEP válido com 8 números.';
        return;
      }

      // Simula valor do frete baseado no último dígito do CEP
      const ultimoDigito = parseInt(cep.charAt(cep.length - 1));
      const valorFrete = 10 + ultimoDigito * 2; // R$10 a R$28, só de exemplo

      info.style.color = '#27ae60';
      info.innerText = `Frete estimado para CEP ${cep}: R$ ${valorFrete.toFixed(2)}`;
    }

    // Navegar para seção (scroll suave)
    function scrollParaSecao(id) {
      document.getElementById(id).scrollIntoView({ behavior: 'smooth' });
    }

    // Inicialização
    mostrarProdutos();
    mostrarPromocoes();
    atualizarCarrinho();

  </script>
</body>
</html>
