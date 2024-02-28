
module.exports = {
  content: [
    "./src/**/*.{html,js,svelte,ts}",
  ],
  theme: {
    extend: {
      colors: {
        // Define the palettes separately for easy switching
        palette: {
          // Brown palette
          brown: {
            1: '#fec',
            2: '#fdb',
            3: '#fca',
            4: '#eb9',
            5: '#da8',
            6: '#c97',
            7: '#b86',
            8: '#a75',
            9: '#964',
            10: '#853',
            11: '#742',
            12: '#631',
            13: '#530',
            14: '#420',
            15: '#310',
            16: '#210',
          },
          // Orange palette
          orange: {
            1: '#fff4e6',
            2: '#ffe8cc',
            3: '#ffddb3',
            4: '#ffd199',
            5: '#ffc480',
            6: '#ffb866',
            7: '#ffac4d',
            8: '#ffa033',
            9: '#ff941a',
            10: '#ff8800',
            11: '#e67900',
            12: '#cc6a00',
            13: '#b35c00',
            14: '#994d00',
            15: '#804000',
            16: '#663300',
          },
        },
      },
    },
  },
  // Dynamically switch the palette here by extending the them
  plugins: [require("daisyui")]
};