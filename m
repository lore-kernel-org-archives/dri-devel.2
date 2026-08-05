Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF14DC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 04:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EDDA10E147;
	Wed,  5 Aug 2026 04:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FgyUEkOS";
	dkim-atps=neutral
Received: from mail-m24102.xmail.ntesmail.com (mail-m24102.xmail.ntesmail.com
 [45.195.24.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F209E10E147
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 04:06:52 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 48d284d12;
 Wed, 5 Aug 2026 12:06:48 +0800 (GMT+08:00)
Message-ID: <29d483f3-2eb2-4886-a4fe-9b4b6d9d14f3@rock-chips.com>
Date: Wed, 5 Aug 2026 12:06:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Add HPD support for Rockchip Analogix DP
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20260804081717.741404-1-damon.ding@rock-chips.com>
 <5609825.iZASKD2KPV@diego>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <5609825.iZASKD2KPV@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fd01a3dc903a8kunm1ce208566a0762
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUtDVkxKH0lPHk8aQk9NQ1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=FgyUEkOSbZ9/Qa2HsnMSqlJTDs3+ieUTOhT9JTG9m353+h07kHDJSkyJkiV1xSGLeuP1ZNOPNhW/UyyKHBrB0s88ZhkpPA9S9N/GUK+Ysde2voUzWUHSAaRZ6kSaywTHvGm6ytkbHBrkYeBqy2xriZHbFkzBzomG2mMnge3r4Gw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=46KglQXmBZaXhQzKYrdlIIgbE5Hkt8Onh1lXOlB0H+Y=;
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

Hi Heiko,

On 8/5/2026 6:39 AM, Heiko Stübner wrote:
> Hi Damon,
> 
> Am Dienstag, 4. August 2026, 10:17:07 Mitteleuropäische Sommerzeit schrieb Damon Ding:
>> Display-connector mode (DP connector without HPD GPIO):
>>
>>    &edp_out_conn {
>>        remote-endpoint = <&dp_con_in>;
>>    };
>>
>>    dp-con {
>>        compatible = "dp-connector";
>>        label = "DP OUT";
>>        type = "full-size";
>>
>>        port {
>>            dp_con_in: endpoint {
>>                remote-endpoint = <&edp_out_conn>;
>>            };
>>        };
>>    };
>>
>> Display-connector mode (DP connector with HPD GPIO):
>>
>>    dp-con {
>>        compatible = "dp-connector";
>>        label = "DP OUT";
>>        type = "full-size";
>>        pinctrl-0 = <&edp0_hpd>;
>>        pinctrl-names = "default";
>>        hpd-gpios = <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
>>
>>        port {
>>            dp_con_in: endpoint {
>>                remote-endpoint = <&edp_out_conn>;
>>            };
>>        };
>>    };
>>
>> All four configurations detect cable plug/unplug events correctly.

Thanks a lot for your testing and feedback. :-)

It seems my test setup gave me the false impression that those cases 
worked well.

> 
> hmm, it wasn't working entirely for me though and was still running into
> issues when the display was unplugged on boot.
> 

Are you seeing this boot‑unplug issue for both scenarios: DP‑connector 
with HPD‑gpio paired with eDP without HPD‑gpio, and DP‑connector without 
HPD‑gpio paired with eDP with HPD‑gpio? I.e. it wrongly reports 
connected even with no display plugged in and proceeds into DRM 
.atomic_enable()?

> I wiggled around a bit like in the diff below and am now getting correct
> plug and unplug events.

Oh, I see. For the GPIO HPD case, the IRQ needs to be enabled early so 
that plug‑in interrupts can be properly responded to. However GPIO HPD 
does not require a runtime PM get. I will better separate these two 
scenarios in the next version.

> 
> But of course, as the dp-variant of the connector does not provide
> a "detect" and just the "hpd" functionality, it's missing the initial state.
> 
> I'm currently not sure how to find out _if_ a panel is connected on boot.
> 

Based on Dmitry's commit cb640b2ca546 ("drm/bridge: display‑connector: 
don't set OP_DETECT for DisplayPorts"), HPD events from DP‑variant 
connector should be handled by the upstream DP controller. Hence I added 
analogix_dp_bridge_notify() to retrieve HPD status coming from downstream.

As expected, under the bridge‑connector framework, the detect result 
from Analogix DP should in theory reflect the actual connection status.
Let's dig into this boot‑time initial‑state issue together.

> 
> In other review comments:
> - the bridge could use devm_drm_of_get_bridge() as suggested in
>    the documentation of drm_of_find_panel_or_bridge(), as that would
>    remove the separate panel_bridge creation
> - instead of using plat_data->next_bridge _inside_ the driver
>    struct drm_bridge has a field next_bridge already.

Great suggestions, I will incorporate them for the next version 
alongside Sashiko's comments.

Best regards,
Damon

> 
> 
> Heiko
> 
> 
> ------- 8< -------
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 877e1b3ca7525..1388640a27de7 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -43,7 +43,7 @@ static const bool verify_fast_training;
>   static bool analogix_dp_require_pm_for_hpd_irq(struct analogix_dp_device *dp)
>   {
>   	return analogix_dp_is_rockchip(dp->plat_data->dev_type) && !dp->hpd_gpiod &&
> -	       !dp->force_hpd;
> +	       !dp->hpd_bridge && !dp->force_hpd;
>   }
>   
>   static void analogix_dp_init_dp(struct analogix_dp_device *dp)
> @@ -72,7 +72,7 @@ static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
>   	 * Trust connection status from downstream bridge (e.g.,
>   	 * display-connector with hpd-gpios).
>   	 */
> -	if (dp->plat_data->next_bridge && dp->connection_notified)
> +	if (dp->hpd_bridge && dp->connection_notified)
>   		return 0;
>   
>   	while (timeout_loop < DP_TIMEOUT_LOOP_COUNT) {
> @@ -926,10 +926,10 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
>   	 */
>   	if (dp->plat_data->next_bridge && dp->last_bridge_is_panel)
>   		status = connector_status_connected;
> -
> -	if (!analogix_dp_detect_hpd(dp))
> +	else if (!analogix_dp_detect_hpd(dp))
>   		status = connector_status_connected;
>   
> +printk("---> %s status %d\n", __func__, status);
>   	return status;
>   }
>   
> @@ -1044,7 +1044,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>   		goto out_dp_init;
>   	}
>   
> -	if (!analogix_dp_require_pm_for_hpd_irq(dp))
> +	if (!analogix_dp_require_pm_for_hpd_irq(dp) && !dp->hpd_bridge)
>   		enable_irq(dp->irq);
>   	return 0;
>   
> @@ -1187,7 +1187,7 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
>   	if (dp->dpms_mode != DRM_MODE_DPMS_ON)
>   		return;
>   
> -	if (!analogix_dp_require_pm_for_hpd_irq(dp))
> +	if (!analogix_dp_require_pm_for_hpd_irq(dp) && !dp->hpd_bridge)
>   		disable_irq(dp->irq);
>   
>   	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
> @@ -1264,6 +1264,7 @@ static void analogix_dp_bridge_notify(struct drm_bridge *bridge, struct drm_conn
>   	struct analogix_dp_device *dp = to_dp(bridge);
>   
>   	dp->connection_notified = (status == connector_status_connected);
> +printk("---> %s connection_notified %d\n", __func__, dp->connection_notified);
>   }
>   
>   static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
> @@ -1641,6 +1642,13 @@ static int analogix_dp_aux_done_probing(struct drm_dp_aux *aux)
>   	if (ret && ret != -ENODEV)
>   		return ret;
>   
> +	/*
> +	 * There is a next link in the chain which is not a panel, we should
> +	 * expect hotplug-information coming from there.
> +	 */
> +	if (plat_data->next_bridge && !drm_bridge_is_panel(plat_data->next_bridge))
> +		dp->hpd_bridge = true;
> +
>   	return component_add(dp->dev, plat_data->ops);
>   }
>   
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index d0fb25e543ea0..ecca3b87b4456 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -169,6 +169,7 @@ struct analogix_dp_device {
>   	bool			fast_train_enable;
>   	bool			psr_supported;
>   	bool			last_bridge_is_panel;
> +	bool			hpd_bridge;
>   	bool			connection_notified;
>   
>   	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index ec5950066f838..6f0d642739ffd 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -182,7 +182,7 @@ void analogix_dp_config_interrupt(struct analogix_dp_device *dp)
>   	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_2);
>   	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_3);
>   
> -	if (dp->hpd_gpiod) {
> +	if (dp->hpd_gpiod || dp->hpd_bridge) {
>   		analogix_dp_mute_hpd_interrupt(dp, HPD_IRQ);
>   	} else {
>   		/*
> @@ -438,7 +438,7 @@ void analogix_dp_init_hpd(struct analogix_dp_device *dp)
>   {
>   	u32 reg;
>   
> -	if (dp->hpd_gpiod)
> +	if (dp->hpd_gpiod || dp->hpd_bridge)
>   		return;
>   
>   	analogix_dp_clear_hotplug_interrupts(dp, HPD_IRQ);
> @@ -539,6 +539,9 @@ int analogix_dp_get_plug_in_status(struct analogix_dp_device *dp)
>   	if (dp->hpd_gpiod) {
>   		if (gpiod_get_value(dp->hpd_gpiod))
>   			return 0;
> +	} else if (dp->hpd_bridge) {
> +		if (dp->connection_notified)
> +			return 0;
>   	} else {
>   		reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
>   		if (reg & HPD_STATUS)
> 
> 
> 
> 
> 

