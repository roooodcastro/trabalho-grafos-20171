// Yes, it's a global var, but this isn't made to be too reusable anyway :/
var $canvas = null;
var $ctx = null;
var $vertices = {};

Object.size = function(obj) {
    var size = 0, key;
    for (key in obj) { if (obj.hasOwnProperty(key)) size++; }
    return size;
};

$(document).ready(function() {
    $canvas = $('#canvas')[0];
    $ctx = $canvas.getContext('2d');
    $($canvas).attr('width', 1200);
    $($canvas).attr('height', 700);

    var verticesString = $($canvas).data('vertices');

    loadVertices(verticesString);
    setTimeout(loadEdges);
});

function loadVertices(verticesString) {
    var vertices = verticesString.split(',');
    for (var i = 0; i < vertices.length; i++) {
        var vertexParts = vertices[i].split('-');
        $vertices[vertexParts[0]] = [vertexParts[1], vertexParts[2]];
    }
}

function loadEdges() {
    var edgesString = $($canvas).data('edges');
    var edges = edgesString.split(',');
    for (var i = 0; i < edges.length; i++) {
        var edgesParts = edges[i].split('-');
        var vertex1 = $vertices[edgesParts[0]];
        var vertex2 = $vertices[edgesParts[1]];
        drawEdge(vertex1[0], vertex1[1], vertex2[0], vertex2[1]);
    }
    drawVertices();
}

function drawVertices() {
    for (var i = 0; i <  Object.size($vertices); i++) {
        var vertex = $vertices[i];
        drawVertex(vertex[0], vertex[1]);
    }
}

function drawVertex(x, y) {
    var posX = x * $canvas.width;
    var posY = y * $canvas.height;

    $ctx.beginPath();
    $ctx.arc(posX, posY, 5, 0, 2 * Math.PI, false);
    $ctx.fillStyle = 'green';
    $ctx.fill();
}

function drawEdge(fromX, fromY, toX, toY) {
    setTimeout(function() {
        fromX = fromX * $canvas.width;
        fromY = fromY * $canvas.height;
        toX = toX * $canvas.width;
        toY = toY * $canvas.height;

        $ctx.beginPath();
        $ctx.moveTo(fromX, fromY);
        $ctx.lineTo(toX, toY);
        $ctx.strokeStyle = 'rgba(0,0,0,0.1)';
        $ctx.stroke();
    });
}
