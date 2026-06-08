Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAB0CD8CA6
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C583D10EE1F;
	Mon,  8 Jun 2026 07:22:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ui0nMbrQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8DA10EE1F
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:22:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 79572600AE;
 Mon,  8 Jun 2026 07:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7F71F00893;
 Mon,  8 Jun 2026 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780903335;
 bh=EGwF48TOxb/3r3jEtUXLothOzqXjtQDyqEkp8JCs1Kw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ui0nMbrQH2Hnj8sRo0Bois9+exTzWATKw562J3jFTtut3tSi3n0rUqa2DsMKZFLUt
 mxnLdq+41bEL2f992+z8LHJxAZo7DtrHm8f3d5m3Qba9ydtwlox3GYcNKgz7aoB1AA
 iAPjbr0Bk6rkimRqv89aXn2XTs3TzL0VbepvuTc6W3TcADrRmXEN/wInyhsOROBpDZ
 ccjUPzYDJ+jRdgu9PvSxf17OdjrHTqvBacyKzkey3xq/UvAolJwy0JWqOOzw4PvCC+
 Ez6vzNbstSMZ9eVol7Da3hn0M8HHQs6dIL+zu9FgD72zIbXBQf206waN/phKl7hBAT
 iNaOBdhd9VShA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] drm/bridge: Implement generic USB Type-C DP HPD bridge
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: olteanv@gmail.com, vkoul@kernel.org, dri-devel@lists.freedesktop.org,
 linux-phy@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20260608070805.88-2-kernel@airkyi.com>
References: <20260608070805.88-2-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 07:22:14 +0000
Message-Id: <20260608072214.DF7F71F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Unbounded memory leak and devres accumulation due to missing B=
US_NOTIFY_DEL_DEVICE handler.
- [High] Missing initialization for pre-existing Type-C devices.
- [High] Double bridge registration conflicts with explicit controller driv=
er bridges.
--

commit 8b46d64e255268bcd7c9f7656649f0dfbcb9e277
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: drm/bridge: Implement generic USB Type-C DP HPD bridge

This patch implements a generic DP HPD bridge that monitors Type-C bus
events. When a Type-C port device containing the DP SVID is registered,
it automatically creates an HPD bridge for it without requiring the USB-C
controller driver to implement the feature.

> diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/g=
pu/drm/bridge/aux-hpd-typec-dp-bridge.c
> new file mode 100644
> index 0000000000000..c09579ff7ab91
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0+
[ ... ]
> +static int drm_typec_bus_event(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{
> +	struct device *dev =3D (struct device *)data;
> +	struct typec_altmode *alt =3D to_typec_altmode(dev);
> +
> +	if (action !=3D BUS_NOTIFY_ADD_DEVICE)
> +		return NOTIFY_OK;

[Severity: Critical]
Since this only handles BUS_NOTIFY_ADD_DEVICE, will this leak memory when a
cable is unplugged?

Type-C altmode devices are frequently registered and unregistered during no=
rmal
operation. Because there is no BUS_NOTIFY_DEL_DEVICE handler to clean up th=
ese
bridges, and the registration uses a devm allocation attached to the parent
controller, won't every plug event leak a new bridge allocation and IDA ent=
ry?

> +
> +	/*
> +	 * alt->dev.parent->parent : USB-C controller device
> +	 * alt->dev.parent         : USB-C connector device
> +	 */
> +	if (is_typec_port_altmode(&alt->dev) && alt->svid =3D=3D USB_TYPEC_DP_S=
ID)
> +		drm_dp_hpd_bridge_register(alt->dev.parent->parent,
> +					   to_of_node(alt->dev.parent->fwnode));

[Severity: High]
Does this unconditionally allocate a new bridge even if the controller driv=
er
already allocated one?

Several Type-C controller drivers already explicitly allocate a DP HPD brid=
ge
for their device nodes during probe. If this notifier registers a second br=
idge
for the exact same device node, won't this create duplicate bridges?

This could break of_drm_find_bridge(), causing it to return the bridge crea=
ted
by this generic notifier while the controller driver continues sending even=
ts
to its explicitly created bridge, leading to missed HPD events.

> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block drm_typec_event_nb =3D {
> +	.notifier_call =3D drm_typec_bus_event,
> +};
> +
> +static void drm_aux_hpd_typec_dp_bridge_module_exit(void)
> +{
> +	bus_unregister_notifier(&typec_bus, &drm_typec_event_nb);
> +}

[Severity: Critical]
Does this module exit function leave dangling devres actions?

Unregistering the notifier prevents new events, but without a cleanup routi=
ne
here or a device removal handler, all previously accumulated devm actions f=
rom
plug events will remain attached to the controller devices indefinitely.

> +
> +static int __init drm_aux_hpd_typec_dp_bridge_module_init(void)
> +{
> +	bus_register_notifier(&typec_bus, &drm_typec_event_nb);
> +
> +	return 0;
> +}

[Severity: High]
If this module is loaded after the Type-C subsystem has already probed, will
it miss all existing devices?

bus_register_notifier() only invokes the callback for events that occur aft=
er
the notifier is registered. Do we need to manually iterate over existing
devices on typec_bus to ensure bridges are created for pre-existing DP
altmodes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608070805.88-1=
-kernel@airkyi.com?part=3D1
