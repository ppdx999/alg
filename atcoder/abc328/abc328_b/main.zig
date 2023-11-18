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
    _ = alc;

    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const N = parseInt(u64, nextLine(reader, &buffer));

    var ans: u64 = 0;

    var month: u64 = 1;
    while (month <= N) : (month += 1) {
        const day_length = if (month == N) parseInt(u64, nextLine(reader, &buffer)) else parseInt(u64, nextToken(reader, &buffer));

        if (month < 10 or (month / 10 == month % 10)) {
            if (month == 100) {
                continue;
            }

            const number: u64 = month % 10;
            var j: u64 = number;
            while (j <= day_length) {
                ans += 1;
                j = j * 10 + number;
            }
        }
    }

    try stdout.print("{d}\n", .{ans});
}
