Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD30CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED18610F365;
	Thu, 28 May 2026 15:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Gv+tohvh";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3783010F365
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779982643; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UmekvXYN7RRSnHTCLJ9nmNGs86iZ9e9cQ/O+BAx9wNHc7Rf2nDJ1pbe+O+WB7u4hfl8CrX1IcE7UhWWdqTV2PvlYIX+fVS4VqW2wa++vgK9bgyVwTECevZ0liE7xYX8bfXvuXYYM/fXbM98eXNxP+oA4Ifc9518B9Vvv86haNhY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779982643;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hx6IngChPzu8wVFfFvPOU9rvJKQ/Ut7ytcKKn5x2rGo=; 
 b=Yztq4r7PXpI/bsIIkuyyunCgThBDvC8hO44keh1DfewMNqOrW9KJ/qcikqsRMTUjXnv4vy6JSdcOTUfqjE6eiPxM+zOLkq4njm2IGn0WIpmUjSIFnzMMz3pOhVgaDqUYOMk1mFsPb7NgiscAh1rT01aqadQEENOeecYntiuoLEo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779982643; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=hx6IngChPzu8wVFfFvPOU9rvJKQ/Ut7ytcKKn5x2rGo=;
 b=Gv+tohvhN+Q91PScXFZSx7Yqg3dd2TPLxKiFsIK9A7Qx4du0tJ3PLa19oqdrMlG/
 J8zxhIsPW3tBY5qn1bHUw5Iot5mzRvPkRA3IR4fnluUtb+DvGo6Z/SJdcHgtH3hrQWK
 LtrRp0QQyYArHz1vZJNxzlzeTk13hX0E1izuf6BM=
Received: by mx.zohomail.com with SMTPS id 1779982641704569.2331869375547;
 Thu, 28 May 2026 08:37:21 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Peter Chen <hzpeterchen@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
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
 dri-devel@lists.freedesktop.org, Chaoyi Chen <kernel@airkyi.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH v15 1/9] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Date: Thu, 28 May 2026 17:37:10 +0200
Message-ID: <q6ufdWF5QJ60i9KlIiE_AA@collabora.com>
In-Reply-To: <20260304094152.92-2-kernel@airkyi.com>
References: <20260304094152.92-1-kernel@airkyi.com>
 <20260304094152.92-2-kernel@airkyi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, 4 March 2026 10:41:44 Central European Summer Time Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The HPD function of Type-C DP is implemented through
> drm_connector_oob_hotplug_event(). For embedded DP, it is required
> that the DRM connector fwnode corresponds to the Type-C port fwnode.
> 
> To describe the relationship between the DP controller and the Type-C
> port device, we usually using drm_bridge to build a bridge chain.
> 
> Now several USB-C controller drivers have already implemented the DP
> HPD bridge function provided by aux-hpd-bridge.c, it will build a DP
> HPD bridge on USB-C connector port device.
> 
> But this requires the USB-C controller driver to manually register the
> HPD bridge. If the driver does not implement this feature, the bridge
> will not be create.
> 
> So this patch implements a generic DP HPD bridge based on
> aux-hpd-bridge.c. It will monitor Type-C bus events, and when a
> Type-C port device containing the DP svid is registered, it will
> create an HPD bridge for it without the need for the USB-C controller
> driver to implement it.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> 
> (no changes since v14)
> 
> Changes in v13:
> - Only register drm dp hpd bridge for typec port altmode device.
> 
> (no changes since v12)
> 
> Changes in v11:
> - Switch to using typec bus notifiers.
> 
> (no changes since v10)
> 
> Changes in v9:
> - Remove the exposed DRM_AUX_HPD_BRIDGE option, and select
> DRM_AUX_HPD_TYPEC_BRIDGE when it is available.
> - Add more commit comment about problem background.
> 
> Changes in v8:
> - Merge generic DP HPD bridge into one module.
> ---
> 
>  drivers/gpu/drm/bridge/Kconfig                | 10 ++++
>  drivers/gpu/drm/bridge/Makefile               |  1 +
>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 49 +++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index a250afd8d662..559487aa09a9 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -30,6 +30,16 @@ config DRM_AUX_HPD_BRIDGE
>  	  Simple bridge that terminates the bridge chain and provides HPD
>  	  support.
>  
> +if DRM_AUX_HPD_BRIDGE
> +config DRM_AUX_HPD_TYPEC_BRIDGE
> +	tristate
> +	depends on TYPEC || !TYPEC
> +	default TYPEC
> +	help
> +	  Simple bridge that terminates the bridge chain and provides HPD
> +	  support. It build bridge on each USB-C connector device node.
> +endif
> +
>  menu "Display Interface Bridges"
>  	depends on DRM && DRM_BRIDGE
>  
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index c7dc03182e59..a3a0393d2e72 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_DRM_AUX_BRIDGE) += aux-bridge.o
>  obj-$(CONFIG_DRM_AUX_HPD_BRIDGE) += aux-hpd-bridge.o
> +obj-$(CONFIG_DRM_AUX_HPD_TYPEC_BRIDGE) += aux-hpd-typec-dp-bridge.o
>  obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
>  obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
>  obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
> diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> new file mode 100644
> index 000000000000..d915e0fb0668
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0+

