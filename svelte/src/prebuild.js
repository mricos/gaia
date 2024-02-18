// scripts/generateCssVariables.js
const fs = require('fs');
const tailwindConfig = require('../tailwind.config.js');

const colors = tailwindConfig.theme.extend.colors;

let cssVariables = ':root {\n';
for (const palette in colors) {
  for (const shade in colors[palette]) {
    cssVariables += `  --${palette}-${shade}: ${colors[palette][shade]};\n`;
  }
}
cssVariables += '}';

fs.writeFileSync('./src/globalStyles.css', cssVariables);
