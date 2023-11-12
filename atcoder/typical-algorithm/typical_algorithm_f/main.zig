const std = @import("std");
const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();

const UnionFind = struct {
    const Self = UnionFind;
    parents: []u64,

    pub fn init(alc: std.mem.Allocator, n: u64) !Self {
        const parents = try alc.alloc(u64, n);
        var i: u64 = 0;
        while (i < n) : (i += 1) {
            parents[i] = i;
        }
        return Self{ .parents = parents };
    }

    pub fn deinit(self: *Self, alc: std.mem.Allocator) void {
        alc.free(self.parents);
    }

    pub fn root(self: *Self, a: u64) u64 {
        var x = a;
        while (self.parents[x] != x) : (x = self.parents[x]) {}
        return x;
    }

    pub fn unite(self: *Self, a: u64, b: u64) void {
        const a_root = self.root(a);
        const b_root = self.root(b);
        self.parents[a_root] = b_root;
    }
};

fn nextToken(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiter(buffer, ' ') catch unreachable;
}

fn nextLine(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiterOrEof(buffer, '\n') catch unreachable orelse unreachable;
}

fn parseInt(comptime T: type, buf: []const u8) T {
    return std.fmt.parseInt(T, buf, 10) catch unreachable;
}

fn readLine(reader: anytype, buffer: []u8) Edge {
    const v0 = parseInt(u64, nextToken(reader, buffer));
    const v1 = parseInt(u64, nextToken(reader, buffer));
    const cost = parseInt(u64, nextLine(reader, buffer));
    return Edge{ .vertex0 = v0, .vertex1 = v1, .cost = cost };
}

const Edge = struct {
    vertex0: u64,
    vertex1: u64,
    cost: u64,
};

fn ascEdge(_: void, lhs: Edge, rhs: Edge) bool {
    return lhs.cost < rhs.cost;
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alc = arena.allocator();

    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const N = parseInt(u64, nextToken(reader, &buffer));
    const M = parseInt(u64, nextLine(reader, &buffer));

    var uf = try UnionFind.init(alc, N);
    var edges = try alc.alloc(Edge, M);

    var i: u64 = 0;
    while (i < M) : (i += 1) {
        edges[i] = readLine(reader, &buffer);
    }

    std.mem.sort(Edge, edges, {}, ascEdge);

    var ans: u64 = 0;
    i = 0;
    while (i < M) : (i += 1) {
        const edge = edges[i];
        if (uf.root(edge.vertex0) != uf.root(edge.vertex1)) {
            uf.unite(edge.vertex0, edge.vertex1);
            ans += edge.cost;
        }
    }

    try stdout.print("{d}\n", .{ans});
}
