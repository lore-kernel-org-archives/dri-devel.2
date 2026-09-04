Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D11EC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3409610E011;
	Fri,  4 Sep 2026 13:09:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hlKv62Kq";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB6710E011
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:09:24 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-499c0879d51so782145e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788527362; x=1789132162; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PlQbIt4yNB0MJLP43bg8WECYkTcWZ9D6PtJHQo6kx6Y=;
 b=hlKv62Kq8UxGsNxUG797OAYcYbu4zFVJ/eWRGhYBtNhXWiFaAxTcUMvqPf29FpXZVy
 h8ee1iYgPGPBhkLyiZ5VyPux85Z4jbvESa8dGewSscTa1c5lgMRsOkbVH/DQRJrtHT7M
 sLjX4QczgerJu7HH/4QgADCEejiuPouH98Wv0EHJooU920BVLlHcuvL2khYkmDRx1gAX
 u1FZGcgg0lllw/r3E3PydVUHDkymCxQluKcRl52RHUklPb6T4wmbc95yTicb2NtjgACs
 xrVhH8OiS7HQxLAEb2bgPuKH7ZsrSQhW0uqz7CbPKOI4qG+rJ1brUp8ugsUDVksz5X2d
 VCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527362; x=1789132162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PlQbIt4yNB0MJLP43bg8WECYkTcWZ9D6PtJHQo6kx6Y=;
 b=NUq9Tr2yFGYMaKvFVXKgq0uOwDKU/1wV40oPgNi1snsDsLXsORtca3mKCi280JlZOe
 PMWpcI++HfWJVkDccSX/hHH1S4oBKFHz7xYlx5EqFsEh05zP4Kue6uHQ6P5mLGFF3uMN
 vvheVjMPFPZ4tihw4SZuAlT4cqNaceea6EGclq8+XUplqEY1smY3FTTUPCS9LJqfQsiR
 wwP0F/G/qMXLydo6VZ1gooYGLdHIMekpYC1AC5+l02bYah44Duluowthk70Wb+97Rsej
 xxNqGIeYsdKope9tBMfoEGqfX+g23PCLNzp6LNGcGuxK0SA9wgQ7kzY4wxYEE5Lima9v
 XvZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqKlxCdyR3l22s1T+tux52ppe+4hHxZb1bWZBBRK1t7euV+wzlY+JsGul4NDEAdLTtOQIcI6SmYW4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kePS6NTkhi+PWzGn6k4EpHkyfgJeXbPK7jd9VaDuMuO5Iejiug
 9RVtfgsw4GPlTm4e7GoB4DMul0p79OBEkJ2PPa7W8UB/TmIewP6PViN8
X-Gm-Gg: AYBFou3Klhe6sjD1DPLpu95lsQEM299SOuGTdXRiaIkosLcXYk7Cja1qOiaMJ06oN8o
 tg+hdTjukFirtuqEqxjY9+FmDVr7alIKxmAtCFHPPUKYrgmhJ1h4WER0vEdK8HbQwcjLgpBSgQE
 knJCIKOa5wItEfwfDI/jFhAj/m02slMft0yuDCBtDrp8TcSM7f+4KAOUY5D3xSHZZgJ9Ugaqwa8
 rLKhTSnkpoObt6hjyKqYj3jpkX1dOG04eG/0a2gq2pcPCLovjfiyG1o8fMnc2y8DI/ZVlguibHU
 V8652uc0huRZLkYl7Jow+PfShQ7aLf02+LWbBgT8MhIw+UExcteZSC8JBU6nVfMStiA7IKrjEkq
 662bGhQpI6dzJFMGWWLAVlNZOE/jBq+MeaDTsGRmz89F312Ro7vpvhA6QJTGcVrI62UCUQCwps/
 eCpLO7mKs8y811oLH1tXnklRwHaKPJZ8141PIbTdRJs+aX4b/AKcRIPRHfgMFtZ2U65NaSOLXC5
 g07REzlhRZh3cZX0wH/L9cx+ObAs+/Fl0Ra1MSOJunKSJiK+55sZQ==
X-Received: by 2002:a05:600c:1c24:b0:49b:9241:7ff0 with SMTP id
 5b1f17b1804b1-49cf7f4d9b7mr51861245e9.0.1788527362095; 
 Fri, 04 Sep 2026 06:09:22 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B871500CB6EF488A18F9C42.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:1500:cb6e:f488:a18f:9c42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm135575435e9.3.2026.09.04.06.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:09:21 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 0/7] accel/rocket: DVFS for the RK3588 NPU
Date: Fri,  4 Sep 2026 15:08:51 +0200
Message-ID: <20260904130858.27803-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The rocket driver runs the NPU at whatever rate the devicetree pinned it to.
On the RK3588 that is 200 MHz, out of the 1 GHz the hardware reaches, and the
firmware will change it on request. This series adds devfreq so the driver
scales the clock with the load, plus the OPP table and the thermal plumbing
that go with it.

Hardware constraint
-------------------

The three cores share one clock and one supply, so they cannot be scaled
apart, and there is exactly one devfreq device for all of them.

