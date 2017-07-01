// Yes, it's a global var, but this isn't made to be too reusable anyway :/
var $canvas = null;
var $ctx = null;
var $vertices = [];

Object.size = function(obj) {
    var size = 0, key;
    for (key in obj) { if (obj.hasOwnProperty(key)) size++; }
    return size;
};

$(document).ready(function() {
    $canvas = $('#canvas')[0];
    $ctx = $canvas.getContext('2d');
    $($canvas).attr('width', $($canvas).parent().width() - 15);
    $($canvas).attr('height', $('body').height() - 165);

    var verticesString = $($canvas).data('vertices');

    loadVertices(verticesString);
    setTimeout(loadEdges);
});

function loadVertices(verticesString) {
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
        drawEdge(vertex1[0], vertex1[1], vertex2[0], vertex2[1], false);
    }
    drawVertices();
    drawDijkstra();
}

function drawVertices() {
    for (var i = 0; i < $vertices.length; i++) {
        var vertex = $vertices[i];
        drawVertex(vertex[0], vertex[1], vertex[2]);
    }
}

function drawVertex(x, y, previousIndex) {
    var posX = x * $canvas.width;
    var posY = y * $canvas.height;
    var isRoot = previousIndex == '';
    var circleWidth = isRoot ? 10 : 5;
    var circleColor = isRoot ? 'red' : 'green';

    $ctx.beginPath();
    $ctx.arc(posX, posY, circleWidth, 0, 2 * Math.PI, false);
    $ctx.fillStyle = circleColor;
    $ctx.fill();
}

function drawEdge(fromX, fromY, toX, toY, isSolution) {
    setTimeout(function() {
        fromX = fromX * $canvas.width;
        fromY = fromY * $canvas.height;
        toX = toX * $canvas.width;
        toY = toY * $canvas.height;

        $ctx.beginPath();
        $ctx.moveTo(fromX, fromY);
        $ctx.lineTo(toX, toY);
        $ctx.strokeStyle = isSolution ? 'rgba(255,0,0,0.3)' : 'rgba(0,0,0,0.2)';
        $ctx.lineWidth = isSolution ? 3 : 1;
        $ctx.stroke();
    });
}

function drawDijkstra() {
    for (var i = 0; i < $vertices.length; i++) {
        var current = $vertices[i];
        var previous = undefined;

        console.log("NEXT");
        while (previous = $vertices[current[2]]) {
            drawEdge(current[0], current[1], previous[0], previous[1], true);
            current = previous;
        }
    }
}
