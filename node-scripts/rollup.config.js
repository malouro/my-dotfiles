import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import { babel } from '@rollup/plugin-babel'
import { terser } from 'rollup-plugin-terser'
import json from '@rollup/plugin-json'

const plugins = [
	resolve({
		mainFields: ['main', 'module'],
		extensions: ['.js', '.ts', '.json'],
		preferBuiltins: true
	}),
	commonjs({ requireReturnsDefault: 'auto' }),
	babel({ exclude: 'node_modules/*', babelHelpers: 'bundled' }),
	terser(),
	json()
]
const commonOptions = {
	treeshake: true
}


/** @type {import('rollup').RollupOptions} */
export default [
	{
		input: ['open-project.js'],
		output: {
			file: '../bin/open-project',
			format: 'cjs',
		},
		plugins,
		...commonOptions
	}
]
