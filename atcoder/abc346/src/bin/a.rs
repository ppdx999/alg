use proconio::input;

fn main() {
    input! {
        n: u64
    }

    let mut prev = Option::None;

    for _ in 0..n {
        input ! {
            a: u64,
        }
        match prev {
            Some(prev) => print!("{} ", prev * a),
            None => (),
        }

        prev = Some(a);
    }
}
