Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B9DCD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 06:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47AB010E108;
	Sat, 13 Jun 2026 06:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i0sKmdtp";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E6610E108
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 06:58:21 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so13518515e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781333900; x=1781938700; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4QsU3lUuOvN1fkkJCd/R0PVYRNNXIyBXyGs7tF0ADRs=;
 b=i0sKmdtplHtuQENUshKn3MDqpf5209UfOrcrVnbceKsPkMLeVsjA+TBs9UHfc25J/n
 LnfTX2jV24zjWoQrgl56hvlTWtBuJubm6O75QnroEG9U/WVJQaLCgHLkvqx3wJFUsa0g
 likCoc5SgUjorclDPNgtKlUiB5WZRlZQwHisyEGV0rV8LZpURsUw0QVEjsz5FDaUYlGV
 4NNkTRZ5JNOLb2trDgm2NtO5HBd7SmBcJPW/dHsWCzQ4BDQqQkQkOHHkE2C3jFJavq/v
 f5U1bxGRTJB40fJK1fFP4Eqao4IcidSByNkOcpPnL0lzTnu8snW3/IdDKM98tSWXEAAA
 cFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781333900; x=1781938700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QsU3lUuOvN1fkkJCd/R0PVYRNNXIyBXyGs7tF0ADRs=;
 b=EQVHBHu9ZHw6VMgQ6OlDrTIQuPfa+21jTFQAqYJFS22umft5gFuw7oZ+VuSkcarTby
 G+r+V0xSjHvCRM2LCMR9dcECIOlFSRglToCg/2IYPfk12Fhs6RZOoq6oNdCCaeOuOXW6
 dBAmkHPw65WTUb+8ItUiEv20Hw0uVc6wP+TWCSW1N7mIKfRkO3IlswzWmGUj+F/rn+XI
 Xfu3K+IsCgfHu4ydPMDqWmITK/iIf61yO6+Alb3ZtyGvYZr+C/+ZtuQXquE2O4qUBIzr
 kq/FN98fuzUtkEwBv7hhRoC5GyncZ91B6PK+r0kzlRxJQvnTRBTxzX6+EyVnWR1hLi6d
 wWUA==
X-Gm-Message-State: AOJu0YwWwsg6feufsY9wSMxl9x1wX/lo3cyA+r3GdRHWnHVM3XkUiJPq
 LdFvNM/JLOpfD1KuIXirYyB4icepmrIzZ24k9TSz0h9ttrODmtg6q+EO
X-Gm-Gg: Acq92OFgrfBeTRRgDcr31S/7RvBi8Nde5jAYN0gssiYMe65Ori/oW0Xfz+UjRkq+hdR
 Si2gNNMSDEjwr3yICH0C0+LfQyP8F58iSovIQ2OrbpzeQz06qCwztFQeXWGcdDGZt0oPeyXUG/O
 TcXXISQcMpfmf0VOGPYPHjhIkDhX66mgM0bF0T8J0Ba2UOVpPpsRDZIxnrCIKW+JHKDLRjUDoXk
 xdKDmr2QI3xHOYOqK6sHOlw2HVW+opYdeMx/k2U574rmnndHW1vX+pUFs0fFdZUCdS1Un3AisW5
 YW2kxRQk3AqCKLVXX916iF+oJjx9PxeuFor2Gojq8pLYSHmVNgjmbwgmhrI4bV/LM2o83c1Vu9n
 HkGHYCPQqEiyVpTZ4Adotg1jIVJYJR9NR3MI28dPGc2znklsUw5KQCVdmGGSBK2nPWnlwnVuBto
 ySvEXzFFu1f5Z1V7MDIlt9cmH4YwmeyP8FpJw2mj9QFg==
X-Received: by 2002:a05:600c:c171:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-490ec4dfb03mr56249045e9.14.1781333900211; 
 Fri, 12 Jun 2026 23:58:20 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 23:58:19 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, xxm@rock-chips.com,
 chaoyi.chen@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, jonas@kwiboo.se, Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 0/9] accel: rocket: Add RK3568 NPU support
