import includePaths from 'rollup-plugin-includepaths';


const BUNDLE = process.env.BUNDLE === 'true'
const ESM = process.env.ESM === 'true'

const fileDest = `oembed${ESM ? '.esm' : ''}`

let includePathOptions = {
  include: {},
  paths: ['app/javascript'],
  external: [],
  extensions: ['.js']
};

const rollupConfig = {
  input: 'app/javascript/oembed.js',
  output: {
    file: `app/assets/javascripts/blacklight_oembed/${fileDest}.js`,
    format: ESM ? 'es' : 'umd',
    generatedCode: { preset: 'es2015' },
    name: ESM ? undefined : 'BlacklightOembed'
  },
  plugins: [includePaths(includePathOptions)]
}

export default rollupConfig
