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

const Job = struct {
    expiry: u64,
    workload: u64,
    reward: u64,
};

fn readLine(reader: anytype, buffer: []u8) Job {
    return Job{
        .expiry = parseInt(u64, nextToken(reader, buffer)),
        .workload = parseInt(u64, nextToken(reader, buffer)),
        .reward = parseInt(u64, nextLine(reader, buffer)),
    };
}

fn ascJobExpirty(_: void, a: Job, b: Job) bool {
    return a.expiry < b.expiry;
}

fn solve(alc: std.mem.Allocator, N: u64, jobs: []Job) !u64 {
    std.mem.sort(Job, jobs, {}, ascJobExpirty);
    const dp_row_size = N + 1;
    const dp_col_size = 5001;
    const dp_size = dp_row_size * dp_col_size;
    var dp = try alc.alloc(u64, dp_size);
    defer alc.free(dp);
    {
        var i: u64 = 0;
        while (i < dp_size) : (i += 1) {
            dp[i] = 0;
        }
    }

    {
        var i: u64 = 0;
        while (i < N) : (i += 1) {
            var job = jobs[i];

            var j: u64 = 0;
            while (j < dp_col_size) : (j += 1) {
                // When we don't take the job
                dp[(i + 1) * dp_col_size + j] = @max(dp[(i + 1) * dp_col_size + j], dp[i * dp_col_size + j]);

                // When we take the job
                if (j <= job.expiry and j >= job.workload) {
                    dp[(i + 1) * dp_col_size + j] = @max(dp[(i + 1) * dp_col_size + j], dp[i * dp_col_size + j - job.workload] + job.reward);
                }
            }
        }
    }

    var max: u64 = 0;
    {
        var i: u64 = 0;
        while (i < dp_col_size) : (i += 1) {
            max = @max(max, dp[N * dp_col_size + i]);
        }
    }

    return max;
}

pub fn main() !void {
    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const N = parseInt(u64, nextLine(reader, &buffer));
    var jobs: [5000]Job = undefined;

    {
        var i: u64 = 0;
        while (i < N) : (i += 1) {
            jobs[i] = readLine(reader, &buffer);
        }
    }

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alc = arena.allocator();

    const ans = try solve(alc, N, &jobs);
    try stdout.print("{d}\n", .{ans});
}
