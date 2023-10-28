const std = @import("std");

fn nextToken(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiter(buffer, ' ') catch unreachable;
}

fn nextLine(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiterOrEof(buffer, '\n') catch unreachable orelse unreachable;
}

fn parseUsize(buf: []const u8) usize {
    return std.fmt.parseInt(usize, buf, 10) catch unreachable;
}

fn solve(n: usize, m: usize, list: []usize) usize {
    var max: usize = 0;
    var l: usize = 0;
    var r: usize = 0;
    while (l < n) : (l += 1) {
        while (list[r] - list[l] < m) {
            r += 1;
        }

        max = @max(max, r - l);
    }
    return max;
}

pub fn main() !void {
    const stdin = std.io.getStdIn();
    const stdout = std.io.getStdOut();

    var buf_reader = std.io.bufferedReader(stdin.reader());
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const n = parseUsize(nextToken(reader, &buffer));
    const m = parseUsize(nextLine(reader, &buffer));

    var arr: [3 * 100000]usize = undefined;

    var i: usize = 0;
    while (i < n) : (i += 1) {
        arr[i] = if (i < n - 1) parseUsize(nextToken(reader, &buffer)) else parseUsize(nextLine(reader, &buffer));
    }
    arr[n] = 9000000000000;

    var list = arr[0 .. n + 1];

    std.mem.sort(usize, list, {}, comptime std.sort.asc(usize));

    const ans = solve(n, m, list);

    try stdout.writer().print("{d}\n", .{ans});
}
