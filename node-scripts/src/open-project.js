import fs from 'fs'
import path from 'path'
import { promisify } from 'util'
import { exec } from 'child_process'
import inquire from 'inquirer'

/**
 * @param {string} dir 
 * @returns {import('node:fs').PathLike[]}
 */
async function ls(dir) {
	let normalizedPath = dir
	let directories = []

	if (dir.startsWith('~'))
		normalizedPath = dir.replace('~', process.env.HOME)
	if (dir.startsWith('./'))
		normalizedPath = path.join(process.cwd(), dir)

	const stat = promisify(fs.lstat)
	const dirStat = await stat(normalizedPath).catch((error) => {
		if (error && error.code === 'ENOENT') {
			console.log(`\nDirectory "${dir}", normalized to "${normalizedPath}", doesn't seem to exist.\n\nExiting...`)
			process.exit(1)
		}
		throw error
	})

	if (!dirStat.isDirectory()) {
		console.log(`\nPath "${dir}", normalized to "${normalizedPath}", doesn't point to a directory.\n\nExiting...`)
		process.exit(1)
	}

	directories = fs.readdirSync(normalizedPath)
		.map((source) => path.resolve(normalizedPath, source))
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
	const codeDirectories = await ls(parentDir)

	if (codeDirectories.length === 0) {
		console.log(`\nThis directory "${parentDir}" looks empty.\n\nExiting...`)
		process.exit(1)
	}

	const choices = []

	for (const dir of codeDirectories) {
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


async function testRun(pathToTest) {
	const projects = await getProjects(
		pathToTest,
		pathToTest.substr(pathToTest.lastIndexOf(path.sep) + 1)
	)
	console.log(projects)
}

const projectMappings = {
	work: {
		name: 'iCIMS',
		path: '~/Projects/Work',
		description: 'Projects for work @ iCIMS'
	},
	personal: {
		name: 'Personal',
		path: '~/Projects/Personal',
		description: 'Personal projects from GitHub',
	},
	test: {
		name: 'Testing',
		path: '~/Projects/Test',
		description: 'Projects to test on, or with'
	},
	learning: {
		name: 'Learning',
		path: '~/Projects/Learning',
		description: 'Tutorials & trainings'
	}
}

let projectsInCategory = []

// Execute prompt!
inquire.prompt([
	{
		name: 'category',
		message: 'Choose a flavor of work:',
		type: 'list',
		choices: Object.keys(projectMappings),
		filter: async (chosenCategory) => {
			// Before moving to next inquiry, we need to get and set
			// the list of projects available in the chosen category
			const { path: catPath, name: catName } = projectMappings[chosenCategory]
			projectsInCategory = await getProjects(catPath, catName)
			return chosenCategory
		},
		transformer: (input) => input + 'TEST'
	},
	{
		name: 'project',
		message: 'Pick a project',
		type: 'list',
		pageSize: 5,
		// Choices needs to be a function to "wait" for previous answer,
		// which actually is setting up the `projectsInCategory` for us
		choices: () => projectsInCategory.map(({ name }) => name),
		filter: (chosenProject) => projectsInCategory.find(({ name }) => name === chosenProject)
	}
]).then(({ project }) => {
	console.log(`Opening ${project.description} in VS Code...`)

	exec(`code ${project.value}`)
})
