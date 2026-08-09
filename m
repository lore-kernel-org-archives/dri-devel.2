Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072C7C5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C18C10E07A;
	Sun,  9 Aug 2026 13:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eErtlhGS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED8DB10E07A
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:15:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 61CDC43D3F;
 Sun,  9 Aug 2026 13:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C59AC2BCB9;
 Sun,  9 Aug 2026 13:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786281320;
 bh=gfs+9iLn0MqSGihE5E+ZK+BYSdrrMqoj2otlPFYQCdc=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=eErtlhGSXNFRitshXqyXYyIMxts8Vs7CrBzY42rNRgnWweauujceZBMhELACHEskr
 HNAc96emDseR5Cu8fvvGaKkCxrXhfp/5aM5dYEL0D236eEj9lzyljVaGC7i48EHV5C
 Pw41hrMgvI6R+oklU28RjB53zUWhvyWRnI/j1G7H4f0wImVH+ovUJTAHvtsDpjBzmB
 AJ0hkoBZhBvxmGa29/rJ+gI6soH5c/H6LdWwBb1qUqPrmnKVVr93HTmtPvDeEw/f+c
 531rUkW4/PrcYyX5d39Ujm9/ggSKM/MRVdVSqzO6qft7XPgdJ1EyRdy/cX1OK4ng3J
 9+URiZVY/M+Vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 016E0C5AD4E;
 Sun,  9 Aug 2026 13:15:20 +0000 (UTC)
From: Cody Kang via B4 Relay <devnull+codykang.hk.gmail.com@kernel.org>
Subject: [PATCH v2 00/17] drm/spacemit: add SpacemiT K3 display support
Date: Sun, 09 Aug 2026 21:14:09 +0800
Message-Id: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACF9eGoC/02Nyw6CMBBFf4XM2pp20IKs/A/DosIURnmlRSIh/
 XcBXbg8ybnnLuDJMXnIogUcTey571bAQwRFbbqKBJcrA0rUMlGxeMaiZD80ZhaUWkulTugSa1g
 HgyPL7z12y7/sX/cHFeNW2Iya/di7eX+b1Ob9wnj6D09KSGERjZLmjKlOrlVruDkWfQt5COEDl
 ZTES7YAAAA=
X-Change-ID: 20260713-k3-display-e8ffed67e936
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guodong Xu <docular.xu@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786281298; l=8381;
 i=codykang.hk@gmail.com; s=codykang; h=from:subject:message-id;
 bh=gfs+9iLn0MqSGihE5E+ZK+BYSdrrMqoj2otlPFYQCdc=;
 b=gLEnFaJd2Ov9N3suvm3c1Xs8Y13FGpGbNL1AvGnHPTsE/BRYvX/JstclXFAPVoMrsRf1Ey7jt
 FtqL/hVnlR1CDgN/yUmiA7RlFM1JTlF8jhJ3mRSzdm8CD7e5hJkM3Z5
X-Developer-Key: i=codykang.hk@gmail.com; a=ed25519;
 pk=Osn6/cs9Su/mHHw4P19cmVc3v2FMQfiWahjsN0vEkuk=
X-Endpoint-Received: by B4 Relay for codykang.hk@gmail.com/codykang with
 auth_id=895
X-Original-From: Cody Kang <codykang.hk@gmail.com>
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
Reply-To: codykang.hk@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This series adds display support for the SpacemiT K3 [2], a RISC-V SoC:
a new DRM driver, a new PHY driver and three new bindings.

The display path is three blocks deep:

  Saturn DPU -> Innosilicon DP/eDP controller -> Innosilicon DP PHY

In v2, two major improvements:

- Module unload is now robust.
- The bindings now require the controller's output port (port@1).

The rest of the v2 changes please see below, with details in each patch's
changelog.

Sashiko AI review contributed total review comments: 57 items, which I
accepted: 14 items.

v2 repeated the full v1 test matrix on both boards, in built-in and
modular configurations, plus the new module load/unload rounds.

The v1 cover letter follows below, unchanged, to provide some backgroud
(I can remove them from cover letter in next version):

