/*
 * This first part was taken from https://stackoverflow.com/a/23941786/753012
 */
(function () {
    var lastTime = 0;
    var vendors = ['ms', 'moz', 'webkit', 'o'];
    for (var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
        window.requestAnimationFrame = window[vendors[x] + 'RequestAnimationFrame'];
        window.cancelAnimationFrame = window[vendors[x] + 'CancelAnimationFrame'] || window[vendors[x] + 'CancelRequestAnimationFrame'];
    }

    if (!window.requestAnimationFrame) window.requestAnimationFrame = function (callback, element) {
        var currTime = new Date().getTime();
        var timeToCall = Math.max(0, 5 - (currTime - lastTime));
        var id = window.setTimeout(function () {
                callback(currTime + timeToCall);
            },
            timeToCall);
        lastTime = currTime + timeToCall;
        return id;
    };

    if (!window.cancelAnimationFrame) window.cancelAnimationFrame = function (id) {
        clearTimeout(id);
    };
}());
// End of taken code

// Yes, it's a global var, but this isn't made to be too reusable anyway :/
var $canvas = null;
var $ctx = null;
var $vertices = [];
var $edges = [];
var $root = null;
var $dijkstraEdges = [];

$(document).ready(function() {
    $canvas = $('#canvas')[0];
    $ctx = $canvas.getContext('2d');
    $($canvas).attr('width', $($canvas).parent().width() - 15);
    $($canvas).attr('height', $('body').height() - 165);

    loadVertices();
    loadEdges();
    loadDijkstra();

    draw();

    $(document).on('click', '#reanimate', function() {
        $ctx.clearRect(0, 0, $canvas.width, $canvas.height);
        draw();
    });
});

function loadVertices() {
    $root = $($canvas).data('root');
    var verticesString = $($canvas).data('vertices');
    var vertices = verticesString.split(',');
    for (var i = 0; i < vertices.length; i++) {
        var vertexParts = vertices[i].split('-');
        $vertices.push(vertexParts);
    }
}

function loadEdges() {
    var edgesString = $($canvas).data('edges');
    var edges = edgesString.split(',');
    for (var i = 0; i < edges.length; i++) {
        var edgesParts = edges[i].split('-');
        var vertex1 = $vertices[edgesParts[0]];
        var vertex2 = $vertices[edgesParts[1]];
        $edges.push([vertex1[0], vertex1[1], vertex2[0], vertex2[1]]);
    }
}

function loadDijkstra() {
    for (var i = 0; i < $vertices.length; i++) {
        var current = $vertices[i];

        var nextVertices = current[2].split('|');
        for (var j = 0; j < nextVertices.length; j++) {
            if ($dijkstraEdges[i] == undefined) { $dijkstraEdges[i] = []; }
            $dijkstraEdges[i].push(nextVertices[j]);
        }
    }
}

function draw() {
    drawVertices();
    drawEdges();
    drawDijkstra($root, 0);
}

function drawVertices() {
    for (var i = 0; i < $vertices.length; i++) {
        var vertex = $vertices[i];
        drawVertex(vertex[0], vertex[1], i == $root);
    }
}

function drawEdges() {
    for (var i = 0; i < $edges.length; i++) {
        var edge = $edges[i];
        drawEdge(edge[0], edge[1], edge[2], edge[3], false);
    }
}

function drawVertex(x, y, isRoot) {
    var posX = x * $canvas.width;
    var posY = y * $canvas.height;
    var circleWidth = isRoot ? 10 : 5;
    var circleColor = isRoot ? 'red' : 'green';

    $ctx.beginPath();
    $ctx.arc(posX, posY, circleWidth, 0, 2 * Math.PI, false);
    $ctx.fillStyle = circleColor;
    $ctx.fill();
}

function drawEdge(fromX, fromY, toX, toY, isSolution) {
    fromX = fromX * $canvas.width;
    fromY = fromY * $canvas.height;
    toX = toX * $canvas.width;
    toY = toY * $canvas.height;

    $ctx.beginPath();
    $ctx.moveTo(fromX, fromY);
    $ctx.lineTo(toX, toY);
    $ctx.strokeStyle = isSolution ? 'rgba(255,0,0,0.6)' : 'rgba(0,0,0,0.2)';
    $ctx.lineWidth = isSolution ? 5 : 1;
    $ctx.stroke();
}

function drawDijkstra(index, nextIndex) {
    var nextIndices = $dijkstraEdges[index];

    var toIndex = nextIndices[nextIndex];

    if (toIndex && $vertices[toIndex]) {
        var from = $vertices[index];
        var to = $vertices[toIndex];

        var points = calcWaypoints(from[0], from[1], to[0], to[1]);
        animateEdge(points);

        if ((nextIndex + 1) < nextIndices.length) {
            deferDrawDijkstra(index, nextIndex + 1);
        } else {
            for (var i = 0; i < nextIndices.length; i++) {
                deferDrawDijkstra(nextIndices[i], 0);
            }
        }
    }
}

function deferDrawDijkstra(index, nextIndex) {
    setTimeout(function () {
        drawDijkstra(index, nextIndex);
    }, 500);
}

/*
 * This last part was adapted from https://stackoverflow.com/a/23941786/753012
 */
function calcWaypoints(fromX, fromY, toX, toY) {
    var waypoints = [];

    fromX = fromX  * $canvas.width;
    fromY = fromY * $canvas.height;
    toX = toX  * $canvas.width;
    toY = toY * $canvas.height;

    var dx = parseFloat(toX) - parseFloat(fromX);
    var dy = parseFloat(toY) - parseFloat(fromY);
    for (var j = 0; j < 50; j++) {
        var x = parseFloat(fromX) + dx * j / 50;
        var y = parseFloat(fromY) + dy * j / 50;
        waypoints.push({ x: x, y: y });
    }
    return waypoints;
}

function animateEdge(points, t) {
    if (t == undefined) t = 1;
    if (t < points.length - 1) {
        requestAnimationFrame(function() {
            animateEdge(points, t + 1);
        });
    }
    // draw a line segment from the last waypoint
    // to the current waypoint
    $ctx.lineCap = 'round';
    $ctx.beginPath();
    $ctx.moveTo(points[t - 1].x, points[t - 1].y);

    $ctx.lineTo(points[t].x, points[t].y);
    $ctx.strokeStyle = '#FF3333';
    $ctx.lineWidth = 3;
    $ctx.stroke();
    // increment "t" to get the next waypoint
}
