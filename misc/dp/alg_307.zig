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

fn solve(N: u32, A: []const i32) i32 {
    var dp: [10000]i32 = undefined;
    dp[0] = 0;
    var i: u32 = 0;
    while (i < N) : (i += 1) {
        dp[i + 1] = @max(dp[i], dp[i] + A[i]);
    }
    return dp[N];
}

pub fn main() !void {
    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const N = parseInt(u32, nextLine(reader, &buffer));

    var A: [10000]i32 = undefined;
    {
        var i: u32 = 0;
        while (i < N - 1) : (i += 1) {
            A[i] = parseInt(i32, nextToken(reader, &buffer));
        }
        A[N - 1] = parseInt(i32, nextLine(reader, &buffer));
    }

    try stdout.print("{s}\n", .{solve(N, A)});
}

const tt = std.testing;
test "solve" {
    const TestCase = struct {
        N: u32,
        A: []const i32,
        expected: i32,
    };

    var testCases = [_]TestCase{
        .{ .N = 3, .A = &[_]i32{ 7, -6, 9 }, .expected = 16 },
        .{ .N = 5, .A = &[_]i32{ -10, -10, -10, -10, -10 }, .expected = 0 },
    };

    for (testCases) |tc| {
        const actual = solve(tc.N, tc.A);
        const expected = tc.expected;

        if (actual != expected) {
            try stdout.print("n = {d}, A = {d}, expected = {any}, actual = {d}", .{ tc.N, tc.A, expected, actual });
        }
        try tt.expectEqual(actual, expected);
    }
}