The Saturn DPU is SpacemiT's own display processing unit. It has a private
address translation unit and a command-list composer that replays a batch
of register writes when a flush is latched. It exposes one CRTC with one
primary plane. The K3 instantiates two DPUs, one per display path.

The DPU driver arrives as five staged patches to keep each one a
reasonable size. The driver only becomes buildable with that last patch.
Bisect safe.

The DP/eDP controller and its PHY are Innosilicon IP, also two instances
of each. An instance behaves as embedded DisplayPort or as external
DisplayPort purely according to what its output port is wired to, so the
bindings do not distinguish them. The PHY's registers are interleaved
with the controller's inside one MMIO window, which is why it is
described as a child node and shares the controller's regmap.

The pixel clock is generated by the DP PHY's PLL, and the SoC's APMU
pixel-clock mux takes that PLL as an input. Rather than let the display
driver reach into PHY registers, the PHY registers its PLL as a clock
provider and the APMU mux is parented to it through the clock framework.
That is what patches 2, 4, 5 and 6 are for, and it is also what keeps the
APMU and the DP/eDP controller out of a devicetree provider cycle.

As a first posting of the K3 display subsystem, this patchset supports:
a single primary plane per CRTC, linear RGB scanout (no plane scaling,
rotation, YUV or writeback). It does not support DSI, DSC or DP audio,
and link rates are capped at HBR2.

