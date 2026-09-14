Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FCFC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDBBB10EA1D;
	Mon, 14 Sep 2026 21:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="r6dkOUFA";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB8A10EA1D
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 21:48:12 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260914214810euoutp014ff49e2223f4f8180019e91812fcef1f~VTkYr5QQQ2280222802euoutp01a;
 Mon, 14 Sep 2026 21:48:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260914214810euoutp014ff49e2223f4f8180019e91812fcef1f~VTkYr5QQQ2280222802euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789422490;
 bh=8TZkNginDFdnLOsvcdP/UiXA2NQy9Wjc4iv1hpjrasw=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=r6dkOUFApQ564cxrtN6rYxMjd083iQt0SKXIDHMTQyQ0Mhmm64sSk4IoJORV1eqDM
 QYXEUTE7eiweJHOaotoScvkRvvVhhyccmhjrLm6mWzskoNeiwiCS487fkuQf3uSB2x
 plKJ9L78cQ7/WjdWCkYYu5h6jd0G1h5vmx8OTtAA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260914214809eucas1p1f9f9e91cd4f4d15fbe6b7489db12b126~VTkXpQxDx0077300773eucas1p1l;
 Mon, 14 Sep 2026 21:48:09 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260914214806eusmtip22f86fc473aa0bd24e8d3cad7225a6972~VTkVfsV9Z2978529785eusmtip2x;
 Mon, 14 Sep 2026 21:48:06 +0000 (GMT)
Message-ID: <b4c80c88-9235-4ad0-bc23-53dddddfadb3@samsung.com>
Date: Mon, 14 Sep 2026 23:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/19] drm/bridge: starfive: Add JH7110 HDMI
 controller driver
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Lee Jones <lee@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, Hal
 Feng <hal.feng@starfivetech.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney@redhat.com>, Heiko Stuebner <heiko@sntech.de>, Conor Dooley
 <conor@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Dominique Belhachemi <db@domibel.de>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mfd@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <15741677-7f2c-4190-b77f-a496643593c6@rock-chips.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260914214809eucas1p1f9f9e91cd4f4d15fbe6b7489db12b126
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260904132735eucas1p2c898afe4a4c6e957a7b9eedff321a6dc
X-EPHeader: CA
X-CMS-RootMailID: 20260904132735eucas1p2c898afe4a4c6e957a7b9eedff321a6dc
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132735eucas1p2c898afe4a4c6e957a7b9eedff321a6dc@eucas1p2.samsung.com>
 <20260904-jh7110-clean-send-v3-14-484f9ae72715@samsung.com>
 <15741677-7f2c-4190-b77f-a496643593c6@rock-chips.com>
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



On 9/7/26 05:51, Chaoyi Chen wrote:
> Hello Michal,
> 
> On 9/4/2026 9:27 PM, Michal Wilczynski wrote:
>> Add the HDMI controller (bridge) driver for the StarFive JH7110.
>>
>> This driver binds to the starfive,jh7110-inno-hdmi-controller node.
>> It gets its shared regmap from its parent and its register access,
>> module and bus clocks from voutcrg. It consumes the pixel clock and the
>> PHY from its hdmi_phy sibling.
>>
>> The driver calls the generic inno_hdmi_probe function and passes the
>> shared regmap to it, registering as a DRM bridge. The .enable hook is
>> responsible for setting the PHY's pixel clock rate via clk_set_rate()
>> and powering on the PHY via phy_power_on().
>>
>> The DC8200 has two panels, each exposing a DP and a DPI interface, and a
>> mux in the video output system controller picks which of them drives the
>> HDMI transmitter. Program that mux from the port graph rather than
>> relying on whatever the bootloader left behind, taking the panel from the
>> remote port number and the interface from the remote endpoint number.
>>
>> The generic driver holds the clock it looks up as the register access
>> clock enabled for its lifetime, and derives the DDC divider from that
>> clock's rate, so point it at the system clock. Naming the pixel clock
>> there instead would keep the PHY pre-PLL powered from probe onwards and
>> size the divider from the wrong rate.
>>
>> The PHY can only generate the discrete set of pixel clocks described by
>> its pre-PLL table, so .mode_valid rejects any mode clk_round_rate()
>> cannot satisfy. Without it such a mode would be advertised to userspace
>> and the modeset would appear to succeed while the display stayed blank.
>>
>> .enable returns early when the rate is unsupported or the PHY fails to
>> power on, so track whether the pixel clock was actually enabled and let
>> .disable tear down only what was brought up, otherwise the clock
>> refcount underflows.
>>
>> The clocks and the reset are torn down through devm rather than from
>> .remove, so that they outlive the bridge that inno_hdmi_probe() adds with
>> devm_drm_bridge_add(). Releasing them in .remove runs before devres
>> unwinds and would leave the bridge registered with its clocks already
>> gated.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  drivers/gpu/drm/bridge/Kconfig            |  11 ++
>>  drivers/gpu/drm/bridge/Makefile           |   1 +
>>  drivers/gpu/drm/bridge/jh7110-inno-hdmi.c | 318 ++++++++++++++++++++++++++++++
>>  3 files changed, 330 insertions(+)
>>

[snip]

>> +static enum drm_mode_status
>> +inno_hdmi_starfive_mode_valid(struct device *dev,
>> +			      const struct drm_display_mode *mode)
>> +{
>> +	struct stf_inno_hdmi_controller *ctrl = dev_get_drvdata(dev);
>> +	unsigned long pixelclk = mode->clock * 1000;
>> +	long rounded;
>> +
>> +	/*
>> +	 * The PHY can only generate the discrete set of pixel clocks described
>> +	 * by its pre-PLL table, and clk_round_rate() fails for anything else.
>> +	 * Reject those modes here: without this the modeset would appear to
>> +	 * succeed while the PHY never produces a signal.
>> +	 */
>> +	rounded = clk_round_rate(ctrl->clks[CLK_PCLK].clk, pixelclk);
>> +	if (rounded < 0 || rounded != pixelclk)
>> +		return MODE_NOCLOCK;
>> +
> 
> Using "if (rounded != pixelclk)" would be ok.

Thanks will fix.

> 
>> +	return MODE_OK;
>> +}
>> +

[snip]

>> +/*
>> + * The DC8200 has two panels, each exposing a DP and a DPI interface, and a mux
>> + * in dom_vout_syscon picks which of them drives the HDMI transmitter. Derive
>> + * the mux setting from the port graph: the remote port number selects the
>> + * DC8200 panel, and the remote endpoint number the interface on that panel
>> + * (0 for DPI, 1 for DP). Both drive 8-bit RGB, the only format this driver
>> + * currently produces.
>> + */
>> +static int stf_inno_hdmi_setup_mux(struct device *dev)
>> +{
>> +	struct device_node *ep, *remote;
> 
> Using "struct device_node *ep __free(device_node)" can help you simplify
> the processing of resource release.
> 

Sure, thanks !

> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

