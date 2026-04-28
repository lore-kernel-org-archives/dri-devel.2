Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A82BFF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D807D10ED3B;
	Tue, 28 Apr 2026 13:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="X7gm0TRi";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E7410ED23
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777384696;
 bh=nuHroiOqJcryl2ckI5x4LwVq+WBidpOUFG2463L5EuI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=X7gm0TRiOuMp3bthsMo7Qh4S4Ac+F7+TgPoySHm7CtJK3xIeM1Ab44xS7zv+Xd9hY
 VjbFaXIydkrWpPZaHA5fxshx/wfLf/9Wzv27LAwdzVAt1ID9jnP6jmbelE9jW1xtMo
 R8F75o5rxdazv58NlpwoOUGaK3jlxLA+iImKRDxHWUPb2le5/J/jLAQYgDnOeBXpZb
 RglQfLok30Si1sf21fooc6RjGemqo6XHxcHDWytb2wd3xNjSj7azgmoNVXG3x+mTXN
 s5/GJk25PDZWnW+kIv12b6jTNLNvwKOLa29Zt0QWODL7Oueik5yEj2PMXjIpQSBsRf
 sVSG0D0kufUeQ==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7FBB817E12E5;
 Tue, 28 Apr 2026 15:58:15 +0200 (CEST)
Message-ID: <17fd4e6e-8036-4cb8-9d62-152306ba7a51@collabora.com>
Date: Tue, 28 Apr 2026 16:58:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] drm/rockchip: dw_hdmi_qp: Register HPD IRQ after
 connector setup
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-9-d778e70c317b@collabora.com>
 <hnbecmgviu7jl4xrsksna63sa376gpcaa6ate2qp2o5lgg35ot@wdthrayons3k>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <hnbecmgviu7jl4xrsksna63sa376gpcaa6ate2qp2o5lgg35ot@wdthrayons3k>
Content-Type: text/plain; charset=UTF-8
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

On 4/28/26 4:41 AM, Dmitry Baryshkov wrote:
> On Sun, Apr 26, 2026 at 03:20:21AM +0300, Cristian Ciocaltea wrote:
>> Move devm_request_threaded_irq() to the end of bind(), after
>> drm_bridge_connector_init() and drm_connector_attach_encoder(), to
>> ensure all DRM resources are ready before HPD interrupts can fire.
>>
>> While at it, add error handling for drm_connector_attach_encoder().
>>
>> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
>> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
>> index 618d2aaa5c7d..fbbe26f8730c 100644
>> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
>> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
>> @@ -577,14 +577,6 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
>>  	if (irq < 0)
>>  		return irq;
>>  
>> -	ret = devm_request_threaded_irq(dev, irq,
>> -					cfg->ctrl_ops->hardirq_callback,
>> -					cfg->ctrl_ops->irq_callback,
>> -					IRQF_SHARED, "dw-hdmi-qp-hpd",
>> -					hdmi);
>> -	if (ret)
>> -		return ret;
>> -
>>  	drm_encoder_helper_add(encoder, &dw_hdmi_qp_rockchip_encoder_helper_funcs);
>>  	ret = drmm_encoder_init(drm, encoder, NULL, DRM_MODE_ENCODER_TMDS, NULL);
>>  	if (ret)
>> @@ -602,7 +594,15 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
>>  		return dev_err_probe(dev, PTR_ERR(connector),
>>  				     "Failed to init bridge connector\n");
>>  
>> -	return drm_connector_attach_encoder(connector, encoder);
>> +	ret = drm_connector_attach_encoder(connector, encoder);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to attach connector\n");
>> +
>> +	return devm_request_threaded_irq(dev, irq,
>> +					 cfg->ctrl_ops->hardirq_callback,
>> +					 cfg->ctrl_ops->irq_callback,
>> +					 IRQF_SHARED, "dw-hdmi-qp-hpd",
>> +					 hdmi);
> 
> And if requesting of the IRQ fails, you have a lot to unwind. It might
> be better to request IRQ early enough with the IRQF_NO_AUTOEN flag and
> then enable_irq() here.

Indeed, that'd be a better approach.

Thanks,
Cristian
