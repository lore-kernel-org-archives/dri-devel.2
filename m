Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E718C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9EA410F292;
	Wed,  2 Sep 2026 15:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="G5N0CsxQ";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E90310F292
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1788363605;
 bh=bHtjTcLrG0knafbd8zwXtCbTXm1/ruu7gX+jOBhr0RU=;
 b=G5N0CsxQ9HmroMJAIaWcivn+538DsuejGoPxWeaf9t2lcVo2bwVHVttErP0/7pEfPsSQ+b7kp
 pCOcVX04E3/s+GF357E8VGsjdEWxfiXjNJUd9CPGktUMHBSr097gvvwZLS7AYjUlsAZq//kTL4B
 RPvQwUZfS3rb3TH7Io9jQpvAHhiSlJgEbZkSrglScPuWoYnUDsqGOAkD5xojj+FkC8JERPT7/sG
 vlkdkOlUEgcNeiybGnTjIaeuWvBKszyrxAHgDh6DzGEAYf1S4iFuufYYh1TGzrkwk+1jVh3GugC
 82Ql1rdhw1rn52zpVemQ1vTp4L/zhN7LtBM9N9ot0plA==
X-Forward-Email-ID: 6a9842fcde3605641460f2af
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.14.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7b26a257-534b-4bb1-a6a4-17d3d41aa374@kwiboo.se>
Date: Wed, 2 Sep 2026 17:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] drm/bridge: dw-hdmi: optionally ignore rxsense
 when detecting hotplug
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lucas Stach <l.stach@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260902130117.2731-1-ian.ray@gehealthcare.com>
 <20260902130117.2731-2-ian.ray@gehealthcare.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260902130117.2731-2-ian.ray@gehealthcare.com>
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

Hi Ian,

On 9/2/2026 3:01 PM, Ian Ray wrote:
> Commit da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event
> on link change") changed the way hotplug is detected to take into
> consideration rxsense.
> 
> That change is problematic for boards where rxsense is always detected,
> such as when an HDMI to DP converter is used.

I have a series [1] with a patch [2] that tries to fully remove the
rxsense part from the dw-hdmi driver, any help to test that series is
welcomed. Should likely solve the issue you are trying to workaround
here.

Planning on sending out a v8 next few days now that v7.3-rc1 have landed.

[1] https://lore.kernel.org/all/20260518180206.2480119-1-jonas@kwiboo.se/
[2] https://lore.kernel.org/all/20260518180206.2480119-21-jonas@kwiboo.se/

Regards,
Jonas

> 
> Introduce an optional property 'ignore-rxsense' to handle such boards.
> 
> Fixes: da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event on link change")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 34c5f583e910..a9337d1f4b88 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -171,6 +171,7 @@ struct dw_hdmi {
>  	bool disabled;			/* DRM has disabled our bridge */
>  	bool bridge_is_on;		/* indicates the bridge is on */
>  	bool rxsense;			/* rxsense state */
> +	bool ignore_rxsense;		/* use HPD only, ignore rxsense for detect */
>  	u8 phy_mask;			/* desired phy int mask settings */
>  	u8 mc_clkdis;			/* clock disable register */
>  
> @@ -3156,6 +3157,9 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>  		if (phy_stat & HDMI_PHY_HPD)
>  			status = connector_status_connected;
>  
> +		if (hdmi->ignore_rxsense)
> +			phy_stat &= ~HDMI_PHY_RX_SENSE;
> +
>  		if (!(phy_stat & (HDMI_PHY_HPD | HDMI_PHY_RX_SENSE)))
>  			status = connector_status_disconnected;
>  	}
> @@ -3362,6 +3366,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>  	mutex_init(&hdmi->cec_notifier_mutex);
>  	spin_lock_init(&hdmi->audio_lock);
>  
> +	hdmi->ignore_rxsense = of_property_read_bool(np, "ignore-rxsense");
> +
>  	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
>  	if (ddc_node) {
>  		hdmi->ddc = of_get_i2c_adapter_by_node(ddc_node);

