Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E79260A263E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=R+isLw7C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F2510E79D;
	Thu, 29 Oct 2026 07:54:01 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 270F710E0FD
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:53:55 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029075353euoutp017577b9f0ab2a8c24146faa2d5002a148~i8Nz3tQNi1385013850euoutp01B;
 Thu, 29 Oct 2026 07:53:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261029075353euoutp017577b9f0ab2a8c24146faa2d5002a148~i8Nz3tQNi1385013850euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793260433;
 bh=wqr33KQzaFSGsxikxIEyBRQqcIHSvI9Rq0DE91IdOSQ=;
 h=From:Subject:Date:To:Cc:References:From;
 b=R+isLw7C6nRMadWjLhkYvOkqyjgQVOZeG35Qa5zg7qbbVF/NFyPFpmAMHBMJPRrHX
 dP8ZsvZortdIy6cuBi8+EtaVSORG07PuZIxYJb4Pbp8sdOcrblA/B7ckSW3ElAgAvB
 SMw7xdueDtEJYNrfRB8i9PEFYVFSkcxlp4wEE0Xs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261029075352eucas1p28bb0b14e03ab247dfbbee4843e1332ba~i8Nyw-HVD1120211202eucas1p21;
 Thu, 29 Oct 2026 07:53:52 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029075349eusmtip118ed2acf94e09c5a557db33b65b8ab98~i8Nv1v0So1314413144eusmtip1B;
 Thu, 29 Oct 2026 07:53:49 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v6 00/18] drm: starfive: jh7110: Enable display subsystem
Date: Thu, 29 Oct 2026 08:53:34 +0100
Message-Id: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH774moC/4XRzW7bMAwA4FcxdK4Gkvp1TnuPYQeJomoNi9PZq
 dGi6LtXTg5N0QA7UgI//r2pVZYmqzoMb2qRra3tNPfAPwyKpzQ/im6lx4qAHIJB/WcKiKD5r6R
 ZrzIXHQqRJcQI5FXPe1qktpeL+et3j6e2nk/L66XERvvrrnmIFO9oG2nQxqCPwDGPBX+u6bg+z
 48/+HRUu7eZT2MEe88w3UjAY3a52jHIF+Nh+G+ujbaOSQIFdN/r25v66O4ZthsVxNbiKzHH74a
 7MWi8Z7huRMq2RDHsOXw13q+LXuTfc7/Z+bptldMquv8f2/kwMBjGhNZBKDXVmKPzvO+9j8aEH
 ggrE5G6vfVh2HtC+LxNm+eTnsqx6afpVUcjjmvy1og5bNd7pzNPl9Q+ckSL3mepY0VKiOxsEQg
 EJmPIZQwJKPT23z8A6uNcD3oCAAA=
X-Change-ID: 20251031-jh7110-clean-send-7d2242118026
To: Neil Armstrong <neil.armstrong@linaro.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Philipp Zabel
 <p.zabel@pengutronix.de>,  Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Andy Yan <andyshrk@163.com>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Yakir Yang
 <kuankuan.y@gmail.com>,  Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>,  Conor Dooley <conor@kernel.org>, William Qiu
 <william.qiu@starfivetech.com>,  Xingyu Wu <xingyu.wu@starfivetech.com>,
 Sandy Huang <hjc@rock-chips.com>,  Manivannan Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Byron Stanoszek <gandalf@winds.org>,
 OOHehir <oo.hehir@gmail.com>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=18526;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=lSL3jNMMbcdvIY4jtOqWa9i8hqqcgTkooaE5HYO5yj8=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWQ9+t3TwFP6gDlKu0l65YEnV6uUDGUS70RwTk4PZ7x7+
 t6feRc+dpSyMIhxMMiKKbKc3RhtJPmP4Wn58ce/YOawMoEMYeDiFICJ+IQwMsyTjQmfbtRdvFWl
 acrN9v7Jxj5zjM8fMjN6f/v5sd1aVXMY/pcIhrJYOnbw/l7gaCYQvKPtYdNX44Ib65Kv3u/5dGB
 6ACcA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261029075352eucas1p28bb0b14e03ab247dfbbee4843e1332ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029075352eucas1p28bb0b14e03ab247dfbbee4843e1332ba
