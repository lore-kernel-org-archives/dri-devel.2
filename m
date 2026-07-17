Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC984C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 17:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287F110E24D;
	Fri, 17 Jul 2026 17:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Kt6hXTUP";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ECE510E4DA
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 17:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784308778; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=H4pcaiyWw5sNUEJZbm9eM14QxzQ3Fs5J/zfbyV0gtqk2u2v4xJDuHRHpJrMW4yt/U89AweWnlDnKJVWJ9EJh2HDtzg3qoDhYlz9QeCZgEupMPqCn8FsN5Fef2I9+RNV5PQvDSgZagf80bsYu6HdpvxEIL+5lpEckH+axrSLiKFA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784308778;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ogRVHXmQ7ZTJHboM5CyugXRM1/jtS4o3Av3SvfnT0jM=; 
 b=Rb7JV/PRuKjmFm0CH5WxKJ4Mj6i1P7r5AKeRg2rN3MsSwrNkfq/sXt5U/JHt16WU2YBz6hxJpwguBbEqDQceav8DUK63eoyiRWGOR1BPn45vOY2wFBfpyDLrt0KTqUcoNkWwn9bjiskzT/ZRZ/FonO9dcLRF4H245+ZSLIgc1tc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784308777; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=ogRVHXmQ7ZTJHboM5CyugXRM1/jtS4o3Av3SvfnT0jM=;
 b=Kt6hXTUPPH6CFVs5HGy+sK42o+r4NCkzV6Q9KDzVFjAQW/qbb1HX75xBc8USxQgx
 RexIGKLGYtbvejBVzCeDDvxU/hevu/BjXDIhBq48yYc0cn0fZjxN7Wjiv0+aYjBEVgt
 YAda0f9SiK99bk32KBOvI3qSvslKA4kIskVrC6RI=
Received: by mx.zohomail.com with SMTPS id 178430877525932.612933366387324;
 Fri, 17 Jul 2026 10:19:35 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 1F724181CD9; Fri, 17 Jul 2026 19:19:29 +0200 (CEST)
Date: Fri, 17 Jul 2026 19:19:29 +0200
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
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 1/5] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Message-ID: <alpeAqKo72pwOEnX@venus>
References: <20260717072323.96-1-kernel@airkyi.com>
 <20260717072323.96-2-kernel@airkyi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jbdw5cv6ljemwd7w"
Content-Disposition: inline
In-Reply-To: <20260717072323.96-2-kernel@airkyi.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.287.57
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


--jbdw5cv6ljemwd7w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/5] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
MIME-Version: 1.0

Hello,

On Fri, Jul 17, 2026 at 03:23:19PM +0800, Chaoyi Chen wrote:
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
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com> # ArmSom Sig=
e5

I gave this a test together with the RK3588/RK3576 USB-C DP AltMode
patches I'm working on. As the fusb302 does a manual registration
for the DRM bridge in its probe function, the bridge is registered
twice:

root@sige5 # cat /sys/kernel/debug/dri/bridges
=2E..
bridge[1]: drm_aux_hpd_bridge_funcs
	refcount: 4
	type: [10] DP
	OF: /soc/i2c@2ac50000/typec-portc@22/connector:usb-c-connector
	ops: [0x4] hpd
bridge[2]: drm_aux_hpd_bridge_funcs
	refcount: 2
	type: [10] DP
	OF: /soc/i2c@2ac50000/typec-portc@22/connector:usb-c-connector
	ops: [0x4] hpd
=2E..

Apparently the USB-C DP AltMode keeps working, so this just wastes
a few CPU cycles and some memory. So this can land and then we can
remove the manual code from the driver as a follow-up step. I also
gave that a try and things keep working. I won't send the fusb302
patch for now to ensure its not applied before this patch lands.

Greetings,

-- Sebastian

> (no changes since v3)
>=20
> Changes in v2:
> - Add copyright text.
> - Remove useless goto.
>=20
> ---
>  drivers/gpu/drm/bridge/Kconfig                | 10 ++++
>  drivers/gpu/drm/bridge/Makefile               |  1 +
>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 54 +++++++++++++++++++
>  3 files changed, 65 insertions(+)
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
> index 000000000000..c09579ff7ab9
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> @@ -0,0 +1,54 @@
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
> +MODULE_AUTHOR("Chaoyi Chen <chaoyi.chen@rock-chips.com>");
> +MODULE_DESCRIPTION("DRM TYPEC DP HPD BRIDGE");
> +MODULE_LICENSE("GPL");
> --=20
> 2.53.0
>=20

--jbdw5cv6ljemwd7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpaZBQACgkQ2O7X88g7
+po4qA/+IBHGDueFgcm82WUb8KlcPZXHjJIodD4gCNh2En34PfHdv2tgAZk8FNoa
130uQsjBUVejRARr4hgsqrKrisG/t/JfzHqg1DZpeok3j+sqCCDjuOYg3HBRrpjx
WgTnxT7RWYqUjKE1bNX957wGBqggHx53///8/q2wwk4lCg99GEkoEqbbCgL4nQtb
qwaQxOzI012LR46Q1c7lfSYYtjIAJEP2ojNbQUyUSuP58zZs2LsgdR0x8QVHx8h+
PdwS92uTNQ5iMEWZh/jkB3xUaS3Rr9avZSwdaRgL0nGYnsuC5gBDBuVQtgFztnJl
gK80/W5U61uXnj4IY1i61+V5jwNvBbqnSG0VXaN85zbMEhH6IwWPFb4SFm2NduwN
ba93B+wOyFXoTZ+xPy1PLjQ3jwaHG91tw2gQLurisvb9+eAbGdFKbG2t6pkvCuD2
LcwFHTSTD/gpsWMRiz4Lbz0I49jSRgW5x0wB4HOsOMDrFVDR8+MqNKMKHdErPqRp
ZUeligeDaPclFpvT/ea7ChBipXN6/T6DvnwWe+Rsrn663mE3Y+GgOHiCYyfZZcRc
SZk1gwoEskqaR6tguKoHT5hJwH30MVTmQDLL5I8AFij9LVl7MehM+DPjS+kRTE35
FnmtXnvKOa19o/QDH4N/zq1C+ayxbN+IQKCaJ2g3irXGVpl4q38=
=wii+
-----END PGP SIGNATURE-----

--jbdw5cv6ljemwd7w--
