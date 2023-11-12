const std = @import("std");
const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();

fn nextToken(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiter(buffer, ' ') catch unreachable;
}

fn nextLine(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiterOrEof(buffer, '\n') catch unreachable orelse unreachable;
}

fn parseInt(comptime T: type, buf: []const u8) T {
    return std.fmt.parseInt(T, buf, 10) catch unreachable;
}

const SEEN = 'x';

fn add(a: u64, b: u64) u64 {
    return a + b;
}

fn sub(a: u64, b: u64) u64 {
    return a - b;
}

fn dfs(matrix: []u8, H: u64, W: u64, current: u64) bool {
    var i: u64 = 0;
    while (i < 4) : (i += 1) {
        const next = switch (i) {
            0 => if (current % W != W - 1) current + 1 else continue,
            1 => if (current % W != 0) current - 1 else continue,
            2 => if (current + W < H * W) current + W else continue,
            3 => if (current >= W) current - W else continue,
            else => unreachable,
        };

        if (matrix[next] == SEEN) continue;
        if (matrix[next] == '#') continue;
        if (matrix[next] == 'g') return true;
        matrix[next] = SEEN;
        if (dfs(matrix, H, W, next)) return true;
    }

    return false;
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alc = arena.allocator();

    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const H = parseInt(u64, nextToken(reader, &buffer));
    const W = parseInt(u64, nextLine(reader, &buffer));

    const matrix_size = H * W;
    const matrix = try alc.alloc(u8, matrix_size);

    var start: u64 = 0;
    var h: u64 = 0;
    while (h < H) : (h += 1) {
        var w: u64 = 0;
        const line = nextLine(reader, &buffer);
        while (w < W) : (w += 1) {
            const idx = h * W + w;
            matrix[idx] = line[w];
            if (line[w] == 's') start = idx;
        }
    }

    const ans = if (dfs(matrix, H, W, start)) "Yes" else "No";

    try stdout.print("{s}\n", .{ans});
}
