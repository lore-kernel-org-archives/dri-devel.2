Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968EBC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D6510E42D;
	Tue, 22 Sep 2026 08:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Od/Uz4q4";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9419D10E42D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:26 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b0dd3e1d0so1718995e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064085; x=1790668885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KlrTUdxs01E/pA1z3Pr9MJkC0zDiUUzoqp93jYKaJpE=;
 b=Od/Uz4q4Z3vp7M8o4Dv5AMFFod1oWCY6iQdp6NAjyZ44ZSdWAfSNejquVfezAbZBD6
 FJzGE2JoqsJz7dgkM8PbdjJgvTErGHSznNNKU7ri2j0PgYeeB6Rmvf3uQEjnLJvvnTjS
 YzQ71OS7Ftv926VHGLoLn3P3QZQ3wk6ASHS6Y07Bhd2X2RdA0CkujhNTm2eN49pgCGep
 esQx1iNPdiADoPjedKXrHkgec20SFAeExhIuXcpedR2FaSbLC0QEXoGcfs7nn50AgJog
 4uHeNCfxawTQAfkFQ7OEnRvU6jymej05NEc3iCgZolKxdTOQ0DwlRVJIQmAt++SaGCII
 z7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064085; x=1790668885;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KlrTUdxs01E/pA1z3Pr9MJkC0zDiUUzoqp93jYKaJpE=;
 b=MjM8Ym0iho/VLXGaNbHh5RxD6wujS8MTHpUPQ8CsyUM4SU9lvbcgQyAXhUxn8LuR/Z
 NMrKMOl2F7zIehZmOqCB6ubRZcxKEjDV5LUEomIvQWm5Pf2JaVioFNBigrgpsD+dTZCe
 HzboD1K+iAV//3Zykg9et41fppnDboiiFtg0Pzd6e9s7+YTxAay+Z4FC2g6PdFn0UzR4
 wU8GfN8+1eMeStJAsPJOD5afNAizuISHXOpqAE+SryaA0VFtGVDtV7Y5AvQHpWtIWZvP
 DLY6gDbMuWlCg7m+jG8XTOPEVHG0jWGEIIraaOqKrmXBcCXyf/dGsPx3NjT1U1kqmCZP
 NiCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGtgEUt1YxjdsCi4aauNvPF44UTjBa91wYkjoFEOD5xsQpkIBBYj52qxc647/6XHz8MIsdT7Ni8Lo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nGzIDdr1xT1/V4+c7hdtzWROAsoRRooTKXxvuhsOau638qJHBp
 rTwXmrryEB4uqgPFN60CqUQHncFCeflRCh/HPhBRwu7DqTGZovgzpaTe
X-Gm-Gg: AYBFou0Jw4vn2NZThWZqa7xmr6OUcqPyAiNb8LpbTg7GoYwjEhZZCW13xCDmTtlkgOm
 o5JLSBXLoxZ6mzgh2I6jE/rVyjcj8ez60jX/ml5UwOy3p01bxFs40dbEJDUtwXjWA9z3rkeb/lz
 MIb++cyqrhXS66US8jZwfcmEyoUw0/yIwBtGh1Ih0SoBmbefIuu4AoOfN0PEIzqWfYDCnkAIZQC
 Bw+myf6+V8YuJLMZ5XAFl2TWztwrvn3DYVGLPx6MyveqHeBgrlWHRLGqO97JGPGQgziiKLhz2X4
 aqJWexttnQQoL6eF8ATBHGvK+zqFbAKAil7SGZh6O6FK2Ff6ZXtug/OH1KrY2IRi6hufPxxTEtu
 7yc4UdZIms2GOxoHUZL8/bbNCQGCWsERPS5jap9V1hKDCq89nssDKXKM56YBhxkzIZ4tV5vTHss
 4x/R7ScRBucMYrSIR3kLV6CE6tcNaO2rC+hYVcMyOqnsyen74JXUyNtSYnIXXMvIjfLwV0MBJjU
 VtDowb8DFDfDK35NX3Wupr8qdMIkAISQyDaymFWQbyoCnM636ZW15AVmP6aDvDjnS51Sh2isWt6
 wDM=
X-Received: by 2002:a05:600c:a00a:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49fc7b83237mr163719885e9.0.1790064084425; 
 Tue, 22 Sep 2026 01:01:24 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:23 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 00/11] accel/rocket: DVFS for the RK3588 NPU
Date: Tue, 22 Sep 2026 10:01:03 +0200
Message-ID: <20260922080114.44662-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The rocket driver runs the NPU at whatever rate the devicetree pinned
it to: 200 MHz on the RK3588, out of the 1 GHz the hardware reaches.
This series adds devfreq, the OPP table and the thermal plumbing that
go with it.

