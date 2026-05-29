Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE68CD5BD1
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 01:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3BF10F78F;
	Fri, 29 May 2026 01:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XH3HAMkJ";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Fri, 29 May 2026 01:23:12 UTC
Received: from mail-m128182.netease.com (mail-m128182.netease.com
 [103.209.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E759D10F78F
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 01:23:12 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 403fe69fb;
 Fri, 29 May 2026 09:18:05 +0800 (GMT+08:00)
Message-ID: <162da16e-6fec-4d47-ba67-46ec2ffa8e2f@rock-chips.com>
Date: Fri, 29 May 2026 09:18:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 1/9] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Peter Chen <hzpeterchen@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, Hugh Cole-Baker <sigmaris@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Chaoyi Chen <chaoyi.chen@rock-chips.com>
References: <20260304094152.92-1-kernel@airkyi.com>
 <20260304094152.92-2-kernel@airkyi.com>
 <q6ufdWF5QJ60i9KlIiE_AA@collabora.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <q6ufdWF5QJ60i9KlIiE_AA@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e714f575603a7kunm02f79646c276f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTkkYVkJCS01DQ0pLQx1KTVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=XH3HAMkJS0xVohcQuMdKTriE7Bx8yFw6eb42zoSKsvGfn7hX654CyUvDAI5X7TDt3QLQKsY0JYgFk82I6qcr7FwY1sB0NglC9697BPY9uHlC0kePlaHxXstQmxJq3qRRm5aETC3C2H7j2/19/UHeGZCfVTUs9fJAGvk+bTsSZpI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=IFhWtiTca4KN7jNJbQ39dVsqplJfAuEyUAlnwh0AXXA=;
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

Hello Nicolas,

On 5/28/2026 11:37 PM, Nicolas Frattaroli wrote:
> On Wednesday, 4 March 2026 10:41:44 Central European Summer Time Chaoyi Chen wrote:
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
>> ---
>>
>> (no changes since v14)
>>
>> Changes in v13:
>> - Only register drm dp hpd bridge for typec port altmode device.
>>
>> (no changes since v12)
>>
>> Changes in v11:
>> - Switch to using typec bus notifiers.
>>
>> (no changes since v10)
>>
>> Changes in v9:
>> - Remove the exposed DRM_AUX_HPD_BRIDGE option, and select
>> DRM_AUX_HPD_TYPEC_BRIDGE when it is available.
>> - Add more commit comment about problem background.
>>
>> Changes in v8:
>> - Merge generic DP HPD bridge into one module.
>> ---
>>
>>  drivers/gpu/drm/bridge/Kconfig                | 10 ++++
>>  drivers/gpu/drm/bridge/Makefile               |  1 +
>>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 49 +++++++++++++++++++
>>  3 files changed, 60 insertions(+)
>>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
>>
>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>> index a250afd8d662..559487aa09a9 100644
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
>> index c7dc03182e59..a3a0393d2e72 100644
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
>> index 000000000000..d915e0fb0668
>> --- /dev/null
>> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
>> @@ -0,0 +1,49 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> Having a copyright statement added here is likely required.
> Something like
> 
> /*
>  * Copyright (C) 2026 Rockchip Electronics Co., Ltd.
>  *
>  * Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>  */
> 
> will suffice. While I hope it's never relevant for a driver this
> small, explicit copyright statements in this form have a legal
> effect in some jurisdictions like the US, where by law it
> automatically dismisses the defense that the copyright holder
> wasn't known.
> 

Oh! I hadn't noticed that. Thank you for your legal advice.

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
> 
> Small nitpick: The explicit (struct device *) cast of data isn't
> needed here. Just
> 
>     struct device *dev = data;
> 
> will work fine. The benefit is that if the type of "data" ever changes
> (e.g. from void *data to const void *data) then we're not silencing
> a warning/error through an explicit cast.
>

Yep. Will fix in v2.

>> +	struct typec_altmode *alt = to_typec_altmode(dev);
>> +
>> +	if (action != BUS_NOTIFY_ADD_DEVICE)
>> +		goto done;
>> +
>> +	/*
>> +	 * alt->dev.parent->parent : USB-C controller device
>> +	 * alt->dev.parent         : USB-C connector device
>> +	 */
>> +	if (is_typec_port_altmode(&alt->dev) && alt->svid == USB_TYPEC_DP_SID)
>> +		drm_dp_hpd_bridge_register(alt->dev.parent->parent,
>> +					   to_of_node(alt->dev.parent->fwnode));
>> +
>> +done:
>> +	return NOTIFY_OK;
>> +}
> 
> Nitpicking: the "done" label and "goto done" here is redundant.
> You could remove the label and replace the goto with another
> "return NOTIFY_OK;". There's no functional change here though.
> 

Will fix in v2.

>> +
>> +static struct notifier_block drm_typec_event_nb = {
>> +	.notifier_call = drm_typec_bus_event,
>> +};
>> +
>> +static void drm_aux_hpd_typec_dp_bridge_module_exit(void)
>> +{
>> +	bus_unregister_notifier(&typec_bus, &drm_typec_event_nb);
>> +}
>> +
>> +static int __init drm_aux_hpd_typec_dp_bridge_module_init(void)
>> +{
>> +	bus_register_notifier(&typec_bus, &drm_typec_event_nb);
>> +
>> +	return 0;
>> +}
>> +
>> +module_init(drm_aux_hpd_typec_dp_bridge_module_init);
>> +module_exit(drm_aux_hpd_typec_dp_bridge_module_exit);
>> +
>> +MODULE_DESCRIPTION("DRM TYPEC DP HPD BRIDGE");
>> +MODULE_LICENSE("GPL");
>>
> 
> Feel free to add yourself as MODULE_AUTHOR here. :)
> 
> With those things changed:
> 
> Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> Kind regards,
> Nicolas Frattaroli
> 
> 
> 

-- 
Best, 
Chaoyi
