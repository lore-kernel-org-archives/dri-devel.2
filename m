Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F5FCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B762011A0CA;
	Thu,  4 Jun 2026 13:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AHqATarR";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1777611A0C8
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:52:59 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so717249f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581177; x=1781185977; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TpNHefKtZBMcFXf5tGwuXkoAaa88dbJ1eJ42SBDaonY=;
 b=AHqATarREhJsp3xQiT8VyyFrzZziFOoGc94p0vgNqjDDo9i5/ONajT+17P/xmP0PWe
 lrd+fTepB9uvP07ehY/iM/lC0WRiSXvS7Q98n0PFj9GoDKmCohKMnDxjwy1LYhxBMJhs
 JH8KG/Sj3gbCu8JYPawpp3j/5R0W3oQdVfr0iAnUauaH5emYV/u/pe7vc0BA2ZuUIXCN
 MhqL77LCvR9as440Dy2GOXA9aXK95tX5xkL7xwMfxaGFYaWNAO7vnE3zkiO7A0yw9MK6
 xfPZ8r/cBQyooYdD484TsoxTv3wqOpCuGzi3o8pK5uHsqdlU6x0eejHwOOEtUeW4QpEf
 QdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581177; x=1781185977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpNHefKtZBMcFXf5tGwuXkoAaa88dbJ1eJ42SBDaonY=;
 b=AwYYRoXxEcLeIvDXO/hUDZFQE+en2xOMJ+es761+rbTLcd8OzqacpLRpuw4OA8v5Cg
 sUrNB1vgwPJPef5z58vBR5cF7iLYjV69o4sfxnrk9wiYRheG3e0EzxByWl8M0G98muW4
 mtk5ImxK+6DXYfdWqEjDDfTh4bll8XflH3HZ7vcv1Bku3pmi7rJKwcRfhiA0nte1/HWE
 IkyjWLdnPuPlmubnyY5E5Dy3qFOGUnd5XLXPsyociY+zte8ufo3sfKTbx0xMZF+ta/zN
 DrYmGVQdV6qUmht8s5nPflUA5nnrP1QfPe1v0Ogdp52PnslvAUQHPkEZuIskf380cGmH
 ZCXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xq/eiOzSDa9OhDMS+cMIwlA9yx3SGoCzIiM8V2KXKGN/vVfih4eJSxnU0OK+YT8wRjppom3Pl/bA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWjPoFrt3AOWE6nsIxkYReWbYP7wYnNCoEgd5rpU3kQVV8URAH
 eN0KcFo5Asie02Rh1uj4q/zu19MuDNpiq8Fk4rFCkyoTqrAXZwzkywv7
X-Gm-Gg: Acq92OF367g/fd9u1lGM5eKzl9Cf7duHiYCqe72ehqwOLovcKRB6bp/h1HtKvbXUxxC
 Isn+ZsTfNxpKO0wPx1AoUSQRJi/CiNYrnfbRYWAhin2wSAu4NpZydIPI/2LvM5DvXbsDj0dN7Xd
 aSMS0JxbprORsrC1uX19EyLNIRgI8dFnCPkSk3zFMgwbEUiPRk7dQQ3oJTi6j27OW/i2WmeLm47
 5gcZK6gGOJGLEUYFzUkRky815k+1MtCHY4ErhV1AqZzXS09FjByMM28ojWS1Fw5mzYtFSQygkly
 ZoThw3pSYEXPXKnnb0hjkW54TeukD3wirIraCzwx3RLbVxB7Z3j4Y5jvvWKkbYhc0tMUrYdjNWU
 QAhnltAaiZD12bfwQO7c0BMPSW15XpACT7q6ojEVzFXC4Xkibm942AeEqDY4jFJba8TiQXrsYqH
 rkdlGcGecRJk5HDe6dZ6nmptGpsS2287Z7GcWgJGnneU5Yw6t7GbEJP8lPuVc/bJgLayxG64hjQ
 w==
X-Received: by 2002:a05:600c:64c5:b0:490:52c0:744c with SMTP id
 5b1f17b1804b1-490b5ed43cbmr130379805e9.20.1780581177177; 
 Thu, 04 Jun 2026 06:52:57 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:52:56 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
Date: Thu,  4 Jun 2026 13:52:46 +0000
Message-Id: <20260604135255.62682-1-midgy971@gmail.com>
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

RFC, not for merge. End-to-end inference does not produce correct output
yet (see Status), so per the v2 discussion this is a request for design
feedback. It now probes, attaches, and submits cleanly on a stock
v7.1-rc6 tree; what remains is one hardware-internal issue.

The RK3568 has a single NVDLA-derived NPU core, the same IP family as the
RK3588 NPU the driver already supports; the register layout matches. The
RK3568 differences are a 32-bit NPU AXI/IOMMU (vs 40-bit) and explicit
PVTPLL/PMU bring-up to power and de-idle the NPU before it is reachable.

