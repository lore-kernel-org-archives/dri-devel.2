Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7E4C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB26810F247;
	Mon, 14 Sep 2026 21:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="rUuWsUYY";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418A610F247
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 21:02:25 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260914210223euoutp0232f0813c7657236ff92e65a4f265b42c~VS8afgsQQ2818028180euoutp02V;
 Mon, 14 Sep 2026 21:02:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260914210223euoutp0232f0813c7657236ff92e65a4f265b42c~VS8afgsQQ2818028180euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789419743;
 bh=JH7rxlQZ0+nRwrQxylBU7gkca4+zlyVrnpLiQJx/SLY=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=rUuWsUYYKAojChsYja+6EWNcL3qZVqZ74VO/OCeiK0hiMLACAh/M0UmD0XSAxCoHG
 vSk4ivL+UidbpjFeDgdzT/RJTrutLygyep0taUKbTv7kkeL/mZ4tQaw3nSg72hvI4X
 b5HtClGVkvgjAGxjh4kyW31zAJs+/N2OOGl4BUZc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260914210222eucas1p278d9f9996cf56dd8c531811edd3c5c82~VS8aCtH-63167031670eucas1p2k;
 Mon, 14 Sep 2026 21:02:22 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260914210220eusmtip22564f1bf2f1e653328b6ed505c100cc9~VS8YOBrF41559115591eusmtip2b;
 Mon, 14 Sep 2026 21:02:20 +0000 (GMT)
Message-ID: <071901ef-57f3-456f-af5b-a8c99a0a7dd3@samsung.com>
Date: Mon, 14 Sep 2026 23:02:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] drm: starfive: jh7110: Enable display subsystem
To: Joshua Peisach <jpeisach@ubuntu.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Emil
 Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Heiko Stuebner
 <heiko@sntech.de>, Conor Dooley <conor@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mfd@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <DL6MO1P17KSW.1DKQ6HW2U2ZCK@ubuntu.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260914210222eucas1p278d9f9996cf56dd8c531811edd3c5c82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260904132708eucas1p1adfa26ef0fe5109eca63a3aeadf74915
X-EPHeader: CA
X-CMS-RootMailID: 20260904132708eucas1p1adfa26ef0fe5109eca63a3aeadf74915
References: <CGME20260904132708eucas1p1adfa26ef0fe5109eca63a3aeadf74915@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <DL6MO1P17KSW.1DKQ6HW2U2ZCK@ubuntu.com>
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



