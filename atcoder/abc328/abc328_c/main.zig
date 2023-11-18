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

    var buffer: [3 * 100_000 + 10]u8 = undefined;

    const N = parseInt(u64, nextToken(reader, &buffer));
    const Q = parseInt(u64, nextLine(reader, &buffer));
    const S = nextLine(reader, &buffer);

    var arr = try alc.alloc(u64, N + 1);
    arr[0] = 0;
    arr[1] = 0;

    {
        var i: u64 = 2;
        while (i <= N) : (i += 1) {
            if (S[i - 1] == S[i - 2]) {
                arr[i] = arr[i - 1] + 1;
            } else {
                arr[i] = arr[i - 1];
            }
        }
    }

    {
        var i: u64 = 0;
        while (i < Q) : (i += 1) {
            const l = parseInt(u64, nextToken(reader, &buffer));
            const r = parseInt(u64, nextLine(reader, &buffer));
            const ans = arr[r] - arr[l];
            try stdout.print("{d}\n", .{ans});
        }
    }
}
