Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0408CD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 05:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0455C112710;
	Sat, 30 May 2026 05:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="owTzXrgq";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96AD112190
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:55:53 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso122170505e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780070152; x=1780674952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pm1egj7rvNz6E3Ee54JdqUG6bAMQYsYWlFR8JwRKRcg=;
 b=owTzXrgqPziUxSKjoJD5cfcEIHVFNAkjsCgIzNm1dj/Ak74cJb6MVNwG90pguOltlr
 HJPE5EFbB9DfB/D4CxJOTTpNivZHwoLsieW0Ao2TvlbTMWPf1lr1MmCWlmq9rPZLOiT9
 vgqPoqFifgkEAVnbtP1pnDlwHR0lMG1qS808dgmzyICrY1MEAkWAsKtbL37759Zyz54h
 zXInbHM35guHooF7SVtdIlBKZ/4Ti2RBs9L5Hz1XBEunyjgaWeZf16CvhlRP+74RPQ1s
 uIxqvgqBPtZPwzY5QvYaYL3T+UNRO/ttWyIKmJbMEQojhsLBJjnaa0ZS8jaGONBViBtA
 XDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780070152; x=1780674952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pm1egj7rvNz6E3Ee54JdqUG6bAMQYsYWlFR8JwRKRcg=;
 b=keCzcFoHIhSaKIefRPt1Uffi1T9+LB5DVNV1xh3SF2Tnrj4LirEpyDsAgqnTDM5+5Y
 EbXTZK/+e6tmH2eeqx5A8fBdmU79ZvKeXgvDYJEmPmxPbR6yzejCSmd2/lQk3OpDrUCq
 f5v8wTBtx02Q7JfZk4nkRhGOBkG2qjtTPEaXAPvOmpD/tYhqBMdbjD8fLztIFHhIZlbP
 AysFg/I1XZy0aUKJ5BUX/9bYCYQZoe+p2cx86qSo+x+X9dKkKBoFoWUuV67xx1kqiMbW
 Daj+fStFrLO+KSDBk2Nq5TAg/9htbAhi1Dz0ez0p8J0Zb6PtGEEHa3uJEDoJxLrcP5F8
 Ushg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9r8bm9Qqe0IojRuk7sg8w/3XLuRKCBHJ1eLOO/b/AnyPUwPi0wvZZf+OmMrhjpMm5bpxLFj493gGI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNEREgXu1ofQ2XdtNgUWPle4AxfNV/sehP09hxXhPvRXiMCgVS
 QXOZsrzDhK5qJhne8laLyOL7KMvg6svn24tj0NdB+N6Bij3sLinwTd7g
X-Gm-Gg: Acq92OHZyiylcCgwzIBfX4GUGO4aaR5xBd43NN4avlIGeFZqceKb2RpLoT7fE3BfMZU
 WtRxUo4miGoie1EgUahq5tbl9F9tfxN8oqEkFG07sGQBG9BAkn456/jHYWq1oiX3KZowgMyZXvk
 3K/2b0ydGdD4GL1mSNBNEqdRnbBxalen55tPNGUA5od9OR0cylI1MwE2cdyCVQtpYPGoKBbG6UH
 n5tUhLEmLicA6r/uPMO0AvmdmjnFLf+2iOfDlUHOWBYnFlTNc9q563oxUjLcELyFLOjqBTWYPyr
 mr0UfSivPi9zlADMs9Nh/c7O2mfah+GAHZnoA3dWOoHh65oFW2tiZ/jzP46K5p1DFm70RCiy+Bq
 Vzhq6SjBatB+e6zGgqileUg8Jjxus9v1ayih+MfkeWdbFujEV5y1upCYH1uzfgHKRM1lUADXZRQ
 gG1CyLAlU/Ae1AKkZeiz4DCfmoXkNlhamUBNgnMez9sDEgt+lFCApKABuDHCoNYqQIB12jbskin
 jvbzqyfz+qtlOgUGwWr+OJQCKs04HAc63FdHhNv