Date: Sat, 13 Jun 2026 09:01:07 +0200
Message-Id: <20260613070116.438906-1-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
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

From: Midgy BALON <midgy971@gmail.com>

RFC, not for merge. End-to-end inference does not produce correct output
yet (see Status), so per the v2 discussion this is a request for design
feedback. It probes, attaches, and submits cleanly on a stock v7.1-rc6
tree; what remains is one hardware-internal issue.

The RK3568 has a single NVDLA-derived NPU core, the same IP family as the
RK3588 NPU the driver already supports; the register layout matches. The
RK3568 differences are a 32-bit NPU AXI/IOMMU (vs 40-bit) and explicit
PVTPLL/PMU bring-up to power and de-idle the NPU before it is reachable.

Patches:
  1-2  rocket: per-SoC data struct, then derive DMA width and core count
       from match data (refactors, no functional change); patch 2 also
       bounds-checks the per-SoC cores array.
  3    rocket: RK3568 SoC data; start the PVTPLL compute clock via SCMI.
       Powering on and de-idling the NPU NoC are left to the power domain.
  4    rocket: reset the NPU before detaching the IOMMU on a job timeout
       (the detach otherwise stalls a wedged AXI master and WARNs).
  5    rocket: keep the IOMMU domain attached across jobs instead of
       re-attaching per job (the per-job rk_iommu handshake on the idle
       NPU MMU is slow and noisy); also drop the domain on reset and stop
       the scheduler before IOMMU teardown.
  6    dt-bindings: add the RK3568 NPU compatible; require rockchip,pmu
       for RK3568.
  7-8  arm64 dts: add the NPU and its IOMMU, and enable them on ROCK 3B.
  9    pmdomain: give the RK3568 NPU power domain a regulator so genpd
       owns vdd_npu via domain-supply (Suggested-by Chaoyi Chen).

Dependencies. This series no longer touches the IOMMU driver; two
in-flight Rockchip IOMMU changes are relevant but not part of it:
  - Simon Xue's "iommu/rockchip: Drop global rk_ops in favor of
    per-device ops" [1]. On boards with more than 4 GiB of RAM the NPU
    MMU's DTE must stay below 4 GiB (its DTE address is 32-bit), so the
    NPU IOMMU is described with the "rockchip,iommu" compatible, whose ops
    allocate the page tables with GFP_DMA32; the SoC's other IOMMUs use
    the "rockchip,rk3568-iommu" (40-bit) ops. The driver keeps a single
    global ops pointer, so two ops on one SoC trip its coexistence check;
    this series therefore sits on top of Simon's per-device-ops change,
    which Rockchip (Chaoyi Chen) confirmed is the intended way to give the
    NPU MMU its 32-bit DTE.
  - "iommu/rockchip: disable fetch dte time limit" [2] (Simon Xue / Sven
    Pueschel, in the iommu tree), which sets AUTO_GATING bit 31. v3 carried
    a local AUTO_GATING patch; that unconditional fix has since been merged,
    so this series drops its IOMMU patch. The bit is a no-op on this
    hardware in any case (the page walk completes on its reset value).

Power bring-up. The NPU is brought up through the power-domain layer (no
driver hack): the NPU power-domain keeps its clocks but drops the pm_qos
phandle (qos_npu sits behind the gated NPU NoC, so genpd's power-off QoS
save faults reading it), and vdd_npu is wired as the domain's
domain-supply with the domain marked need_regulator (patch 9), so genpd
brings the rail up before it de-idles the NoC at power-on. The PMU de-idle
then ACKs without PVTPLL running; PVTPLL is only needed for compute.

Status. On v7.1-rc6 the driver probes, creates /dev/accel/accel0,
attaches an IOMMU domain, and submits jobs; the program controller
fetches and broadcasts the command list. Inference output is still
wrong. The kernel side (this series) appears complete; what remains is
mesa/Teflon userspace, which still emits RK3588-tuned config (to be
filed on mesa-dev), and the hardware: with corrected config the NPU
reads the full input and weight tensors (per its DMA counters) but the
MAC/output stage never completes and the job times out, leaving the
output at the buffer's zero-point. It is not in the command list (a
byte-exact replay of the vendor's command list behaves the same).
Pointers from anyone with RK3568 NPU experience welcome.

