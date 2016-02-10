Handlebars = require 'handlebars'
moment     = require 'moment'
glob       = require 'glob'
path       = require 'path'
fs         = require 'fs'
debug      = require('debug')('peterdemartini:handlebars')

PARTIAL_DIR = __dirname + '/templates/partials'

registerPartial = (partial) =>
  partialName = path.basename partial, '.hbt'
  debug 'adding partial', partialName
  content = fs.readFileSync("#{PARTIAL_DIR}/#{partialName}.hbt").toString();
  Handlebars.registerPartial(partialName, content);

glob "#{PARTIAL_DIR}/*.hbt", (error, files) =>
  return throw error if error?
  files.forEach registerPartial

Handlebars.registerHelper 'dateFormat', (context, block) =>
  format = block.hash.format || "MMM Do, YYYY";
  return moment(context).format(format)

Handlebars.registerHelper 'trimString', (passedString) =>
  return unless passedString?
  passedString = passedString.replace(/<(?:.|\n)*?>/gm, '')
  theString = passedString.substring 0,200
  theString = theString.replace(/^[a-zA-Z ]*$/g, '')
  return new Handlebars.SafeString theString
