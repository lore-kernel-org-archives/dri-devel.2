Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF6CCA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 16:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E183210E3BB;
	Sat,  3 Oct 2026 16:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="lsnwuG0R";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E0710E3BB
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 16:19:46 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261003161944euoutp015445fcbf6e0d4e3cb00b7533697c0e02~bEWDnwLC60335403354euoutp012;
 Sat,  3 Oct 2026 16:19:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261003161944euoutp015445fcbf6e0d4e3cb00b7533697c0e02~bEWDnwLC60335403354euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791044384;
 bh=1XaQcVeyhm8yfAFalkdFK1wk7N73U0zKdzj1RF8N3QE=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=lsnwuG0Rt3fGmtfGSOO65rhkC0IFUgrq1ANqgsQGtVreBctftYXQpGMAZgPzf+Ci0
 +kvHkS1AYixN1TDhKQn3VgurKD90DR9RBMHeFubIeyUtXTe1ckGdkeIPTPBfcYCdGk
 P4JjhZ41OygKkWPJO9Q1IpC/ICJqCNGZ8gN2VJqo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261003161943eucas1p2d4d85e066b9cedf34cbeaf481bf875db~bEWCnjmvZ2037620376eucas1p20;
 Sat,  3 Oct 2026 16:19:43 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261003161941eusmtip20b539371f409b63e666c140753664cb8~bEWBBnkRs2154121541eusmtip2G;
 Sat,  3 Oct 2026 16:19:41 +0000 (GMT)
Message-ID: <e1b83c15-1ca9-4575-97aa-f44552ecb182@samsung.com>
Date: Sat, 3 Oct 2026 18:19:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/21] drm/bridge: inno-hdmi: Split probe out of bind
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Vinod Koul
 <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Andy Yan <andy.yan@rock-chips.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Emil Renner Berthing
 <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>, Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <6535891.44csPzL39Z@diego>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261003161943eucas1p2d4d85e066b9cedf34cbeaf481bf875db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260929103221eucas1p264107850882dde96fcda4772332d4f41
X-EPHeader: CA
X-CMS-RootMailID: 20260929103221eucas1p264107850882dde96fcda4772332d4f41
References: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
 <CGME20260929103221eucas1p264107850882dde96fcda4772332d4f41@eucas1p2.samsung.com>
 <20260929-jh7110-clean-send-v5-8-82b4d8e3c6c7@samsung.com>
 <6535891.44csPzL39Z@diego>
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



