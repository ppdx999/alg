const std = @import("std");
const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();

fn nextLine(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiterOrEof(buffer, ' ') catch unreachable orelse unreachable;
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alc = arena.allocator();

    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [2 * 100_000 + 10]u8 = undefined;

    const S = nextLine(reader, &buffer);

    var answer = std.ArrayList(u8).init(alc);
    defer answer.deinit();

    var i: u64 = 0;
    while (i < S.len) : (i += 1) {
        try answer.append(S[i]);

        if (answer.items.len >= 3 and std.mem.eql(u8, answer.items[answer.items.len - 3 ..], "ABC")) {
            try answer.resize(answer.items.len - 3);
        }
    }

    try stdout.print("{s}", .{answer.items});
}
