Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06ADCD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BADDB10E9F6;
	Mon,  1 Jun 2026 22:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="BUIQ3fbn";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5744D10E9F6
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 22:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780351738; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DFTvSjlq6jnIXNf0M9KS2sJ/lMP29aQTGqrIezRk3x0RGNMbLqF03kl/DA4yD8aJsNSkH1COokzAXzNNXe71ZJVxyHB+AGlcVdEch2FxEhpUeOqe1CnU/Uz2dPd/FMfYt3l9Wpriicp8dRyO/R2fOQWzHTNznefdxS8HMEtTTmo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780351738;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1lK1yNZdrKT8RuPFT6vih0wWSf1jo44LoNBqX+KfL0M=; 
 b=KH/4V1Ldup46P6gqKWWlb8LM0fPlt2BDHkk813kn6x7F7A0vc44ppp5HUCFuF3LbFwGglUkfI4MpOkIZ/n2Wfel8CIQekOrw42gr5P+zy8du1QWfeuQ5qZ9VzWVM03b4iexSdd8wfqde7urVU+0ks5FHGqkiROvoeDcVyXXlcI0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780351737; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=1lK1yNZdrKT8RuPFT6vih0wWSf1jo44LoNBqX+KfL0M=;
 b=BUIQ3fbngH6E2GT5G7rpUSBewxAJyxIl+lR3yFYwvtS2tqoPkRt7+/Muq5CFSNaL
 mV6NLFOKmwKjS6jyoO/Wjw5dePkldz5YHfYGq0wbVLSyK6vPS9caCalpe7Tp2HCHLWC
 sX1JY7n/mW01G2j7r4weTdsWLFO2IWm3ZmbWPssc=
Received: by mx.zohomail.com with SMTPS id 1780351733835755.6229336935343;
 Mon, 1 Jun 2026 15:08:53 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id D5550183854; Tue, 02 Jun 2026 00:08:46 +0200 (CEST)
Date: Tue, 2 Jun 2026 00:08:46 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-phy@lists.infradead.org, Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH 1/5] drm/bridge: Implement generic USB Type-C DP HPD bridge
Message-ID: <ah3-auKugGCVojOp@venus>
References: <20260521032854.103-1-kernel@airkyi.com>
 <20260521032854.103-2-kernel@airkyi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2wjtyeyqji5ix4fa"
Content-Disposition: inline
In-Reply-To: <20260521032854.103-2-kernel@airkyi.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.325.56
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


--2wjtyeyqji5ix4fa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
MIME-Version: 1.0

Hi,

On Thu, May 21, 2026 at 11:28:50AM +0800, Chaoyi Chen wrote:
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
> ---
>  drivers/gpu/drm/bridge/Kconfig                | 10 ++++
>  drivers/gpu/drm/bridge/Makefile               |  1 +
>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 49 +++++++++++++++++++

Doesn't this require removing the manual registration of the HPD
auxillary bridge in the USB-C controller drivers to avoid that
two bridges are registered for them?

>  3 files changed, 60 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
>=20
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index c3209b0f4678..d92e93875793 100644
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
> index beab5b695a6e..c4761526ba0a 100644
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
> index 000000000000..d915e0fb0668
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0+
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
> +		goto done;
> +
> +	/*
> +	 * alt->dev.parent->parent : USB-C controller device
> +	 * alt->dev.parent         : USB-C connector device
> +	 */
> +	if (is_typec_port_altmode(&alt->dev) && alt->svid =3D=3D USB_TYPEC_DP_S=
ID)
> +		drm_dp_hpd_bridge_register(alt->dev.parent->parent,
> +					   to_of_node(alt->dev.parent->fwnode));

IIUIC this is called when the USB-C controller spawns a sub-device
for the DP AltMode and then registers a HPD bridge to the USB-C
controller itself. Wouldn't that register new HPD bridges on every
USB-C replug?

Also doesn't this result in the bridge not being registered when
nothing is plugged and thus the DRM pipeline not being able to bind
properly?

Greetings,

-- Sebastian

> +
> +done:
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
> +MODULE_DESCRIPTION("DRM TYPEC DP HPD BRIDGE");
> +MODULE_LICENSE("GPL");
> --=20
> 2.53.0
>=20
>=20

--2wjtyeyqji5ix4fa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmoeAusACgkQ2O7X88g7
+poFDhAAqmoRFuBnWXN9ThmBhdcTbKmP9xRiRbmFvKqyJCJGzQ3m9vJWXeRgnm2p
xp0Pd6zOCm4m4snw4PElFYmAJACJZbKD19oPGRUy7ClzIHqyQUmh/DweeHexRcwb
iS7XC9qxSrCmkWu2/CVYnIVDb+YeC7/aMwjMG5nn6PL3i0ftBqiMGM2TFbka3O+1
THzO03GrjEl3f2mNJm2HYI//Lsl27+WXebGweEhyGtZIoI+BGi3uCMLq7afmeKc+
BhTXSJAjHQDo76RglJLBiOi1PfeLQT8SLxu6cfqTIrjVnBoy7iPTtopTpuQK5a8g
nVh8C7wuSwHhO0FAp2kt6JeFYTzLRQj6YCdMdzIS8fw9vc9dSKgwFhTk6wDbDzds
Z6qmigIPYvawBo3cWy20RHQynxXchqaKbSqT9IJ3QxdHgGiNdPc5AzrS3V/Oyi/s
q4QWtaqoLN1qCTGVNOnqJ+1vQhzBuLZCZJt/g8nlJMYSVUe0RYGXRUjOgK9f1B97
Vc1myj5dNB1u5EwcRhcDopxmw6S95GqAPZydo9yduYUIj2Uu5adlFGDZiaJMoZvz
w/51Wmp/n+azkiSyBhjPLr9ieZD/WKuUpbAwzeLv/B9cL+L2i3n1PtAwwj/W3Tgx
VP8/olbfezC3hFV6Wwzap+LPLW91JARUpjYwZuptpDcuDDfsVho=
=0qDd
-----END PGP SIGNATURE-----

--2wjtyeyqji5ix4fa--
