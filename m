Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1239CC624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 05:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A93110E5A5;
	Sat,  5 Sep 2026 05:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=murena.io header.i=@murena.io header.b="e09BHDAH";
	dkim-atps=neutral
Received: from mail2.ecloud.global (mail2.ecloud.global [135.181.6.248])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7526E10E1D4
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 05:21:42 +0000 (UTC)
Received: from authenticated-user (mail2.ecloud.global [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail2.ecloud.global (Postfix) with ESMTPSA id B8626721285;
 Sat,  5 Sep 2026 05:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail2;
 t=1788585699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCOIseHcTnUxxa8UzPwtOfVQnt/pNmZAJdUPIg+XLqo=;
 b=e09BHDAHB8rW8CJ877ybXQO9BIhYTyEJyZ1UfCDGFBXGQp83jw90VJvx43GTmCwSaQjzmZ
 vZpB35WoTlow0wOgePmLAALvOVX4UDG1WLETkdYfE0Yms42sgAvS1PemSzA2A12krn4rTT
 1cf3fVX7lS+xZMHPIc92+QnIa3PDUgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
 s=mail2; t=1788585699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCOIseHcTnUxxa8UzPwtOfVQnt/pNmZAJdUPIg+XLqo=;
 b=jP8u0+6IUTg6AgiXIbTGUEcfBSMqo7Nmd7Jr3DYd3CWjZY43q91uDjoMKSmOPb7C2g5uaR
 iIEJS2tWhm2RJi0GFGMGg4N9fF1QxzfQ74UijbJC18veoZSi49xvXSRP1T4Cl2WVqw+irA
 xNMCko+5QoxwijbilgirxAp71w2JUOQ=
ARC-Authentication-Results: i=1; mail2.ecloud.global;
 auth=pass smtp.mailfrom=maud_spierings@murena.io
ARC-Seal: i=1; s=mail2; d=murena.io; t=1788585699; a=rsa-sha256; cv=none;
 b=Ky3gcQbu+iQn3gGJSjO38x37++V52aS5N/nQCOx3J6XxPIqfFy1ZbkijYRzWOWiFT+pVmT
 7YFhfuIVisKc3ETR/8jHzo+pemFPQ34KVfBmoujMt5BFDBSdKw+v6R/9q4pnc6yOtpxUSR
 njWiXCniQ4hrwKE4/mkGqbMrN0fifdM=
Message-ID: <ea529e06-2eab-4e3b-92af-ba17de44091c@murena.io>
Date: Sat, 5 Sep 2026 07:21:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/19] drm: starfive: jh7110: Enable display subsystem
To: Michal Wilczynski <m.wilczynski@samsung.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Lee Jones <lee@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Dominique Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mfd@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Graham Markall <hello@big-grey.co.uk>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
References: <CGME20260904132708eucas1p1adfa26ef0fe5109eca63a3aeadf74915@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
Content-Language: en-US
From: Maud Spierings <maud_spierings@murena.io>
In-Reply-To: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Michal,

This new version added some more issues on my fml13v01 board, this time 
2 registers in the VOUT_CRG are misconfigured that were correct in v2, 
namely:

0x295c0004 was 0x00000004 on the previous version but is now 0x00000006
0x295c001c was 0x81000000 on the previous version but is now 0x80000000

xx04 sets a slightly different clock divider, but it doesn't seem to 
matter, display also works with this changed value.

xx1c seems to select the wrong clock mux?

After correcting 0x295c001c (and the ones that I mentioned before in the 
hdmitx block), the display comes to life again.

Not sure why these are changed.

Besides that it works great!

Kind regards,
Maud

On 9/4/26 15:27, Michal Wilczynski wrote:
> This series enables the display subsystem on the StarFive JH7110.
> 
> The dom_vout block holds the display controller (dc8200), the clock
> generator (voutcrg) and the HDMI IP, all inside PD_VOUT. The HDMI IP is
> a single register block containing both the controller and the PHY, and
> it has a circular clock dependency with voutcrg:
> 
>    - the HDMI controller needs pclk/mclk/bclk from voutcrg
>    - voutcrg needs the pixel clock for its dc8200 pixel MUXes, and that
>      clock is generated by the HDMI PHY
> 
> The loop only exists if the HDMI block is treated as one device. The
> PHY's reference clock is xin24m, not a voutcrg output, so splitting the
> node into a parent plus phy and controller children gives deferred probe
> a linear order: hdmi-phy, then voutcrg, then hdmi-controller.
> 
> The parent maps the register block and owns the regmap its two children
> share. Everything in the region sits behind one NoC port whose clock and
> reset gate access to it, inside PD_VOUT, so the vout subsystem node from
> the RFC is back and owns those for as long as any child exists.
> 
> Patch 10 adds a .mode_valid platform op to inno-hdmi.
> inno_hdmi_bridge_mode_valid() checks the pixel clock against
> hdmi->refclk, but that clock only exists where a "ref" clock is
> described. The JH7110 gets its pixel clock from the PHY, so refclk is
> NULL and the check was skipped: unsupported modes were advertised, the
> modeset then "succeeded" because the atomic enable path cannot fail, and
> the display stayed blank.
> 
> Patches 15-17 drop the PHY duplication from the RFC. The JH7110 has the
> same Innosilicon PHY as the RK3328, offset by 0x100 because it sits
> behind the controller in the shared register block. Patch 15 factors out
> the pre-PLL config format, table lookup, determine_rate, recalc_rate and
> the pre-PLL programming; patch 16 moves Rockchip onto it; patch 17 adds
> the JH7110 driver. Pixel clock tables, post-PLL and analog config stay
> SoC specific.
> 
> Patch 16 should be a no-op for Rockchip - same writes, same order, same
> values - and RK3228, whose pre-PLL is at different addresses, keeps its
> own register code and shares only the lookup. I have no Rockchip
> hardware, so it is build tested only (arm and riscv). A Tested-by would
> help.
> 
> The dc8200 driver, th1520 reset controller and inno-hdmi bridge that the
> RFC listed as prerequisites are all upstream now, so there are no
> out-of-tree dependencies.
> 
> Testing
> =======
> 
> Tested on a VisionFive 2 v1.3B using modetest.
> 
> All 42 modes the sink advertises work, with nothing in dmesg. Pixel
> clocks run from 25.175 MHz (640x480@59.94) up to 297 MHz
> (4096x2160@30), including 3840x2160 and the full 1920x1080 and 1280x720
> rate families.
> 
> The four modes the RFC reported as broken work now too: 2560x1440@59.95,
> 2048x1080@60.00, 2048x1080@24.00 and 720x400@70.08.
> 
> Before patch 10, four of the advertised modes failed: 1680x1050@59.95
> (146.250 MHz), 1400x1050@59.98 (121.750), 1152x864@59.97 (81.768) and
> 1280x768@60.35 (80.140). Those pixel clocks are not in the PHY pre-PLL
> table, so clk_set_rate() returned -EINVAL and the screen stayed black
> while userspace saw a successful modeset. They are rejected in
> .mode_valid now; the other refresh rates of those resolutions still work.
> 
> Every commit builds for riscv, and the Rockchip PHY also for arm.
> 
> Notes
> =====
> 
> The JH7110 has no central MAINTAINERS entry and maintainership is
> fragmented, so patch 19 adds one for the display subsystem and I am
> happy to help maintain it. The new PHY library lives under drivers/phy/,
> already covered by the generic PHY framework entry.
> 
> checkpatch warns "does MAINTAINERS need updating?" on the patches adding
> files, because that entry comes in patch 19.
> 
> Thanks to Icenowy Zheng for the dc8200 driver and for explaining how the
> SoC and the display pipeline fit together.
> 
> Thanks also to Dominique Belhachemi, who got rid of the vout-subsystem
> wrapper and helped with the testing, to Maud Spierings for testing on a
> Framework 13 panel, and to Graham Markall for testing
> the JH7110 display patches independently and writing up the results:
> https://big-grey.co.uk/2026/01/26/testing-starfive-jh7110-display-controller-patches/
> 
