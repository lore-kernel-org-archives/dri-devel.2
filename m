Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F52C55162
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 01:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D5910E4A0;
	Mon,  3 Aug 2026 01:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Jt5HTmsU";
	dkim-atps=neutral
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Mon, 03 Aug 2026 01:43:35 UTC
Received: from mail-m158189.netease.com (mail-m158189.netease.com
 [47.251.158.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4F910E4A0
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 01:43:34 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 487cbd68b;
 Mon, 3 Aug 2026 09:38:26 +0800 (GMT+08:00)
Message-ID: <c6728974-3098-4232-927f-40911f0b4e39@rock-chips.com>
Date: Mon, 3 Aug 2026 09:38:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
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
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
References: <20260730013349.51-1-kernel@airkyi.com>
 <20260730013349.51-2-kernel@airkyi.com> <amyp3C_yzxpKzigR@venus>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <amyp3C_yzxpKzigR@venus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9fc545af7303a7kunmdf79e4127cbc75
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0hCVhlCSUxCSB5CHx1CHlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=Jt5HTmsU9lA0nVJbfxu5LdwAyRIq9ZBtXrW3nIcOVhQXF0H4282MRbkzExrMAbPWV2ZeVjMQYl6mf7ZqUDz8jYEWQLUo/NPo3/7n6w/vYPCXxwIWRW0Tn3FmfFwXuin4YyI0Lqv0nVORUrti9WiKpQkwmAKSxD9cR/jyimtV30o=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=hCaqyyISkfmc8KoVMA+IE9BEl7i+kSQyUjrBtfdkvIc=;
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

On 7/31/2026 10:20 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jul 30, 2026 at 09:33:44AM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> The HPD function of Type-C DP is implemented through
>> drm_connector_oob_hotplug_event(). For embedded DP, it is required
>> that the DRM connector fwnode corresponds to the Type-C port fwnode.
>>
>> To describe the relationship between the DP controller and the Type-C
>> port device, we usually using drm_bridge to build a bridge chain.
>>
>> Now several USB-C controller drivers have already implemented the DP
>> HPD bridge function provided by aux-hpd-bridge.c, it will build a DP
>> HPD bridge on USB-C connector port device.
>>
>> But this requires the USB-C controller driver to manually register the
>> HPD bridge. If the driver does not implement this feature, the bridge
>> will not be create.
>>
>> So this patch implements a generic DP HPD bridge based on
>> aux-hpd-bridge.c. It will monitor Type-C bus events, and when a
>> Type-C port device containing the DP svid is registered, it will
>> create an HPD bridge for it without the need for the USB-C controller
>> driver to implement it.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>> ---
>>
>> (no changes since v5)
>>
>> Changes in v4:
>> - Scan the entire typec_bus and attempt to register the hpd bridge,
>>   so as not to miss devices that were already added during initialization.
>>
>> (no changes since v3)
>>
>> Changes in v2:
>> - Add copyright text.
>> - Remove useless goto.
>> ---
>>  drivers/gpu/drm/bridge/Kconfig                | 10 +++
>>  drivers/gpu/drm/bridge/Makefile               |  1 +
>>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 64 +++++++++++++++++++
>>  3 files changed, 75 insertions(+)
>>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
>>
>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>> index 4a57d49b4c6d..9739b2a19758 100644
>> --- a/drivers/gpu/drm/bridge/Kconfig
>> +++ b/drivers/gpu/drm/bridge/Kconfig
>> @@ -30,6 +30,16 @@ config DRM_AUX_HPD_BRIDGE
>>  	  Simple bridge that terminates the bridge chain and provides HPD
>>  	  support.
>>  
>> +if DRM_AUX_HPD_BRIDGE
>> +config DRM_AUX_HPD_TYPEC_BRIDGE
>> +	tristate
>> +	depends on TYPEC || !TYPEC
>> +	default TYPEC
>> +	help
>> +	  Simple bridge that terminates the bridge chain and provides HPD
>> +	  support. It build bridge on each USB-C connector device node.
>> +endif
>> +
>>  menu "Display Interface Bridges"
>>  	depends on DRM && DRM_BRIDGE
>>  
>> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
>> index 15cc821d85b7..d88a9e1ccc9a 100644
>> --- a/drivers/gpu/drm/bridge/Makefile
>> +++ b/drivers/gpu/drm/bridge/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_DRM_AUX_BRIDGE) += aux-bridge.o
>>  obj-$(CONFIG_DRM_AUX_HPD_BRIDGE) += aux-hpd-bridge.o
>> +obj-$(CONFIG_DRM_AUX_HPD_TYPEC_BRIDGE) += aux-hpd-typec-dp-bridge.o
>>  obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
>>  obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
>>  obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
>> diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
>> new file mode 100644
>> index 000000000000..43af3ea20f20
>> --- /dev/null
>> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
>> @@ -0,0 +1,64 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2026 Rockchip Electronics Co., Ltd.
>> + *
>> + * Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> + */
>> +#include <linux/of.h>
>> +#include <linux/usb/typec_altmode.h>
>> +#include <linux/usb/typec_dp.h>
>> +
>> +#include <drm/bridge/aux-bridge.h>
>> +
>> +static int drm_typec_bus_event(struct notifier_block *nb,
>> +			       unsigned long action, void *data)
>> +{
>> +	struct device *dev = (struct device *)data;
>> +	struct typec_altmode *alt = to_typec_altmode(dev);
>> +
>> +	if (action != BUS_NOTIFY_ADD_DEVICE)
>> +		return NOTIFY_OK;
>> +
>> +	/*
>> +	 * alt->dev.parent->parent : USB-C controller device
>> +	 * alt->dev.parent         : USB-C connector device
>> +	 */
>> +	if (is_typec_port_altmode(&alt->dev) && alt->svid == USB_TYPEC_DP_SID)
>> +		drm_dp_hpd_bridge_register(alt->dev.parent->parent,
>> +					   to_of_node(alt->dev.parent->fwnode));
> 
> So there are 3 ways to end up with duplicated hpd bridges now:
> 
> 1. TypeC controller driver already registered one manually
> 2. There is a race in drm_aux_hpd_typec_dp_bridge_module_init, if a
>    device appears between registering the notifier and looping
>    through all pre-existing devices
> 3. Reloading the aux-hpd-typec-dp-bridge module re-registers the
>    bridges
> 
> It's not a huge problem as the system works with the duplicated HPD
> bridges, but it's also quite ugly.
> 
> I think it can be trivially avoided by adding this function to
> drivers/gpu/drm/bridge/aux-hpd-bridge.c and then making use of it
> here as an additional check (code untested):
> 
> bool drm_device_has_dp_hpd_bridge(struct device *parent)
> {
> 	struct device *hpd_bridge = device_find_child_by_name(parent, "dp_hpd_bridge");
> 
> 	if (!hpd_bridge)
> 		return false;
> 
> 	put_device(hpd_bridge);
> 	return true;
> }
> EXPORT_SYMBOL_GPL(drm_dev_has_dp_hpd_bridge);
>

I think deduplication during registration is a good idea. Detecting it
during alloc seems a bit premature.

Thanks again for your suggestion. I'll try to add it in the next version.

> That would solve all of the above, but leaves one problem when this
> module races against manual device creation in a TypeC controller
> driver. That could be avoided by doing the check in
> devm_drm_dp_hpd_bridge_alloc() under a lock, but that's probably not
> worth the trouble (it would require updating all users to handle a
> new error code like -EEXIST) considering manual registration can be
> removed from all drivers anyways.
> 
> Greetings,
> 
> -- Sebastian
> 
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block drm_typec_event_nb = {
>> +	.notifier_call = drm_typec_bus_event,
>> +};
>> +
>> +static int check_device_already_added(struct device *dev, void *data)
>> +{
>> +	drm_typec_bus_event(NULL, BUS_NOTIFY_ADD_DEVICE, dev);
>> +	return 0;
>> +}
>> +
>> +static void drm_aux_hpd_typec_dp_bridge_module_exit(void)
>> +{
>> +	bus_unregister_notifier(&typec_bus, &drm_typec_event_nb);
>> +}
>> +
>> +static int __init drm_aux_hpd_typec_dp_bridge_module_init(void)
>> +{
>> +	bus_register_notifier(&typec_bus, &drm_typec_event_nb);
>> +	/*
>> +	 * Before module initialization, some devices may have already been added.
>> +         * Register the HPD bridge for these devices.
>> +	 */
>> +	bus_for_each_dev(&typec_bus, NULL, NULL, check_device_already_added);
>> +	return 0;
>> +}
>> +
>> +module_init(drm_aux_hpd_typec_dp_bridge_module_init);
>> +module_exit(drm_aux_hpd_typec_dp_bridge_module_exit);
>> +
>> +MODULE_AUTHOR("Chaoyi Chen <chaoyi.chen@rock-chips.com>");
>> +MODULE_DESCRIPTION("DRM TYPEC DP HPD BRIDGE");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.53.0
>>

-- 
Best, 
Chaoyi
