Handlebars = require 'handlebars'
moment     = require 'moment'
glob       = require 'glob'
path       = require 'path'
fs         = require 'fs'
debug      = require('debug')('invincible-io:handlebars')

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
