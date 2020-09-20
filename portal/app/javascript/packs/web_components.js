function importAll(r) {
  r.keys().forEach(r)
}

importAll(require.context("../web_components", true, /_component.js$/))
