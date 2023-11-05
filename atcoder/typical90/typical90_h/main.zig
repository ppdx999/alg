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

const MOD = 1000000007;
fn add(a: *u32, b: u32) void {
    a.* += b;
    if (a.* >= MOD) {
        a.* -= MOD;
    }
}

fn solve(alc: std.mem.Allocator, N: u32, S: []const u8, T: []const u8) !u32 {
    const dp_row_size = N + 1;
    const dp_col_size = T.len + 1;
    const dp_size = dp_row_size * dp_col_size;
    var dp = try alc.alloc(u32, dp_size);
    defer alc.free(dp);

    {
        var i: u32 = 0;
        while (i < dp_size) : (i += 1) {
            dp[i] = 0;
        }
    }

    dp[0] = 1;

    {
        var i: u32 = 0;
        while (i < N) : (i += 1) {
            var j: u32 = 0;
            while (j < dp_col_size) : (j += 1) {
                add(&dp[(i + 1) * dp_col_size + j], dp[i * dp_col_size + j]);

                if (j < T.len and S[i] == T[j]) {
                    add(&dp[(i + 1) * dp_col_size + j + 1], dp[i * dp_col_size + j]);
                }
            }
        }
    }

    return dp[N * dp_col_size + T.len];
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [100001]u8 = undefined;

    const N = parseInt(u32, nextLine(reader, &buffer));
    const S = nextLine(reader, &buffer);
    const T: []const u8 = "atcoder";

    const ans = try solve(allocator, N, S, T);
    try stdout.print("{d}\n", .{ans});
}
