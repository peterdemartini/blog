MetalSmith  = require 'metalsmith'
collections = require 'metalsmith-collections'
drafts      = require 'metalsmith-drafts'
markdown    = require 'metalsmith-markdown'
permalinks  = require 'metalsmith-permalinks'
templates   = require 'metalsmith-templates'
debug       = require('debug')('peterdemartini:build')

require './handlebars-config'

class Builder
  constructor: ->

  run: (callback=->) =>
    debug 'Building site...'

    MetalSmith(__dirname)
      .use drafts()
      .use collections({
        pages:
          pattern: 'content/pages/*.md'
        posts:
          pattern: 'content/posts/*.md',
          sortBy: 'date',
          reverse: true
      })
      .metadata {
        meta_title: 'Peter DeMartini'
        meta_description: "I am a husband, a father, and a Software Craftsman. I build because I love it, not because it is my job."
        meta_author: 'Peter DeMartini'
      }
      .use markdown()
      .use permalinks(pattern: ':title')
      .use templates(engine: 'handlebars')
      .build callback

module.exports = Builder
