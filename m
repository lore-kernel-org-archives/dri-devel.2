Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D174DC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A36D10E5D5;
	Fri, 28 Aug 2026 13:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="EgcV9Qk/";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50ABB10F3B4
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 13:48:16 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260828134814euoutp01f2ad3c9463856e5e034ddb0282f0ad63~P-Df0fOiX2677926779euoutp017;
 Fri, 28 Aug 2026 13:48:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260828134814euoutp01f2ad3c9463856e5e034ddb0282f0ad63~P-Df0fOiX2677926779euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787924894;
 bh=lEAv/2TAHPqfa06royvwvLBs1NQSafLAoUyNsIumgks=;
 h=From:Subject:Date:To:Cc:References:From;
 b=EgcV9Qk/UbSLAFFgzOUTEt/4UoC7rEx+ccpBIKy0oru6eYUcFWeIqg/d/b11GC8uc
 rMR2p/yAhjeKMBG77BzoyE64uUb00l7vFTsEBWSG7K+5+KmAq5t728oCUVWQqFkwC4
 zq7P0emg3DDiQco6yoexohStzGDK+JxCv5tqqWy8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260828134813eucas1p1bd003a66706ed251017185fc14f13cc9~P-DfWduwc1588515885eucas1p1H;
 Fri, 28 Aug 2026 13:48:13 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260828134812eusmtip1eb3666b9effe69dfe934e9f45f4672ba~P-Ddt1SrK3269332693eusmtip1C;
 Fri, 28 Aug 2026 13:48:12 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v2 00/15] drm: starfive: jh7110: Enable display subsystem
Date: Fri, 28 Aug 2026 15:47:24 +0200
Message-Id: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGyRkWoC/x3MSwqAMAwA0atI1gaa+Kl4FXEhNtqIVGlBBPHuF
 pdvMfNAkqiSoC8eiHJp0iNkcFnA7KewCqrLBjbckKkIN2+JDM67TAGTBIfWMddM1BluIXdnlEX
 v/zmM7/sB4Z8oYmMAAAA=
X-Change-ID: 20251031-jh7110-clean-send-7d2242118026
To: Vinod Koul <vkoul@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>,  Robert Foss <rfoss@kernel.org>,  Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,  Simona
 Vetter <simona@ffwll.ch>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>,  Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,  Heiko
 Stuebner <heiko@sntech.de>, Conor Dooley <conor@kernel.org>,  Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Icenowy Zheng <uwu@icenowy.me>,  Andy Yan
 <andyshrk@163.com>, Marek Szyprowski <m.szyprowski@samsung.com>,  Maud
 Spierings <maudspierings@gocontroll.com>,  Graham Markall
 <hello@big-grey.co.uk>,  Michal Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260828134813eucas1p1bd003a66706ed251017185fc14f13cc9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260828134813eucas1p1bd003a66706ed251017185fc14f13cc9
X-EPHeader: CA
X-CMS-RootMailID: 20260828134813eucas1p1bd003a66706ed251017185fc14f13cc9
References: <CGME20260828134813eucas1p1bd003a66706ed251017185fc14f13cc9@eucas1p1.samsung.com>
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

  - the HDMI controller needs sys/mclk/bclk from voutcrg
  - voutcrg needs the pixel clock for its dc8200 pixel MUXes, and that
    clock is generated by the HDMI PHY

The loop only exists if the HDMI block is treated as one device. The
PHY's reference clock is xin24m, not a voutcrg output, so splitting the
node into a parent plus phy and controller children gives deferred probe
a linear order: hdmi-phy, then voutcrg, then hdmi-controller.

The parent maps the register block, owns the regmap its two children
share, and enables the NoC display bus clock and reset that gate the
whole vout region. Each node has its own power-domains property, so
genpd powers PD_VOUT on demand. The RFC's vout-subsystem wrapper is gone
along with the patch that relaxed the voutcrg binding.

Patch 7 adds a .mode_valid platform op to inno-hdmi.
inno_hdmi_bridge_mode_valid() checks the pixel clock against
hdmi->refclk, but that clock only exists where a "ref" clock is
described. The JH7110 gets its pixel clock from the PHY, so refclk is
NULL and the check was skipped: unsupported modes were advertised, the
modeset then "succeeded" because the atomic enable path cannot fail, and
the display stayed blank.

Patches 11-13 drop the PHY duplication from the RFC. The JH7110 has the
same Innosilicon PHY as the RK3328, offset by 0x100 because it sits
behind the controller in the shared register block. Patch 11 factors out
the pre-PLL config format, table lookup, determine_rate, recalc_rate and
the pre-PLL programming; patch 12 moves Rockchip onto it; patch 13 adds
the JH7110 driver. Pixel clock tables, post-PLL and analog config stay
SoC specific.

