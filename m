Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A47DC5AC67
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 18:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8595610F27F;
	Thu,  6 Aug 2026 18:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="bkoij3dw";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1C010F27F
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 18:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786039210; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AdF3bXdw4ifqRQn+Z14k05G3vBN2Zbw5ryBRX7nMIR34yKc3lqGiWCaUWIIW15KEjMwvZs2F6rVqE2sF3B3sYifDvM0o0dARZ3AFwIIyVEzAkVxP0plAROr31J7AnjQ8h6HZxKSGnUnxaq4AtvzWaM+GAmEAnmf7M/JvHEjppNE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786039210;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gtpJ1OnihTTKEzJSRRxLvCmwCvQZFllDLgsiyAu84JA=; 
 b=gN+QSq/EjgbOrzI3g/KtImaxS//xi0X0mGZykSqQBMUizTaab+6rZ1eDK3DxudoXFpl2pUcsI9cL5ym0IJuvnKkdCAlHTX+koWiMO7Vzx1fXNDUsUh1p+K4axrxQuYk7e4Rhtz8RTdZgRWDhBAV605/B3jYUlKnK8QgOBNOTGck=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786039210; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=gtpJ1OnihTTKEzJSRRxLvCmwCvQZFllDLgsiyAu84JA=;
 b=bkoij3dwB37+3nzXWtd8k7W3YzUKADxohIby+J7vcduon7XaNipa84gteRdEMpf6
 zVJrdo/JL+tTDaZrrTsQeioZst9VNocpTmgzmM4q4Px7dQgsDLXKrv0GDSmvTtucNvo
 WC/fMPuv+L2yPf0ElTXtt+/5TF8rm5yDGM96VBt8=
Received: by mx.zohomail.com with SMTPS id 1786039208126323.7662493941132;
 Thu, 6 Aug 2026 11:00:08 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id CF44C1808BD; Thu, 06 Aug 2026 20:00:01 +0200 (CEST)
Date: Thu, 6 Aug 2026 20:00:01 +0200
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
Subject: Re: [PATCH v6 2/7] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Message-ID: <anTK6xqHcTn62fiN@venus>
References: <20260804070730.68-1-kernel@airkyi.com>
 <20260804070730.68-3-kernel@airkyi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ugiil5heltqaqved"
Content-Disposition: inline
In-Reply-To: <20260804070730.68-3-kernel@airkyi.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/286.26.37
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


--ugiil5heltqaqved
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/7] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
MIME-Version: 1.0

Hi,

On Tue, Aug 04, 2026 at 03:07:25PM +0800, Chaoyi Chen wrote:
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

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>

As mentioned in previous patch, 1x duplication still happens for
drivers that currently do a manual HPD bridge registration. IMHO
this is fine as the manual registration can be removed as a
follow-up anyways.

Greetings,

-- Sebastian

> Changes in v6:
> - Avoid duplicate registration of the same DisplayPort HPD bridge.=20
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
>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 67 +++++++++++++++++++
>  3 files changed, 78 insertions(+)
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
> index 000000000000..682bc192e093
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
> +	 * Register the HPD bridge for these devices.
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

--ugiil5heltqaqved
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmp0y6EACgkQ2O7X88g7
+pqeMhAAop4PMlriumn53C/b8+hkuAPzNz/c9n07pHZ2RNEh/j+6cvJEwZob4kkH
isJNqDmSlD8GnlIbAwLKzxqmj55Uvza59VhpLORJOFGxVtXYPLZt4Y9JRwVSm59C
bQIJ7zBuRDrpaPXrobdKnn0DLUJA7eSGwIQFNDbtS8z4DDzFLbR+nVlO+kvBMTBw
BLQY9h4cjoD62tz4f8uMdsVGq2KaSRo/xacF2Ey5JFTtZkdXD0+8VIUZ5BFaJOjz
jCb1jHkEniLDIRJO4a4Fz6WQJTMvGRjqPFe/rR1KLX7UHUTbqyfMUGq+8FoTOcep
loV5Mqb02BRdl6b2X0y5Cr7fYpAVKe7edctXyjXVAKwmGmm5dasp8MtRuNg4hZij
N5Jcz9q9sySzU+VVd6v6B2KAzUnjJAi3h2i4QhklU2CYsmy+h67LqFvvvbopVT7I
Cb4XDGy3QRrkVoV5SELhBKY161Y9mo0mEeZSaRMt6ZeGJHbIVx5tSU1nthFcRFJi
45arT2hkhE8DUGf3YHwHeJKNx6pyl0PoDZM4bUrwW051Dx5dYW4iq/clCvWwSthS
SFK+6h3yqcKZGHM+YMM2GQTIbf6dS8uMwvHy5t135ifFLu7FuLbnnhPYASbhQbKH
LAiToqKpTM7BlMAuaVK0dMQcArbpdx4cnYysWDuAB408gQppyhY=
=VzYA
-----END PGP SIGNATURE-----

--ugiil5heltqaqved--
