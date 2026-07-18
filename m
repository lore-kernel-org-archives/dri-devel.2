Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09D8C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C392010E78F;
	Mon, 20 Jul 2026 07:15:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="FLEygAnJ";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J1Psw1t4";
	dkim-atps=neutral
Received: from flow-a2-smtp.messagingengine.com
 (flow-a2-smtp.messagingengine.com [103.168.172.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5E810E516
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 03:21:33 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id A557113800A8;
 Fri, 17 Jul 2026 23:12:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 23:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1784344321; x=1784347921; bh=O5UO+r1tw5
 O/LBbUfpvJPgD+I1aOB3b1e+3aqw181G0=; b=FLEygAnJSZ3WKCo+W2zSHa5WC9
 P3tF7eyq4PE1kVv72cFBOQs3xcA43b/mG17NC/dORUNIIrRlt4nBvXh8aTOL8jyJ
 DJxVduoydwdPsmwc3x0bk+RijrPJTz9xgYi2Bd00ttiIO95Xgh1k1Kj+/S1am6hX
 1WiuKjr+P63CugKP14CpC4TrBcy9qe4wmWJRxdCAzyG0JG0aZar2bdv5IDzstUzc
 dvPvQWP+ArjC18GfUM7MF/kuzPXRw5tMvxqu1Wxdm7i7K8/9q4GnvQtjirufig7t
 3De8usGMdzvW27iNziDdDZ7ysCGd4+DrfIBU9dkndGTDwt3hW7rmdMsCSIhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1784344321; x=1784347921; bh=O5UO+r1tw5O/LBbUfpvJPgD+I1aOB3b1e+3
 aqw181G0=; b=J1Psw1t4l+cybF3KE5R7M4Ld8/2R1bibfnmmW0Kdxi1bLjDprRe
 kYps09OCCqOchCrSTwWm/FXy1Ix+7nM7AcwoDUsZ6LDdI/mm1LY8zVnrHRYNYIqE
 0fkCephN6PdwTesWu4e96up7UJKQG30KGeideMor/fQNv/uM8bewZXtToWKtIKnu
 DDy1zV8ZE3FubV1tLWuW9EkYTrSht+1oohaJN88QBNBamxsOgx0ek1Y+Xt7BGg0p
 lynYW5LKxDuGo/vlNeBcMbM8PGtndQpDN7Myu5/oLZwQtiKLyipktqUl2i1Zjak8
 zOYRNjy1rfLYoJpJObGV9HRnd2RM3uz12+g==
X-ME-Sender: <xms:_u5aavsk84VuFybQ6CtJeID3M4Qo3aUfXIV0s6Qm6ThuodbFxIGuBg>
 <xme:_u5aag31Mgcwz1Qhw5JvBpOhPYi9gwmDDeooX9ymSntr9350r2aF0rG0EU1A8MQiO
 b3IDZX9XqAWrG0D-XO214P8a7nRgcsxVEGHSZKN1UEhcTU2bUcJJnk>
X-ME-Received: <xmr:_u5aaj4SkoUNdd-1i2J9z7jlGLSYQ2xjUvjrFCdSorZT7ZA3GEimZrwL14YTpc6f-Vib_v_JKCPwiREkgyU>
X-ME-Proxy-Cause: dmFkZTG1BKwpOrUet1Yz3ReM3q8b+SU1Y0/3E/GtpuUDrj0RW7aZrRz1EkrdLfowjHCTZn
 KHQtKMuWZlkEuvq3c/1uYeHLYKalGUaqALOTDnvMzn1+EaIkreHdEflsbm9CI/YFbSTVhF
 XZ3FYbXkynNIH0cYbzyCZN+Fu0EU4C0Ecx1u/0LycRsT5wthraRx/8kne0EIYOAZY321KB
 /7+UzOh7OlqviMCxy8sehh+ffZzbA1ZloX0T1ZphHs2gfKgTZgme9j+DaFkr7jrXNK2+Da
 UZ1kFcX0GytWLrOKSYk85Ql6OoEElRCk/ag+HIAS5ZZ8BTmO4ki0zhNsB4g1D4h0/1B2An
 xugJgGOblZ4hY9pLc88dgop7V5XtaCBez0UGJPls1sN+bAqnhrwv0xEoeG3mynqSvbubZP
 Gt/B7ZzYsY8Qp5LlS5JG8sXLiXxCX+G+WraFcWBsnyYdRBX8qJp+bDFG7vtjsCnNxd7K32
 /Oh9+RsSGqJvsn24ccbcmCAxG43kZcj7UN/SkYjt7wXAaffBTHAMpJEEV6lMJDi/PDsNoH
 oyFhbM5ddf9t86LtqhLqMiZ5c0OmILw0JN2hfFoqcoqLI1ER8az2XYaANF0Bma+rFXs6EM
 KlLzr3ppO4Tkvar4RQngMJfo9zGQ3AMUJyhDDesMyyFG/d+TZPzmD4FpuU8g
X-ME-Proxy: <xmx:_u5aaqMpj0699XrR4t-KqyhEru8d4RSd6nXieDHJUVfNg17lPeTofg>
 <xmx:_u5aavEw0Gm4vgwZIKI0pXWgbFSj8B0T-fkXdF5Oue7NPHKf0ZpstA>
 <xmx:_u5aam0EheD3UUHBEENMgsmzU2NjPkKHrQuR1W4ERWcv7LV09IhBsg>
 <xmx:_u5aauFtPvtzpIJMb1u9qHUIkJLWqmkuYrIf2bSoLtIVH__oSRGu1Q>
 <xmx:Ae9aagQsgx-EbfkkoZbbHdDdzvcnAkc9r36ecnN5C2FBl1Js3xTLx8az>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 23:11:51 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org
Cc: chaoyi.chen@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v2 0/8] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Sat, 18 Jul 2026 15:11:38 +1200
Message-ID: <20260718031146.3368811-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

This adds RK3576 NPU support to accel/rocket.  RFC: the NPU brings up and
runs, but full inference is not correct yet, and I would rather get
feedback now than sit on it.

Tested on a Radxa ROCK 4D.  The NPU probes, powers on, brings up its
IOMMUs, and runs jobs to completion (rocket + Mesa Teflon).  Getting there
took a few fixes outside the driver too: a power-domain settle delay and
reset cycling (else a cold power-on throws an async SError), the full
clock set on the MMU nodes, clearing a stale firmware page fault, and both
NPU power domains on the core.

Not solved: only the first operation in a power session gives the right
answer.  Every later one engages and DMAs its input, but the compute
output never lands, so the readback is the zero-point.  I chased it
through the whole software surface (registers, IOMMU/TLB, cache,
power/clock/reset, dispatch) and it reproduces even with the driver
environment matched to the vendor's on the same kernel, so it looks to be
below software, in the fixed-function block.  Traces available.

Two asks: review of the bring-up and the shared pmdomain/iommu changes;
and if anyone knows the RK3576 NPU internals, whether that
per-power-session arm can be driven from software at all.

The series is split by subsystem (binding, pmdomain, iommu, driver, DT).
The board DT keeps vdd_npu_s0 always-on for now; happy to switch to
proper runtime control if preferred.

Changes in v2 (thanks to Chaoyi Chen and the Sashiko review bot):
  - dt-bindings: keep sram-supply required for rk3588 via allOf/if-then
    instead of dropping it from the shared required list
  - pmdomain: release the resets in rockchip_pm_remove_one_domain()
  - iommu: drop the redundant "err == 0" check in the clock probe
  - iommu: replace the two "skip orphaned-fault banks" patches with one
    that clears the stale firmware page fault (CMD_PAGE_FAULT_DONE) before
    enabling stall, so no bank needs special-casing -- Chaoyi asked
    whether dealing with the fault avoids the skip, and it does
  - accel/rocket: gate every RK3576-specific difference (extra clocks,
    single reset, multi power-domain attach, polled completion) behind
    of_device_id match data so the RK3588 path is byte-for-byte unchanged;
    drop the unused DPU register mapping (the driver did no pre-arm)
  - series is now 8 patches (was 9)

I used Claude Opus 4.8 to help trim this series out of my debugging tree
and generate the diffs.

Jiaxing Hu (8):
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  pmdomain/rockchip: add optional per-domain power-on settle delay
  pmdomain/rockchip: cycle optional power-domain resets on power-on
  iommu/rockchip: take all DT clocks
  iommu/rockchip: clear stale page faults before enabling stall
  accel/rocket: add RK3576 NPU (RKNN) support
  arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
  arm64: dts: rockchip: rk3576-rock-4d: enable NPU

 .../npu/rockchip,rk3588-rknn-core.yaml        |  12 +-
 .../boot/dts/rockchip/rk3576-rock-4d.dts      |  16 +++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  78 ++++++++++-
 drivers/accel/rocket/rocket_core.c            |  39 +++++-
 drivers/accel/rocket/rocket_core.h            |  22 ++-
 drivers/accel/rocket/rocket_device.c          |   4 +
 drivers/accel/rocket/rocket_drv.c             |  22 ++-
 drivers/accel/rocket/rocket_job.c             | 127 ++++++++++++++++--
 drivers/iommu/rockchip-iommu.c                |  41 +++---
 drivers/pmdomain/rockchip/pm-domains.c        |  69 ++++++----
 10 files changed, 371 insertions(+), 59 deletions(-)

-- 
2.43.0