v1: https://lore.kernel.org/r/20260904130858.27803-1-royalnet026@gmail.com

As Tomeu asked [1], the slot-search fix now leads the series, with the
two rocket fixes this builds on and, as patch 4, 2/2 of my July
lifecycle series [2], without which v2 oopsed when one core was unbound,
bound and unbound again. KASAN found that v1 4/7 (now 8) kept a clk
handle that unbinding freed; the notes under each --- list the rest.

Hardware constraint
-------------------

The three cores share one clock and one supply. The clock comes from a
PVTPLL inside the NPU power islands: for a PVTPLL rate the firmware
programs NPU GRF registers inside the islands, for the 200 MHz boot rate
it only switches CRU selectors to GPLL (clk_npu_set_rate() in
plat/rockchip/rk3588/drivers/scmi/rk3588_clk.c, TF-A v2.12.0, which
Nicolas pointed me to). An island powered up while the clock is above
the boot rate never acknowledges the power-on, and the next register
access into it takes an asynchronous SError. Returning to the boot rate
is safe at any time; raising the clock is not, so while it is above the
boot rate every core is held runtime resumed and no island can
transition. Unbinding any core takes devfreq down until all are bound
again.

The firmware accepts only the nine rates of its rk3588_npu_pvtpll_table,
300 to 1000 MHz in 100 MHz steps plus 200 MHz, and refuses any other.
The refusal never reaches the caller: clk_change_rate() ignores what
->set_rate() returns, so clk_set_rate() reports success and the clock
stays put. Hence patch 7 names exactly those nine.