X-EPHeader: CA
X-CMS-RootMailID: 20261029075352eucas1p28bb0b14e03ab247dfbbee4843e1332ba
References: <CGME20261029075352eucas1p28bb0b14e03ab247dfbbee4843e1332ba@eucas1p2.samsung.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series enables the display subsystem on the StarFive JH7110.

Merging: the series splits by subsystem, there is no build dependency
between the blocks, and each block lands in the tree that already owns
those files:

  drm-misc                     1-3, 6, 8-13, 16
    drivers/gpu/drm/bridge/, include/drm/bridge/ and the display
    bindings. Patches 1 and 2 are inno-hdmi fixes with Fixes: tags;
    they apply to Rockchip as much as to StarFive and are independent
    of the rest, so they can go on their own.

  Conor's tree                 4, 5, 7, 14-15, 17
    bindings/soc/starfive/ (STARFIVE SOC DRIVERS),
    arch/riscv/boot/dts/starfive/ (STARFIVE DEVICETREES), and
    drivers/soc/starfive/, which this series creates.

  -                            18
    MAINTAINERS.

The PHY patches are now a separate series for linux-phy, as Vinod
suggested: "phy: Add the StarFive JH7110 Innosilicon HDMI PHY" [1]. This
series depends on it, and the DT needs the PHY driver at runtime. There
is no build dependency.

[1] https://lore.kernel.org/all/20261028-jh7110-inno-hdmi-phy-v6-0-f3379684d97e@samsung.com/

Ordering: patch 4 references the bindings from patch 3 and the PHY
series, the example in patch 7 instantiates nodes from patches 3 and 6
and the PHY series, and the DT in patch 17 uses all of them. Patches 4,
7 and 17 therefore need the drm-misc bindings and the PHY series in
place to pass dt_binding_check and dtbs_check. Patches 5, 14 and 15 have
no such dependency.

There are no out-of-tree dependencies: the dc8200 driver, the th1520
reset controller and the inno-hdmi bridge that the RFC listed as
prerequisites are all upstream now.

One more dependency: the clk patch that was 14/20 in v4 has been
applied by Brian Masney through the clk tree (af384d6e0573 in
linux-next). The DT patch needs it at runtime for the pixel MUXes to
follow the PHY.

The dom_vout block holds the display controller (dc8200), the clock
generator (voutcrg) and the HDMI IP, all inside PD_VOUT. The HDMI IP is
a single register block containing both the controller and the PHY,
which are described as separate children because they have separate
resources:

  - the PHY takes only the 24 MHz reference clock, and provides the
    pixel clock that voutcrg routes on to the dc8200 pixel MUXes, and
    the phy the controller uses
  - the controller takes pclk/mclk/bclk from voutcrg

It is the same Innosilicon PHY that the RK3328 describes as its own
hdmiphy node; here it shares a register window with the controller.

The parent maps the register block and owns the regmap its two children
share. Everything in the region sits behind one NoC port whose clock and
reset gate access to it, inside PD_VOUT, so the vout subsystem node from
the RFC is back and owns those for as long as any child exists.

Patch 11 adds a .mode_valid platform op to inno-hdmi.
inno_hdmi_bridge_mode_valid() checks the pixel clock against
hdmi->refclk, but that clock only exists where a "ref" clock is
described. The JH7110 gets its pixel clock from the PHY, so refclk is
NULL and the check was skipped: unsupported modes were advertised, the
modeset then "succeeded" because the atomic enable path cannot fail, and
the display stayed blank.

Patch 12 makes the inno-hdmi PHY configuration table optional. The
JH7110 drives its PHY through a separate driver, so the table only ever
existed to get past a probe time check, and the register writes it fed
belong to the integrated PHY the JH7110 does not have.

Patches 1, 2 and 8-13 change the inno-hdmi bridge, which the Rockchip
RK3036 and RK3128 use as well. I have no Rockchip hardware, so on
Rockchip they are build tested only (arm and riscv). A Tested-by would
help.

