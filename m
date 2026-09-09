Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34336C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1520110F1E4;
	Wed,  9 Sep 2026 17:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AkKbwAvQ";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1059310F1E4
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:00:04 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485ac8990caso114803f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788973202; x=1789578002; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FXW4rsfWsl/qV1jQizp21oY8xUg2xuC2B9JemfOPbJA=;
 b=AkKbwAvQc/VuV7GLtnr7b3aKVoRAevxRMTLAlYz1k2K7MdpzC1+kyRwIHri0rEjf9L
 jQRilUiyaWex+QB/wpUNEneaeIdt6qdopka+kHAUczCe3QBNjHs++DDEwNs6ps+JTpK5
 7ci3sv8ByzY6g/XtZ6doVyOULfbj6AdwjJ4j5fzE7UMdMnrF+s5sxXwvY8O9QjOESYI5
 5qtxzSMz0xdjlseT3jeNXf0gpQwGI2RuyEkbzIu6eOjs0Hkyk5xkLArmq+RR/ZgLgrDy
 IyWpiCO8duR1n+QNDfSDw7MyuUpJ/a3zVSvBvjPXCUdQ4NHHTncJNNpHXkIh1tidmAVj
 jkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788973202; x=1789578002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FXW4rsfWsl/qV1jQizp21oY8xUg2xuC2B9JemfOPbJA=;
 b=oP1JlRvc2hGYARI0Vc8BC0CLsZMy2FoafJADuKFJkJTsxcxoTg7tI22JWYZFjmS4jO
 1iSVYlO/B5RBFaebywriJbGTQm8p/ga/+XI4vtiEMcjfHwOSqKqhvWgZp42tgN+cfBGR
 4ntomhhbpuhGvsPTzy4r5OlPAtd8AaBevJKMZeIVHnQgcf4fkn9O34ilrXRX9b2Hodsh
 OVLeqd0/ioxPqhfHkwjOuiVNXn9mOp3T0YRHWvHZM8cqQ0xBzux8XA5skOv3c9Gz0Zli
 90fKlT7hQwl7R8bJpTpUmzaRpnlG9C8LQAdnqC0egA2v6eyNhmdcJ2Q7Kj/C2jb4LyOJ
 fsKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5yqeo/BlWxWOXk9bpL5AYi3rRIB0USn3JTkO/XUX8dtvoSbMQb8Y2mK1uTaOCrqi5m3MRAfNE6nc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lMs/gK4qvYP9V1k9WhJqIlanKfe42ub8txlmUNjKC4UDF5tZ2h
 Sql2YKXXMBa8fT763OxGq1+KzuYE00PhzQzSy8mJbjUh65DOPUtiXEBB
X-Gm-Gg: AYBFou0+dOlmwoHINgtQh1U7jOyU3YTeZLOjpu0hoJ8r/7+VsyGxOf6DtT35aj3Fl4m
 W/nhC4wSGpOmze4FHO23IMeU02+3hK+diBSYHlkgifivtU4BpL5VPiwYztOwQzyzjWSWc8V97uQ
 zRzdrK8AlyoArHZOfTlPze4ijAavqlkwDToEyIg/p2k18HL8XTyVRmGb6RbPWv198xvy7gFC439
 cUAIT4csImH/4iQ4te/wJE6KyCEDVEvst95eHBoPeqm9U/mMwslHTFoqrRCXMt9zGY1zlmS+QE/
 wcYy08/PD7pXupo4CUoo2YjxUi8F2GKEBhUEeR+4TWzmzhSB6KI+fbzIfKGnNz47NeWIOhngb9R
 Gwlrz6WYMZBVFDGBlJdKpEIqKd+N5Ehyobew5Rwb7LVL8mFt7eTj2dQUGzsryDdYbbr5ul4Iu/u
 kA/Xzxkj5oYGDnz/SxMKv8BCne76K7D3JQkmni6SfFQdFkM4H4htWAZ4YN0BT4jrKtlq+yQrwkR
 J/9voDLPljnS7EiO5cOAjDb5R8rytnaQMFmkde+UU9BuQrFyBgTK7pFq6R1qxfC8xDIboPWDsoo
 nRs=
X-Received: by 2002:adf:e001:0:20b0:485:a9b4:9883 with SMTP id
 ffacd0b85a97d-485a9b498b4mr6458294f8f.1.1788973201948; 
 Wed, 09 Sep 2026 10:00:01 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B836900B0110705BF092680.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:b011:705:bf09:2680])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bbb51sm47864373f8f.30.2026.09.09.10.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 10:00:01 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Igor Paunovic <royalnet026@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Jonas Karlman <jonas@kwiboo.se>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] arm64: dts: rockchip: rk3588: add an OPP table for
 the NPU
