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

pub fn main() !void {
    const stdin = std.io.getStdIn();
    const stdout = std.io.getStdOut();

    var buf_reader = std.io.bufferedReader(stdin.reader());
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const n = parseUsize(nextToken(reader, &buffer));
    const x = parseUsize(nextLine(reader, &buffer));

    var i: usize = 0;
    while (i < n) : (i += 1) {
        const num = if (i == n - 1) nextLine(reader, &buffer) else nextToken(reader, &buffer);

        if (x == parseUsize(num)) {
            try stdout.writer().print("Yes\n", .{});
            return;
        }
    }
    try stdout.writer().print("No\n", .{});
}
