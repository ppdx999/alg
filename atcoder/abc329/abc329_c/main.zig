const std = @import("std");
const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();

fn nextLine(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiterOrEof(buffer, '\n') catch unreachable orelse unreachable;
}

fn parseInt(comptime T: type, buf: []const u8) T {
    return std.fmt.parseInt(T, buf, 10) catch unreachable;
}

const alphabet_size = 26;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alc = arena.allocator();

    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [2 * 100_000 + 10]u8 = undefined;

    const N = parseInt(u64, nextLine(reader, &buffer));
    _ = N;
    const S = nextLine(reader, &buffer);

    const bufs = try alc.alloc(u64, alphabet_size);
    var i: u64 = 0;
    while (i < alphabet_size) : (i += 1) {
        bufs[i] = 0;
    }

    var prev_char = S[0];
    var continuous_count: u64 = 0;

    i = 0;
    while (i < S.len) : (i += 1) {
        const c = S[i];
        if (c == prev_char) {
            const idx = c - 'a';
            continuous_count += 1;
            bufs[idx] = @max(bufs[idx], continuous_count);
        } else {
            prev_char = c;
            continuous_count = 1;
            const idx = c - 'a';
            bufs[idx] = @max(bufs[idx], continuous_count);
        }
    }

    var ans: u64 = 0;
    for (bufs) |buf| {
        ans += buf;
    }

    try stdout.print("{d}\n", .{ans});
}
