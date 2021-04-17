import fs from 'fs'
import path from 'path'
import { exec } from 'child_process'
import inquire from 'inquirer'

/**
 * @param {string} dir 
 * @returns {import('node:fs').PathLike[]}
 */
function ls(dir) {
	let normalizedPath = dir

	if (dir.startsWith('~'))
		normalizedPath = dir.replace('~', process.env.HOME)
	if (dir.startsWith('./'))
		normalizedPath = path.join(process.cwd(), dir)

	const directories = fs.readdirSync(normalizedPath)
		.map((source) =>	path.resolve(normalizedPath, source))
		.filter((source) => fs.lstatSync(source).isDirectory())

	return directories
}

/**
 * @typedef {{
 * 	name: string,
 * 	value: string,
 * 	description: string
 * }} Project
 * @param {string} parentDir String path to project directory
 * @param {string} category Describes the set of projects being fetched
 * @returns {Project[]} List of projects to choose from
 */
async function getProjects(parentDir, category) {
	const codeDir = ls(parentDir)
	const choices = []

	for (const dir of codeDir) {
		// Ignore certain files or directories
		if (/node_modules|\.DS_Store/.test(dir)) continue

		// Check that these are "projects"
		if (
			fs.existsSync(path.join(dir, './package.json')) ||  // Node/JS
			fs.existsSync(path.join(dir, './requirements.txt')) // Python
		) {
			const name = dir.substr(dir.lastIndexOf(path.sep) + 1)

			choices.push({
				name,
				value: dir,
				description: `${category}/${name}`,
			})
		}
	}

	return choices
}

const projectMappings = {
	personal: {
		name: 'Personal',
		path: '~/Projects/Personal',
		description: 'Personal projects from GitHub',
	},
	work: {
		name: 'iCIMS',
		path: '~/Projects/Work',
		description: 'Projects for work @ iCIMS'
	},
	test: {
		name: 'Testing',
		path: '~/Projects/Test',
		description: 'Projects to test on, or with'
	}
}

let projectsInCategory = []

inquire.prompt([
	{
		name: 'category',
		message: 'Choose a flavor of work:',
		type: 'list',
		choices: Object.keys(projectMappings),
		filter: async (category) => {
			projectsInCategory = await getProjects(
				projectMappings[category].path,
				projectMappings[category].name
			)
			return category
		}
	},
	{
		name: 'project',
		message: 'Pick a project',
		type: 'list',
		pageSize: 9,
		choices: () => projectsInCategory.map(({ name }) => name),
		filter: (projectSelection) => projectsInCategory.find(({ name }) => name === projectSelection)
	}
]).then(({ project }) => {
	console.log(`Opening ${project.description} in VS Code...`)

	exec(`code ${project.value}`)
})