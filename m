Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34C7C55162
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 01:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF6010E4C1;
	Mon,  3 Aug 2026 01:50:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KbRfJgCD";
	dkim-atps=neutral
Received: from mail-m128193.netease.com (mail-m128193.netease.com
 [103.209.128.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD2810E4C1
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 01:50:36 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 487d3130a;
 Mon, 3 Aug 2026 09:50:31 +0800 (GMT+08:00)
Message-ID: <a51a6359-c00c-4190-b3ef-13c79bb5bfed@rock-chips.com>
Date: Mon, 3 Aug 2026 09:50:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] Add HPD support for Rockchip Analogix DP
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
References: <20260730032744.381566-1-damon.ding@rock-chips.com>
 <24131962.ssLaC8jLEa@diego>
 <44ff5316-43cc-46be-b947-ea6e1f5da1bb@rock-chips.com>
 <5209243.oAaWjsssbx@diego>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <5209243.oAaWjsssbx@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fc550bff503a8kunm98219b2a55f5b9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTUlMVkNMT01PSU9MSR8dQ1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=KbRfJgCDsDrnjcREajGQGc5avyyAbQToOYReFowTyhSSJ7BHpVIUrzum2s11qB4PSjrizUtHAq66dMGoLg93ne4f9uXk7tbb7/Z1CHHKNMtuD3PiQjBBf537wFyD/yAqXgEMRvqx/LeyUP4L7ublfViUYWrJZ9R0eCOY/heSB3M=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=c6wh7zdiLYbCoFb7Xy9PfvQW4nqvBFuzM1gperfrKNs=;
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

On 7/31/2026 6:30 PM, Heiko Stübner wrote:
> Hi Damon,
> 
> Am Freitag, 31. Juli 2026, 11:55:42 Mitteleuropäische Sommerzeit schrieb Damon Ding:
>> On 7/31/2026 5:23 PM, Heiko Stübner wrote:
>>> Am Freitag, 31. Juli 2026, 05:08:45 Mitteleuropäische Sommerzeit schrieb Damon Ding:
>>>> On 7/31/2026 2:49 AM, Heiko Stübner wrote:
>>>>> Am Donnerstag, 30. Juli 2026, 05:27:37 Mitteleuropäische Sommerzeit schrieb Damon Ding:
>>>>>> This series improves the HPD (Hotplug Detect) interrupt handling in
>>>>>> the Analogix DP driver to enable reliable native HPD pin detection on
>>>>>> Rockchip platforms, and introduces platform-specific HPD detection
>>>>>> schemes with fine-grained interrupt control.
>>>>>
>>>>> [...]
>>>>>
>>>>>> Tested on RK3576 with both native HPD pin and GPIO HPD configurations.
>>>>>>
>>>>>> Native HPD pin mode:
>>>>>>
>>>>>>      &edp {
>>>>>>          status = "okay";
>>>>>>          pinctrl-names = "default";
>>>>>>          pinctrl-0 = <&edp_txm0_pins>;
>>>>>>      };
>>>>>>
>>>>>> GPIO HPD mode:
>>>>>>
>>>>>>      &edp {
>>>>>>          status = "okay";
>>>>>>          pinctrl-names = "default";
>>>>>>          pinctrl-0 = <&edp0_hpd>;
>>>>>>          hpd-gpios = <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
>>>>>>      };
>>>>>>
>>>>>>      &pinctrl {
>>>>>>          edp {
>>>>>>              edp0_hpd: edp0-hpd {
>>>>>>                  rockchip,pins = <4 RK_PC1 0 &pcfg_pull_none>;
>>>>>>              };
>>>>>>          };
>>>>>>      };
>>>>>
>>>>> Yay and thanks a lot for working on that.
>>>>>
>>>>> If I roll my display-port carrier board back to the analogix-dp being
>>>>> the endpoint, this works exactly as expected :-) .
>>>>>
>>>>> I can plug in the display at some point after the boot and have it
>>>>> detected and setup correctly. Same with unplugging it while
>>>>> the system is running. The connection status is correctly reported
>>>>> in sysfs.
>>>>>
>>>>>
>>>>> Though there is a caveat. When the eDP is not the last part, this does not
>>>>> work anymore. The detect function always returns "connected" if there is
>>>>> a next bridge available.
>>>>>
>>>>> My board [0] has a physical DP connector on it, so models it as
>>>>> dp-connector, but in that case the Analogix driver always reports being
>>>>> connected.
>>>>>
>>>>>
>>>>> [0] https://lore.kernel.org/linux-rockchip/20251009225050.88192-3-heiko@sntech.de/
>>>>> ... same effect with hpd-gpios in either the edp node or dp-connector node
>>>>>
>>>>>
>>>>
>>>> My previous tests were carried out on the modified RK3576 IOTEST board
>>>> DTS based on RK3576 EVB1, which includes dp-connector by default. I also
>>>> did extra verification without dp-connector, and HPD detection works
>>>> correctly in both cases.
>>>>
>>>> I've taken a look at the Tiger board DT configuration. The pinctrl
>>>> settings for the eDP HPD GPIO may need adjustment:
>>>>
>>>> &pinctrl {
>>>> 	edp0 {
>>>> 		edp0_hpd_l: edp0-hpd-l-pin {
>>>> 			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
>>>> 		};
>>>> 	};
>>>> };
>>>>
>>>> It is recommended to configure GPIO4B5 as pull-down or pll-none. Pull-up
>>>> configuration may prevent GPIO interrupts from being triggered properly,
>>>> resulting in a permanent "connected" status.
>>>
>>> At least on that DP-carrier the pin direction is different.
>>> I.e. it is active-low, meaning 0 for plugged in.
>>>
>>> In the schematics I do see a hw pull up too - so pull-none in the pinconfig
>>> would also be possible, but pull-down is definitly wrong on _this_ board.
>>>
>>> So we're talking about the same code, I put the dts up on [0] .
>>>
>>> I'm currently running with a printk diff [1] to showcase the issue.
>>>
>>> So on boot, with the display unplugged I get:
>>> [   14.757911] ---> drm_bridge_connector_detect: detect
>>> [   14.757914] ---> analogix_dp_bridge_detect a
>>> [   14.757918] ---> drm_bridge_connector_detect: detect
>>> [   14.773779] ---> analogix_dp_bridge_detect a
>>> [   14.838658] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
>>> [   14.838662] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* dp commit error, ret = -110
>>> [   14.838670] rockchip-dp fdec0000.edp: failed to set bridge, retry: 0
>>> [   14.884791] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
>>> [   14.884793] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* dp commit error, ret = -110
>>> [   14.884796] rockchip-dp fdec0000.edp: failed to set bridge, retry: 1
>>> [   14.930925] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
>>> [   14.930927] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* dp commit error, ret = -110
>>> [   14.930930] rockchip-dp fdec0000.edp: failed to set bridge, retry: 2
>>> [   14.977032] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
>>> [   14.977034] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* dp commit error, ret = -110
>>> [   14.977037] rockchip-dp fdec0000.edp: failed to set bridge, retry: 3
>>> [   15.023150] rockchip-dp fdec0000.edp: failed to read dpcd caps: -110
>>> [   15.023152] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* dp commit error, ret = -110
>>> [   15.023155] rockchip-dp fdec0000.edp: failed to set bridge, retry: 4
>>> [   15.023168] rockchip-dp fdec0000.edp: too many times retry set bridge, give it up
>>> [   15.052485] Console: switching to colour frame buffer device 80x30
>>> [   15.210457] rockchip-drm display-subsystem: [drm] fb0: rockchipdrmfb frame buffer device
>>> [   15.223444] ---> drm_bridge_connector_detect: detect
>>> [   15.231974] ---> analogix_dp_bridge_detect a
>>> [   15.239587] ---> drm_bridge_connector_detect: detect
>>> [   15.245341] ---> analogix_dp_bridge_detect a
>>>
>>> So analogix_dp_bridge_detect() is called and always returns connected.
>>>
>>> Plugging in the the display, I get:
>>> [  290.592096] ---> display_connector_detect gpio value is 1   {display-connector returning connected}
>>> [  290.598648] ---> drm_bridge_connector_detect: detect
>>> [  290.604637] ---> analogix_dp_bridge_detect a
>>> [  290.609826] ---> drm_bridge_connector_detect: detect
>>> [  290.615784] ---> analogix_dp_bridge_detect a
>>>
>>> Unplugging the display, I get:
>>> [  302.081444] ---> display_connector_detect gpio value is 0   {display-connector returning disconnected}
>>> [  302.087996] ---> drm_bridge_connector_detect: detect
>>> [  302.093945] ---> analogix_dp_bridge_detect a
>>> [  302.099131] ---> drm_bridge_connector_detect: detect
>>> [  302.105090] ---> analogix_dp_bridge_detect a
>>> [  302.144834] ---> drm_bridge_connector_detect: detect
>>> [  302.150784] ---> analogix_dp_bridge_detect a
>>> [  302.155933] ---> drm_bridge_connector_detect: detect
>>> [  302.161859] ---> analogix_dp_bridge_detect a
>>>
>>>
>>> So it looks like on the gpio-side the detection is correct and/but
>>> analogix_dp_bridge_detect() is always returning a connected state
>>> ("b" output is never reached).
>>>
>>> I'm still working on understanding how the whole detection logic works
>>> in drm ;-) .
>>>
>>>
>>
>> I think I've spotted the environmental difference between our setups.
>> Your DTS places the hpd-gpios property under the dp-connector node,
>> which is a scenario I haven't covered yet. I will reproduce and test
>> this case locally.
>>
>> As a quick experiment, could you try removing hpd-gpios from
>> dp-connector and move it under the edp node instead? As expected, GPIO
>> HPD should work properly with that configuration.
> 
> I've updated the branch in [0] with that hpd move to the edp node, but
> the result is similar:
> 
> With the panel _disconnected_ on boot I see
> [   12.887555] ---> drm_bridge_connector_detect: detect
> [   12.893104] ---> analogix_dp_bridge_detect a
> [   12.897881] ---> drm_bridge_connector_detect: detect
> [   12.903424] ---> analogix_dp_bridge_detect a
> [   14.124848] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* failed to get hpd single ret = -110
> [   14.124891] rockchip-dp fdec0000.edp: failed to set bridge, retry: 0
> [   14.236031] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* failed to get hpd single ret = -110
> [   14.236074] rockchip-dp fdec0000.edp: failed to set bridge, retry: 1
> [   14.346940] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* failed to get hpd single ret = -110
> [   14.346990] rockchip-dp fdec0000.edp: failed to set bridge, retry: 2
> [   14.458590] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* failed to get hpd single ret = -110
> [   14.458638] rockchip-dp fdec0000.edp: failed to set bridge, retry: 3
> [   14.570262] [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* failed to get hpd single ret = -110
> [   14.570312] rockchip-dp fdec0000.edp: failed to set bridge, retry: 4
> [   14.570328] rockchip-dp fdec0000.edp: too many times retry set bridge, give it up
> [   14.751371] ---> drm_bridge_connector_detect: detect
> [   14.757207] ---> analogix_dp_bridge_detect a
> 
> So with the diff from earlier, analogix_dp_bridge_detect() still runs,
> finds its next bridge and returns "connected".
> 
> I.e. the
>>>           if (dp->plat_data->next_bridge)
>>>                   return connector_status_connected;
> 
> part.
> 
> 

Thanks a lot for running the test and confirming the behaviour. I've 
also reproduced this issue locally.

I will dig deeper into this problem and fix this incorrect connection 
status logic in v2. :-)

