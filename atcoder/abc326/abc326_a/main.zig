const std = @import("std");

fn nextToken(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiter(buffer, ' ') catch unreachable;
}

fn nextLine(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiterOrEof(buffer, '\n') catch unreachable orelse unreachable;
}

fn parseI8(buf: []const u8) i8 {
    return std.fmt.parseInt(i8, buf, 10) catch unreachable;
}

pub fn main() !void {
    const stdin = std.io.getStdIn();
    const stdout = std.io.getStdOut();

    var buf_reader = std.io.bufferedReader(stdin.reader());
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const x = parseI8(nextToken(reader, &buffer));
    const y = parseI8(nextLine(reader, &buffer));

    const diff = y - x;
    const ans = if (-3 <= diff and diff <= 2) "Yes" else "No";

    try stdout.writer().print("{s}\n", .{ans});
}
