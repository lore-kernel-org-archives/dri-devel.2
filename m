Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B3EC44524
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 02:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4299610E235;
	Tue, 21 Jul 2026 02:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NcPrwaP/";
	dkim-atps=neutral
Received: from mail-m1069.netease.com (mail-m1069.netease.com [154.81.10.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5BE10E235
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 02:22:34 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 46edaba15;
 Tue, 21 Jul 2026 10:22:30 +0800 (GMT+08:00)
Message-ID: <f567a9fb-925e-4d61-ba57-1bf8c72668c8@rock-chips.com>
Date: Tue, 21 Jul 2026 10:22:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Vinod Koul <vkoul@kernel.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
References: <20260717072323.96-1-kernel@airkyi.com>
 <20260717072323.96-2-kernel@airkyi.com> <alpeAqKo72pwOEnX@venus>
 <al5fYojQ0kJw2okg@venus>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <al5fYojQ0kJw2okg@venus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9f827b5c9903a7kunm1e14f012284aff
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHklLVklDTU0ZGBkYTEIeHVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=NcPrwaP/SOF3bVD2Wap635SUawMfOlaMfPFODyXj/hvz4H6eYO1G089WGYOnvIoxHXFQWVafef22+S5ntKXholZO2GOc6QvX7Rzkz7jVLkgND7SOpKFqE3TC8fOImzJ9R3KUQTCwINZiK6Ao7Zr+4bR4SX/FqdlVlBJ+jSURwRk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=wMHOBENfy80mTz3btHp7p7Yxxoxadnd1IuP2ft5rDgw=;
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

Hi Sebastian,

On 7/21/2026 1:59 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Jul 17, 2026 at 07:19:29PM +0200, Sebastian Reichel wrote:
>> On Fri, Jul 17, 2026 at 03:23:19PM +0800, Chaoyi Chen wrote:
>>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>
>>> The HPD function of Type-C DP is implemented through
>>> drm_connector_oob_hotplug_event(). For embedded DP, it is required
>>> that the DRM connector fwnode corresponds to the Type-C port fwnode.
>>>
>>> To describe the relationship between the DP controller and the Type-C
>>> port device, we usually using drm_bridge to build a bridge chain.
>>>
>>> Now several USB-C controller drivers have already implemented the DP
>>> HPD bridge function provided by aux-hpd-bridge.c, it will build a DP
>>> HPD bridge on USB-C connector port device.
>>>
>>> But this requires the USB-C controller driver to manually register the
>>> HPD bridge. If the driver does not implement this feature, the bridge
>>> will not be create.
>>>
>>> So this patch implements a generic DP HPD bridge based on
>>> aux-hpd-bridge.c. It will monitor Type-C bus events, and when a
>>> Type-C port device containing the DP svid is registered, it will
>>> create an HPD bridge for it without the need for the USB-C controller
>>> driver to implement it.
>>>
>>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>> Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>>> ---
>>
>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com> # ArmSom Sige5
>>
>> I gave this a test together with the RK3588/RK3576 USB-C DP AltMode
>> patches I'm working on. As the fusb302 does a manual registration
>> for the DRM bridge in its probe function, the bridge is registered
>> twice:
>>
>> root@sige5 # cat /sys/kernel/debug/dri/bridges
>> ...
>> bridge[1]: drm_aux_hpd_bridge_funcs
>> 	refcount: 4
>> 	type: [10] DP
>> 	OF: /soc/i2c@2ac50000/typec-portc@22/connector:usb-c-connector
>> 	ops: [0x4] hpd
>> bridge[2]: drm_aux_hpd_bridge_funcs
>> 	refcount: 2
>> 	type: [10] DP
>> 	OF: /soc/i2c@2ac50000/typec-portc@22/connector:usb-c-connector
>> 	ops: [0x4] hpd
>> ...
>>
>> Apparently the USB-C DP AltMode keeps working, so this just wastes
>> a few CPU cycles and some memory. So this can land and then we can
>> remove the manual code from the driver as a follow-up step. I also
>> gave that a try and things keep working. I won't send the fusb302
>> patch for now to ensure its not applied before this patch lands.
> 
> The above test was done with a kernel having all config options
> built-in (i.e. no modules). Using arm64 defconfig one ends up with
> 
> CONFIG_DRM_AUX_HPD_TYPEC_BRIDGE=m
> 
> But the resulting 'aux-hpd-typec-dp-bridge' module is not loaded
> automatically resulting in missing bridge registration. Running
> 'modprobe aux-hpd-typec-dp-bridge' manually in the booted system
> does not work either as the TypeC controller has already been
> registered and no new BUS_NOTIFY_ADD_DEVICE is generated.
>

Oh, we indeed didn't consider that such a probe ordering issue exists.

The approach I came up with is to iterate through the &typec_bus after
registering the notifier, to ensure we don't miss any events that 
occurred prior:

 static int __init drm_aux_hpd_typec_dp_bridge_module_init(void)
 {
        bus_register_notifier(&typec_bus, &drm_typec_event_nb);
-
+       bus_for_each_dev(&typec_bus, NULL, NULL,
+                        check_altmode_dev_and_register_hpd_bridge);
        return 0;
 }


But I'm not sure if there are potential race conditions involved.
Perhaps @Heikki and others have better ideas? Thanks.

> Greetings,
> 
> -- Sebastian

-- 
Best, 
Chaoyi