Testing
=======

Tested on a VisionFive 2 v1.3B using modetest, with the PHY series
applied.

All 42 modes the sink advertises work, with nothing in dmesg. Pixel
clocks run from 25.175 MHz (640x480@59.94) up to 297 MHz
(4096x2160@30), including 3840x2160 and the full 1920x1080 and 1280x720
rate families.

The four modes the RFC reported as broken work now too: 2560x1440@59.95,
2048x1080@60.00, 2048x1080@24.00 and 720x400@70.08.

Before patch 11, four of the advertised modes failed: 1680x1050@59.95
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

Every commit builds for riscv, and the Rockchip inno-hdmi glue also for
arm.

Notes
=====

The JH7110 has no central MAINTAINERS entry and maintainership is
fragmented, so patch 18 adds one for the display subsystem and I am
happy to help maintain it. The PHY series adds its own entry for the
JH7110 HDMI PHY.

checkpatch warns "does MAINTAINERS need updating?" on the patches adding
files, because that entry comes in patch 18.

Thanks to Icenowy Zheng for the dc8200 driver and for explaining how the
SoC and the display pipeline fit together.

Thanks also to Dominique Belhachemi, who got rid of the vout-subsystem
wrapper and helped with the testing, to Maud Spierings for testing on a
Framework 13 panel, to Byron Stanoszek and OOHehir for testing v5, and
to Graham Markall for testing the JH7110 display patches independently
and writing up the results:
https://big-grey.co.uk/2026/01/26/testing-starfive-jh7110-display-controller-patches/

Link to v1: https://lore.kernel.org/all/20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com/

---
Changes in v6:
- Split the PHY patches into their own series (Vinod)
- New patch 2: the hotplug NULL drm_device guard is split out of "Split
  probe out of bind" into its own patch (Heiko)
- inno_hdmi_bind() takes a platform_device, like dw_hdmi_bind() (Heiko)
- Describe the HDMI PHY node by its resources rather than by the probe
  cycle, in the commit messages and the Kconfig help (Krzysztof)
- Rebased onto v7.3, collected tags
- Link to v5: https://lore.kernel.org/r/20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com

Changes in v5:
- Rebased onto v7.3-rc5.
- Dropped the clk patch, applied as af384d6e0573.
- New patch 13 makes the HDMI_SYS_CTRL register clock source selectable
  per platform, and the JH7110 selects the TMDS clock. The driver drove
  the register interface from the system clock for everyone, and a
  Framework 13 panel flickers continuously that way (Maud Spierings).
  Rockchip keeps the system clock, so this is a no-op there. This was
  listed as a known limitation in v4.
- New patch 1 fixes v_HSYNC_POLARITY and v_VSYNC_POLARITY, which have
  been swapped in inno-hdmi since the driver was merged. The hardware
  puts HSYNC in bit 2 and VSYNC in bit 3, and the driver had them the
  other way round. Almost all CEA modes drive both syncs with the same
  polarity, so the two writes are indistinguishable and the bug only
  shows on a mode whose polarities differ - a band of black rows at the
  top of the screen, vsync_end - vsync_start + 1 rows tall. Reported
  independently by Dominique Belhachemi, Maud Spierings and Byron
  Stanoszek, and confirmed against the RK3128 TRM by Icenowy Zheng, so
  this is a Rockchip fix too.
- Added a 201 MHz entry to the JH7110 pre-PLL table for a 2560x1440
  mode Byron Stanoszek runs on a Dell U2711. It is derived the same way
  as the neighbouring entries (fbdiv 134, /16, VCO 3.216 GHz) but I have
  no sink that asks for it, so it is untested on my hardware.
- Moved the hdmi-subsystem binding from bindings/mfd/ to
  bindings/soc/starfive/, next to the vout-subsystem binding and matching
  its driver in drivers/soc/starfive/. The mfd/ path was left over from
  when the driver was called hdmi-mfd; nothing in the series is an MFD
  device, and it meant one isolated binding patch would have had to go
  through the MFD tree on its own.
- The commit message for "Split probe out of bind" claimed a matching
  inno_hdmi_remove(); no such function exists, so the claim is gone.
