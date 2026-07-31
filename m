Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D9FC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C1710E20D;
	Fri, 31 Jul 2026 14:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="QrZir8gD";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDE410E20D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785507608; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gonwM0okZ6hITbCN/Ts7G4RSWCX89laF+zumSUVrwAm3oSEImua8/Ip3XZcGnxGl6XULlPKir3oD+3KhbSjsBbHJmflovKlVNIet0TDQsXb8fx/h/+dT+UySSYxxy8WmZuNHv7rmBoz54JNsjmDndkN0KzNKJRvCiAzgsmnR6L0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785507608;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GgkkzLgavD1JLOx9pOWVhcYj+T5mcWCBWQkfA5oQhms=; 
 b=GO84OCE01uj9mMMoC8z/5OXltmEtqpXuHswEdTAQV34Pwa6FrxD8eUBTRduk0R2XrpptLJMj1k37Vv17SECccV8EYkX0jKqBt474eRpYtZiLi7vqIIJ8h7pkAcWX6adfFINnaHCzLHTTNRqrU2sOpFsade18MPzbvyu+6ec57Bg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785507608; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=GgkkzLgavD1JLOx9pOWVhcYj+T5mcWCBWQkfA5oQhms=;
 b=QrZir8gD1Fhl9tzI/e8fj0GnAtfLqy68zI9Af7VVWI+IfKh65fPf+imDzAqgKqPD
 wUDfyPTDepxJe5R4FEnzDMOw676FlFfi2td6hv0a8mj7wfEnofA0ik73cXA2DAn2ojj
 zzFcZ+pxpDWEmGy+u/SUGIL66JCeHlrmrXRkBV0w=
Received: by mx.zohomail.com with SMTPS id 1785507607193239.6197346559776;
 Fri, 31 Jul 2026 07:20:07 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id A7E0118029A; Fri, 31 Jul 2026 16:20:00 +0200 (CEST)
Date: Fri, 31 Jul 2026 16:20:00 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Vinod Koul <vkoul@kernel.org>, Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 1/6] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Message-ID: <amyp3C_yzxpKzigR@venus>
References: <20260730013349.51-1-kernel@airkyi.com>
 <20260730013349.51-2-kernel@airkyi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mc36q3ts5ojyt2ub"
Content-Disposition: inline
In-Reply-To: <20260730013349.51-2-kernel@airkyi.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.486.37
X-ZohoMailClient: External
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


--mc36q3ts5ojyt2ub
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/6] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
MIME-Version: 1.0

Hi,

On Thu, Jul 30, 2026 at 09:33:44AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>=20
> The HPD function of Type-C DP is implemented through
> drm_connector_oob_hotplug_event(). For embedded DP, it is required
> that the DRM connector fwnode corresponds to the Type-C port fwnode.
>=20
> To describe the relationship between the DP controller and the Type-C
> port device, we usually using drm_bridge to build a bridge chain.
>=20
> Now several USB-C controller drivers have already implemented the DP
> HPD bridge function provided by aux-hpd-bridge.c, it will build a DP
> HPD bridge on USB-C connector port device.
>=20
> But this requires the USB-C controller driver to manually register the
> HPD bridge. If the driver does not implement this feature, the bridge
> will not be create.
>=20
> So this patch implements a generic DP HPD bridge based on
> aux-hpd-bridge.c. It will monitor Type-C bus events, and when a
> Type-C port device containing the DP svid is registered, it will
> create an HPD bridge for it without the need for the USB-C controller
> driver to implement it.
>=20
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>=20
> (no changes since v5)
>=20
> Changes in v4:
> - Scan the entire typec_bus and attempt to register the hpd bridge,
>   so as not to miss devices that were already added during initialization.
>=20
> (no changes since v3)
>=20
> Changes in v2:
> - Add copyright text.
> - Remove useless goto.
> ---
>  drivers/gpu/drm/bridge/Kconfig                | 10 +++
>  drivers/gpu/drm/bridge/Makefile               |  1 +
>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 64 +++++++++++++++++++
>  3 files changed, 75 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
>=20
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index 4a57d49b4c6d..9739b2a19758 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -30,6 +30,16 @@ config DRM_AUX_HPD_BRIDGE
>  	  Simple bridge that terminates the bridge chain and provides HPD
>  	  support.
> =20
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
> =20
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Mak=
efile
> index 15cc821d85b7..d88a9e1ccc9a 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_DRM_AUX_BRIDGE) +=3D aux-bridge.o
>  obj-$(CONFIG_DRM_AUX_HPD_BRIDGE) +=3D aux-hpd-bridge.o
> +obj-$(CONFIG_DRM_AUX_HPD_TYPEC_BRIDGE) +=3D aux-hpd-typec-dp-bridge.o
>  obj-$(CONFIG_DRM_CHIPONE_ICN6211) +=3D chipone-icn6211.o
>  obj-$(CONFIG_DRM_CHRONTEL_CH7033) +=3D chrontel-ch7033.o
>  obj-$(CONFIG_DRM_CROS_EC_ANX7688) +=3D cros-ec-anx7688.o
> diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/g=
pu/drm/bridge/aux-hpd-typec-dp-bridge.c
> new file mode 100644
> index 000000000000..43af3ea20f20
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> @@ -0,0 +1,64 @@
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

