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

fn ascU64(context: void, a: u64, b: u64) std.math.Order {
    _ = context;
    return std.math.order(a, b);
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alc = arena.allocator();

    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const N = parseInt(u64, nextLine(reader, &buffer));
    var pq = std.PriorityQueue(u64, void, ascU64).init(alc, {});
    defer pq.deinit();

    var i: u64 = 0;
    while (i < N) : (i += 1) {
        const query_type = reader.readByte() catch unreachable;

        switch (query_type) {
            '1' => {
                // space
                _ = reader.readByte() catch unreachable;
                const priority = parseInt(u64, nextLine(reader, &buffer));
                try pq.add(priority);
            },
            '2' => {
                if (i != N - 1) {
                    // \n
                    _ = reader.readByte() catch unreachable;
                }

                try stdout.print("{?d}\n", .{pq.peek()});
            },
            '3' => {
                if (i != N - 1) {
                    // \n
                    _ = reader.readByte() catch unreachable;
                }
                _ = pq.remove();
            },
            else => unreachable,
        }
    }
}