Best regards,
Damon

> 
> 
> 
>>> [0] https://github.com/mmind/linux-rockchip/blob/dev/v7.3/rk3588-tiger-dp-carrier-v5/arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts
>>> [1]
>>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>> index 7a89548a7a885..0accdf62637ae 100644
>>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>> @@ -915,8 +915,10 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
>>>           struct analogix_dp_device *dp = to_dp(bridge);
>>>           enum drm_connector_status status = connector_status_disconnected;
>>>    
>>> +printk("---> %s a\n", __func__);
>>>           if (dp->plat_data->next_bridge)
>>>                   return connector_status_connected;
>>> +printk("---> %s b\n", __func__);
>>>    
>>>           if (!analogix_dp_detect_hpd(dp))
>>>                   status = connector_status_connected;
>>> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
>>> index 16c0631adeb18..b0c07694b82e3 100644
>>> --- a/drivers/gpu/drm/bridge/display-connector.c
>>> +++ b/drivers/gpu/drm/bridge/display-connector.c
>>> @@ -45,6 +45,7 @@ static enum drm_connector_status display_connector_detect(struct drm_bridge *bri
>>>           struct display_connector *conn = to_display_connector(bridge);
>>>    
>>>           if (conn->hpd_gpio) {
>>> +printk("---> %s gpio value is %d\n", __func__, gpiod_get_value_cansleep(conn->hpd_gpio));
>>>                   if (gpiod_get_value_cansleep(conn->hpd_gpio))
>>>                           return connector_status_connected;
>>>                   else
>>> @@ -84,6 +85,7 @@ static enum drm_connector_status display_connector_detect(struct drm_bridge *bri
>>>    static enum drm_connector_status
>>>    display_connector_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
>>>    {
>>> +printk("---> %s\n", __func__);
>>>           return display_connector_detect(bridge);
>>>    }
>>>    
>>> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
>>> index 649969fca1413..8816d837c9a77 100644
>>> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
>>> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
>>> @@ -218,6 +218,7 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
>>>           enum drm_connector_status status;
>>>    
>>>           if (detect) {
>>> +printk("---> %s: detect\n", __func__);
>>>                   status = detect->funcs->detect(detect, connector);
>>>    
>>>                   if (hdmi)
>>>
>>>
>>>
>>>
>>>
>>
>>
> 
> 
> 
> 
> 
> 

