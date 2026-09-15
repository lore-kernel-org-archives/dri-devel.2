Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805F9C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9472C10E210;
	Tue, 15 Sep 2026 15:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="MOB90zZ5";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC95710E116
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:32:15 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260915153213euoutp0103dd16744749957a90678f2a4c5f62ec~ViFbneXZF0667706677euoutp01l;
 Tue, 15 Sep 2026 15:32:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260915153213euoutp0103dd16744749957a90678f2a4c5f62ec~ViFbneXZF0667706677euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789486333;
 bh=SDX1Go88GYVoyF45wf3REjN1Tontm1ztp/VkkMXRZzU=;
 h=From:Subject:Date:To:Cc:References:From;
 b=MOB90zZ5qaw5xs/piW5B2GIlD2rxWhiq7VnETFjDysg+WvDvHYBggRwj7SHB+KDH0
 WNl8iZXSWGpxfNjY1NkozQ0FORaogXb3eu4KqOgRDw0+9h97HOSviD1VVBaJYKUYjR
 G86f7For63053bfY32ICUv7474+JiVjAWw3fjrGQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260915153213eucas1p148f013af239a334fc78cdc249c0f8a61~ViFa-goIN1221512215eucas1p1K;
 Tue, 15 Sep 2026 15:32:13 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260915153211eusmtip10ade95c9b5bcd5e74ba0d94b5e80de91~ViFZSSOpA0336503365eusmtip1u;
 Tue, 15 Sep 2026 15:32:11 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v4 00/20] drm: starfive: jh7110: Enable display subsystem
Date: Tue, 15 Sep 2026 17:32:08 +0200
Message-Id: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPhkqWoC/4XNwWrDMBAE0F8xOkdldyVbUk79j5CDLK9jlUYuV
 mISgv+9ci7FYOhxBubNS2SeImdxrF5i4jnmOKYS9KESYfDpwjJ2JQsCqhEUyq/BIIIM3+yTzJw
 6aToiTYgWqBFl9zNxHx9v83QueYj5Nk7P98VMa7tqDViyO9pMEqRS2FgItnUdfmZ/zfd0+QjjV
 azerP4MB3rPUMXwEFxbt712hjfGofp3q63unWdDBuvt/7Isvz7qDRI0AQAA
X-Change-ID: 20251031-jh7110-clean-send-7d2242118026
To: Vinod Koul <vkoul@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>,  Robert Foss <rfoss@kernel.org>,  Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>,  Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,  Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org,  Marek Szyprowski
 <m.szyprowski@samsung.com>,  Maud Spierings <maud_spierings@murena.io>, 
 Graham Markall <hello@big-grey.co.uk>,  Icenowy Zheng
 <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260915153213eucas1p148f013af239a334fc78cdc249c0f8a61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915153213eucas1p148f013af239a334fc78cdc249c0f8a61
X-EPHeader: CA
X-CMS-RootMailID: 20260915153213eucas1p148f013af239a334fc78cdc249c0f8a61
References: <CGME20260915153213eucas1p148f013af239a334fc78cdc249c0f8a61@eucas1p1.samsung.com>
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

This series enables the display subsystem on the StarFive JH7110.

The dom_vout block holds the display controller (dc8200), the clock
generator (voutcrg) and the HDMI IP, all inside PD_VOUT. The HDMI IP is
a single register block containing both the controller and the PHY, and
it has a circular clock dependency with voutcrg:

  - the HDMI controller needs pclk/mclk/bclk from voutcrg
  - voutcrg needs the pixel clock for its dc8200 pixel MUXes, and that
    clock is generated by the HDMI PHY

The loop only exists if the HDMI block is treated as one device. The
PHY's reference clock is xin24m, not a voutcrg output, so splitting the
node into a parent plus phy and controller children gives deferred probe
a linear order: hdmi-phy, then voutcrg, then hdmi-controller.

The parent maps the register block and owns the regmap its two children
share. Everything in the region sits behind one NoC port whose clock and
reset gate access to it, inside PD_VOUT, so the vout subsystem node from
the RFC is back and owns those for as long as any child exists.

Patch 10 adds a .mode_valid platform op to inno-hdmi.
inno_hdmi_bridge_mode_valid() checks the pixel clock against
hdmi->refclk, but that clock only exists where a "ref" clock is
described. The JH7110 gets its pixel clock from the PHY, so refclk is
NULL and the check was skipped: unsupported modes were advertised, the
modeset then "succeeded" because the atomic enable path cannot fail, and
the display stayed blank.