Known residual. On the first IOMMU attach the NPU MMU is idle with paging
already enabled; the rk_iommu stall/reset handshake does not complete in
that state and logs one burst of timeouts before the (kept) domain
settles. It is harmless here because the job times out regardless, but it
points at an idle-MMU reconfiguration corner the rk_iommu code does not
handle on this block.

[1] https://lore.kernel.org/linux-rockchip/20260310105303.128859-1-xxm@rock-chips.com/
[2] https://lore.kernel.org/all/20260428-spu-iommudtefix-v2-1-f592f579e508@pengutronix.de/

Changes since v3:
  - Dropped the local AUTO_GATING patch: the correct fix (set AUTO_GATING
    bit 31, "disable fetch dte time limit") has since been merged upstream
    [2], so the series no longer touches the IOMMU driver.
  - vdd_npu: new pmdomain patch (9) gives the RK3568 NPU domain a regulator
    (need_regulator) and the board wires domain-supply, dropping the
    regulator-always-on workaround (Suggested-by Chaoyi Chen). It relies on
    the in-tree pmdomain default-off-if-need_regulator handling. The
    "Failed to create device link ... <pmic>" line at pmdomain probe is a
    pre-existing fw_devlink cyclic-dependency warning (the single
    power-controller provides every domain, including the one the I2C PMIC
    needs), seen the same way on RK3588; it is harmless here beyond a few
    wasted EPROBE_DEFER retries, and a proper fix belongs in the
    power-controller driver, not this series.
  - rk356x dts: also assign the CRU CLK_NPU so the NPU AXI bus clock comes
    up at 200 MHz instead of the 12 MHz boot default; order the NPU/IOMMU
    nodes by unit address.
  - rocket RK3568: fetch the SCMI/PVTPLL clock by name (the v3 bulk index
    resolved to the wrong clock); drop the redundant driver PMU de-idle
    writes (handled by the power domain).
  - rocket: clear the attached IOMMU domain on reset; unwind through
    rocket_core_fini() on noc_init failure; stop the scheduler before the
    IOMMU teardown.
  - rocket: bounds-check the cores array against the per-SoC core count.
  - Binding: require rockchip,pmu on RK3568.
  - Dependency framing: confirmed by Rockchip as v2 + 32-bit DTE via
    Simon's per-device-ops series (was framed as v1 in v3).

Midgy BALON (9):
  accel: rocket: Introduce per-SoC rocket_soc_data
  accel: rocket: Derive DMA width and core count from match data
  accel: rocket: Add RK3568 SoC support
  accel: rocket: Reset the NPU before detaching the IOMMU on timeout
  accel: rocket: Keep the IOMMU domain attached across jobs
  dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568
  arm64: dts: rockchip: rk356x: Add the NPU and its IOMMU
  arm64: dts: rockchip: rk3568-rock-3b: Enable the NPU
  pmdomain: rockchip: Add a regulator to the RK3568 NPU power domain

 .../npu/rockchip,rk3588-rknn-core.yaml        | 27 +++++++++-
 .../boot/dts/rockchip/rk3568-rock-3b.dts      | 18 ++++++-
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 38 ++++++++++++++
 drivers/accel/rocket/rocket_core.c            | 30 ++++++++++-
 drivers/accel/rocket/rocket_core.h            | 19 +++++++
 drivers/accel/rocket/rocket_device.c          | 15 ++----
 drivers/accel/rocket/rocket_device.h          |  3 +-
 drivers/accel/rocket/rocket_drv.c             | 50 ++++++++++++++++++-
 drivers/accel/rocket/rocket_job.c             | 45 ++++++++++++++---
 drivers/pmdomain/rockchip/pm-domains.c        | 36 +++++++++----
 10 files changed, 245 insertions(+), 36 deletions(-)


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.39.5

