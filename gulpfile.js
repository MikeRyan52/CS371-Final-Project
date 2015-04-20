var request = require('request');
var gulp = require('gulp');
var _ = require('lodash');
var fs = require('fs');

gulp.task('levels', function(){
	request('https://script.google.com/macros/s/AKfycbznZzWm1vML1e7gVJxHLAtEmAUKKmpwpxqmJM8OgaeDi0BFqfC8/exec', function(error, response, body){
		if( ! error && response.statusCode == 200 )
		{
			var levels = JSON.parse(body);
			
			for(var i = 0; i < levels.length; i++)
			{
				generateLevels(i + 1, levels[i])
			}
		}
	});	
});

function generateLevels(id, level){
	level.id = 'level-' + id;
	level.towers = findTowers(level.nodes);

	var paths = findPaths(level.nodes);
	var grid = {};

	_.each(paths, function(path){
		var id = path.id;
		delete path.id;

		grid[id] = path;
	});

	level.grid = grid;

	delete level.nodes

	fs.writeFile('./levels/' + level.id + '.json', JSON.stringify(level, null, '\t'), function(e){
		if(e)
		{
			console.log(e);
		}
	});
}

function findTowers(nodes){
	var towersById = {};

	_.each(nodes, function(node){
		if(node.type == 'tower'){
			var id = node.id;
			delete node.id;

			towersById[id] = node;
		}
	});

	return towersById;
}

function findPaths(level){
	var start = _.find(level, function(path){
		return path.type === 'goal';
	});

	var frontier = [ start ];
	var cameFrom = {};
	var distance = {};
	var paths = [];

	cameFrom[start.id] = false;
	distance[start.id] = 0;

	_.each(level, function(){
		level.goesTo = [];
		level.cameFrom = [];
	});
	

	while( frontier.length > 0 ){
		var current = frontier.shift();
		current.goesTo = [];

		_.each(current.adjacentTo, function(neighbor){
			var next = _.find(level, function(path){
				return path.id === neighbor;
			});

			if( next && ! cameFrom[next.id] && ( next.type == 'path' || next.type == 'spawn' )){
				

				next.cameFrom = current.id;
				next.distance = 1 + distance[current.id];
				cameFrom[next.id] = current.id;
				distance[next.id] = 1 + distance[current.id];

				frontier.push(next);
			}
		});

		paths.push(current);
	}

	_.each(paths, function(path){
		if(path.cameFrom)
		{
			_.find(paths, function(targetPath){
				return targetPath.id == path.cameFrom
			}).goesTo.push(path.id);
		}
	});

	return paths;
}