Patches:
  1-2  rocket: per-SoC data struct, then derive DMA width and core count
       from match data (refactors, no functional change).
  3    rocket: RK3568 SoC data + PVTPLL/PMU/NOC bring-up.
  4    rocket: reset the NPU before detaching the IOMMU on a job timeout
       (the detach otherwise stalls a wedged AXI master and WARNs).
  5    rocket: keep the IOMMU domain attached across jobs instead of
       re-attaching per job (the per-job rk_iommu handshake on the idle
       NPU MMU is slow and noisy).
  6    iommu/rockchip: clear AUTO_GATING bit 1 on the RK356x v1 IOMMU so
       the page-walker keeps its clock (else a TLB-miss walk never
       completes).
  7    dt-bindings: add the RK3568 NPU compatible.
  8-9  arm64 dts: add the NPU and its IOMMU, and enable them on ROCK 3B.

Dependency. The NPU MMU is rockchip-iommu v1 (32-bit) while the rest of
the RK3568 uses v2 (40-bit). They cannot coexist until the driver carries
per-device ops; this series is developed on top of Simon Xue's
"iommu/rockchip: Drop global rk_ops in favor of per-device ops" [1].
Without it the NPU IOMMU fails to probe on a full RK3568 boot.

Power bring-up. The NPU is brought up through the power-domain layer (no
driver hack): the NPU power-domain keeps its clocks but drops the pm_qos
phandle (qos_npu sits behind the gated NPU NoC, so genpd's power-off QoS
save faults reading it), and vdd_npu is marked always-on so the rail is
up before genpd de-idles the NoC at power-on. The PMU de-idle then ACKs
without PVTPLL running; PVTPLL is only needed for compute.

Status. On v7.1-rc6 the driver probes, creates /dev/accel/accel0,
attaches an IOMMU domain, and submits jobs; the program controller
fetches and broadcasts the command list. Inference output is still wrong,
and the cause is split across three layers:
  - kernel (this series): the RK3568 differences appear handled;
  - mesa/Teflon userspace: still emits RK3588-tuned config, wrong for
    RK3568 (to be filed separately on mesa-dev);
  - hardware: with corrected config the NPU's DMA reads the full input
    and weight tensors (confirmed via its DMA bandwidth counters), but
    the MAC/output stage never completes, the job times out, and the
    output stays at the buffer's zero-point. I have not found the missing
    step; it is not in the command list (replaying the vendor's
    byte-exact command list behaves the same). Pointers welcome,
    especially from anyone with RK3568 NPU experience.

Known residual. On the first IOMMU attach the NPU MMU is idle with paging
already enabled; the rk_iommu stall/reset handshake does not complete in
that state and logs one burst of timeouts before the (kept) domain
settles. It is harmless here because the job times out regardless, but it
points at an idle-MMU reconfiguration corner the rk_iommu code does not
handle on this block.

[1] https://lore.kernel.org/linux-rockchip/20260310105303.128859-1-xxm@rock-chips.com/

Changes since v2:
  - Tagged RFC; now tested on a stock v7.1-rc6 tree.
  - Bring-up moved into the power-domain/DT layer (no initcall hack).
  - Added the IOMMU detach-on-timeout and attach-once driver fixes.
  - Split the driver patch (Heiko): soc_data / match-data / RK3568.
  - Derive DMA width and core count from match data; drop the DT rescans.
  - Binding describes the hardware; added the missing $ref on rockchip,pmu.
  - Disclosed the per-device-ops IOMMU dependency.

Midgy BALON (9):
  accel: rocket: Introduce per-SoC rocket_soc_data
  accel: rocket: Derive DMA width and core count from match data
  accel: rocket: Add RK3568 SoC support
  accel: rocket: Reset the NPU before detaching the IOMMU on timeout
  accel: rocket: Keep the IOMMU domain attached across jobs
  iommu/rockchip: Clear AUTO_GATING bit 1 on the RK356x v1 IOMMU
  dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568
  arm64: dts: rockchip: rk356x: Add the NPU and its IOMMU
  arm64: dts: rockchip: rk3568-rock-3b: Enable the NPU

 .../npu/rockchip,rk3588-rknn-core.yaml        | 18 ++++-
 .../boot/dts/rockchip/rk3568-rock-3b.dts      | 14 +++-
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 38 +++++++++++
 drivers/accel/rocket/rocket_core.c            | 22 ++++++-
 drivers/accel/rocket/rocket_core.h            | 19 ++++++
 drivers/accel/rocket/rocket_device.c          | 15 ++---
 drivers/accel/rocket/rocket_device.h          |  3 +-
 drivers/accel/rocket/rocket_drv.c             | 66 ++++++++++++++++++-
 drivers/accel/rocket/rocket_job.c             | 35 ++++++++--
 drivers/iommu/rockchip-iommu.c                | 12 ++++
 10 files changed, 219 insertions(+), 23 deletions(-)


base-commit: 52c800fdcf11888ebeb50c3d707f782cc15b66eb
-- 
2.39.5

