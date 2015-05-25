MetalSmith  = require 'metalsmith'
collections = require 'metalsmith-collections'
drafts      = require 'metalsmith-drafts'
markdown    = require 'metalsmith-markdown'
permalinks  = require 'metalsmith-permalinks'
templates   = require 'metalsmith-templates'
debug       = require('debug')('invincible-io:build')

metadata   = require './metadata'
collectionsMetadata = require './collections-metadata'

class Builder
  constructor: ->
    require './handlebars-config'

  run: =>
    debug 'Building site...'

    MetalSmith(__dirname)
      .use drafts()
      .use collections(collectionsMetadata)
      .metadata metadata
      .use markdown()
      .use permalinks(pattern: ':title')
      .use templates(engine: 'handlebars')
      .build (error) =>
        return throw error if error?
        debug 'Successfully built site'

module.exports = Builder