On 9/30/26 12:02, Heiko Stübner wrote:
> Am Dienstag, 29. September 2026, 12:31:05 Mitteleuropäische Sommerzeit schrieb Michal Wilczynski:
>> inno_hdmi_bind() both sets up the bridge and attaches it to a DRM
>> encoder. A platform whose HDMI controller is a child of a larger device
>> needs the first half without the second, since it registers as its own
>> platform driver and lets the DRM core bind the bridge later.
>>
>> Move the setup into a new exported inno_hdmi_probe(), and reduce
>> inno_hdmi_bind() to a wrapper around it.
>>
>> No functional change intended.
>>
>> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  drivers/gpu/drm/bridge/inno-hdmi.c | 49 +++++++++++++++++++++++++++++++++-----
>>  include/drm/bridge/inno_hdmi.h     |  4 ++++
>>  2 files changed, 47 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
>> index d7c33b92e2ddf4ced84d17304463f44be52270b8..7a9f54dce2647f0320d77629a28154eade14385f 100644
>> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
>> @@ -929,7 +929,14 @@ static irqreturn_t inno_hdmi_irq(int irq, void *dev_id)
>>  {
>>  	struct inno_hdmi *hdmi = dev_id;
>>  
>> -	drm_helper_hpd_irq_event(hdmi->bridge.dev);
>> +	/*
>> +	 * The interrupt is requested in probe, but bridge.dev is only set once
>> +	 * the DRM master binds and attaches the bridge, which may never happen.
>> +	 * Drop hotplug events that arrive before then rather than dereference a
>> +	 * NULL drm_device.
>> +	 */
>> +	if (hdmi->bridge.dev)
>> +		drm_helper_hpd_irq_event(hdmi->bridge.dev);
> 
> This is not part of the commit description and while true, should likely
> be its own patch with its own description.


It only made sense with this patch, hence why it's included. Happy to
split it.

> 
> 
>>  
>>  	return IRQ_HANDLED;
>>  }
>> @@ -1061,11 +1068,24 @@ static struct i2c_adapter *inno_hdmi_i2c_adapter(struct inno_hdmi *hdmi)
>>  	return adap;
>>  }
>>  
>> -struct inno_hdmi *inno_hdmi_bind(struct device *dev,
>> -				 struct drm_encoder *encoder,
>> -				 const struct inno_hdmi_plat_data *plat_data)
>> +/**
>> + * inno_hdmi_probe - Internal helper to perform common setup
>> + * @pdev: platform device
>> + * @plat_data: SoC-specific platform data
>> + *
>> + * This function handles all the common hardware setup: allocating the main
>> + * struct, mapping registers, getting clocks, initializing the hardware,
>> + * setting up the IRQ, and initializing the DDC adapter and bridge struct.
>> + * It returns a pointer to the inno_hdmi struct on success, or an ERR_PTR
>> + * on failure.
>> + *
>> + * This function is used by modern, decoupled MFD/glue drivers. It registers
>> + * the bridge but does not attach it.
>> + */
>> +struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
>> +				  const struct inno_hdmi_plat_data *plat_data)
>>  {
>> -	struct platform_device *pdev = to_platform_device(dev);
>> +	struct device *dev = &pdev->dev;
>>  	struct inno_hdmi *hdmi;
>>  	int irq;
>>  	int ret;
>> @@ -1128,7 +1148,24 @@ struct inno_hdmi *inno_hdmi_bind(struct device *dev,
>>  	if (ret)
>>  		return ERR_PTR(ret);
>>  
>> -	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>> +	return hdmi;
>> +}
>> +EXPORT_SYMBOL_GPL(inno_hdmi_probe);
>> +
>> +struct inno_hdmi *inno_hdmi_bind(struct device *dev,
>> +				 struct drm_encoder *encoder,
>> +				 const struct inno_hdmi_plat_data *plat_data)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct inno_hdmi *hdmi;
>> +	int ret;
>> +
>> +	hdmi = inno_hdmi_probe(pdev, plat_data);
>> +	if (IS_ERR(hdmi))
>> +		return hdmi;
>> +
>> +	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL,
>> +				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>>  	if (ret)
>>  		return ERR_PTR(ret);
> 
> This clutters up the structure even more than it is right now. From "bind"
> back to "probe" and "dev" back to "pdev" and calling a function called
> "probe" from the bind callback.
> 
> You are right, that all the resource allocation can (and probably should)
> live in the drivers probe-path, but then please call that probe function
> from the actual probe path.
> 
> For example you could look at how all the Synopsys bridges do that.

That is what the new jh7110 driver does - it is a plain platform driver
and calls inno_hdmi_probe() from its own probe no component framework.
Same shape as th1520-dw-hdmi.c which calls dw_hdmi_probe() from its
platform probe and never calls dw_hdmi_bind().

I kept inno_hdmi_bind() as a wrapper on purpose so the rockchip probe/bind
flow stays exactly as it is today. I do not have any rockchip hardware and
moving resource acquisition out of bind and into probe there changes when the
bridge is added, which I did not want to do build tested only. dw-hdmi keeps
dw_hdmi_bind() for the same kind of consumer since dw_hdmi-rockchip.c is
still component based.

I am happy to convert inno_hdmi-rockchip.c so probe acquires the
resources and bind only attaches - that would let inno_hdmi_bind() go
away entirely - if someone with rockchip hardware can test it. Otherwise
I would rather send it separately where it can get proper testing, as
this series is at 21 patches already.

You are right about pdev - inno_hdmi_bind() will take a platform_device like
dw_hdmi_bind() does so the to_platform_device() goes away.

> 
> 
> Thanks
> Heiko
> 
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