Date: Wed,  9 Sep 2026 18:59:02 +0200
Message-ID: <20260909165903.8472-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9af28de2a07f7965300b898994481ccf194a30da.camel@ndufresne.ca>
References: <9af28de2a07f7965300b898994481ccf194a30da.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Nicolas,

> If you can script the test, I can run it on Rock5B later on.

Here it is. I ran this exact script on my board before sending it, so it
is the same code, not a cleaned-up retelling of what I did.

It answers one question and refuses to answer anything else. Two modes:

  ./rk3588-npu-devfreq-check.sh --check     # discovery and gates only
  NPU_LOAD_CMD='...' ./rk3588-npu-devfreq-check.sh

The load command is yours - anything that keeps the NPU busy for about
25 s and exits. I did not want to ship my benchmark, both because it is
not interesting and because the point is that the result should not
depend on which load you use.

The gates matter more than the measurement, so let me say what they do.
It refuses to run if the governor is not simple_ondemand, if min_freq or
max_freq are pinned (then the governor decides nothing and the number is
meaningless), or if the loaded rocket module is not the one belonging to
the running kernel. That last one caught me: my everyday kernel carries
an out-of-tree rocket with its own OPP list built by dev_pm_opp_add()
with no voltages, and no opp-table-npu in DT at all. A measurement there
would have described a different program. It warns rather than refuses
when there is no DT table, or when the table carries opp-suspend, since
both change what is being measured rather than invalidating it.

Everything is discovered, nothing is hardcoded: the devfreq device by
name, the lowest and highest OPP from available_frequencies, the supply
by regulator name. That last one is not paranoia - on my board the NPU
regulator was regulator.2, .6, .7 and .8 across four boots today.

It needs no sudo. Passwordless sudo, if present, only adds a clock
summary sample from debugfs; without it the script says so and goes on.

The verdict is deliberately narrow. It looks only at the window after
the load stops, and it wants the device to reach the lowest OPP and stay
there, not merely touch it - simple_ondemand dips to the bottom between
batches while the load is still running, and an earlier version of this
script counted that as success. It also prints the trans_stat delta for
the idle window, which is the part I would trust most if we disagree.

If it says INVALID, that is the intended outcome for a run that cannot
support a conclusion, not a bug.

What it says here, on an Orange Pi 5 Plus with the series applied,
in-tree rocket, the 3/7 table read out of DT, 25 s of load then 60 s
idle:

  under load : peak 1000 MHz, 700-850 mV
  after load : 200 MHz immediately, held for the whole 59.8 s, 700 mV
  trans_stat : +60055 ms at 200 MHz in the idle window, 0 ms elsewhere
  RESULT: YES

That is worth one remark. I had already measured this earlier today with
a different script of my own, which reported 60129 ms at 200 MHz for the
same window. Two differently written tools, the same answer to within
their sampling noise - which is a better reason to believe it than one
tool run twice. Neither of them, though, is a second board, which is why
your offer is worth more than either.

The script follows below.

Igor
---

#!/bin/bash
# Does the NPU devfreq governor return to the lowest OPP after the load stops?
#
# Written for the discussion on "[PATCH 3/7] arm64: dts: rockchip: rk3588: add an
# OPP table for the NPU", where the question was whether opp-suspend is needed.
# It answers exactly that one question and nothing else.
#
#   ./rk3588-npu-devfreq-check.sh --check          # discovery + gates only, no load
#   NPU_LOAD_CMD='...' ./rk3588-npu-devfreq-check.sh
#
# The load command is yours: anything that keeps the NPU busy for LOAD_S seconds
# and then exits. It is run in the foreground and its exit status is checked.
#
# Requires: bash, python3, awk. No sudo for the measurement itself; sudo is used
# only to read the clock summary in debugfs, and the script works without it.
set -u

CHECK_ONLY=0
[ "${1:-}" = "--check" ] && CHECK_ONLY=1

LOAD_S=${LOAD_S:-25}          # how long the load runs
IDLE_S=${IDLE_S:-60}          # how long we watch after it stops
SETTLE_S=${SETTLE_S:-20}      # how long it must stay at the low OPP to count
OUT=${OUT:-$PWD/npu-devfreq-$(date +%Y%m%d-%H%M%S)}