- Dropped Joshua Peisach's Reviewed-by from the PHY driver patch as well,
  since that patch changed in v5.
- Dropped Joshua Peisach's Reviewed-by from the binding patches; he said
  he is not reviewing DT (Krzysztof Kozlowski). It is kept on the driver
  patches he did look at.
- Removed a probe-time clk_set_rate() from the PHY driver. It programmed
  a default rate, and .set_rate writes PHY registers that live in the
  window gated by the controller's system clock - a clock the PHY cannot
  hold without creating a probe cycle with voutcrg.
- Link to v4: https://lore.kernel.org/r/20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com

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
Michal Wilczynski (18):
      drm/bridge: inno-hdmi: fix swapped HSYNC and VSYNC polarity
      drm/bridge: inno-hdmi: Don't dereference a NULL drm_device on hotplug
      dt-bindings: display: bridge: Add starfive,jh7110-inno-hdmi-controller
      dt-bindings: soc: starfive: Add starfive,jh7110-hdmi-subsystem
      dt-bindings: soc: starfive: Add starfive,jh7110-vout-syscon
      dt-bindings: display: verisilicon: Add starfive,jh7110-dc8200
      dt-bindings: soc: starfive: Add starfive,jh7110-vout-subsystem
      drm/bridge: inno-hdmi: Split probe out of bind
      drm/bridge: inno-hdmi: Allow the register map to come from a parent
      drm/bridge: inno-hdmi: Add .disable platform operation
      drm/bridge: inno-hdmi: Add .mode_valid platform operation
      drm/bridge: inno-hdmi: Make the PHY configuration table optional
      drm/bridge: inno-hdmi: Make the register clock source selectable
      soc: starfive: Add jh7110-hdmi-subsystem driver
      soc: starfive: Add jh7110-vout-subsystem driver
      drm/bridge: starfive: Add JH7110 HDMI controller driver
      riscv: dts: starfive: jh7110: Update DT for display subsystem
      MAINTAINERS: Add StarFive JH7110 display subsystem entry

 .../starfive,jh7110-inno-hdmi-controller.yaml      | 121 +++++++++
 .../bindings/display/verisilicon,dc.yaml           |   1 +
 .../starfive/starfive,jh7110-hdmi-subsystem.yaml   |  95 +++++++
 .../soc/starfive/starfive,jh7110-syscon.yaml       |   1 +
 .../starfive/starfive,jh7110-vout-subsystem.yaml   | 218 +++++++++++++++
 MAINTAINERS                                        |  11 +
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    | 121 ++++++++-
 arch/riscv/boot/dts/starfive/jh7110.dtsi           | 105 ++++++--
 drivers/gpu/drm/bridge/Kconfig                     |  11 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/inno-hdmi.c                 | 118 ++++++--
 drivers/gpu/drm/bridge/jh7110-inno-hdmi.c          | 296 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c      |   2 +-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/starfive/Kconfig                       |  42 +++
 drivers/soc/starfive/Makefile                      |   3 +
 drivers/soc/starfive/jh7110-hdmi-subsystem.c       |  72 +++++
 drivers/soc/starfive/jh7110-vout-subsystem.c       |  82 ++++++
 include/drm/bridge/inno_hdmi.h                     |  14 +-
 20 files changed, 1269 insertions(+), 47 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20251031-jh7110-clean-send-7d2242118026
prerequisite-change-id: 20261028-jh7110-inno-hdmi-phy-83e5cfa643e3:v6
prerequisite-patch-id: d0734cca85ae4192ed921fb1a0b9e4bdb4e9ae6a
prerequisite-patch-id: 7ffec3af58389aa090d5a9947889060dd5493138
prerequisite-patch-id: 4a3488cc151ae0e9ef053ea67e8e520520c7df15
prerequisite-patch-id: 37de8eb6867db62f75e39908a136684a1cc14743
prerequisite-patch-id: 27aeff98d5c0b0bdb3eb9e9bbc2bf5e982864774
prerequisite-patch-id: f0e814166bef9f12a11c54de07203b17bd97a027

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

