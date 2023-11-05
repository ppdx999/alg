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

fn Matrix(comptime T: type) type {
    return struct {
        data: []T,
        width: usize,
        height: usize,
        size: usize,

        const Self = @This();

        pub fn init(allocator: std.mem.Allocator, width: usize, height: usize) !Self {
            return .{
                .data = try allocator.alloc(T, width * height),
                .width = width,
                .height = height,
                .size = width * height,
            };
        }

        pub fn deinit(self: *Self, allocator: std.mem.Allocator) void {
            allocator.free(self.data);
        }

        pub inline fn get(self: Self, i: usize, j: usize) T {
            return self.data[i * self.width + j];
        }

        pub inline fn set(self: *Self, i: usize, j: usize, value: T) void {
            self.data[i * self.width + j] = value;
        }
    };
}

const MOD = 1000000007;
fn add(matrix: anytype, i: usize, j: usize, value: u32) void {
    var new_value = matrix.get(i, j) + value;
    if (new_value >= MOD) {
        new_value -= MOD;
    }
    matrix.set(i, j, new_value);
}

fn solve(alc: std.mem.Allocator, N: u32, S: []const u8, T: []const u8) !u32 {
    const dp_row_size = N + 1;
    const dp_col_size = T.len + 1;
    var dp = try Matrix(u32).init(alc, dp_col_size, dp_row_size);
    defer dp.deinit(alc);

    {
        var i: u32 = 0;
        while (i < dp_row_size) : (i += 1) {
            var j: u32 = 0;
            while (j < dp_col_size) : (j += 1) {
                dp.set(i, j, 0);
            }
        }
    }

    dp.set(0, 0, 1);

    {
        var i: u32 = 0;
        while (i < N) : (i += 1) {
            var j: u32 = 0;
            while (j < dp_col_size) : (j += 1) {
                add(&dp, i + 1, j, dp.get(i, j));

                if (j < T.len and S[i] == T[j]) {
                    add(&dp, i + 1, j + 1, dp.get(i, j));
                }
            }
        }
    }

    return dp.get(N, T.len);
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