Patch 12 should be a no-op for Rockchip - same writes, same order, same
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

Before patch 7, four of the advertised modes failed: 1680x1050@59.95
(146.250 MHz), 1400x1050@59.98 (121.750), 1152x864@59.97 (81.768) and
1280x768@60.35 (80.140). Those pixel clocks are not in the PHY pre-PLL
table, so clk_set_rate() returned -EINVAL and the screen stayed black
while userspace saw a successful modeset. They are rejected in
.mode_valid now; the other refresh rates of those resolutions still work.

Every commit builds for riscv, and the Rockchip PHY also for arm.

Notes
=====

The JH7110 has no central MAINTAINERS entry and maintainership is
fragmented, so patch 15 adds one for the display subsystem and I am
happy to help maintain it. The new PHY library lives under drivers/phy/,
already covered by the generic PHY framework entry.

checkpatch warns "does MAINTAINERS need updating?" on the patches adding
files, because that entry comes in patch 15.

Changes since the RFC:
- Dropped the vout-subsystem wrapper driver and its binding, along with
  the patch relaxing the voutcrg binding; genpd handles PD_VOUT per node.
- Renamed the compatible to starfive,jh7110-hdmi-subsystem, dropping
  "mfd" as a Linux term (Conor Dooley).
- Absolute $refs in the bindings, unused example labels dropped, and the
  examples deduplicated between parent and children (Conor Dooley).
- Added the .mode_valid platform operation (patch 7).
- Split the inno-hdmi rework into a mechanical probe/bind split (patch 4)
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

Thanks to Icenowy Zheng for the dc8200 driver and for explaining how the
SoC and the display pipeline fit together.

Thanks also to Dominique Belhachemi, who got rid of the vout-subsystem
wrapper and helped with the testing, and to Graham Markall for testing
the JH7110 display patches independently and writing up the results:
https://big-grey.co.uk/2026/01/26/testing-starfive-jh7110-display-controller-patches/

Link to v1: https://lore.kernel.org/all/20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com/

---
Michal Wilczynski (15):
      dt-bindings: phy: Add starfive,jh7110-inno-hdmi-phy
      dt-bindings: display: bridge: Add starfive,jh7110-inno-hdmi-controller
      dt-bindings: mfd: Add starfive,jh7110-hdmi-subsystem
      drm/bridge: inno-hdmi: Split probe out of bind
      drm/bridge: inno-hdmi: Allow the register map to come from a parent
      drm/bridge: inno-hdmi: Add .disable platform operation
      drm/bridge: inno-hdmi: Add .mode_valid platform operation
      soc: starfive: Add jh7110-hdmi-subsystem driver
      clk: starfive: jh7110-vout: Allow pixel clock rate propagation
      drm/bridge: starfive: Add JH7110 HDMI controller driver
      phy: Add common Innosilicon HDMI PHY helpers
      phy: rockchip: inno-hdmi: Use the common Innosilicon PHY helpers
      phy: starfive: Add jh7110-inno-hdmi-phy driver
      riscv: dts: starfive: jh7110: Update DT for display subsystem
      MAINTAINERS: Add StarFive JH7110 display subsystem entry

 .../starfive,jh7110-inno-hdmi-controller.yaml      | 109 ++++
 .../mfd/starfive,jh7110-hdmi-subsystem.yaml        | 116 +++++
 .../phy/starfive,jh7110-inno-hdmi-phy.yaml         |  58 +++
 MAINTAINERS                                        |  10 +
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    | 119 ++++-
 arch/riscv/boot/dts/starfive/jh7110.dtsi           |  87 +++-
 drivers/clk/starfive/clk-starfive-jh7110-vout.c    |   4 +-
 drivers/gpu/drm/bridge/Kconfig                     |  11 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/inno-hdmi.c                 |  82 ++-
 drivers/gpu/drm/bridge/jh7110-inno-hdmi.c          | 224 ++++++++
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-inno-hdmi.c                        | 297 +++++++++++
 drivers/phy/rockchip/Kconfig                       |   1 +
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      | 127 +----
 drivers/phy/starfive/Kconfig                       |  20 +
 drivers/phy/starfive/Makefile                      |   1 +
 drivers/phy/starfive/phy-jh7110-inno-hdmi.c        | 567 +++++++++++++++++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/starfive/Kconfig                       |  27 +
 drivers/soc/starfive/Makefile                      |   2 +
 drivers/soc/starfive/jh7110-hdmi-subsystem.c       | 114 +++++
 include/drm/bridge/inno_hdmi.h                     |  10 +-
 include/linux/phy/inno-hdmi-phy.h                  |  85 +++
 26 files changed, 1959 insertions(+), 124 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20251031-jh7110-clean-send-7d2242118026

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

