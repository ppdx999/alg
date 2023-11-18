const std = @import("std");
const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();

fn nextLine(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiterOrEof(buffer, '\n') catch unreachable orelse unreachable;
}

pub fn main() !void {
    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [10000]u8 = undefined;

    const S = nextLine(reader, &buffer);

    var i: u64 = 0;
    while (i < S.len) : (i += 1) {
        if (i == S.len - 1) {
            try stdout.print("{c}", .{S[i]});
        } else {
            try stdout.print("{c} ", .{S[i]});
        }
    }
}