die() { echo "FAIL: $*" >&2; exit 1; }
ok()  { echo "  ok   $*"; }
note(){ echo "  --   $*"; }

echo "=== rk3588 npu devfreq check, $(date '+%F %T %Z') ==="
echo "kernel: $(uname -r)"

# ---------------------------------------------------------------- discovery
D=""
for d in /sys/class/devfreq/*; do
  [ -e "$d/available_frequencies" ] || continue
  case "$(basename "$d")" in *npu*) D="$d"; break;; esac
done
[ -n "$D" ] || die "no NPU devfreq device under /sys/class/devfreq"
ok "devfreq device: $D"

MINF=$(tr ' ' '\n' < "$D/available_frequencies" | grep -v '^$' | sort -n | head -1)
MAXF=$(tr ' ' '\n' < "$D/available_frequencies" | grep -v '^$' | sort -n | tail -1)
ok "OPPs: $(tr ' ' '\n' < "$D/available_frequencies" | grep -cv '^$') steps, $((MINF/1000000))-$((MAXF/1000000)) MHz"

REG=""
for f in /sys/class/regulator/*/name; do
  case "$(cat "$f" 2>/dev/null)" in *npu*) REG=$(dirname "$f"); break;; esac
done
if [ -n "$REG" ]; then ok "supply: $(cat "$REG/name") = $(cat "$REG/microvolts") uV  ($REG)"
else note "no NPU regulator found by name - voltage will not be sampled"; fi

SUDO=0; sudo -n true 2>/dev/null && SUDO=1
[ $SUDO = 1 ] && ok "sudo available - clock summary will be sampled" \
              || note "no passwordless sudo - clock summary will be skipped"

# ---------------------------------------------------------------- gates
GOV=$(cat "$D/governor"); MIN=$(cat "$D/min_freq"); MAX=$(cat "$D/max_freq")
[ "$GOV" = simple_ondemand ] || die "governor is '$GOV'; this test only means something with simple_ondemand"
ok "governor: $GOV"
[ "$MIN" = "$MINF" ] && [ "$MAX" = "$MAXF" ] \
  || die "min_freq/max_freq are pinned ($MIN/$MAX); the governor decides nothing. Reset them first."
ok "limits not pinned: $MIN / $MAX"

DTOPP=/proc/device-tree/opp-table-npu
[ -d "$DTOPP" ] && ok "OPP table comes from DT ($DTOPP)" \
                || note "no $DTOPP - the driver is building its own OPP list, results describe that instead"
if [ -d "$DTOPP" ] && ls "$DTOPP"/opp-*/opp-suspend >/dev/null 2>&1; then
  note "the DT table carries opp-suspend - that changes what is being measured"
fi

SRC_LIVE=$(cat /sys/module/rocket/srcversion 2>/dev/null || echo -)
SRC_TREE=$(modinfo -F srcversion "/lib/modules/$(uname -r)/kernel/drivers/accel/rocket/rocket.ko" 2>/dev/null || echo -)
if [ "$SRC_LIVE" != - ] && [ "$SRC_TREE" != - ] && [ "$SRC_LIVE" != "$SRC_TREE" ]; then
  die "the loaded rocket module ($SRC_LIVE) is not this kernel's ($SRC_TREE) - out-of-tree module in the way"
fi
ok "rocket module matches the running kernel"

if [ $CHECK_ONLY = 1 ]; then
  echo
  echo "=== --check only: everything above passed, no load was run ==="
  echo "To measure, give it a load command, for example:"
  echo "  NPU_LOAD_CMD='your-inference-tool --seconds $LOAD_S' $0"
  exit 0
fi

[ -n "${NPU_LOAD_CMD:-}" ] || die "set NPU_LOAD_CMD to something that keeps the NPU busy for ~${LOAD_S}s and exits"

# ---------------------------------------------------------------- measure
mkdir -p "$OUT" || die "cannot create $OUT"
cp "$D/trans_stat" "$OUT/trans_stat.begin" 2>/dev/null

SAMPLES=$OUT/samples.txt; : > "$SAMPLES"
( while :; do
    printf '%s %s %s\n' "$(date +%s.%N)" "$(cat "$D/cur_freq" 2>/dev/null || echo 0)" \
      "$([ -n "$REG" ] && cat "$REG/microvolts" 2>/dev/null || echo 0)" >> "$SAMPLES"
    sleep 0.2
  done ) &
SPID=$!
cleanup(){ kill $SPID 2>/dev/null; }
trap 'cleanup; echo; echo "INTERRUPTED - result is not valid"; exit 130' INT TERM
trap cleanup EXIT

