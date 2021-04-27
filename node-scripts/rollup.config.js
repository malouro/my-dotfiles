import fs from 'fs'
import path from 'path'
import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import { babel } from '@rollup/plugin-babel'
import { terser } from 'rollup-plugin-terser'
import json from '@rollup/plugin-json'

const srcDir = 'src'
const buildDir = 'dist'
const scriptList = fs.readFileSync(path.join(__dirname, './script-list'), 'utf-8').split('\n')
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

/** @type {import('rollup').RollupOptions} */
export default scriptList
	.map((scriptName) => ({
		input: [`${srcDir}/${scriptName}.js`],
		output: {
			file: `${buildDir}/${scriptName}`,
			format: 'cjs',
		},
		plugins
	}))