Patch 11 makes the inno-hdmi PHY configuration table optional. The
JH7110 drives its PHY through a separate driver, so the table only ever
existed to get past a probe time check, and the register writes it fed
belong to the integrated PHY the JH7110 does not have.

Patches 16-18 drop the PHY duplication from the RFC. The JH7110 has the
same Innosilicon PHY as the RK3328, offset by 0x100 because it sits
behind the controller in the shared register block. Patch 16 factors out
the pre-PLL config format, table lookup, determine_rate, recalc_rate and
the pre-PLL programming; patch 17 moves Rockchip onto it; patch 18 adds
the JH7110 driver. Pixel clock tables, post-PLL and analog config stay
SoC specific.

Patch 17 should be a no-op for Rockchip - same writes, same order, same
values - and RK3228, whose pre-PLL is at different addresses, keeps its
own register code and shares only the lookup. I have no Rockchip
hardware, so it is build tested only (arm and riscv). A Tested-by would
help.

The dc8200 driver, th1520 reset controller and inno-hdmi bridge that the
RFC listed as prerequisites are all upstream now, so there are no
out-of-tree dependencies.

Testing
=======

Tested on a VisionFive 2 v1.3B using modetest.

All 42 modes the sink advertises work, with nothing in dmesg. Pixel
clocks run from 25.175 MHz (640x480@59.94) up to 297 MHz
(4096x2160@30), including 3840x2160 and the full 1920x1080 and 1280x720
rate families.

The four modes the RFC reported as broken work now too: 2560x1440@59.95,
2048x1080@60.00, 2048x1080@24.00 and 720x400@70.08.

Before patch 10, four of the advertised modes failed: 1680x1050@59.95
(146.250 MHz), 1400x1050@59.98 (121.750), 1152x864@59.97 (81.768) and
1280x768@60.35 (80.140). Those pixel clocks are not in the PHY pre-PLL
table, so clk_set_rate() returned -EINVAL and the screen stayed black
while userspace saw a successful modeset. They are rejected in
.mode_valid now; the other refresh rates of those resolutions still work.

The mux the HDMI controller programs in dom_vout_syscon has a DP and a
DPI branch, and the DT wires the DPI one, so the DP branch was checked
separately by moving the input endpoint to the DC8200's DP output on a
throwaway branch. SYSCFG_4 reads 0x4c0b0000 instead of 0x0c0b0000, the
output is identical to the DPI path and all 42 modes set. Sweeping
VOUT_HDMI_DP_YUV_MODE over its four values with a mode held shows only
RGB giving a correct picture, as documented.

Every commit builds for riscv, and the Rockchip PHY also for arm.

Known limitation
================

The Framework 13 (fml13v01) panel needs one more change that is not in
here: dropping v_REG_CLK_INV | v_REG_CLK_SOURCE_SYS from the
HDMI_SYS_CTRL write in inno_hdmi_init_hw(), without which it flickers
(Maud Spierings). Those bits are set unconditionally for every user of
the generic driver, so changing them is outside the scope of this
series. Input from the inno-hdmi maintainers, or from anyone with a
datasheet that says when they apply, would be welcome.

Notes
=====

The JH7110 has no central MAINTAINERS entry and maintainership is
fragmented, so patch 20 adds one for the display subsystem and I am
happy to help maintain it. The new PHY library lives under drivers/phy/,
already covered by the generic PHY framework entry.

checkpatch warns "does MAINTAINERS need updating?" on the patches adding
files, because that entry comes in patch 20.

Thanks to Icenowy Zheng for the dc8200 driver and for explaining how the
SoC and the display pipeline fit together.

Thanks also to Dominique Belhachemi, who got rid of the vout-subsystem
wrapper and helped with the testing, to Maud Spierings for testing on a
Framework 13 panel, and to Graham Markall for testing
the JH7110 display patches independently and writing up the results:
https://big-grey.co.uk/2026/01/26/testing-starfive-jh7110-display-controller-patches/

Link to v1: https://lore.kernel.org/all/20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com/

---
Changes in v4:
- New patch 11 makes the inno-hdmi PHY configuration table optional, so
  the JH7110 controller can drop the dummy two entry table it carried
  only to satisfy the probe time check, along with the integrated PHY
  register writes that table fed (Icenowy Zheng). That table was also
  acting as an upper bound: inno_hdmi_find_phy_config() runs before the
  platform .mode_valid and returns early, so its 297 MHz sentinel
  rejected every mode above that even though the PHY pre-PLL table has a
  594 MHz entry. Nothing here advertises such a mode, so it was latent.