echo
echo "--- load: $NPU_LOAD_CMD"
T0=$(date +%s.%N)
if ! eval "$NPU_LOAD_CMD" > "$OUT/load.log" 2>&1; then
  cleanup; die "the load command exited non-zero - see $OUT/load.log"
fi
T1=$(date +%s.%N)
cp "$D/trans_stat" "$OUT/trans_stat.load_end" 2>/dev/null
[ $SUDO = 1 ] && sudo -n cat /sys/kernel/debug/clk/clk_summary 2>/dev/null | grep -i npu > "$OUT/clk.load_end"

echo "--- load ran for $(python3 -c "print(f'{$T1-$T0:.1f}')") s; now watching for ${IDLE_S}s, keep the machine idle"
sleep "$IDLE_S"
T2=$(date +%s.%N)
cp "$D/trans_stat" "$OUT/trans_stat.end" 2>/dev/null
[ $SUDO = 1 ] && sudo -n cat /sys/kernel/debug/clk/clk_summary 2>/dev/null | grep -i npu > "$OUT/clk.end"
cleanup; trap - EXIT INT TERM

python3 - "$SAMPLES" "$T0" "$T1" "$T2" "$SETTLE_S" "$IDLE_S" "$LOAD_S" "$MINF" <<'PY' | tee "$OUT/verdict.txt"
import sys
f,t0,t1,t2,settle,idle_s,load_s,minf = sys.argv[1], *map(float,sys.argv[2:8]), int(sys.argv[8])
S=[]
for line in open(f):
    p=line.split()
    if len(p)==3:
        try: S.append((float(p[0]),int(p[1]),int(p[2])))
        except ValueError: pass
load=[x for x in S if t0<=x[0]<=t1]; post=[x for x in S if x[0]>t1]
mhz=lambda v: v//1000000
bad=[]
if (t1-t0) < 0.9*load_s: bad.append(f"load ran {t1-t0:.1f}s, expected ~{load_s:.0f}s")
if not post: bad.append("no samples after the load")
elif post[-1][0]-t1 < 0.95*idle_s: bad.append(f"idle window only {post[-1][0]-t1:.1f}s of {idle_s:.0f}s")
peak = max((x[1] for x in load), default=0)
print()
print(f"under load : peak {mhz(peak)} MHz, {len(load)} samples"
      + (f", {min(x[2] for x in load)//1000}-{max(x[2] for x in load)//1000} mV" if load and load[0][2] else ""))
first=tail=None
if post:
    t=post[0][0]
    for ts,v,u in post:
        if v==minf: first=ts-t; break
    tail=0.0
    for ts,v,u in reversed(post):
        if v==minf: tail=post[-1][0]-ts
        else: break
    print(f"after load : first {mhz(minf)} MHz after {'never' if first is None else f'{first:.1f}s'}, "
          f"continuously at {mhz(minf)} MHz for the last {tail:.1f}s (need >= {settle:.0f}s)"
          + (f", {min(x[2] for x in post)//1000}-{max(x[2] for x in post)//1000} mV" if post[0][2] else ""))
print()
if bad:
    print("RESULT: INVALID -", "; ".join(bad))
elif peak <= minf:
    print(f"RESULT: INVALID - the NPU never went above {mhz(minf)} MHz; the load did not reach it")
elif first is not None and tail>=settle:
    print(f"RESULT: YES - the governor returned to {mhz(minf)} MHz on its own and stayed there")
elif first is not None:
    print(f"RESULT: PARTIAL - it reached {mhz(minf)} MHz but did not stay; try a longer IDLE_S")
else:
    print(f"RESULT: NO - it did not return to {mhz(minf)} MHz within {idle_s:.0f}s")
PY

echo
echo "trans_stat delta (ms per OPP, idle window only):"
python3 - "$OUT/trans_stat.load_end" "$OUT/trans_stat.end" <<'PY'
import sys
def parse(p):
    out={}
    try:
        for l in open(p):
            l=l.strip().lstrip('*').strip()
            if ':' in l and l.split(':')[0].strip().isdigit():
                k=int(l.split(':')[0]); c=l.split(':')[1].split()
                if c: out[k]=int(c[-1])
    except OSError: pass
    return out
a,b=parse(sys.argv[1]),parse(sys.argv[2])
for k in sorted(set(a)|set(b)):
    d=b.get(k,0)-a.get(k,0)
    if d: print(f"  {k//1000000:>5} MHz: +{d} ms")
PY
echo
echo "everything written to: $OUT"
