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

pub fn main() !void {
    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const N = parseInt(u64, nextLine(reader, &buffer));
    var max: u64 = 0;
    var second_max: u64 = 0;
    var i: u64 = 0;
    while (i < N) : (i += 1) {
        var value = if (i == N - 1) parseInt(u64, nextLine(reader, &buffer)) else parseInt(u64, nextToken(reader, &buffer));

        if (value > max) {
            second_max = max;
            max = value;
        } else if (value > second_max and value != max) {
            second_max = value;
        }
    }

    try stdout.print("{d}\n", .{second_max});
}
