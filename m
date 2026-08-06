Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0861C5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE71F10F27C;
	Thu,  6 Aug 2026 17:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="A88Zm4h1";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B34A10F27C
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786039023; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZFXJbF+uCUZNw+eEaDW5/JhYp93Db5Hqqko0UmTN24ysW6SuIQSB2aLdBUhpgCgz7qHVmKwUru53W6h67x2JkC7lxCbfI20cXJBpNaBout4CgQ2tNm/0ZkwrdzxvoUb9mHtrlIeC+ErP3lJc5U3VTvz0pjXis/NDzgUlGLjMl7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786039023;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7t2ppmEV8KZPQctXq3NUCSS5AXEtR6dC/YbrnTJetEs=; 
 b=NjPBIc8XI2v5ookPpLYAmEprwtm2lmLdWHJ32BMu8hEwM4lddPgXhmnGWsc4kiw3WC0bpEOKC198UY0zBXo4GdKOqr/gphV5L9TEEW9R7Zvl6VysD1IKdqkA0/xNhcFoE6Uv9ypOvpOc6/YkpQGGpFCa8Xm7odQLpkuJ42bVNgI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786039023; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=7t2ppmEV8KZPQctXq3NUCSS5AXEtR6dC/YbrnTJetEs=;
 b=A88Zm4h1XJd75PKpCw9Qd2ouL8JgScvKbLul8lq5fGefFN3GsNc6BoxuM+i6F2LG
 B91VeeXuXo8UKZpI+4YlP43oNGHJKYw7wrpdTd6F9vTk7oiYPCbeyh7eMwd/KrMi3X/
 zhBg1wdeFxC1yohQ4BnYDH6mPQBSssxidTYOwGMg=
Received: by mx.zohomail.com with SMTPS id 178603901993027.6707984562496;
 Thu, 6 Aug 2026 10:56:59 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id D00661808BD; Thu, 06 Aug 2026 19:56:53 +0200 (CEST)
Date: Thu, 6 Aug 2026 19:56:53 +0200
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
Subject: Re: [PATCH v6 1/7] drm/bridge: aux-hpd-bridge: Add
 drm_dev_has_dp_hpd_bridge()
Message-ID: <anTHNpUryNm72aGM@venus>
References: <20260804070730.68-1-kernel@airkyi.com>
 <20260804070730.68-2-kernel@airkyi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lmyx267gariqvzno"
Content-Disposition: inline
In-Reply-To: <20260804070730.68-2-kernel@airkyi.com>
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


--lmyx267gariqvzno
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/7] drm/bridge: aux-hpd-bridge: Add
 drm_dev_has_dp_hpd_bridge()
MIME-Version: 1.0

Hi,

On Tue, Aug 04, 2026 at 03:07:24PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>=20
> Add a new API to check whether a DisplayPort HPD bridge has already
> been registered. This helps avoid duplicate registration of the same
> HPD bridge, although the current framework allows doing so.
>=20
> Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I still see the bridge registered twice for fusb302. Apparently the
the new notifier is faster than the explicit registration in the
driver. The code added here works though; reloading
aux_hpd_typec_dp_bridge does not register more and more bridges :)

Greetings,

-- Sebastian

>  drivers/gpu/drm/bridge/aux-hpd-bridge.c | 42 ++++++++++++++++++++++++-
>  include/drm/bridge/aux-bridge.h         |  6 ++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/br=
idge/aux-hpd-bridge.c
> index f02a38a2638a..a56c88eba005 100644
> --- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> +++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> @@ -12,6 +12,8 @@
>  #include <drm/drm_bridge.h>
>  #include <drm/bridge/aux-bridge.h>
> =20
> +#define DRM_AUX_HPD_BRIDGE_NAME	"dp_hpd_bridge"
> +
>  static DEFINE_IDA(drm_aux_hpd_bridge_ida);
> =20
>  struct drm_aux_hpd_bridge_data {
> @@ -36,6 +38,44 @@ static void drm_aux_hpd_bridge_free_adev(void *_adev)
>  	auxiliary_device_uninit(_adev);
>  }
> =20
> +static int hpd_bridge_match(struct device *dev, const void *data)
> +{
> +	const struct device_node *np =3D data;
> +	struct auxiliary_device *adev;
> +
> +	if (!dev_is_auxiliary(dev))
> +		return 0;
> +
> +	adev =3D to_auxiliary_dev(dev);
> +	if (strcmp(adev->name, DRM_AUX_HPD_BRIDGE_NAME))
> +		return 0;
> +
> +	return adev->dev.platform_data =3D=3D np;
> +}
> +
> +/**
> + * drm_dev_has_dp_hpd_bridge - check whether a HPD DisplayPort bridge is=
 registered
> + * @parent: device instance providing this bridge
> + * @np: device node pointer corresponding to this bridge instance
> + *
> + * Walk the children of @parent and check whether a HPD DisplayPort brid=
ge for
> + * the given @np has already been registered via devm_drm_dp_hpd_bridge_=
add().
> + *
> + * Return: true if a HPD bridge for @parent / @np already exists, false =
otherwise
> + */
> +bool drm_dev_has_dp_hpd_bridge(struct device *parent, struct device_node=
 *np)
