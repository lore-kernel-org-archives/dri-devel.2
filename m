Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C98CD6E55
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 01:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B643B10EAFD;
	Tue,  2 Jun 2026 01:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="R5sU8Xow";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Tue, 02 Jun 2026 01:33:39 UTC
Received: from mail-m9355.xmail.ntesmail.com (mail-m9355.xmail.ntesmail.com
 [103.126.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABD710EAFD
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 01:33:38 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 40ab83ee7;
 Tue, 2 Jun 2026 09:28:33 +0800 (GMT+08:00)
Message-ID: <bee9fdba-536f-4296-a9be-db35ab8d4172@rock-chips.com>
Date: Tue, 2 Jun 2026 09:28:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/bridge: Implement generic USB Type-C DP HPD bridge
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Vinod Koul <vkoul@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org
References: <20260521032854.103-1-kernel@airkyi.com>
 <20260521032854.103-2-kernel@airkyi.com> <ah3-auKugGCVojOp@venus>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <ah3-auKugGCVojOp@venus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e85f25b4c03a7kunm8d21327629bc6f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGRkaVk5KSElOSk9OTk1NS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=R5sU8Xowx13A7b3tEpXEjh68l/6BcGouqkVH9cIcjydpMUe+bcLLnLBhrYB8NITiM2QDaYlcz8cbGbRu8/aEwYC4JinvABAmYkGevvUGt6KfDj8+JwsYZv/3TqtkLPaMIIVZ0S1pykGEATLAaBZHyX6+H1q3JDt8ZFS/sOK4O3o=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=gvBTxmnkMtYSMLhCFymsQ41jj4G+NLVy+qkjJoW9Up0=;
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

On 6/2/2026 6:08 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, May 21, 2026 at 11:28:50AM +0800, Chaoyi Chen wrote:
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
>>  drivers/gpu/drm/bridge/Kconfig                | 10 ++++
>>  drivers/gpu/drm/bridge/Makefile               |  1 +
>>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 49 +++++++++++++++++++
> 
> Doesn't this require removing the manual registration of the HPD
> auxillary bridge in the USB-C controller drivers to avoid that
> two bridges are registered for them?
> 

I believe this will not affect existing controller drivers,
as they call drm_bridge_attach during registration. Of course,
while it won't affect the main bridge chain, you'll still see
an additional HPD bridge.

>>  3 files changed, 60 insertions(+)
>>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
>>
>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>> index c3209b0f4678..d92e93875793 100644
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
>> index beab5b695a6e..c4761526ba0a 100644
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
>> +		goto done;
>> +
>> +	/*
>> +	 * alt->dev.parent->parent : USB-C controller device
>> +	 * alt->dev.parent         : USB-C connector device
>> +	 */
>> +	if (is_typec_port_altmode(&alt->dev) && alt->svid == USB_TYPEC_DP_SID)
>> +		drm_dp_hpd_bridge_register(alt->dev.parent->parent,
>> +					   to_of_node(alt->dev.parent->fwnode));
> 
> IIUIC this is called when the USB-C controller spawns a sub-device
> for the DP AltMode and then registers a HPD bridge to the USB-C
> controller itself. Wouldn't that register new HPD bridges on every
> USB-C replug?
> 
> Also doesn't this result in the bridge not being registered when
> nothing is plugged and thus the DRM pipeline not being able to bind
> properly?
>

That's a good question. The port altmode device here is only registered
once during initialization. While the parnter altmode device will
register and unregister during the plugging and unplugging process.
So you don't need to worry about that :)

https://lore.kernel.org/all/4fddba9a-b073-4bca-bd13-64a415f4bc47@rock-chips.com/

-- 
Best, 
Chaoyi
