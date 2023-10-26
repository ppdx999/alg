const std = @import("std");

fn nextToken(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiter(buffer, ' ') catch unreachable;
}

fn nextLine(reader: anytype, buffer: []u8) []const u8 {
    const line = reader.readUntilDelimiterOrEof(buffer, '\n') catch unreachable;
    return line.?;
}

fn parseUsize(buf: []const u8) usize {
    return std.fmt.parseInt(usize, buf, 10) catch unreachable;
}

pub fn main() !void {
    const stdin = std.io.getStdIn();
    var buf_reader = std.io.bufferedReader(stdin.reader());
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const n = parseUsize(nextLine(reader, &buffer));

    const result = n * n;

    const stdout = std.io.getStdOut();
    try stdout.writer().print("{d}", .{result});
}

const assert = @import("std").debug.assert;
test "main" {
    var i: u32 = 2;
    while (i < 100) {
        i *= 2;
    }
    assert(i == 128);
}