The table is on all three cores with opp-shared (Nicolas's review);
the one devfreq device sits on rknn_core_0, the lowest devicetree index.
Patch 9 explains the maximum over the cores and why runtime suspend
does not call devfreq_suspend_device().

Testing
-------

Orange Pi 5 Plus, 7.3.0-rc2 (drm-misc-next 3afbeb6b99dd) plus this
series, in-tree rocket, BL31 v2.12.0-10-g70d814213: the edk2-rk3588 TF-A
branch with upstream d2d6928641ba, so that it reports the PVTPLL rate it
measures. MobileNetV1 through Teflon, 3 x 20 s per arm, one thread
pinned to one CPU, CPUs on the performance governor, a bit-exact oracle
on every inference, polling_interval at the driver's 50 ms, core 0's
interrupt on a CPU with its deep idle state disabled.

cur_freq is only the driver's request and scmi_clk_npu on the GPLL path
echoes the last accepted rate, so the CRU selector is the witness
(CLKSEL_CON74 bit 0 = PVTPLL, CLKSEL_CON73 = GPLL divider), read once a
second:

  200 MHz OPP, userspace     91.15 inf/s   CRU GPLL/6 = 198 MHz, 700 mV
  1000 MHz OPP, userspace   234.45 inf/s   CRU PVTPLL (BL31 1 GHz), 850 mV
  simple_ondemand           232.88 inf/s   OPPs 200-1000 MHz
  200 MHz OPP again          90.87 inf/s   drift 0.997

That is 2.57x pinned and 2.55x under the governor, 0.7 % below pinned;
the oracle and the interrupts per inference were the same in all four
arms.

Three clients, each with its own oracle, all three cores computing
together, output bit-exact and identical to a single-client control:

  OPP                one client   three clients              total
  900 MHz, 800 mV      234.42     199.33 + 198.95 + 199.19   597.47 inf/s
  1000 MHz, 850 mV     240.49     203.16 + 203.01 + 203.46   609.63 inf/s

After 25 s of load the governor is at the 200 MHz OPP from the first
sample (0.24 s apart) through the 60 s idle window: CRU 198 MHz in all
60 one-second samples, rail 700 mV. The islands were power-cycled five
times at 700 mV and powered down once more after a raise to 1000 MHz.
All six bind orders give bit-exact output, with devfreq and cooling back
on rknn_core_0 after every rebind.

Unbind and reload: 25 rounds of all three cores, 4 of a single core with
an inference while it was gone, 5 rmmod rounds, and 3 unbinds plus 1
rmmod with the clock raised (CRU on the PVTPLL before each). Without
patch 4 the single-core round oopses, as its commit message shows.

On a KASAN, kmemleak and PROVE_LOCKING build of the same tree the unbind
(no client submitting), reload, three-client and island tests gave no
report and kmemleak nothing from this driver, and a lockdep run through
the governor, cooling, three clients, and unbind and rmmod with the
clock raised to the 1 GHz OPP left lockdep enabled.

Build: the series was rebased onto drm-misc-next 8ef59ee79407 to send
it; apart from one comment corrected in 9 (rocket_devfreq.o is
byte-identical), the patches are the ones tested above. On that base,
arm64, gcc 13.3: each patch that touches drivers/accel/rocket builds
with W=1 and no warning, and sparse reports nothing in
drivers/accel/rocket; 9, 10 and 11 also build with W=1 and no warning
with CONFIG_DEVFREQ_THERMAL=n. dt_binding_check at 6 and 11, and
CHECK_DTBS on rk3588-orangepi-5-plus, rk3588s-orangepi-5 and
rk3588-edgeble-neu6b-io at the base, 7 and 11, give no schema warning.
A full Image, modules and dtbs build at 11 completes with no warning
from drivers/accel/rocket. checkpatch --strict flags only the 75-column
oops line in 4 and MAINTAINERS for the new files in 9, which
F: drivers/accel/rocket/ covers.

Two corrections to my reply of 9 September [3]: the supply could have
come down to the 200 MHz voltage even had the clock change failed, since
the refusal is not reported, so the CRU selector is the witness now; and
the v1 governor arm was the governor running, not limits pinned by hand.

Not done
--------

- Unbinding a core while clients submit is still unsafe. Patch 3 notes
  that an open file keeps an entity on the departed core's scheduler;
  on the KASAN build (three clients running, then as root
  "echo fdac0000.npu > /sys/bus/platform/drivers/rocket/unbind") that
  is a use-after-free:

    BUG: KASAN: slab-use-after-free in _raw_spin_lock+0xb4/0x118
     drm_sched_rq_remove_entity+0x94/0x2b0 [gpu_sched]
     drm_sched_entity_select_rq+0x1f4/0x698 [gpu_sched]
     drm_sched_job_arm+0x50/0x258 [gpu_sched]
     rocket_job_push+0x2f8/0x6b8 [rocket]
     rocket_ioctl_submit+0x888/0xd28 [rocket]
    Freed by: drm_sched_fini <- rocket_job_fini <- rocket_core_fini <-
              rocket_remove

  then a soft lockup: drm_sched_fini() frees the run queues while the
  entity still points at one. drm-misc-next has the same path (read,
  not run): rocket_job_open() builds the entity over every core, and
  rocket_remove() ignores open files. The fixes I see are policy,
  suppress_bind_attrs (undoing patch 4) or unplugging the DRM device
  when any core goes. Tomeu, which would you prefer? I will write it.
- Probe and remove are not serialised against open, and a file opened
  while a core probes can see its scheduler uninitialised; both predate
  this series.
- Lifecycle 1/2 [2] (a devres leak that moves the accel minor up after
  every full unbind and rebind, invisible to kmemleak) builds on
  Guangshuo Li's "accel/rocket: clear rdev on device init failure" [4],
  which is not in drm-misc-next. Sashiko's other pre-existing findings
  on the standalone slot-search patch, which I agreed with [5], stand
  unless patch 4 covers them.
- Not exercised: a devicetree without the OPP table or without
  assigned-clock-rates (code-read only), throttling at 85 degrees (not
  reachable here), system suspend (s2idle does not resume on this board,
  for reasons outside the NPU), kexec from a raised clock, and any other
  board. No milliwatt figure, no energy model.

Routing
-------

Patches 1-4 are fixes with Cc: stable and 9 builds on 1, 2 and 4, so the
simplest route is all but the two dts patches through drm-misc-next. The
binding (6) must land before those (7 and 11, Heiko's tree), which I can
resend once the rest is in. 1-3 supersede their standalone postings
(links under each ---); 5 is also 01/14 of Jiaxing Hu's RK3576 series,
and whichever lands first, the other drops it. I have not rebased onto
that series.

Questions
---------

Q1. DT maintainers: is opp-shared on all three cores the right
    description of one clock and one supply? v2 leaves opp-suspend out;
    Nicolas found it "not 100% fit" for 200 MHz but not unfit either,
    and asked for your view [6].
Q2. Maximum over the cores, or a summed busy count? And no OPP table
    means no devfreq and no error, as in panfrost and lima: the policy
    you want?
Q3. assigned-clock-rates stays on all three nodes. Jiaxing reports that
    on the RK3576 it hangs the board before the console when set on the
    SCMI clock, and that the vendor driver never writes that rate from
    DT [7]. I have not booted this board without it. Keep it, or drop it
    in a patch on top?

Nicolas also floated the component framework; I have not tried it.

Credits
-------

Nicolas Dufresne: review, opp-shared, the TF-A pointer, and a proof of
concept with the same rates and voltages. Tomeu Vizoso agreed to the
full-range table [8]. Jiaxing Hu: the RK3576 multi-core corruption the
three-client test answers, a test and a review. Sidong Yang: the report
behind patch 3 and a test.

Jonas Karlman pointed me at his GPU approach, a .config_clks() that
checks pm_runtime_suspended() [9][10], and warned that "just reading
clk_summary to read SCMI clock rate can issue SError or a freeze" [11].
From the code, not a test: ->get_cur_freq() returns the last request,
probe reads the boot rate with the domain on, and with the in-tree
devicetree every set_rate that reaches the firmware, re-read included,
runs with the cores held.

Hüseyin BIYIK wrote TF-A commit d2d6928641ba, which makes BL31 report
the PVTPLL rate it measures rather than the one asked for, and guessed
early that the clock framework ignores what SCMI answers [12]; for a
refused set_rate it does.

The Assisted-by: LLM tags are Claude (Fable 5.1 and Opus 5; the v1
cover named only Opus 5, though Fable 5.1 worked on v1 too). We wrote
the code and these messages together, including the v3 changes to patch
4; it also found the silent refusal with me in the clock, OPP and TF-A
code, wrote and adversarially reviewed the test scripts, and analysed
the crash patch 4 fixes and the one under Not done. I threw out plenty
of what it proposed. The board, every boot and measurement, the decision
to send this and the responsibility for it are mine.

[1] https://lore.kernel.org/r/CAPsqS2QXQda2ftbEJb_-Qeva9ay4+4ysdpUtj8jAvbyAsYiAJw@mail.gmail.com
[2] https://lore.kernel.org/r/20260731064933.12548-1-royalnet026@gmail.com
[3] https://lore.kernel.org/r/20260909091825.10838-1-royalnet026@gmail.com
[4] https://lore.kernel.org/r/20260708062845.716487-1-lgs201920130244@gmail.com
[5] https://lore.kernel.org/r/20260904135938.8757-1-royalnet026@gmail.com
[6] https://lore.kernel.org/r/9af28de2a07f7965300b898994481ccf194a30da.camel@ndufresne.ca
[7] https://lore.kernel.org/r/20260904110853.85150-1-gahing@gahingwoo.com
[8] https://lore.kernel.org/r/CAPsqS2RRUyG1vz5Nm7990yd0hcKR5E-SWhbt0ishaVYvCqQftw@mail.gmail.com
[9] https://lore.kernel.org/r/ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se
[10] https://github.com/Kwiboo/linux-rockchip/commits/next-20260619-rk35xx-scmi-gpu-clk/
[11] https://lore.kernel.org/r/82c8b17e-7215-45ea-84d1-9991ba6fb541@kwiboo.se
[12] https://lore.kernel.org/r/20260903185147.49411-1-royalnet026@gmail.com

Igor Paunovic (11):
  accel/rocket: search every core slot when a core is removed
  accel/rocket: number the cores by devicetree position, not bind order
  accel/rocket: search every core slot when looking up a scheduler
  accel/rocket: keep core slots stable across unbind and rebind
  accel/rocket: request the core clocks by name
  dt-bindings: npu: rockchip: allow DVFS and thermal properties
  arm64: dts: rockchip: rk3588: add an OPP table for the NPU
  accel/rocket: restore the NPU clock boot rate before powering the
    cores down
  accel/rocket: add devfreq support
  accel/rocket: register a devfreq cooling device
  arm64: dts: rockchip: rk3588: add passive cooling to the NPU thermal
    zone

 .../npu/rockchip,rk3588-rknn-core.yaml        |  10 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  17 +-
 arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi  |  54 ++
 drivers/accel/rocket/Kconfig                  |   2 +
 drivers/accel/rocket/Makefile                 |   1 +
 drivers/accel/rocket/rocket_core.c            |  14 +
 drivers/accel/rocket/rocket_core.h            |  16 +
 drivers/accel/rocket/rocket_devfreq.c         | 525 ++++++++++++++++++
 drivers/accel/rocket/rocket_devfreq.h         |  67 +++
 drivers/accel/rocket/rocket_device.c          |   2 +
 drivers/accel/rocket/rocket_device.h          |  21 +
 drivers/accel/rocket/rocket_drv.c             | 192 ++++++-
 drivers/accel/rocket/rocket_job.c             |  47 +-
 13 files changed, 945 insertions(+), 23 deletions(-)
 create mode 100644 drivers/accel/rocket/rocket_devfreq.c
 create mode 100644 drivers/accel/rocket/rocket_devfreq.h


base-commit: 8ef59ee794076e2b58cff357b12de2ba5d441271
-- 
2.43.0