- Fixed a v3 regression: CLK_SET_RATE_NO_REPARENT stops clk_set_rate()
  from reparenting the dc8200 pixel MUXes, so they kept whatever the
  bootloader had selected and the display stayed black on boards where
  that was not the HDMI PHY. They get assigned-clock-parents now (Maud
  Spierings, Dominique Belhachemi).
- vout-subsystem binding: describe the children by compatible instead of
  $ref, as qcom,sm8750-mdss does, and show the whole subsystem with all
  four children in the example (Krzysztof Kozlowski).
- Dropped the vout-syscon example from starfive,jh7110-syscon.yaml, it
  is part of the vout subsystem example now (Krzysztof Kozlowski).
- Renamed the xin24m node to xin24m-clock (Krzysztof Kozlowski).
- Fixed the HDMI HPD pinmux: it drove the pin high (GPOUT_HIGH with the
  output enabled) while also reading it as the hotplug input, so HPD
  could only ever read asserted. It is an input now.
- jh7110-inno-hdmi: dropped a regmap lookup whose result was never used;
  inno_hdmi_probe() fetches the parent regmap itself. The commit message
  claimed otherwise and is corrected.
- phy: rockchip: dropped two now unused RK3328 spread spectrum macros
  the v3 cleanup missed. The register write itself moved to the shared
  helper and is unchanged, so Chaoyi's Reviewed-by is carried over.
- inno-hdmi: the hotplug handler dereferenced bridge.dev unconditionally.
  Splitting probe out of bind moved the interrupt request to probe, so
  an HPD event before the DRM master attaches the bridge would oops.
  Guarded.
- Dropped the <linux/mod_devicetable.h> includes (Uwe Kleine-König).
- jh7110-inno-hdmi: __free(device_node) for the graph lookups, and
  dropped the redundant negative check on clk_round_rate() (Chaoyi Chen).
- phy: rockchip: dropped the recalc_rate debug print that the shared
  helper already emits (Chaoyi Chen).
- Rebased onto v7.3-rc3.
- Link to v3: https://lore.kernel.org/r/20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com

Changes in v3:
- Brought back the vout subsystem node and driver, now owning the NoC
  bus clock, its reset and PD_VOUT for the whole region, with dc8200,
  the HDMI block, the syscon and voutcrg as its children (Icenowy Zheng).
- Fixed a hard hang when the bridge is built as a module: the PHY's
  .is_prepared read a register in the window gated by the controller's
  system clock, so clk_disable_unused() wedged the CPU before the
  controller had bound. The op is gone; the framework uses the software
  prepare count instead. (Marek Szyprowski)
- The HDMI controller now programs the display mux in dom_vout_syscon
  from the port graph rather than inheriting whatever the bootloader
  left, with a phandle to the syscon (Icenowy Zheng).
- The register access clock is named "pclk" to match the existing
  inno-hdmi binding, so the generic driver no longer picks up the pixel
  clock. Previously it held the pre-PLL powered from probe and sized the
  DDC divider from the wrong rate.
- Dropped the clk suffixes and the single-entry -names properties from
  the bindings (Conor Dooley). mclk and bclk keep their names: per TRM
  5.3 they are the HDMI audio clocks, not module and bus clocks, so the
  descriptions say that instead.
- Replaced patternProperties with plain properties in the hdmi-subsystem
  binding (Conor Dooley).
- dc8200 gets an SoC specific compatible, and inherits dma-noncoherent
  from the subsystem bus node, so it validates against verisilicon,dc.
- Added the pre-PLL entry for the Framework 13 panel and fixed two
  devicetree whitespace nits (Maud Spierings).
- select REGMAP_MMIO, CLK_SET_RATE_NO_REPARENT on the dc8200 pixel MUXes
  so clk_set_rate() cannot reroute them, and inno-hdmi register reads
  return 0 instead of stack garbage when regmap_read() fails.
- phy: rockchip: dropped the local pre-PLL lookup wrapper and the 28 now
  unused RK3328 pre-PLL macros, and restored the VCO debug output, this
  time in the shared helper so both drivers get it (Jonas Karlman).
- Rebased onto v7.3-rc1.
- Link to v2: https://lore.kernel.org/r/20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com

Changes since the RFC:
- Dropped the vout-subsystem wrapper driver and its binding, along with
  the patch relaxing the voutcrg binding; genpd handles PD_VOUT per
  node.
