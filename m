Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAF606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NcjEQpYM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8778910E0BB;
	Thu,  5 Nov 2026 10:54:21 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D4211233A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:54:14 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261105105412euoutp0221de3a5b7a4048d78194fc0f7afe1c16~lIMP-HPlY3044430444euoutp02C;
 Thu,  5 Nov 2026 10:54:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261105105412euoutp0221de3a5b7a4048d78194fc0f7afe1c16~lIMP-HPlY3044430444euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793876052;
 bh=8U+WQmu8jFLJh5cbm79ZPqM5GeKacWcEkDyhOz912oU=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=NcjEQpYMRbxhXBgzKnZDjzO9LLwfDGOaaIfPmI2qnt8v3BjyjGfN95aIsbRJ5WcAe
 pMYGKFT8Id4k/8Q0czZ/74nGUvslfN7Kw9FJOU7LmEuNez+Hz47vdPfnIMzS747B6m
 sW7Jr++9LwO+aS1wGDZxc4S00WHnS1MZnDI6ngsg=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261105105412eucas1p171b6bde174fb0b6700cc78deee9d7edf~lIMPucvWX2329723297eucas1p12;
 Thu,  5 Nov 2026 10:54:12 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261105105410eusmtip15133e9a84efd244fc2a8fcab25cfa49a~lIMOGw1ty2761527615eusmtip1a;
 Thu,  5 Nov 2026 10:54:10 +0000 (GMT)
Message-ID: <204d333a-6f09-4498-b776-b2daee8d94b8@samsung.com>
Date: Thu, 5 Nov 2026 11:54:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/18] drm/bridge: inno-hdmi: Don't dereference a
 NULL drm_device on hotplug
To: Heiko Stuebner <heiko@sntech.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Philipp Zabel
 <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
 <hal.feng@starfivetech.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Dominique Belhachemi <db@domibel.de>, Andy Yan
 <andyshrk@163.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Yakir Yang <kuankuan.y@gmail.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Conor Dooley <conor@kernel.org>,
 William Qiu <william.qiu@starfivetech.com>, Xingyu Wu
 <xingyu.wu@starfivetech.com>, Sandy Huang <hjc@rock-chips.com>, Manivannan
 Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Maud Spierings
 <maud_spierings@murena.io>, Graham Markall <hello@big-grey.co.uk>, Icenowy
 Zheng <zhengxingda@iscas.ac.cn>, Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <2261991.3Lj2Plt8kZ@phil>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261105105412eucas1p171b6bde174fb0b6700cc78deee9d7edf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261030174510eucas1p2f85c6d82738ce34b17bdcab27f914ac1
X-EPHeader: CA
X-CMS-RootMailID: 20261030174510eucas1p2f85c6d82738ce34b17bdcab27f914ac1
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <20261029-jh7110-clean-send-v6-2-759594e43acf@samsung.com>
 <1844578.vCJZsxu672@phil>
 <CGME20261030174510eucas1p2f85c6d82738ce34b17bdcab27f914ac1@eucas1p2.samsung.com>
 <2261991.3Lj2Plt8kZ@phil>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/26 18:44, Heiko Stuebner wrote:
> Am Freitag, 30. Oktober 2026, 18:43:47 Mitteleuropäische Normalzeit schrieb Heiko Stuebner:
>> Am Donnerstag, 29. Oktober 2026, 08:53:36 Mitteleuropäische Normalzeit schrieb Michal Wilczynski:
>>> inno_hdmi_irq() passes hdmi->bridge.dev to drm_helper_hpd_irq_event(),
>>> which dereferences it in its first statement:
>>>
>>> 	if (!dev->mode_config.poll_enabled)
>>>
>>> bridge.dev is assigned only by drm_bridge_attach(), but inno_hdmi_bind()
>>> unmutes the hotplug interrupt in inno_hdmi_init_hw() and installs the
>>> handler well before it attaches the bridge:
>>>
>>> 	inno_hdmi_init_hw(hdmi);		/* unmutes hotplug */
>>> 	devm_request_threaded_irq(...);		/* handler goes live */
>>> 	...
>>> 	hdmi->bridge.ddc = inno_hdmi_i2c_adapter(hdmi);
>>> 	devm_drm_bridge_add(dev, &hdmi->bridge);
>>> 	drm_bridge_attach(...);			/* bridge.dev set here */
>>>
>>> The bridge is allocated by devm_drm_bridge_alloc(), which kzalloc()s it,
>>> so bridge.dev is NULL for all of that window, and a hotplug event
>>> arriving in it enters drm_helper_hpd_irq_event(NULL).
>>>
>>> Before the conversion to a bridge the ordering was safe:
>>> inno_hdmi_register() called drmm_connector_hdmi_init(), which set
>>> connector.dev, before the interrupt was requested.
>>>
>>> Drop hotplug events that arrive before the bridge is attached.
>>>
>>> Fixes: 969325a2597e ("drm/rockchip: inno-hdmi: Convert to drm bridge")
>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>> ---
>>>  drivers/gpu/drm/bridge/inno-hdmi.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
>>> index d7c33b92e2ddf4ced84d17304463f44be52270b8..d29832249b942dec84fb9d07a0b21ee751fc0486 100644
>>> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
>>> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
>>> @@ -929,7 +929,13 @@ static irqreturn_t inno_hdmi_irq(int irq, void *dev_id)
>>>  {
>>>  	struct inno_hdmi *hdmi = dev_id;
>>>  
>>> -	drm_helper_hpd_irq_event(hdmi->bridge.dev);
>>> +	/*
>>> +	 * The interrupt is requested before the bridge is attached, and
>>> +	 * bridge.dev is only set by drm_bridge_attach(). Drop hotplug events
>>> +	 * that arrive before then rather than dereference a NULL drm_device.
>>> +	 */
> 
> nit: I don't think that huge comment is necessary for that

Thanks, I'll trim the comment in v7

> 
> 
>>> +	if (hdmi->bridge.dev)
>>> +		drm_helper_hpd_irq_event(hdmi->bridge.dev);
>>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>>
>> Most other callers of drm_helper_hpd_irq_event() also do exactly this.
>>
>>
>> Heiko
>>
> 
> 
> 
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
