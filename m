Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24F0C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED64C10F301;
	Fri, 28 Aug 2026 09:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GyblVS6A";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5461310F301
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:04:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A40E601F7;
 Fri, 28 Aug 2026 09:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020EA1F000E9;
 Fri, 28 Aug 2026 09:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787907881;
 bh=wNslpbbiWhhziyESvBTgmPZlIYJZZTzsUdAjpzjD20E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GyblVS6Ax+vy0FgglWG8+QLy2Sr/vkwhQIu0SG3W8hERp3tdgtC0flBmw6RWVrDoU
 4tdu4cO0PQ+lFJSFLcbRqMl1xGQEOFN9/Lk6jz+vO4+UmqZPllDu0+zuz8uC08ReQ0
 jeQYRLAXr4Aj32QZgMm+FickhfesrYLPeHE5tOop3nlQhel1QLZ8dGpXWKX+AiYHXI
 mRaTZejDzFoZIJP83S6hoopRM6W1oh0wBqqo2VRDUOWb40yD7f6QR/ZNdUBoEX7MaH
 quLWyEV5m1oDNEaUwq2CTg1j40GM64KUXQv35he83wMr1V4ak98KWMWaaBqco+/jMw
 ghSNCXMpsx2JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/7] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: olteanv@gmail.com, linux-phy@lists.infradead.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260828084737.565-3-kernel@airkyi.com>
References: <20260828084737.565-1-kernel@airkyi.com>
 <20260828084737.565-3-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:04:40 +0000
Message-Id: <20260828090441.020EA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Attaching devm actions to an unowned device without strict depende=
ncies causes a use-after-free panic on module unload.
- [Medium] Missing NULL check for the OF device node causes broken bridge r=
egistration on non-Device Tree systems for multi-port controllers.
- [Medium] Concurrent execution of bus iteration and notifier callback caus=
es duplicate bridge registration.
- [Low] The Kconfig dependency allows the module to be built when CONFIG_TY=
PEC is disabled, causing a link error.
--

commit 9eab2892d2a7baba27c2d68547a8aad1b13a8541
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/bridge: Implement generic USB Type-C DP HPD bridge

This commit implements a generic DisplayPort HPD bridge based on USB Type-C
events. It registers a bus notifier on the typec_bus to automatically create
HPD bridges for Type-C ports with the DP alternate mode. This removes the
need for individual USB-C controller drivers to manually register the bridg=
e.

> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index 4a57d49b4c6d3..9739b2a197586 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -30,6 +30,16 @@ config DRM_AUX_HPD_BRIDGE
[ ... ]
> +if DRM_AUX_HPD_BRIDGE
> +config DRM_AUX_HPD_TYPEC_BRIDGE
> +	tristate
> +	depends on TYPEC || !TYPEC

[Severity: Low]
Will this dependency allow the module to be built when CONFIG_TYPEC is
disabled?=20

If CONFIG_TYPEC=3Dn, the condition "!TYPEC" evaluates to true. However, the=
=20
source file unconditionally uses symbols from the Type-C subsystem, which=20
would result in unresolved external symbols during linking.

> +	default TYPEC
> +	help
> +	  Simple bridge that terminates the bridge chain and provides HPD
> +	  support. It build bridge on each USB-C connector device node.
> +endif
[ ... ]
> diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/g=
pu/drm/bridge/aux-hpd-typec-dp-bridge.c
> new file mode 100644
> index 0000000000000..682bc192e0934
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
[ ... ]
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

[Severity: Medium]
What happens on non-Device Tree systems (like ACPI) where to_of_node()=20
returns NULL?=20

It looks like np will be NULL, and if there are multiple ports on the same=
=20
controller, they could all alias to the same NULL platform data. Does this=
=20
mean only the first port gets a bridge and subsequent ports are skipped?

> +			drm_dp_hpd_bridge_register(alt->dev.parent->parent, np);

[Severity: High]
Does attaching a devm-managed resource to the unowned USB-C controller
device (alt->dev.parent->parent) risk a use-after-free on module unload?=20

Since the observer module doesn't clean these up on exit, the devm actions
could outlive the module. This might crash the system when the controller=20
is eventually unbound and devres executes the unmapped cleanup action.

> +	}
> +
> +	return NOTIFY_OK;
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
Can a device be processed twice here?=20

By registering the bus notifier before iterating over existing devices, is=
=20
there a race condition where a newly added device triggers the notifier=20
concurrently while bus_for_each_dev() is evaluating it?=20

The check-and-register sequence in drm_typec_bus_event() doesn't appear to=
=20
use locking, which might lead to duplicate bridge registrations.

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828084737.565-=
1-kernel@airkyi.com?part=3D2