On 9/4/26 17:13, Joshua Peisach wrote:
> On Fri Sep 4, 2026 at 9:27 AM EDT, Michal Wilczynski wrote:
>> This series enables the display subsystem on the StarFive JH7110.
>>
>> The dom_vout block holds the display controller (dc8200), the clock
>> generator (voutcrg) and the HDMI IP, all inside PD_VOUT. The HDMI IP is
>> a single register block containing both the controller and the PHY, and
>> it has a circular clock dependency with voutcrg:
>>
>>   - the HDMI controller needs pclk/mclk/bclk from voutcrg
>>   - voutcrg needs the pixel clock for its dc8200 pixel MUXes, and that
>>     clock is generated by the HDMI PHY
>>
>> The loop only exists if the HDMI block is treated as one device. The
>> PHY's reference clock is xin24m, not a voutcrg output, so splitting the
>> node into a parent plus phy and controller children gives deferred probe
>> a linear order: hdmi-phy, then voutcrg, then hdmi-controller.
>>
>> The parent maps the register block and owns the regmap its two children
>> share. Everything in the region sits behind one NoC port whose clock and
>> reset gate access to it, inside PD_VOUT, so the vout subsystem node from
>> the RFC is back and owns those for as long as any child exists.
>>
>> Patch 10 adds a .mode_valid platform op to inno-hdmi.
>> inno_hdmi_bridge_mode_valid() checks the pixel clock against
>> hdmi->refclk, but that clock only exists where a "ref" clock is
>> described. The JH7110 gets its pixel clock from the PHY, so refclk is
>> NULL and the check was skipped: unsupported modes were advertised, the
>> modeset then "succeeded" because the atomic enable path cannot fail, and
>> the display stayed blank.
>>
>> Patches 15-17 drop the PHY duplication from the RFC. The JH7110 has the
>> same Innosilicon PHY as the RK3328, offset by 0x100 because it sits
>> behind the controller in the shared register block. Patch 15 factors out
>> the pre-PLL config format, table lookup, determine_rate, recalc_rate and
>> the pre-PLL programming; patch 16 moves Rockchip onto it; patch 17 adds
>> the JH7110 driver. Pixel clock tables, post-PLL and analog config stay
>> SoC specific.
>>
>> Patch 16 should be a no-op for Rockchip - same writes, same order, same
>> values - and RK3228, whose pre-PLL is at different addresses, keeps its
>> own register code and shares only the lookup. I have no Rockchip
>> hardware, so it is build tested only (arm and riscv). A Tested-by would
>> help.
>>
>> The dc8200 driver, th1520 reset controller and inno-hdmi bridge that the
>> RFC listed as prerequisites are all upstream now, so there are no
>> out-of-tree dependencies.
>>
>> Testing
>> =======
>>
>> Tested on a VisionFive 2 v1.3B using modetest.
>>
>> All 42 modes the sink advertises work, with nothing in dmesg. Pixel
>> clocks run from 25.175 MHz (640x480@59.94) up to 297 MHz
>> (4096x2160@30), including 3840x2160 and the full 1920x1080 and 1280x720
>> rate families.
>>
>> The four modes the RFC reported as broken work now too: 2560x1440@59.95,
>> 2048x1080@60.00, 2048x1080@24.00 and 720x400@70.08.
>>
>> Before patch 10, four of the advertised modes failed: 1680x1050@59.95
>> (146.250 MHz), 1400x1050@59.98 (121.750), 1152x864@59.97 (81.768) and
>> 1280x768@60.35 (80.140). Those pixel clocks are not in the PHY pre-PLL
>> table, so clk_set_rate() returned -EINVAL and the screen stayed black
>> while userspace saw a successful modeset. They are rejected in
>> .mode_valid now; the other refresh rates of those resolutions still work.
>>
>> Every commit builds for riscv, and the Rockchip PHY also for arm.
>>
>> Notes
>> =====
>>
>> The JH7110 has no central MAINTAINERS entry and maintainership is
>> fragmented, so patch 19 adds one for the display subsystem and I am
>> happy to help maintain it. The new PHY library lives under drivers/phy/,
>> already covered by the generic PHY framework entry.
>>
>> checkpatch warns "does MAINTAINERS need updating?" on the patches adding
>> files, because that entry comes in patch 19.
>>
>> Thanks to Icenowy Zheng for the dc8200 driver and for explaining how the
>> SoC and the display pipeline fit together.
>>
>> Thanks also to Dominique Belhachemi, who got rid of the vout-subsystem
>> wrapper and helped with the testing, to Maud Spierings for testing on a
>> Framework 13 panel, and to Graham Markall for testing
>> the JH7110 display patches independently and writing up the results:
>> https://protect2.fireeye.com/v1/url?k=a5921a01-fa0e332b-a593914e-000babe598f7-ab8e6a05d613c342&q=1&e=c355ba5a-20ba-4b45-870e-7415c4405787&u=https%3A%2F%2Fbig-grey.co.uk%2F2026%2F01%2F26%2Ftesting-starfive-jh7110-display-controller-patches%2F
>>
>> Link to v1: https://lore.kernel.org/all/20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com/
>>
>> ---
>> Changes in v3:
>> - Brought back the vout subsystem node and driver, now owning the NoC
>>   bus clock, its reset and PD_VOUT for the whole region, with dc8200,
>>   the HDMI block, the syscon and voutcrg as its children (Icenowy Zheng).
>> - Fixed a hard hang when the bridge is built as a module: the PHY's
>>   .is_prepared read a register in the window gated by the controller's
>>   system clock, so clk_disable_unused() wedged the CPU before the
>>   controller had bound. The op is gone; the framework uses the software
>>   prepare count instead. (Marek Szyprowski)
>> - The HDMI controller now programs the display mux in dom_vout_syscon
>>   from the port graph rather than inheriting whatever the bootloader
>>   left, with a phandle to the syscon (Icenowy Zheng).
>> - The register access clock is named "pclk" to match the existing
>>   inno-hdmi binding, so the generic driver no longer picks up the pixel
>>   clock. Previously it held the pre-PLL powered from probe and sized the
>>   DDC divider from the wrong rate.
>> - Dropped the clk suffixes and the single-entry -names properties from
>>   the bindings (Conor Dooley). mclk and bclk keep their names: per TRM
>>   5.3 they are the HDMI audio clocks, not module and bus clocks, so the
>>   descriptions say that instead.
>> - Replaced patternProperties with plain properties in the hdmi-subsystem
>>   binding (Conor Dooley).
>> - dc8200 gets an SoC specific compatible, and inherits dma-noncoherent
>>   from the subsystem bus node, so it validates against verisilicon,dc.
>> - Added the pre-PLL entry for the Framework 13 panel and fixed two
>>   devicetree whitespace nits (Maud Spierings).
>> - select REGMAP_MMIO, CLK_SET_RATE_NO_REPARENT on the dc8200 pixel MUXes
>>   so clk_set_rate() cannot reroute them, and inno-hdmi register reads
>>   return 0 instead of stack garbage when regmap_read() fails.
>> - phy: rockchip: dropped the local pre-PLL lookup wrapper and the 28 now
>>   unused RK3328 pre-PLL macros, and restored the VCO debug output, this
>>   time in the shared helper so both drivers get it (Jonas Karlman).
>> - Rebased onto v7.3-rc1.
>> - Link to v2: https://lore.kernel.org/r/20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com
>>
>> Changes since the RFC:
>> - Dropped the vout-subsystem wrapper driver and its binding, along with
>>   the patch relaxing the voutcrg binding; genpd handles PD_VOUT per
>>   node.
>> - Renamed the compatible to starfive,jh7110-hdmi-subsystem, dropping
>>   "mfd" as a Linux term (Conor Dooley).
>> - Absolute $refs in the bindings, unused example labels dropped, and the
>>   examples deduplicated between parent and children (Conor Dooley).
>> - Added the .mode_valid platform operation (patch 7).
>> - Split the inno-hdmi rework into a mechanical probe/bind split (patch
>>   4)
>>   and the regmap-from-parent change (patch 5). struct inno_hdmi is no
>>   longer exported; no platform glue dereferences it.
>> - Replaced the duplicated PHY driver with a shared Innosilicon library
>>   and moved Rockchip onto it (patches 11-13).
>> - Fixed pre-PLL lock detection, which masked the status read with the
>>   register address instead of the lock bit.
>> - Fixed a pixel clock refcount underflow: enable returns early on
>>   failure while disable tore down unconditionally.
>> - voutcrg patch reduced to adding CLK_SET_RATE_PARENT to the two dc8200
>>   pixel MUXes.
>> - Rebased onto v7.2.
>>
>> ---
>> Michal Wilczynski (19):
>>       dt-bindings: phy: Add starfive,jh7110-inno-hdmi-phy
>>       dt-bindings: display: bridge: Add starfive,jh7110-inno-hdmi-controller
>>       dt-bindings: mfd: Add starfive,jh7110-hdmi-subsystem
>>       dt-bindings: soc: starfive: Add starfive,jh7110-vout-syscon
>>       dt-bindings: soc: starfive: Add starfive,jh7110-vout-subsystem
>>       dt-bindings: display: verisilicon: Add starfive,jh7110-dc8200
>>       drm/bridge: inno-hdmi: Split probe out of bind
>>       drm/bridge: inno-hdmi: Allow the register map to come from a parent
>>       drm/bridge: inno-hdmi: Add .disable platform operation
>>       drm/bridge: inno-hdmi: Add .mode_valid platform operation
>>       soc: starfive: Add jh7110-hdmi-subsystem driver
>>       soc: starfive: Add jh7110-vout-subsystem driver
>>       clk: starfive: jh7110-vout: Allow pixel clock rate propagation
>>       drm/bridge: starfive: Add JH7110 HDMI controller driver
>>       phy: Add common Innosilicon HDMI PHY helpers
>>       phy: rockchip: inno-hdmi: Use the common Innosilicon PHY helpers
>>       phy: starfive: Add jh7110-inno-hdmi-phy driver
>>       riscv: dts: starfive: jh7110: Update DT for display subsystem
>>       MAINTAINERS: Add StarFive JH7110 display subsystem entry
>>
>>  .../starfive,jh7110-inno-hdmi-controller.yaml      | 121 +++++
>>  .../bindings/display/verisilicon,dc.yaml           |   1 +
>>  .../mfd/starfive,jh7110-hdmi-subsystem.yaml        |  95 ++++
>>  .../phy/starfive,jh7110-inno-hdmi-phy.yaml         |  49 ++
>>  .../soc/starfive/starfive,jh7110-syscon.yaml       |   6 +
>>  .../starfive/starfive,jh7110-vout-subsystem.yaml   | 100 ++++
>>  MAINTAINERS                                        |  13 +
>>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi    | 121 ++++-
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi           | 102 +++-
>>  drivers/clk/starfive/clk-starfive-jh7110-vout.c    |   6 +-
>>  drivers/gpu/drm/bridge/Kconfig                     |  11 +
>>  drivers/gpu/drm/bridge/Makefile                    |   1 +
>>  drivers/gpu/drm/bridge/inno-hdmi.c                 |  84 ++-
>>  drivers/gpu/drm/bridge/jh7110-inno-hdmi.c          | 318 +++++++++++
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-inno-hdmi.c                        | 298 +++++++++++
>>  drivers/phy/rockchip/Kconfig                       |   1 +
>>  drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      | 165 +-----
>>  drivers/phy/starfive/Kconfig                       |  20 +
>>  drivers/phy/starfive/Makefile                      |   1 +
>>  drivers/phy/starfive/phy-jh7110-inno-hdmi.c        | 579 +++++++++++++++++++++
>>  drivers/soc/Kconfig                                |   1 +
>>  drivers/soc/Makefile                               |   1 +
>>  drivers/soc/starfive/Kconfig                       |  43 ++
>>  drivers/soc/starfive/Makefile                      |   3 +
>>  drivers/soc/starfive/jh7110-hdmi-subsystem.c       |  74 +++
>>  drivers/soc/starfive/jh7110-vout-subsystem.c       |  83 +++
>>  include/drm/bridge/inno_hdmi.h                     |  10 +-
>>  include/linux/phy/inno-hdmi-phy.h                  |  85 +++
>>  30 files changed, 2227 insertions(+), 174 deletions(-)
>> ---
>> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
>> change-id: 20251031-jh7110-clean-send-7d2242118026
>>
>> Best regards,
> 
> So as a kernel newbie, and someone who happens to have this device,
> it's nice to see it here.
> 
> It looks good to me, just a few questions:
> 
> - One patch mentioned in a comment "the docs" - is there documentation
> for the device?

TRM describing the hardware. It's available online [1].

[1] - https://doc-en.rvspace.org/JH7110/TRM/

> 
> - There are multiple pieces, like the hdmi and vout subsystem, and also
> the inno helpers. Should those be separate patches? I honestly don't
> have enough experience (or authority) to suggest doing so.

They already are: the hdmi subsystem is patch 11, the vout subsystem
patch 12 and the Innosilicon helpers patch 15. They go out as one
series because they depend on each other - the DT in patch 18 needs all
three drivers - and the tree has to build at every commit, so they
cannot land separately.


> 
> 
> I thought this would be great as a possible driver I could do to learn
> kernel dev.. looks like I was very wrong. Great work, and hopefully
> in the future I get my hands on some device that needs a driver to be
> written for it.
> 
> I'm at university, once my board gets mailed from home I'll be able to
> test. For now,

Thanks for the review, I have picked up your Reviewed-by on the patches
that did not change in v4. A Tested-by once your board arrives would be
very welcome.


> 
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
