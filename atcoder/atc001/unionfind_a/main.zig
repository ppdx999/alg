const std = @import("std");
const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();

const UnionFind = struct {
    parents: []u64,
    ranks: []u64,

    pub fn init(alc: std.mem.Allocator, n: u64) !UnionFind {
        var parents = try alc.alloc(u64, n);
        var ranks = try alc.alloc(u64, n);

        var i: u64 = 0;
        while (i < n) : (i += 1) {
            parents[i] = i;
            ranks[i] = 0;
        }

        return UnionFind{
            .parents = parents,
            .ranks = ranks,
        };
    }

    pub fn deinit(self: *UnionFind, allocator: std.mem.Allocator) void {
        allocator.free(self.parents);
        allocator.free(self.ranks);
    }

    pub fn root(self: *UnionFind, x: u64) u64 {
        var p = self.parents[x];
        if (p == x) {
            return x;
        } else {
            var r = self.root(p);
            self.parents[x] = r;
            return r;
        }
    }

    pub fn same(self: *UnionFind, x: u64, y: u64) bool {
        return self.root(x) == self.root(y);
    }

    pub fn unite(self: *UnionFind, x: u64, y: u64) bool {
        var rx = self.root(x);
        var ry = self.root(y);
        if (rx == ry) {
            return false;
        }

        if (self.ranks[rx] < self.ranks[ry]) {
            self.parents[rx] = ry;
        } else {
            self.parents[ry] = rx;
            if (self.ranks[rx] == self.ranks[ry]) {
                self.ranks[rx] += 1;
            }
        }

        return true;
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

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alc = arena.allocator();

    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [100_010]u8 = undefined;

    const N = parseInt(u64, nextToken(reader, &buffer));
    const Q = parseInt(u64, nextLine(reader, &buffer));

    var uf = try UnionFind.init(alc, N);
    defer uf.deinit(alc);

    var i: u64 = 0;
    while (i < Q) : (i += 1) {
        const t = parseInt(u64, nextToken(reader, &buffer));
        const a = parseInt(u64, nextToken(reader, &buffer));
        const b = parseInt(u64, nextLine(reader, &buffer));

        if (t == 0) {
            _ = uf.unite(a, b);
        } else {
            const ans = if (uf.same(a, b)) "Yes" else "No";
            try stdout.print("{s}\n", .{ans});
        }
    }
}
