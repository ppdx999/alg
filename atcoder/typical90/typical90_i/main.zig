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

const Point = struct {
    x: f64,
    y: f64,
};

fn readLine(reader: anytype, buffer: []u8) Point {
    return Point{
        .x = parseInt(f64, nextToken(reader, buffer)),
        .y = parseInt(f64, nextLine(reader, buffer)),
    };
}

const Vector = struct {
    x: f64,
    y: f64,
};

fn getAngle(a: Point, b: Point, c: Point) f64 {
    var ab = Vector{
        .x = b.x - a.x,
        .y = b.y - a.y,
    };

    var cb = Vector{
        .x = b.x - c.x,
        .y = b.y - c.y,
    };

    var dot = ab.x * cb.x + ab.y * cb.y;
    var cross = ab.x * cb.y - ab.y * cb.x;

    var rad = std.math.atan2(f64, cross, dot);
    if (rad < 0) {
        rad += 2 * std.math.pi;
    }

    return rad * 180 / std.math.pi;
}

fn solve(N: u32, points: []Point) !f64 {
    var max_angle: f64 = 0;
    for (0..N) |i| {
        for (i + 1..N) |j| {
            for (j + 1..N) |k| {
                var angle = getAngle(points[i], points[j], points[k]);
                if (angle > 180) {
                    angle = 360 - angle;
                }
                if (angle > max_angle) {
                    max_angle = angle;
                }
            }
        }
    }

    return max_angle;
}

pub fn main() !void {
    var buf_reader = std.io.bufferedReader(stdin);
    var reader = buf_reader.reader();

    var buffer: [1024]u8 = undefined;

    const N = parseInt(f64, nextLine(reader, &buffer));
    var points: [2000]Point = undefined;

    {
        var i: f64 = 0;
        while (i < N) : (i += 1) {
            points[i] = readLine(reader, &buffer);
        }
    }

    const ans = try solve(N, points);
    try stdout.print("{d}\n", .{ans});
}

const tt = std.testing;

test "getAngle" {
    var a = Point{ .x = 0, .y = 0 };
    var b = Point{ .x = 0, .y = 10 };
    var c = Point{ .x = 10, .y = 10 };

    var result = getAngle(a, b, c);

    try tt.expectEqual(result, 90);

    a = Point{ .x = 9, .y = 1 };
    b = Point{ .x = 2, .y = 0 };
    c = Point{ .x = 1, .y = 0 };

    result = getAngle(a, b, c);

    try tt.expectEqual(result, 171.86989764584402);

    a = Point{ .x = 0, .y = 0 };
    b = Point{ .x = 5, .y = 5 };
    c = Point{ .x = 8, .y = 8 };

    result = getAngle(a, b, c);

    try tt.expectEqual(result, 180);
}

test "case 1" {
    var N: u32 = 3;
    var points = [_]Point{
        .{ .x = 0, .y = 0 },
        .{ .x = 0, .y = 10 },
        .{ .x = 10, .y = 10 },
    };
    const result = try solve(N, points[0..N]);

    try tt.expectEqual(result, 90);
}

test "case 2" {
    var N: u32 = 5;
    var points = [_]Point{
        .{ .x = 8, .y = 6 },
        .{ .x = 9, .y = 1 },
        .{ .x = 2, .y = 0 },
        .{ .x = 1, .y = 0 },
        .{ .x = 0, .y = 1 },
    };
    const result = try solve(N, points[0..N]);

    try tt.expectEqual(result, 171.86989764584402);
}

test "case 3" {
    var N: u32 = 10;
    var points = [_]Point{
        .{ .x = 0, .y = 0 },
        .{ .x = 1, .y = 7 },
        .{ .x = 2, .y = 6 },
        .{ .x = 2, .y = 8 },
        .{ .x = 3, .y = 5 },
        .{ .x = 5, .y = 5 },
        .{ .x = 6, .y = 7 },
        .{ .x = 7, .y = 1 },
        .{ .x = 7, .y = 9 },
        .{ .x = 8, .y = 8 },
    };
    const result = try solve(N, points[0..N]);

    try tt.expectEqual(result, 180);
}