So there are 3 ways to end up with duplicated hpd bridges now:

1. TypeC controller driver already registered one manually
2. There is a race in drm_aux_hpd_typec_dp_bridge_module_init, if a
   device appears between registering the notifier and looping
   through all pre-existing devices
3. Reloading the aux-hpd-typec-dp-bridge module re-registers the
   bridges

It's not a huge problem as the system works with the duplicated HPD
bridges, but it's also quite ugly.

I think it can be trivially avoided by adding this function to
drivers/gpu/drm/bridge/aux-hpd-bridge.c and then making use of it
here as an additional check (code untested):

bool drm_device_has_dp_hpd_bridge(struct device *parent)
{
	struct device *hpd_bridge =3D device_find_child_by_name(parent, "dp_hpd_br=
idge");

	if (!hpd_bridge)
		return false;

	put_device(hpd_bridge);
	return true;
}
EXPORT_SYMBOL_GPL(drm_dev_has_dp_hpd_bridge);

That would solve all of the above, but leaves one problem when this
module races against manual device creation in a TypeC controller
driver. That could be avoided by doing the check in
devm_drm_dp_hpd_bridge_alloc() under a lock, but that's probably not
worth the trouble (it would require updating all users to handle a
new error code like -EEXIST) considering manual registration can be
removed from all drivers anyways.

Greetings,

-- Sebastian

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
> +
> +static void drm_aux_hpd_typec_dp_bridge_module_exit(void)
> +{
> +	bus_unregister_notifier(&typec_bus, &drm_typec_event_nb);
> +}
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
> +	return 0;
> +}
> +
> +module_init(drm_aux_hpd_typec_dp_bridge_module_init);
> +module_exit(drm_aux_hpd_typec_dp_bridge_module_exit);
> +
> +MODULE_AUTHOR("Chaoyi Chen <chaoyi.chen@rock-chips.com>");
> +MODULE_DESCRIPTION("DRM TYPEC DP HPD BRIDGE");
> +MODULE_LICENSE("GPL");
> --=20
> 2.53.0
>=20

--mc36q3ts5ojyt2ub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpsrwkACgkQ2O7X88g7
+poJkw/+KMpk0PnZBYCg+0tfUFBXNrjPd5jqvIzb1eMIcgN/E1jW9Qt79O6yXAAZ
uwdcsGKpQ+DG8mmWZwirFCeeNCXP+GWntMKVkNY4SkLJQWNNha+B/KKuP1sobfP9
c/Td1GfZSMJPG01KtOHpc3lL2R05nJp0v1fZOBPT8TjnH+4E+0XZDgaMtDZataDA
p8lEUIOy9ZdVIV3yKRHesuGazKtSTxbNxaX23zqoTPipnuuJtqEP/DC/Z4NUIy5f
yZhCNyNH9r8T6xXjhS3Wrg5A7bqz2x5X2UhEnLtKfVYpCo0TZh1vXgkSbQ9Sx8ff
n7GQaeDiqZbo87sgCSRtbdXD1TBYgFHoY86qg0cZx2acwEe8mnxYpxV04ScAK4ef
IsPhu/IlqZ21S0BRJfYLzDxWGofxDNOiB5CSrFwtpk6g4YHpfIbavMgRQNVqeQ92
s6AiBvA4ot9fqtQTP9dZrT990c8qaluDVZKRoJgdG1nSfVjjZSlsennQi/EpS8yY
cL41RQQdNNt1edxs/O/L0KcNrgPojwdx9NwydaO5iKEcGnqQRBg47+lrGFRlcnX3
43HEL5S+F+qcO2cGp7W7B6oFpfSNGxjkMYjIuKmnI+rSCzfodseNcfhEqJLdGbOM
DxRmSgCpGAlXirP95hduaKSR2UJ1PwvNUYCfR5LAh5mCApd7VuM=
=DFla
-----END PGP SIGNATURE-----

--mc36q3ts5ojyt2ub--