Based on drm-misc-next at commit 5b9af25f2d0b ("accel/ivpu: Remove
unnecessary min_t()/max_t() usage"), v7.2-rc2 based.

Testing this series needs a SpacemiT u-boot carrying display support
[1]. SpacemiT expects to add that support into an official u-boot
release in August 2026.

Tested on two K3 boards:

  - Pico-ITX: an eDP panel and an external DisplayPort monitor.
  - CoM260-IFX: DisplayPort only, no eDP.

Note: The eDP panel DTS enablement is not part of this series; a separate
      series will follow showing how eDP can be verified.

What was run on both boards, with modetest from libdrm and with kmscube:

  - modetest -s, looped over 1920x1080, 1280x720 and 3840x2160
    on DisplayPort and 2560x1600 on eDP
  - kmscube, on each head and on both at once
  - hot-plug and sink swap on the DisplayPort connector

Both built-in and modular configurations were tested. Patch 17
defconfig adds them as modules.

[1] https://github.com/spacemit-com/uboot-for-k3-display-verify/tree/k3-br-v1.0.y
[2] https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k3

Changes in v2:
- unbind: keep the online IRQ alive until the teardown commits have
  drained; module unload no longer rides two watchdog timeouts
- bridge teardown on devres: reset via
  devm_reset_control_get_exclusive_deasserted(), pxclk disable as a
  devm action ordered against the PHY child (Philipp Zabel, Yao Zi)
- all five DPU reset lines behind one reset_control_bulk_* pair
  (Philipp Zabel, Guodong Xu)
- bindings: port@1 is now required; the CoM260 board describes its DP
  receptacle with a dp-connector node; redundant minItems dropped
  (Rob Herring)
- possible_crtcs derived from the input endpoint only
- EDID reads through the AUX I2C adapter; write-1-to-clear interrupt
  acks by plain write; assorted dead code dropped
- picked up Rob Herring's Reviewed-by on patches 1-3
- Link to v1: https://lore.kernel.org/r/20260725-k3-display-v1-0-6de34d80e86c@gmail.com

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
Cody Kang (17):
      dt-bindings: display: spacemit: add K3 Saturn DPU controller
      dt-bindings: phy: add SpacemiT K3 Innosilicon DP PHY
      dt-bindings: display: spacemit: add K3 Innosilicon DP/eDP controller
      dt-bindings: soc: spacemit: allow eDP/DP PHY PLL pixel clocks on K3 APMU
      phy: spacemit: add Innosilicon DP TX PHY driver
      clk: spacemit: k3: parent eDP/DP pixel clock to the PHY PLL
      drm/spacemit: add Saturn DPU register model
      drm/spacemit: add Saturn DPU core types, cmdlist and display MMU
      drm/spacemit: add Saturn DPU hardware backend
      drm/spacemit: add Saturn DPU KMS pipeline
      drm/spacemit: add Saturn DPU DRM device driver
      drm/spacemit: add Innosilicon DP/eDP controller bridge driver
      MAINTAINERS: add SpacemiT K3 display driver entry
      riscv: dts: spacemit: k3: add display nodes
      riscv: dts: spacemit: k3-pico-itx: enable the DisplayPort output
      riscv: dts: spacemit: k3-com260-ifx: enable the DisplayPort output
      riscv: defconfig: spacemit: k3: enable display driver

 .../display/spacemit/spacemit,k3-inno-dp.yaml      |  141 ++
 .../display/spacemit/spacemit,k3-saturn-dpu.yaml   |  132 ++
 .../bindings/phy/spacemit,k3-inno-dp-phy.yaml      |   48 +
 .../bindings/soc/spacemit/spacemit,k1-syscon.yaml  |   21 +-
 MAINTAINERS                                        |   10 +
 arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts     |   27 +
 arch/riscv/boot/dts/spacemit/k3-display.dtsi       |  166 ++
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts       |   11 +
 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi       |   22 +
 arch/riscv/configs/defconfig                       |    2 +
 drivers/clk/spacemit/ccu-k3.c                      |    4 +-
 drivers/gpu/drm/Kconfig                            |    1 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/spacemit/Kconfig                   |   37 +
 drivers/gpu/drm/spacemit/Makefile                  |   15 +
 drivers/gpu/drm/spacemit/dpu/dpu_saturn.c          |  479 ++++
 drivers/gpu/drm/spacemit/dpu/dpu_saturn.h          |   35 +
 drivers/gpu/drm/spacemit/dpu/dpu_saturn_hee.c      |  896 ++++++++
 drivers/gpu/drm/spacemit/dpu/dpu_trace.h           |  350 +++
 drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.c       |  152 ++
 drivers/gpu/drm/spacemit/dpu/saturn_fbcmem.h       |   21 +
 drivers/gpu/drm/spacemit/dpu/saturn_regs/dpu_int.h |   25 +
 drivers/gpu/drm/spacemit/dpu/saturn_regs/ops_hee.h |   51 +
 .../gpu/drm/spacemit/dpu/saturn_regs/reg_map_hee.h |   64 +
 .../drm/spacemit/dpu/saturn_regs/saturn_fields.h   |  298 +++
 drivers/gpu/drm/spacemit/spacemit_cmdlist.c        |  304 +++
 drivers/gpu/drm/spacemit/spacemit_cmdlist.h        |  146 ++
 drivers/gpu/drm/spacemit/spacemit_crtc.c           |  786 +++++++
 drivers/gpu/drm/spacemit/spacemit_crtc.h           |  246 ++
 drivers/gpu/drm/spacemit/spacemit_dmmu.c           |   80 +
 drivers/gpu/drm/spacemit/spacemit_dmmu.h           |   40 +
 drivers/gpu/drm/spacemit/spacemit_dpu_ids.h        |   22 +
 drivers/gpu/drm/spacemit/spacemit_dpu_reg.h        |  108 +
 drivers/gpu/drm/spacemit/spacemit_drm.c            |  140 ++
 drivers/gpu/drm/spacemit/spacemit_drm.h            |   61 +
 drivers/gpu/drm/spacemit/spacemit_inno_dp.c        | 2391 ++++++++++++++++++++
 drivers/gpu/drm/spacemit/spacemit_inno_dp.h        |  329 +++
 drivers/gpu/drm/spacemit/spacemit_planes.c         |  377 +++
 drivers/phy/spacemit/Kconfig                       |   13 +
 drivers/phy/spacemit/Makefile                      |    1 +
 drivers/phy/spacemit/phy-k3-inno-dp.c              |  967 ++++++++
 41 files changed, 9017 insertions(+), 3 deletions(-)
---
base-commit: 5b9af25f2d0b574b4058c9f8c84486a597168116
change-id: 20260713-k3-display-e8ffed67e936

Best regards,
--  
Cody Kang <codykang.hk@gmail.com>


