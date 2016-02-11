MetalSmith  = require 'metalsmith'
collections = require 'metalsmith-collections'
drafts      = require 'metalsmith-drafts'
markdown    = require 'metalsmith-markdown'
permalinks  = require 'metalsmith-permalinks'
templates   = require 'metalsmith-templates'
debug       = require('debug')('peterdemartini:build')

metadata   = require './metadata'
collectionsMetadata = require './collections-metadata'

require './handlebars-config'

class Builder
  constructor: ->

  run: (callback=->) =>
    debug 'Building site...'

    MetalSmith(__dirname)
      .use drafts()
      .use collections(collectionsMetadata)
      .metadata metadata
      .use markdown()
      .use permalinks(pattern: ':title')
      .use templates(engine: 'handlebars')
      .build callback

module.exports = Builder