- Renamed the compatible to starfive,jh7110-hdmi-subsystem, dropping
  "mfd" as a Linux term (Conor Dooley).
- Absolute $refs in the bindings, unused example labels dropped, and the
  examples deduplicated between parent and children (Conor Dooley).
- Added the .mode_valid platform operation (patch 7).
- Split the inno-hdmi rework into a mechanical probe/bind split (patch
  4)
  and the regmap-from-parent change (patch 5). struct inno_hdmi is no
  longer exported; no platform glue dereferences it.
- Replaced the duplicated PHY driver with a shared Innosilicon library
  and moved Rockchip onto it (patches 11-13).
- Fixed pre-PLL lock detection, which masked the status read with the
  register address instead of the lock bit.
- Fixed a pixel clock refcount underflow: enable returns early on
  failure while disable tore down unconditionally.
- voutcrg patch reduced to adding CLK_SET_RATE_PARENT to the two dc8200
  pixel MUXes.
- Rebased onto v7.2.

---
Michal Wilczynski (20):
      dt-bindings: phy: Add starfive,jh7110-inno-hdmi-phy
      dt-bindings: display: bridge: Add starfive,jh7110-inno-hdmi-controller
      dt-bindings: mfd: Add starfive,jh7110-hdmi-subsystem
      dt-bindings: soc: starfive: Add starfive,jh7110-vout-syscon
      dt-bindings: display: verisilicon: Add starfive,jh7110-dc8200
      dt-bindings: soc: starfive: Add starfive,jh7110-vout-subsystem
      drm/bridge: inno-hdmi: Split probe out of bind
      drm/bridge: inno-hdmi: Allow the register map to come from a parent
      drm/bridge: inno-hdmi: Add .disable platform operation
      drm/bridge: inno-hdmi: Add .mode_valid platform operation
      drm/bridge: inno-hdmi: Make the PHY configuration table optional
      soc: starfive: Add jh7110-hdmi-subsystem driver
      soc: starfive: Add jh7110-vout-subsystem driver
      clk: starfive: jh7110-vout: Allow pixel clock rate propagation
      drm/bridge: starfive: Add JH7110 HDMI controller driver
      phy: Add common Innosilicon HDMI PHY helpers
      phy: rockchip: inno-hdmi: Use the common Innosilicon PHY helpers
      phy: starfive: Add jh7110-inno-hdmi-phy driver
      riscv: dts: starfive: jh7110: Update DT for display subsystem
      MAINTAINERS: Add StarFive JH7110 display subsystem entry

 .../starfive,jh7110-inno-hdmi-controller.yaml      | 121 +++++
 .../bindings/display/verisilicon,dc.yaml           |   1 +
 .../mfd/starfive,jh7110-hdmi-subsystem.yaml        |  95 ++++
 .../phy/starfive,jh7110-inno-hdmi-phy.yaml         |  49 ++
 .../soc/starfive/starfive,jh7110-syscon.yaml       |   1 +
 .../starfive/starfive,jh7110-vout-subsystem.yaml   | 218 ++++++++
 MAINTAINERS                                        |  13 +
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    | 121 ++++-
 arch/riscv/boot/dts/starfive/jh7110.dtsi           | 105 +++-
 drivers/clk/starfive/clk-starfive-jh7110-vout.c    |   6 +-
 drivers/gpu/drm/bridge/Kconfig                     |  11 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/inno-hdmi.c                 | 112 +++-
 drivers/gpu/drm/bridge/jh7110-inno-hdmi.c          | 297 +++++++++++
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-inno-hdmi.c                        | 298 +++++++++++
 drivers/phy/rockchip/Kconfig                       |   1 +
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      | 168 +-----
 drivers/phy/starfive/Kconfig                       |  20 +
 drivers/phy/starfive/Makefile                      |   1 +
 drivers/phy/starfive/phy-jh7110-inno-hdmi.c        | 579 +++++++++++++++++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/starfive/Kconfig                       |  43 ++
 drivers/soc/starfive/Makefile                      |   3 +
 drivers/soc/starfive/jh7110-hdmi-subsystem.c       |  73 +++
 drivers/soc/starfive/jh7110-vout-subsystem.c       |  82 +++
 include/drm/bridge/inno_hdmi.h                     |  10 +-
 include/linux/phy/inno-hdmi-phy.h                  |  85 +++
 30 files changed, 2337 insertions(+), 188 deletions(-)
---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20251031-jh7110-clean-send-7d2242118026

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

