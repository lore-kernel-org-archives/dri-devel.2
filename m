Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD107CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A026110EA1C;
	Mon,  1 Jun 2026 22:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="I/NlyQ3Q";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBC410EA1B
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 22:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780352881; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PVFgPC70ErGaEqeSeHjwE2C+cB5bHar7/PSYof40VZPvXovCrOnKYTpSgecOjAGXESM2WrhArffEO92DABYXv/MxbRDraiE7udlw7YgdvRhBGAU3KmANVRwlbkpczO2MMZQ7Vm1iPXuajjfOtdgAlP0Xkfgy4HUhBxCpr7E6xuE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780352881;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BUpb7HT4m15XVVBLdFS9FongkPN47oZiE3d0bUHdpT8=; 
 b=WGgU/IrWHyxgNT2lx0ISRqqyAsgubwNaSJyyd3guT6LnC49oBN12F8r2MX7BSAwyYh6l2VAQqzMApiW7oi1WEqC7hv4+iAYS517knha5cKALMtajpIKgd/c0IXuQ4t2ZyvTKVxdUOkwRgGjsCpRTK4AxONpOzzrdE31ZG/vjKE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780352881; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=BUpb7HT4m15XVVBLdFS9FongkPN47oZiE3d0bUHdpT8=;
 b=I/NlyQ3Q6+Ye1gVvzV2ArOX9glIRXM7xR5m/PVVvimlFqn9UmtHhH71v7AoywFON
 zNXCzPKXKy02ILEhHbM2H4o3PqosEYlGIoevZfh7HKy9bUDKsDUTOPZyeJgqIe1l0TD
 qkREDonolDGSFmZ/rc/UWG1Xx1vydAuLYFirsjA4=
Received: by mx.zohomail.com with SMTPS id 1780352878700771.4001220854549;
 Mon, 1 Jun 2026 15:27:58 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 8CFFE183854; Tue, 02 Jun 2026 00:27:51 +0200 (CEST)
Date: Tue, 2 Jun 2026 00:27:51 +0200
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
Subject: Re: [PATCH 2/5] drm/bridge: aux: Add
 drm_aux_bridge_register_from_node()
Message-ID: <ah4HP0VuZEFUaLlt@venus>
References: <20260521032854.103-1-kernel@airkyi.com>
 <20260521032854.103-3-kernel@airkyi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2xib44wq3r7nfz4n"
Content-Disposition: inline
In-Reply-To: <20260521032854.103-3-kernel@airkyi.com>
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


--2xib44wq3r7nfz4n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] drm/bridge: aux: Add
 drm_aux_bridge_register_from_node()
MIME-Version: 1.0

Hi,