The clock is generated by a PVTPLL that sits inside the NPU power islands.
An island powered up while the clock is above the rate the bootloader left
never acknowledges the power-on, and the first register access into it
afterwards takes an asynchronous SError. Lowering the rate is safe at any
time: the firmware serves the boot rate from GPLL and writes only CRU clock
selectors to get there.

The firmware also accepts only the rates in its own PVTPLL table - 300 to
1000 MHz in 100 MHz steps, plus 200 MHz off GPLL. Any other rate is
rejected outright, which is why patch 3/7 names exactly those nine.

Design
------

The devfreq device hangs off the core that carries the OPP table in the
devicetree, found through the property and not through the core index: the
index is handed out in probe order, which is not the order the cores are
written in.

Before the rate goes up, every core is runtime resumed, and those references
are held for as long as the clock stays raised. While they are held no core
can suspend, so no island can transition at all - that is what makes a
raised clock safe rather than merely unlikely to be caught out. At the boot
rate the references are dropped and runtime PM behaves as it did before.
The cost is that a boosted NPU does not power-gate individual cores; what
that costs in milliwatts has not been measured, and I would rather say so
than guess.

Utilisation is aggregated as the maximum over the cores rather than the sum,
because the clock has to satisfy the busiest of them.

devfreq_suspend_device() and devfreq_resume_device() are deliberately not
called, which is a deviation from panfrost, panthor, lima and msm. See the
commit message of 5/7: they end in cancel_delayed_work_sync() on the
governor worker, and that worker is what calls back into ->target(), which
resumes every core.

Testing
-------

Measured on an Orange Pi 5 Plus with this series applied: MobileNetV1
through Teflon, three 20-second blocks per arm, pinned to one CPU, with a
bit-exact oracle checked on every inference.

  200 MHz, userspace      91.1 inf/s    rail 700 mV
  1000 MHz, userspace    234.0 inf/s    rail 850 mV
  simple_ondemand        231.2 inf/s    rail 700-850 mV
  200 MHz again           91.0 inf/s    (drift 0.999)

That is 2.57x for the fixed maximum and 2.54x for the governor, which
costs 1.2 % against pinning. The oracle passed bit-exact in all four arms,
the interrupt count per inference was identical in all four, and the
kernel log has nothing from this driver for the whole run.

The rail voltages are read back from vdd_npu_s0 inside each arm. Nothing
in the test sets them: they are the OPP core following the table in 3/7.
In a separate run the power islands were cycled five times at 700 mV
without an SError, and at 1000 MHz all three cores stay runtime resumed,
0 of 3 suspended, which is the hold described under Design doing its job.

Under simple_ondemand the governor spent most of the run at 900 MHz rather
than at 1000 - 290 samples against 145, three transitions - and still
landed within 1.2 % of the pinned maximum.

Everything above is one inference thread, which cannot see a fault that
only appears when several cores compute at once. Jiaxing Hu found exactly
that on the RK3576, where two cores in flight together corrupt single
words of the second core's output, and the cure is voltage: the rate his
board came up at wanted 800 mV and had 750. So the same oracle was run
again with three concurrent clients, each checking its own output
bit-exact, at the two top rates in the table:

  900 MHz, rail 800 mV    3 x 199 inf/s, 598 total, all bit-exact
  1000 MHz, rail 850 mV   3 x 204 inf/s, 611 total, all bit-exact

Single-client control on the same rates was 232 and 240 inf/s, so the
aggregate is 2.57x and 2.55x of one client - the cores really were
computing together, which is what makes the bit-exact result mean
anything. Rail voltages read back during the run, set by the OPP core.

kernel 7.3.0-rc1 plus this series, rocket srcversion
C1FE916B551FCF00F0B2D81, BL31 v2.12.0-10-g70d814213.

For anyone comparing against numbers I posted earlier: an out-of-tree
devfreq module on 7.2.0-rc7 measured 2.47x for the governor. The
difference is not the NPU. Time spent NPU-side per inference is the same
to within 1 % (3.02 ms then, 3.00 ms now); what moved is the CPU share of
the wall clock, 32.5 % down to 29.5 %. The ratio improved because the host
side got cheaper, not because the accelerator got faster.

Build-tested with W=1, with sparse, and with CONFIG_DEVFREQ_THERMAL=n, at
every patch in the series and not only at the tip; dt_binding_check and
CHECK_DTBS pass on the binding and on both RK3588 boards here. checkpatch
--strict is clean on six of the seven; on 5/7 it asks whether MAINTAINERS
needs updating for the new files, which it does not - the driver is already
covered by its existing entry.

Not done, and worth saying: the thermal path has not been exercised. 85
degrees could not be reached on an NPU workload with the fan curve on this
board, so what is verified about 7/7 is that the zone parses and binds, not
that throttling engages at temperature.

Routing
-------

The driver patches and the binding go through drm-misc; the two dts patches
(3/7 and 7/7) belong to Heiko's rockchip tree.

