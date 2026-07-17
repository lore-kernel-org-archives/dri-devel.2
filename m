Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64627C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C864A10F47F;
	Fri, 17 Jul 2026 07:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C1PAPEpu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383F810F47F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:36:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 106C9418D7;
 Fri, 17 Jul 2026 07:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915271F000E9;
 Fri, 17 Jul 2026 07:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784273794;
 bh=BIsp1ltMnRr84xlghlTilwM82ZDWiQ3SKYI7CyJYQHA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C1PAPEpuH1lQj4CbatXZ7srbjMTUF5cZ5GmE95anTg/pPRFIyQ94GFIw2jMKSFqJ0
 TY9ZWtScNVFUfbhgtRV9dOcLBmJ4wgIjKpKHK+Igkulc3iFDDHylZykj49RO+hm4O8
 yrdq+ivAux0cHha+uNFqFK2BFWt5HplccUn/931X+vlXar58akKCnDoNkp+CV/Vnz5
 raOUVwpIUewTXy/i07Mm6AB6l3uO8gGLrWFjH2ycHZPEK4aIQMll9HSTNd+du3GQM1
 PQaOG6CyhRX7g8V05akTT8sXKYad0N558PjKBkgeG/XyGJe9jRCWvxn47pnAxOZ7z5
 Q8FwRV7aog8CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org
In-Reply-To: <20260717072323.96-2-kernel@airkyi.com>
References: <20260717072323.96-1-kernel@airkyi.com>
 <20260717072323.96-2-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 07:36:34 +0000
Message-Id: <20260717073634.915271F000E9@smtp.kernel.org>
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
- [High] The module registers a bus notifier to catch device additions but =
fails to iterate over already-registered devices, ignoring any Type-C ports=
 present before the module was loaded.
- [High] The module attaches devm-managed bridges to a foreign USB-C contro=
ller device but fails to clean them up on module unload or device removal, =
leading to resource leaks and an execute-after-free kernel panic.
- [Medium] The return value of `bus_register_notifier()` is ignored.
--

--- Patch [1]: [PATCH v3 1/5] drm/bridge: Implement generic USB Type-C DP H=
PD bridge ---
commit 5c3c19cbb4491c572fdd386c797dfba9412af2b3
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/bridge: Implement generic USB Type-C DP HPD bridge

This patch implements a generic DP HPD bridge based on aux-hpd-bridge.c.
It monitors Type-C bus events and automatically creates an HPD bridge when
a Type-C port device containing the DP svid is registered.

> diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/g=
pu/drm/bridge/aux-hpd-typec-dp-bridge.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> @@ -0,0 +1,54 @@
[ ... ]
> +static int drm_typec_bus_event(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{
> +	struct device *dev =3D (struct device *)data;
> +	struct typec_altmode *alt =3D to_typec_altmode(dev);
> +
> +	if (action !=3D BUS_NOTIFY_ADD_DEVICE)
> +		return NOTIFY_OK;
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
Will this leak devm resources on the controller device when a port is remov=
ed
and re-added, since BUS_NOTIFY_DEL_DEVICE is ignored?

Also, because the devm cleanup callbacks are tied to the controller device
rather than this module, could this cause an execute-after-free panic?
If this module and aux-hpd-bridge are unloaded, the devres callbacks on the
controller will point to unmapped memory when the controller is later unbou=
nd.

[ ... ]
> +static int __init drm_aux_hpd_typec_dp_bridge_module_init(void)
> +{
> +	bus_register_notifier(&typec_bus, &drm_typec_event_nb);

[Severity: Medium]
Is it safe to ignore the return value of bus_register_notifier() here?

If the notifier registration fails, the module initialization will succeed =
but
remain non-functional.

[Severity: High]
Does this code miss existing Type-C DP ports that were probed before this
module was loaded?

bus_register_notifier() only triggers notifications for devices added after
registration. Since there is no bus_for_each_dev() iteration over existing
devices on the typec_bus after registering the notifier, pre-existing ports
might never get an HPD bridge created.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717072323.96-1=
-kernel@airkyi.com?part=3D1
