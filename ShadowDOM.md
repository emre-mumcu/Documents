<div id="widget"></div>

<script>
  const host = document.querySelector("#widget");
  const shadow = host.attachShadow({ mode: "open" });

  shadow.innerHTML = `
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <div class="p-3">
      <button class="btn btn-primary">
        Bootstrap Buton (izole)
      </button>
    </div>
  `;
</script>




<div id="app"></div>

<script>
  const host = document.querySelector("#app");

  const shadow = host.attachShadow({ mode: "open" });

  shadow.innerHTML = `
    <style>
      button {
        background: red;
        color: white;
        padding: 10px;
      }
    </style>

    <button>Shadow DOM Butonu</button>
  `;
</script>




<my-widget></my-widget>

<script>
class MyWidget extends HTMLElement {
  constructor() {
    super();
    const shadow = this.attachShadow({ mode: "open" });

    shadow.innerHTML = `
      <link rel="stylesheet" href="bootstrap.css">
      <div class="container">
        <button class="btn btn-success">Widget Butonu</button>
      </div>
    `;
  }
}

customElements.define("my-widget", MyWidget);
</script>








const host = document.querySelector("#app");

// eski içerik
const oldContent = host.innerHTML;

host.innerHTML = "";

const shadow = host.attachShadow({ mode: "open" });

shadow.innerHTML = `
  <div class="wrapper">
    ${oldContent}
  </div>
`;






<div id="app">
  <p>Eski içerik burada</p>
</div>

<script>
const host = document.querySelector("#app");
const shadow = host.attachShadow({ mode: "open" });

shadow.innerHTML = `
  <style>
    .box { border: 2px solid red; padding: 10px; }
  </style>

  <div class="box">
    <slot></slot>
  </div>
`;
</script>





