On Thu, May 21, 2026 at 11:28:51AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>=20
> The drm_aux_bridge_register() uses the device->of_node as the
> bridge->of_node.
>=20
> This patch adds drm_aux_bridge_register_from_node() to allow
> specifying the of_node corresponding to the bridge.
>=20
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/gpu/drm/bridge/aux-bridge.c | 24 ++++++++++++++++++++++--
>  include/drm/bridge/aux-bridge.h     |  6 ++++++
>  2 files changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge=
/aux-bridge.c
> index 1ed21a8713bf..f50283abed5f 100644
> --- a/drivers/gpu/drm/bridge/aux-bridge.c
> +++ b/drivers/gpu/drm/bridge/aux-bridge.c
> @@ -35,6 +35,7 @@ static void drm_aux_bridge_unregister_adev(void *_adev)
>  /**
>   * drm_aux_bridge_register - Create a simple bridge device to link the c=
hain
>   * @parent: device instance providing this bridge
> + * @np: device node pointer corresponding to this bridge instance
>   *
>   * Creates a simple DRM bridge that doesn't implement any drm_bridge
>   * operations. Such bridges merely fill a place in the bridge chain link=
ing
> @@ -42,7 +43,7 @@ static void drm_aux_bridge_unregister_adev(void *_adev)
>   *
>   * Return: zero on success, negative error code on failure
>   */
> -int drm_aux_bridge_register(struct device *parent)
> +int drm_aux_bridge_register_from_node(struct device *parent, struct devi=
ce_node *np)
>  {
>  	struct auxiliary_device *adev;
>  	int ret;
> @@ -62,7 +63,10 @@ int drm_aux_bridge_register(struct device *parent)
>  	adev->dev.parent =3D parent;
>  	adev->dev.release =3D drm_aux_bridge_release;
> =20
> -	device_set_of_node_from_dev(&adev->dev, parent);
> +	if (np)
> +		device_set_node(&adev->dev, of_fwnode_handle(np));
> +	else
> +		device_set_of_node_from_dev(&adev->dev, parent);
> =20
>  	ret =3D auxiliary_device_init(adev);
>  	if (ret) {
> @@ -80,6 +84,22 @@ int drm_aux_bridge_register(struct device *parent)
> =20
>  	return devm_add_action_or_reset(parent, drm_aux_bridge_unregister_adev,=
 adev);
>  }
> +EXPORT_SYMBOL_GPL(drm_aux_bridge_register_from_node);
> +
> +/**
> + * drm_aux_bridge_register - Create a simple bridge device to link the c=
hain
> + * @parent: device instance providing this bridge
> + *
> + * Creates a simple DRM bridge that doesn't implement any drm_bridge
> + * operations. Such bridges merely fill a place in the bridge chain link=
ing
> + * surrounding DRM bridges.
> + *
> + * Return: zero on success, negative error code on failure
> + */
> +int drm_aux_bridge_register(struct device *parent)
> +{
> +	return drm_aux_bridge_register_from_node(parent, NULL);
> +}
>  EXPORT_SYMBOL_GPL(drm_aux_bridge_register);
> =20
>  struct drm_aux_bridge_data {
> diff --git a/include/drm/bridge/aux-bridge.h b/include/drm/bridge/aux-bri=
dge.h
> index c2f5a855512f..7dd1f17a1354 100644
> --- a/include/drm/bridge/aux-bridge.h
> +++ b/include/drm/bridge/aux-bridge.h
> @@ -13,11 +13,17 @@ struct auxiliary_device;
> =20
>  #if IS_ENABLED(CONFIG_DRM_AUX_BRIDGE)
>  int drm_aux_bridge_register(struct device *parent);
> +int drm_aux_bridge_register_from_node(struct device *parent, struct devi=
ce_node *np);
>  #else
>  static inline int drm_aux_bridge_register(struct device *parent)
>  {
>  	return 0;
>  }
> +
> +static inline int drm_aux_bridge_register_from_node(struct device *paren=
t, struct device_node *np)
> +{
> +	return 0;
> +}
>  #endif
> =20
>  #if IS_ENABLED(CONFIG_DRM_AUX_HPD_BRIDGE)
> --=20
> 2.53.0
>=20
>=20

--2xib44wq3r7nfz4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmoeB18ACgkQ2O7X88g7
+ppogQ//WqinHkPcYFScjtlm9f1ggBxhA9aLxXMnPrZaONmiRW25hCm83sEXJU4H
g/uQA6oeHUzF3zuaZ4U2ObSMC8X6CBSTbzPZ5LpKZxE1767quTuqL92tNgiyYfwr
Jm1EJdNzw/Ij/X4D8D3V7fyqJEbr/YhMMsNRX32RPJXyz8sq7rWs7UORhJL9H83N
+v62SxuuL6dTn5f1B60Bjq5zdL/pq2pxrdgDzd+QiRVX6u/4UIlk1iP5NM+Wgchc
WsPwbUOryyXkVhAu+TAvC+nKxxYg4fuQdC+dnmgXnLc0CaKfOZf8MChaRhVxKhOT
CAqamGlaWX8kEiPcUNk83H6qFA36zJcpzS+H2vwceJqzW/WfE/WrBj5r2KvTs+Ze
OTYAr+BRXA/193Mqd5VuvZ8dzldMj4SdygcuYfoNOl43nFs/UJxs/KyEH7KHtLXp
kyfTlskWVlm7ddDXI2SSBaoftjI/ZmcuT6Sd0lJH+fYTqsQfePz3pZIb9hRK36Es
+3ASREKLL9x/2C0eM++BVx6jK8KAlE3tlO8xNgi/0pLnW/vUI4Zvm6UNftxY6gIo
wfpY1pWgWlz4MVBCHA2ifWqUmU86zuFVOuLsQVriO6R9PfaqkuG53ZX7Dmobh4iY
oZOEX5QW60mRzh+zeTWiOQ0IklFhzR7bUEG/GH313hqf+scDbsU=
=aeh0
-----END PGP SIGNATURE-----

--2xib44wq3r7nfz4n--