X-Received: by 2002:a05:600c:5254:b0:490:9e5b:9e31 with SMTP id
 5b1f17b1804b1-490a28c4156mr5150045e9.0.1780070151955; 
 Fri, 29 May 2026 08:55:51 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 (2a01cb09e0354cc878d00097536575e1.ipv6.abo.wanadoo.fr.
 [2a01:cb09:e035:4cc8:78d0:97:5365:75e1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cabfd6esm55150315e9.15.2026.05.29.08.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:55:51 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Midgy BALON <midgy971@gmail.com>
Subject: [PATCH v2 0/4] accel: rocket: Add RK3568 NPU support
Date: Fri, 29 May 2026 17:58:20 +0200
Message-Id: <20260529155824.3099831-1-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 30 May 2026 05:55:09 +0000
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

This series adds Rockchip RK3568 support to the upstream Rocket accel
driver (drivers/accel/rocket/), tested on a Radxa ROCK 3B board running
Linux 6.19-rc5.

The RK3568 carries a single NVDLA-derived NPU core (0.8 TOPS), the same
IP family as the three-core RK3588 NPU already supported by the driver.
The hardware register layout (pc/cna/core regions, interrupt, IOMMU) is
identical; the differences are:

  - 32-bit DMA address limit (NPU AXI bus and IOMMU page walker are 32-bit)
  - Requires explicit PVTPLL initialisation via two TF-A SCMI calls before
    the NPU NOC bus can be de-idled
  - Requires explicit PMU writes to power on the NPU domain (because the
    RK3568 power domain RK3568_PD_NPU is always_on so the generic
    pm-domains callback is a no-op) and de-idle the NPU NOC bus

Patch 1 introduces a per-SoC rocket_soc_data abstraction (dma_bits and
optional noc_init callback) plumbed via of_device_get_match_data(), and
adds RK3568 SoC support on top of it.  The DMA mask for the parent
DRM facade device is chosen based on the narrowest core present
(32-bit if any RK3568 core is in the system).

Patch 2 documents the new rk3568-rknn-core compatible and the
rockchip,pmu phandle that RK3568 requires; the sram-supply property
becomes conditional (RK3588-only).

Patches 3-4 add the RK3568 NPU and IOMMU nodes to rk356x-base.dtsi and
enable them on the Radxa ROCK 3B.

Verified on Radxa ROCK 3B (RK3568, 8 GB RAM):
  - /dev/accel/accel0 created at boot
  - dmesg: "Rockchip NPU core 0 version: 0"
  - IOMMU domain attached per open()
  - Job submission path complete: regcmd reaches the NPU's program
    controller, PC processes all 135 regcmd entries, broadcasts to
    sub-units, and advances to BSP-equivalent completion state
    (PC_TASKST=0x11000)

Status of end-to-end inference: NOT YET WORKING.  After 12 days of
investigation comparing rocket's behaviour against the vendor BSP RKNPU
driver, the NPU's MMIO state at submission time matches BSP byte-for-byte
(CNA configs, sub-unit OP_ENABLE registers, CBUF_CON0, etc.) but no
sub-unit transitions to its EXECUTER state and the completion IRQ never
fires.  The kernel driver and DT infrastructure in this series stand on
their own — the driver loads, IOMMU domain is attached, regcmd reaches
the NPU, PC state machine matches BSP — but a mesa-side regcmd issue
(or another piece we have not yet found) blocks the final conv firing.

I am sending this series now because the kernel and DT pieces are
self-contained, verifiable, and ready for review.  A separate RFC on
mesa-dev will follow with the userspace findings.  Detailed investigation
notes are available on request; relevant highlights for the maintainer:

1. Mesa rocket userspace (src/gallium/drivers/rocket/) targets RK3588.
   For RK3568, several encoded values need adjustment.  Most notably,
   sub-unit OP_ENABLE register offset on RK3568 is 0x_00c, not 0x_008.
   Mesa emits writes at 0x1008/0x2008/0x3008/0x4008/0x5008 — BSP regcmd
   captures show no writes at these offsets across two distinct conv
   shapes (YOLOv5s 6x6/s2 and MobileNet 3x3/s2).  BSP writes OP_ENABLE
   at offset 0x_00c with multi-bit values (CMAC=0x1, ACCU=0x0, DPU=0x108,
   DPU_RDMA=0x13f), not bit-0 booleans.  This and a handful of other
   shape-independent value differences will be filed as a mesa RFC.

2. The vendor BSP RKNPU driver writes the userspace task_base_addr to
   PC_DMA_BASE_ADDR (PC offset 0x34); the rocket driver did not.  PC's
   TASK_DMA engine reads struct rknpu_task descriptors from there.  With
   task_pp_en=1 in TASK_CON and a kernel-allocated descriptor BO,
   PC's task counter state machine advances from "stuck at 0xf000" to
   the BSP completion state.  This is the most invasive piece of the
   investigation and is held back for a follow-on patch (not in this
   series); the current series gets the driver to a working /dev/accel/
   node and an attached IOMMU domain, which is the right shape for v2.

3. The NPU's master AXI port is 32-bit, but dma_alloc_coherent() through
   the dma-iommu framework silently ignores GFP_DMA32 even with a 32-bit
   dma_mask set on the device.  When BOs for the NPU are allocated kernel-
   side, __get_free_pages(GFP_DMA32 | __GFP_ZERO, order) + dma_map_single()
   is the working pattern.  Not in this series, but might be a useful
   documentation note for other 32-bit AXI accelerators using dma-iommu.

This series builds against current v6.19-rc5 with no checkpatch warnings,
the dtb builds, and dtbs_check passes.  The April v1 series included a
fifth patch ("Use of_find_matching_node() instead of for_each_of_allnodes")
which is no longer required — upstream rocket already uses
for_each_compatible_node() since v6.19-rc5.

Changes since v1 (April 2026, never sent on-list):
  - Rebased to v6.19-rc5
  - Patch 1 absorbed v1 patch 1 (obsolete) and now includes the
    rocket_soc_data abstraction needed to support both RK3568 and
    RK3588 cores in the same driver
  - Cover letter expanded with current investigation status

Assisted by Claude Sonnet/Opus 4.x throughout the investigation.  All
findings empirically verified via BSP register captures and side-by-side
rocket execution traces on the same board.

Midgy BALON (4):
  accel: rocket: Add support for Rockchip RK3568
  dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568 support
  arm64: dts: rockchip: rk356x: Add NPU and its IOMMU
  arm64: dts: rockchip: rk3568-rock-3b: Enable NPU

 Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml | 18 ++++++++++++++--
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi                        | 31 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts                      |  9 ++++++++
 drivers/accel/rocket/rocket_core.c                                   | 21 +++++++++++++++++-
 drivers/accel/rocket/rocket_core.h                                   | 18 ++++++++++++++--
 drivers/accel/rocket/rocket_device.c                                 | 23 +++++++++++++++++--
 drivers/accel/rocket/rocket_drv.c                                    | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 192 insertions(+), 7 deletions(-)


Midgy BALON (4):
  accel: rocket: Add support for Rockchip RK3568
  dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568 support
  arm64: dts: rockchip: rk356x: Add NPU and its IOMMU
  arm64: dts: rockchip: rk3568-rock-3b: Enable NPU

 .../npu/rockchip,rk3588-rknn-core.yaml        | 18 ++++-
 .../boot/dts/rockchip/rk3568-rock-3b.dts      |  9 +++
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 31 ++++++++
 drivers/accel/rocket/rocket_core.c            | 18 ++++-
 drivers/accel/rocket/rocket_core.h            | 16 +++++
 drivers/accel/rocket/rocket_device.c          | 25 ++++++-
 drivers/accel/rocket/rocket_drv.c             | 71 ++++++++++++++++++-
 7 files changed, 182 insertions(+), 6 deletions(-)

-- 
2.39.5