> +{
> +	struct device *child;
> +
> +	child =3D device_find_child(parent, np, hpd_bridge_match);
> +	if (child) {
> +		put_device(child);
> +		return true;
> +	}
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(drm_dev_has_dp_hpd_bridge);
> +
>  /**
>   * devm_drm_dp_hpd_bridge_alloc - allocate a HPD DisplayPort bridge
>   * @parent: device instance providing this bridge
> @@ -63,7 +103,7 @@ struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(=
struct device *parent, str
>  	}
> =20
>  	adev->id =3D ret;
> -	adev->name =3D "dp_hpd_bridge";
> +	adev->name =3D DRM_AUX_HPD_BRIDGE_NAME;
>  	adev->dev.parent =3D parent;
>  	adev->dev.release =3D drm_aux_hpd_bridge_release;
>  	adev->dev.platform_data =3D of_node_get(np);
> diff --git a/include/drm/bridge/aux-bridge.h b/include/drm/bridge/aux-bri=
dge.h
> index c2f5a855512f..cca07a8e2d45 100644
> --- a/include/drm/bridge/aux-bridge.h
> +++ b/include/drm/bridge/aux-bridge.h
> @@ -25,6 +25,7 @@ struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(s=
truct device *parent, str
>  int devm_drm_dp_hpd_bridge_add(struct device *dev, struct auxiliary_devi=
ce *adev);
>  struct device *drm_dp_hpd_bridge_register(struct device *parent,
>  					  struct device_node *np);
> +bool drm_dev_has_dp_hpd_bridge(struct device *parent, struct device_node=
 *np);
>  void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_st=
atus status);
>  #else
>  static inline struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(stru=
ct device *parent,
> @@ -44,6 +45,11 @@ static inline struct device *drm_dp_hpd_bridge_registe=
r(struct device *parent,
>  	return NULL;
>  }
> =20
> +static inline bool drm_dev_has_dp_hpd_bridge(struct device *parent, stru=
ct device_node *np)
> +{
> +	return false;
> +}
> +
>  static inline void drm_aux_hpd_bridge_notify(struct device *dev, enum dr=
m_connector_status status)
>  {
>  }
> --=20
> 2.53.0
>=20

--lmyx267gariqvzno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmp0yuIACgkQ2O7X88g7
+po3bQ//XxQC2aSQqCssQjBwMzPwUFwLFuI1cswQEnui/0Ma+SOGA796JIx+7t4U
aaoov8lNcVLA8v6jA+VHswHsj+iy31uUHdXOJDl06b3CS+wNvxLbelMMQUQ+liFr
XxJ/pgkwSeDY455N996scnB1WG+tYQJSquY95aTlHFitgcp9sLUQ8gQjSNits0nq
qteTIoAV/wzBIAn3gH1XY/aEGSQHg/rXMi+/E8NNgZxuKcMABIbkipi7CG0PGL6F
1GR7OzGOJBAaYBCOTzf+IXXSOs9URotGfXp60kU4ClIGR9WcrdeM+vBVVQteTQeB
d5Cxu7dPTMIeGtpB37xLwlVHb187pE7szjjBi1SWpf5IXv4S3feA5uZnpTwagsR8
rXsD/jEDWZ/3oi5CtDdtAduZEGIxBNAKY2yzC9xze+vM0j8i6RoOHwBTa4vwL7A2
ZwbLdiz+S29nlbImHxcN7riTJOcU31V6ccXtdYVn2REqNzi4wn7kzxP2zMG/pfDr
QpvXOj9UtsFZyo/uCukbBFu6jP6pu08u0qdTa6AUAXYsSgkfaV9jVyDtPboX6fp3
1kxaxqm5IcwdOa6Nz9brODhsigM+qqMrd3WGGurmW4sN8ADfz5Vsdv4dMXOlUGO4
kT0gbbmbtdS1GZ4S6BDC7sNiokDFT0JCJwwL0dIwfiJRr9y1aUU=
=GGPA
-----END PGP SIGNATURE-----

--lmyx267gariqvzno--