Having a copyright statement added here is likely required.
Something like

/*
 * Copyright (C) 2026 Rockchip Electronics Co., Ltd.
 *
 * Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>
 */

will suffice. While I hope it's never relevant for a driver this
small, explicit copyright statements in this form have a legal
effect in some jurisdictions like the US, where by law it
automatically dismisses the defense that the copyright holder
wasn't known.

> +#include <linux/of.h>
> +#include <linux/usb/typec_altmode.h>
> +#include <linux/usb/typec_dp.h>
> +
> +#include <drm/bridge/aux-bridge.h>
> +
> +static int drm_typec_bus_event(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{
> +	struct device *dev = (struct device *)data;

Small nitpick: The explicit (struct device *) cast of data isn't
needed here. Just

    struct device *dev = data;

will work fine. The benefit is that if the type of "data" ever changes
(e.g. from void *data to const void *data) then we're not silencing
a warning/error through an explicit cast.

> +	struct typec_altmode *alt = to_typec_altmode(dev);
> +
> +	if (action != BUS_NOTIFY_ADD_DEVICE)
> +		goto done;
> +
> +	/*
> +	 * alt->dev.parent->parent : USB-C controller device
> +	 * alt->dev.parent         : USB-C connector device
> +	 */
> +	if (is_typec_port_altmode(&alt->dev) && alt->svid == USB_TYPEC_DP_SID)
> +		drm_dp_hpd_bridge_register(alt->dev.parent->parent,
> +					   to_of_node(alt->dev.parent->fwnode));
> +
> +done:
> +	return NOTIFY_OK;
> +}

Nitpicking: the "done" label and "goto done" here is redundant.
You could remove the label and replace the goto with another
"return NOTIFY_OK;". There's no functional change here though.

> +
> +static struct notifier_block drm_typec_event_nb = {
> +	.notifier_call = drm_typec_bus_event,
> +};
> +
> +static void drm_aux_hpd_typec_dp_bridge_module_exit(void)
> +{
> +	bus_unregister_notifier(&typec_bus, &drm_typec_event_nb);
> +}
> +
> +static int __init drm_aux_hpd_typec_dp_bridge_module_init(void)
> +{
> +	bus_register_notifier(&typec_bus, &drm_typec_event_nb);
> +
> +	return 0;
> +}
> +
> +module_init(drm_aux_hpd_typec_dp_bridge_module_init);
> +module_exit(drm_aux_hpd_typec_dp_bridge_module_exit);
> +
> +MODULE_DESCRIPTION("DRM TYPEC DP HPD BRIDGE");
> +MODULE_LICENSE("GPL");
> 

Feel free to add yourself as MODULE_AUTHOR here. :)

With those things changed:

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Kind regards,
Nicolas Frattaroli


