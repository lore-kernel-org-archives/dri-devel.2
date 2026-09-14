Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A1CC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C29910EF21;
	Mon, 14 Sep 2026 15:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="GDO61VSO";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C6B10EF05
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:47:14 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260914154712euoutp02c5051cd29f404323cd1ce4ebcf1a2814~VOpOJJKAf2060820608euoutp02_;
 Mon, 14 Sep 2026 15:47:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260914154712euoutp02c5051cd29f404323cd1ce4ebcf1a2814~VOpOJJKAf2060820608euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789400832;
 bh=tG6YbD+cncbaU7j7yoO6MEtQ744hWAYh4LfOY6utBYg=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=GDO61VSOCVO3k1kf5K78UUt2+RmSvMQDujkUqqiRwIRQp54H3XA3u6HAxA1Bzo9g/
 tCvyeIbekxEClZFD369Hz0B8bRlNt3ZyQYNKC/wf2QdhH9jD28ZIA21IDZJCW8YtoX
 k3/tT/pItRCsYTnCqKU6miJvFJQAcAS4lM6izfts=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260914154711eucas1p1a9c438d50d10b5aa67be8d91d3c6bd8b~VOpNwZ4qm0255102551eucas1p1I;
 Mon, 14 Sep 2026 15:47:11 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260914154709eusmtip1d1d42067dc0186ff40e0a824dfe3578c~VOpL4YvZE0990509905eusmtip17;
 Mon, 14 Sep 2026 15:47:09 +0000 (GMT)
Message-ID: <03a707e8-9382-4d48-9bdc-08fbd0131587@samsung.com>
Date: Mon, 14 Sep 2026 17:47:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/19] drm/bridge: starfive: Add JH7110 HDMI
 controller driver
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Vinod Koul <vkoul@kernel.org>,
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
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <b9973f9817dc023bb703cc14628fbb5ccca27d33.camel@iscas.ac.cn>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260914154711eucas1p1a9c438d50d10b5aa67be8d91d3c6bd8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260904132735eucas1p2c898afe4a4c6e957a7b9eedff321a6dc
X-EPHeader: CA
X-CMS-RootMailID: 20260904132735eucas1p2c898afe4a4c6e957a7b9eedff321a6dc
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132735eucas1p2c898afe4a4c6e957a7b9eedff321a6dc@eucas1p2.samsung.com>
 <20260904-jh7110-clean-send-v3-14-484f9ae72715@samsung.com>
 <b9973f9817dc023bb703cc14628fbb5ccca27d33.camel@iscas.ac.cn>
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



On 9/4/26 15:39, Icenowy Zheng wrote:
> 在 2026-09-04五的 15:27 +0200，Michal Wilczynski写道：
>> Add the HDMI controller (bridge) driver for the StarFive JH7110.
>>
>> This driver binds to the starfive,jh7110-inno-hdmi-controller node.
>> It gets its shared regmap from its parent and its register access,
>> module and bus clocks from voutcrg. It consumes the pixel clock and
>> the
>> PHY from its hdmi_phy sibling.
>>
>> The driver calls the generic inno_hdmi_probe function and passes the
>> shared regmap to it, registering as a DRM bridge. The .enable hook is
>> responsible for setting the PHY's pixel clock rate via clk_set_rate()
>> and powering on the PHY via phy_power_on().
>>
>> The DC8200 has two panels, each exposing a DP and a DPI interface,
>> and a
>> mux in the video output system controller picks which of them drives
>> the
>> HDMI transmitter. Program that mux from the port graph rather than
>> relying on whatever the bootloader left behind, taking the panel from
>> the
>> remote port number and the interface from the remote endpoint number.
>>
>> The generic driver holds the clock it looks up as the register access
>> clock enabled for its lifetime, and derives the DDC divider from that
>> clock's rate, so point it at the system clock. Naming the pixel clock
>> there instead would keep the PHY pre-PLL powered from probe onwards
>> and
>> size the divider from the wrong rate.
>>
>> The PHY can only generate the discrete set of pixel clocks described
>> by
>> its pre-PLL table, so .mode_valid rejects any mode clk_round_rate()
>> cannot satisfy. Without it such a mode would be advertised to
>> userspace
>> and the modeset would appear to succeed while the display stayed
>> blank.
>>
>> .enable returns early when the rate is unsupported or the PHY fails
>> to
>> power on, so track whether the pixel clock was actually enabled and
>> let
>> .disable tear down only what was brought up, otherwise the clock
>> refcount underflows.
>>
>> The clocks and the reset are torn down through devm rather than from
>> .remove, so that they outlive the bridge that inno_hdmi_probe() adds
>> with
>> devm_drm_bridge_add(). Releasing them in .remove runs before devres
>> unwinds and would leave the bridge registered with its clocks already
>> gated.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  drivers/gpu/drm/bridge/Kconfig            |  11 ++
>>  drivers/gpu/drm/bridge/Makefile           |   1 +
>>  drivers/gpu/drm/bridge/jh7110-inno-hdmi.c | 318
>> ++++++++++++++++++++++++++++++
>>  3 files changed, 330 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/Kconfig
>> b/drivers/gpu/drm/bridge/Kconfig
>> index
>> 4a57d49b4c6d3ab4b965228835b372d191647197..75b1cf6727d5a32310dcf9fe573
>> 4d95e14eea8fe 100644
>> --- a/drivers/gpu/drm/bridge/Kconfig
>> +++ b/drivers/gpu/drm/bridge/Kconfig

