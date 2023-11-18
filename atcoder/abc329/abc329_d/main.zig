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
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alc = arena.allocator();

    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const N = parseInt(u64, nextToken(reader, &buffer));
    const M = parseInt(u64, nextLine(reader, &buffer));

    var buf = try alc.alloc(u64, N + 1);

    var i: u64 = 0;
    while (i < N + 1) : (i += 1) {
        buf[i] = 0;
    }

    var winner: u64 = 0;
    i = 0;
    while (i < M) : (i += 1) {
        var vote = if (i == M - 1) parseInt(u64, nextLine(reader, &buffer)) else parseInt(u64, nextToken(reader, &buffer));
        buf[vote] += 1;

        if (winner == 0) {
            winner = vote;
        }

        if (buf[vote] > buf[winner]) {
            winner = vote;
        } else if (buf[vote] == buf[winner]) {
            winner = @min(winner, vote);
        } else {
            // do nothing
        }

        try stdout.print("{d}\n", .{winner});
    }
}
