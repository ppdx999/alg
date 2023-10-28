const std = @import("std");

fn nextLine(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiterOrEof(buffer, '\n') catch unreachable orelse unreachable;
}

fn parseUsize(buf: []const u8) usize {
    return std.fmt.parseInt(usize, buf, 10) catch unreachable;
}

fn is326(i: usize) bool {
    const hundreds = i / 100;
    const tens = i / 10 % 10;
    const ones = i % 10;

    return hundreds * tens == ones;
}

pub fn main() !void {
    const stdin = std.io.getStdIn();
    const stdout = std.io.getStdOut();

    var buf_reader = std.io.bufferedReader(stdin.reader());
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const n = parseUsize(nextLine(reader, &buffer));

    var i = n;
    while (!is326(i)) : (i += 1) {}

    try stdout.writer().print("{d}\n", .{i});
}
