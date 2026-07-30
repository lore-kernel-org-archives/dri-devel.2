Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A085C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D3F010ED15;
	Thu, 30 Jul 2026 01:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZuiVhjnX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2A910ED15
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:50:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E42414044D;
 Thu, 30 Jul 2026 01:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F58C1F000E9;
 Thu, 30 Jul 2026 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785376225;
 bh=sPJ6ULkhyfrBg52VO2+8LMzp105F0zO8YixV9ovEcUc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZuiVhjnXxVBf02//xANfakl9wU1LltELFcyHQV/Jtero2uW/0ST5g2vPuFj0hiiDm
 RKrHdAtSbcDW9PWLp8IoN0VFVVttetzOC/3r+Wzk7tp1uavXbyMf0+0felVw/hCLai
 Th8v54+/nEvRTpg8MNec3CdNUNJpKCOVQuU0kK56rsjZ35+VxyD302ii/TxIdOLb6K
 CYk1HTZlJndOeoYFHTG+yTkWHQgUPX0o6DVLgq0g/bTbS8dHXnvXQCpD4eLuyCaN9l
 WqspbZe8ryvgxWO+hcDDEmEYt5f5j17a19jb3erjuvmQlFFv1Jnqln4zFFi1MacYXY
 3LvZlH7MNg4FA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: linux-phy@lists.infradead.org, olteanv@gmail.com, vkoul@kernel.org,
 neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260730013349.51-2-kernel@airkyi.com>
References: <20260730013349.51-1-kernel@airkyi.com>
 <20260730013349.51-2-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:50:24 +0000
Message-Id: <20260730015025.5F58C1F000E9@smtp.kernel.org>
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
- [High] Resource leak and duplicate bridge registration on module reload d=
ue to lifecycle mismatch.
- [High] Duplicate registration conflict with USB-C controller drivers that=
 natively implement HPD bridges.
- [Medium] Race condition between bus notifier registration and device iter=
ation leading to duplicate bridge registration.
--

--- Patch [1]: [PATCH v5 1/6] drm/bridge: Implement generic USB Type-C DP H=
PD bridge ---
commit 9877135b6e3e85a72f21170c14a083ad3e0308af
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/bridge: Implement generic USB Type-C DP HPD bridge

This patch implements a generic USB Type-C DP HPD bridge that monitors the
Type-C bus for devices containing the DP SVID. It automatically creates an
HPD bridge for these devices without requiring the USB-C controller driver
to implement it manually.

> diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/g=
pu/drm/bridge/aux-hpd-typec-dp-bridge.c
> new file mode 100644
> index 0000000000000..43af3ea20f201
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> @@ -0,0 +1,64 @@

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
Does this unconditional registration create duplicate bridges for controller
drivers (like fusb302 or qcom_pmic_typec) that already manually allocate
their own HPD bridge for the same device node?

If the DRM subsystem binds to the generic bridge instead of the native one,
could HPD events sent by the controller via drm_aux_hpd_bridge_notify() to
its private bridge be lost?

[ ... ]

> +static void drm_aux_hpd_typec_dp_bridge_module_exit(void)
> +{
> +	bus_unregister_notifier(&typec_bus, &drm_typec_event_nb);
> +}

[Severity: High]
Does this leak resources and create duplicate bridges if the module is unlo=
aded
and reloaded?

Since drm_dp_hpd_bridge_register() uses devm semantics tied to the USB-C
controller device (alt->dev.parent->parent) rather than this observer modul=
e,
the bridges will outlive the module. When the module is reloaded, it will
iterate the bus and unconditionally allocate a second set of duplicate brid=
ges.

> +
> +static int __init drm_aux_hpd_typec_dp_bridge_module_init(void)
> +{
> +	bus_register_notifier(&typec_bus, &drm_typec_event_nb);
> +	/*
> +	 * Before module initialization, some devices may have already been add=
ed.
> +         * Register the HPD bridge for these devices.
> +	 */
> +	bus_for_each_dev(&typec_bus, NULL, NULL, check_device_already_added);

[Severity: Medium]
Is there a race condition here between registering the bus notifier and ite=
rating
over the existing devices?

If a Type-C altmode device is added concurrently during module initializati=
on,
could it trigger the notifier callback and also be processed by the bus ite=
ration
loop? Since drm_dp_hpd_bridge_register() lacks deduplication logic, this TO=
CTOU
race might result in duplicate bridge registrations.

> +	return 0;
> +}
> +
> +module_init(drm_aux_hpd_typec_dp_bridge_module_init);
> +module_exit(drm_aux_hpd_typec_dp_bridge_module_exit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730013349.51-1=
-kernel@airkyi.com?part=3D1
