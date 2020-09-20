class RecipeCardComponent extends HTMLElement {
  constructor() {
    super();
    this.shadow = this.attachShadow({mode: 'open'});
    console.log(this.image);
  }

  connectedCallback() {
    this.render();
  }

  render() {
    this.shadow.innerHTML = `
      <div className="card mb-4">
        <img
          src='${this.getAttribute('image')}'
          className="card-img-top"
          alt='${this.alt}'
        />
        <div className="card-body">
          <h5 className="card-title"></h5>
        </div>
      </div>
    `
  }
}
customElements.define('recipe-card', RecipeCardComponent);