[snip]

>> +
>> +	/* Data mapping: 8-bit RGB on whichever interface is in use.
>> */
>> +	mask = VOUT_HDMI_DPI_DP_SEL | VOUT_HDMI_DP_BIT_DEPTH |
>> +	       VOUT_HDMI_DP_YUV_MODE | VOUT_HDMI_DPI_BIT_DEPTH;
>> +	val = FIELD_PREP(VOUT_HDMI_DPI_DP_SEL, endpoint.id) |
>> +	      FIELD_PREP(VOUT_HDMI_DP_YUV_MODE,
>> VOUT_HDMI_DP_YUV_MODE_RGB) |
>> +	      FIELD_PREP(VOUT_HDMI_DPI_BIT_DEPTH,
>> VOUT_HDMI_DPI_BIT_DEPTH_8BIT);
> 
> Well it looks like the vendor driver never sets DP interface, is it
> tested? I doubt whether the SoC designer messed it up.

The DP interface is documented in the TRM and I've also tested it so it
does work indeed. Here is my test branch if you would like to see for
youself.

[1] - https://github.com/mwilczy/linux/commit/7efcba3b0be30734087c79f5773cae19245924db


[snip]

> 
>> +}
>> +
>> +/*
>> + * This table is now only used for the generic .mode_valid check.
>> + * The real validation happens in the PHY driver's .round_rate.
>> + */
>> +static struct inno_hdmi_phy_config stf_hdmi_phy_configs[] = {
>> +	{ 297000000, 0x00, 0x00 },
>> +	{ ~0UL, 0x00, 0x00 }, /* Sentinel */
>> +};
> 
> If it's just such a upper bound, why don't just override the function
> as a bound check?

Yeah actually patch 10 implements mode_valid callback, so it's better to
remove this stub altogether, previously this was done satisfy the probe
check reasons - v4 will add patch that makes this table optional in
inno-hdmi driver.

> 
> Or... should the real table be used here? I start to wonder whether
> this is related to Maud's failure on the Framework panel.

Maud panel needed another entry in PHY pre-PLL table. Patch 17 in v3
adds this entry.

There is a new issue reported by Maud, I will answer that in a separate
thread.

> 
> Thanks,
> Icenowy
> 
>> +
>> +static const struct inno_hdmi_plat_ops stf_inno_hdmi_plat_ops = {
>> +	.enable = inno_hdmi_starfive_enable,
>> +	.disable = inno_hdmi_starfive_disable,
>> +	.mode_valid = inno_hdmi_starfive_mode_valid,
>> +};
>> +
>> +static const struct inno_hdmi_plat_data stf_inno_hdmi_plat_data = {
>> +	.ops = &stf_inno_hdmi_plat_ops,
>> +	.phy_configs = stf_hdmi_phy_configs,
>> +	.default_phy_config = &stf_hdmi_phy_configs[0],
>> +};
>> +
>> +static const struct of_device_id starfive_hdmi_controller_dt_ids[] =
>> {
>> +	{ .compatible = "starfive,jh7110-inno-hdmi-controller",
>> +	  .data = &stf_inno_hdmi_plat_data },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, starfive_hdmi_controller_dt_ids);
>> +
>> +struct platform_driver starfive_inno_hdmi_controller_driver = {
>> +	.probe = starfive_inno_hdmi_controller_probe,
>> +	.driver = {
>> +		.name = "starfive-inno-hdmi-controller",
>> +		.of_match_table = starfive_hdmi_controller_dt_ids,
>> +	},
>> +};
>> +module_platform_driver(starfive_inno_hdmi_controller_driver);
>> +
>> +MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
>> +MODULE_DESCRIPTION("StarFive INNO HDMI Controller Driver");
>> +MODULE_LICENSE("GPL");
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
