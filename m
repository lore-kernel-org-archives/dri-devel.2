Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5BAC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 02:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14B610F324;
	Fri,  7 Aug 2026 02:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IL8agv80";
	dkim-atps=neutral
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Fri, 07 Aug 2026 02:55:49 UTC
Received: from mail-m81220.netease.com (mail-m81220.netease.com [47.88.81.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5687510F324
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 02:55:49 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 491b644d0;
 Fri, 7 Aug 2026 10:50:40 +0800 (GMT+08:00)
Message-ID: <a9b77d07-89de-4b86-8227-2cdd419629c7@rock-chips.com>
Date: Fri, 7 Aug 2026 10:50:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/21] drm/bridge: synopsys: dw-dp: Add follow-up
 bridge support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-10-0d508505f383@collabora.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-10-0d508505f383@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9fda21428903a7kunm17d9edf98123b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCS04dVhpOSkhJS0IeSk9JGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=IL8agv80TbgEJ/ektDWcbhjL7ehF9V68i2rOBuIUN5Z4FrUVZREaVYpGYHYTbM5jlfBZjC0Syh4ZgffUKg1ajhGjZJfXsxtthQ/aClyW6MWb9maeUbGyZPcRZjwJp5WOwGdULyJo+d7kkV9bqArSwfnYMdnYzkM/LKZaBu7lsOc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=slu4UXv1MBP6pJpI4M9su9mc+PRdIjhnDUo1lMf+9Cc=;
 h=date:mime-version:subject:message-id:from;
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

On 8/7/2026 1:02 AM, Sebastian Reichel wrote:
> Add support to use USB-C connectors with the DP altmode helper code on
> devicetree based platforms. To get this working there must be a DRM
> bridge chain from the DisplayPort controller to the USB-C connector.
> E.g. on Rockchip RK3576:
> 
> root@rk3576 # cat /sys/kernel/debug/dri/0/encoder-0/bridges
> bridge[0]: dw_dp_bridge_funcs
>         refcount: 7
>         type: [10] DP
>         OF: /soc/dp@27e40000:rockchip,rk3576-dp
>         ops: [0x47] detect edid hpd
> bridge[1]: drm_aux_bridge_funcs
>         refcount: 4
>         type: [0] Unknown
>         OF: /soc/phy@2b010000:rockchip,rk3576-usbdp-phy
>         ops: [0x0]
> bridge[2]: drm_aux_hpd_bridge_funcs
>         refcount: 5
>         type: [10] DP
>         OF: /soc/i2c@2ac50000/typec-portc@22/connector:usb-c-connector
>         ops: [0x4] hpd
> 
> It's fine to fatally error out when there is no follow-up bridge
> as the Rockchip Designware Displayport controller is the only
> user of the bridge helper and has the port marked as required
> in its binding.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c | 34 +++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> index b9864a17c01d..a6099f7ddc87 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -330,6 +330,8 @@ struct dw_dp {
>  	struct dw_dp_plat_data plat_data;
>  	u8 pixel_mode;
>  
> +	struct drm_bridge *next_bridge;
> +

To be nitpicky, this field would be better placed before the u8.

Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>


>  	DECLARE_BITMAP(sdp_reg_bank, SDP_REG_BANK_SIZE);
>  };
>  
> @@ -1894,7 +1896,22 @@ static int dw_dp_bridge_attach(struct drm_bridge *bridge,
>  
>  	enable_irq(dp->irq);
>  
> +	ret = drm_bridge_attach(encoder, dp->next_bridge, bridge,
> +				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> +	if (ret) {
> +		dev_err(dev, "Failed to attach next bridge: %d\n", ret);
> +		goto err_disable_irq;
> +	}
> +
>  	return 0;
> +
> +err_disable_irq:
> +	disable_irq(dp->irq);
> +	cancel_work_sync(&dp->hpd_work);
> +
> +	drm_dp_aux_unregister(&dp->aux);
> +
> +	return ret;
>  }
>  
>  static void dw_dp_bridge_detach(struct drm_bridge *bridge)
> @@ -2060,6 +2077,13 @@ void dw_dp_unbind(struct dw_dp *dp)
>  }
>  EXPORT_SYMBOL_GPL(dw_dp_unbind);
>  
> +static void dw_dp_put_next_bridge(void *data)
> +{
> +	struct dw_dp *dp = data;
> +
> +	drm_bridge_put(dp->next_bridge);
> +}
> +
>  static void dw_dp_phy_exit(void *data)
>  {
>  	struct dw_dp *dp = data;
> @@ -2157,6 +2181,16 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
>  		return ERR_PTR(ret);
>  	}
>  
> +	dp->next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
> +	if (IS_ERR(dp->next_bridge)) {
> +		dev_err_probe(dev, PTR_ERR(dp->next_bridge), "failed to get follow-up bridge\n");
> +		return ERR_CAST(dp->next_bridge);
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, dw_dp_put_next_bridge, dp);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	dw_dp_init_hw(dp);
>  
>  	ret = phy_init(dp->phy);
> 



-- 
Best, 
Chaoyi