Ordering matters: the binding has additionalProperties: false, so 3/7 and
7/7 must not land before 2/7 or CHECK_DTBS breaks. The reverse asymmetry is
harmless - without an OPP table in the devicetree the driver simply returns
without a devfreq device, and a cooling map with no cooling device is left
unresolved by thermal_of_should_bind().

If it is easier, I am happy to resend the two dts patches separately once
the driver side has landed.

Dependency
----------

This series needs "accel/rocket: search every core slot when a core is
removed", sent separately as a fix:
https://lore.kernel.org/linux-rockchip/20260904125936.26234-1-royalnet026@gmail.com/
5/7 keys the devfreq setup on rdev->max_cores, and that field arrives with
the fix rather than with this series. Without it 5/7 does not build.

1/7 is also carried as 01/14 in Jiaxing Hu's RK3576 series; whichever lands
first, the other drops it. It is included here so this series is
self-contained and reviewable on its own.

The series applies to drm-misc-next. On top of that RK3576 series, 2/7
through 4/7 apply with git am -3 as they are, and 5/7 needs only its two
job-path hooks moved into rocket_job_next_locked(), which that series
factors out. I am happy to do that rebase in whichever order suits.

Questions
---------

Q1. Where should the OPP table live when three devices share a clock? It is
    on rknn_core_0 here, because the devfreq device hangs off that core and
    of_devfreq_cooling_register_power() takes dev->of_node. The alternative
    is all three nodes with opp-shared, which has a precedent on this very
    SoC in cluster0_opp_table. I do not have a strong opinion.

Q2. Is maximum-over-cores the right aggregation, or should it be a summed
    busy count?

Q3. The driver returns without devfreq when there is no OPP table, rather
    than failing probe. That matches panfrost and lima. Is that the policy
    you want here?

Q4. The governor thresholds are a starting point copied from the other
    accelerators, not a measurement. Inference workloads have not been
    profiled against them.

Q5. There is no energy model: the NPU has no measured
    dynamic-power-coefficient and I would rather ship none than invent one.
    Throttling is therefore step-wise.

Q6. All three core nodes name the same npu-supply, but only the core with
    the OPP table hands it to the OPP core. Is that worth changing?

Q7. assigned-clock-rates stays on all three nodes, and I am no longer
    sure it should. of_clk_set_defaults() runs on every probe over the
    shared clock, so re-probing one core while devfreq holds a raised
    rate would quietly lower it - which I have not managed to
    reproduce. But Jiaxing Hu reports that on the RK3576 an
    assigned-clock-rates on the SCMI clock in the NPU node hangs the
    board before the console comes up, with no output at all, and that
    the vendor driver never writes that rate from DT either:
    rockchip_opp_config_clks() returns early for an SCMI clock on a
    device that is not runtime active. That is a good deal worse than
    the case I was worried about. Dropping the property is a small
    patch on top, and with the OPP table carrying the rate I do not
    think anything here needs it. I have left it in only because a
    devicetree with no OPP table still wants a rate that is correct at
    whatever voltage the board boots with.

Credits
-------

Nicolas Dufresne arrived at the same rates and voltages independently in a
proof of concept he never posted, and said to take whatever was useful from
it. His version differs: opp-suspend on the lowest entry, one shared table
across all three cores, and no assigned-clock-rates pins.
Link: https://gitlab.collabora.com/nicolas/linux/-/commits/rock5b-npu-poc-4

Tomeu Vizoso agreed to the full-range table with a per-board cap.

Jiaxing Hu carried 1/7 in the RK3576 series. If you have RK3576 hardware, I
would be glad of a test of 4/7 there: it reads the boot rate rather than
assuming one, which should be the right behaviour on a devicetree that does
not pin the clock.

The Assisted-by: LLM tags on the patches are Claude Opus 5. We wrote the
driver code and these commit messages together, over a long back-and-forth
in which it talked me out of more than one design before it reached a
compiler, and in which I threw out plenty of what it proposed. The board,
every measurement and every boot in Testing above, the decision to send
this, and the responsibility for all of it are mine.

Igor Paunovic (7):
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
 arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi  |  45 ++
 drivers/accel/rocket/Kconfig                  |   2 +
 drivers/accel/rocket/Makefile                 |   1 +
 drivers/accel/rocket/rocket_core.c            |  16 +
 drivers/accel/rocket/rocket_core.h            |  11 +
 drivers/accel/rocket/rocket_devfreq.c         | 482 ++++++++++++++++++
 drivers/accel/rocket/rocket_devfreq.h         |  57 +++
 drivers/accel/rocket/rocket_device.h          |  13 +
 drivers/accel/rocket/rocket_drv.c             | 110 +++-
 drivers/accel/rocket/rocket_job.c             |   7 +
 12 files changed, 763 insertions(+), 8 deletions(-)
 create mode 100644 drivers/accel/rocket/rocket_devfreq.c
 create mode 100644 drivers/accel/rocket/rocket_devfreq.h


base-commit: a9f09b5ea0c3db1e2d4c0f8d3ebdd612d8aa0366
prerequisite-patch-id: 519bcdfdde80d902309c8346f749ebc4bb6b29c0
-- 
2.43.0

