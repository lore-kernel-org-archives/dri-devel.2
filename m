Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2A7C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1638910E105;
	Tue,  4 Aug 2026 07:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hwDYHIzB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 225D410E8A3
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:25:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B212B40E11;
 Tue,  4 Aug 2026 07:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5181F000E9;
 Tue,  4 Aug 2026 07:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785828335;
 bh=bYcaCt0xMAcbFnpLnp3GWiVqN5QIaz2WDsc6pvMHAXg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hwDYHIzBIIH3qOC5X+1dsaF7fkQPiZBxwdbssECa5d39eGDP24Sa1n2KswM5fitdA
 I1XA3aDUVB7l5Trb5qg48SUYL68PgjspgsKQiM8rqQYMxo0pVwTXZWudg8Jc9nXn0N
 zQad8E/EferRULaOFyC/zgu3k8Hjp3yndGaZLCbuPZlzMsR3LcFMXOvGfIIWkwrMo9
 zNba+An7SfptTMRA/Q9E6u9/Y+satmo3dNVo2PPVoNDGc4Z/xi3UnwZKv8UUMrb5bk
 CHbYW3vpw+sJIsxF63EvzpalZcUeib8Hd6JaWz/wMH0x6gTA+7bXEwCncCuGVYhx1R
 jeaUqbyj33qHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/7] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20260804070730.68-3-kernel@airkyi.com>
References: <20260804070730.68-1-kernel@airkyi.com>
 <20260804070730.68-3-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:25:34 +0000
Message-Id: <20260804072535.5F5181F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Type-C DP HPD bridges are erroneously shared across multiple ports=
 on non-DeviceTree (e.g., ACPI) systems due to NULL `of_node` matching.
- [Medium] Double registration of the DP HPD bridge due to a TOCTOU race co=
ndition between module initialization and concurrent device addition.
--

--- Patch [2]: [PATCH v6 2/7] drm/bridge: Implement generic USB Type-C DP H=
PD bridge ---
commit da360ed1d856c20444642867c8a203f9c48362b1
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/bridge: Implement generic USB Type-C DP HPD bridge

This patch implements a generic DP HPD bridge based on aux-hpd-bridge.c.
It monitors Type-C bus events, and when a Type-C port device containing
the DP svid is registered, it will create an HPD bridge for it without
the need for the USB-C controller driver to implement it.

> diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/g=
pu/drm/bridge/aux-hpd-typec-dp-bridge.c
> new file mode 100644
> index 0000000000000..682bc192e0934
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Rockchip Electronics Co., Ltd.
> + *
> + * Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> + */
> +#include <linux/of.h>
> +#include <linux/usb/typec_altmode.h>
> +#include <linux/usb/typec_dp.h>
> +
> +#include <drm/bridge/aux-bridge.h>
> +
> +static int drm_typec_bus_event(struct notifier_block *nb, unsigned long =
action,
> +			       void *data)
> +{
> +	struct device *dev =3D (struct device *)data;
> +	struct typec_altmode *alt =3D to_typec_altmode(dev);
> +	struct device_node *np;
> +
> +	if (action !=3D BUS_NOTIFY_ADD_DEVICE)
> +		return NOTIFY_OK;
> +
> +	/*
> +	 * alt->dev.parent->parent : USB-C controller device
> +	 * alt->dev.parent         : USB-C connector device
> +	 */
> +	if (is_typec_port_altmode(&alt->dev) && alt->svid =3D=3D USB_TYPEC_DP_S=
ID) {
> +		np =3D to_of_node(alt->dev.parent->fwnode);
> +		if (!drm_dev_has_dp_hpd_bridge(alt->dev.parent->parent, np))
> +			drm_dp_hpd_bridge_register(alt->dev.parent->parent, np);

[Severity: High]
On non-DeviceTree systems (like ACPI platforms), will this fail to register
subsequent DP ports on a single USB-C controller?

Since to_of_node() evaluates to NULL for non-OF systems, np will be NULL.
When the first port registers the bridge, it uses NULL as the device node.
When the second port is processed, drm_dev_has_dp_hpd_bridge() will search
for an existing bridge. The underlying hpd_bridge_match() function checks:

    return adev->dev.platform_data =3D=3D np;

Since adev->dev.platform_data is NULL and np is NULL, this returns true,
incorrectly concluding that the second port's bridge is already registered.
Could this silently break hotplug detection for those additional ports?

> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block drm_typec_event_nb =3D {
> +	.notifier_call =3D drm_typec_bus_event,
> +};
> +
> +static int check_device_already_added(struct device *dev, void *data)
> +{
> +	drm_typec_bus_event(NULL, BUS_NOTIFY_ADD_DEVICE, dev);
> +	return 0;
> +}

[ ... ]

> +static int __init drm_aux_hpd_typec_dp_bridge_module_init(void)
> +{
> +	bus_register_notifier(&typec_bus, &drm_typec_event_nb);
> +	/*
> +	 * Before module initialization, some devices may have already been add=
ed.
> +	 * Register the HPD bridge for these devices.
> +	 */
> +	bus_for_each_dev(&typec_bus, NULL, NULL, check_device_already_added);

[Severity: Medium]
Could this setup a race condition resulting in a double registration of the
DP HPD bridge?

If a device is hotplugged precisely during module loading, the notifier
runs on the hotplug thread, and bus_for_each_dev() might visit the same
device on the init thread. Both threads would evaluate
!drm_dev_has_dp_hpd_bridge() as true in drm_typec_bus_event() since it is
a lockless check.

Would this cause drm_dp_hpd_bridge_register() to be called twice for the
same USB-C controller port?

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804070730.68-1=
-kernel@airkyi.com?part=3D2
