Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33078C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8473710E6FF;
	Mon, 24 Aug 2026 09:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=crapouillou.net header.i=@crapouillou.net header.b="DxNW/2pv";
	dkim-atps=neutral
Received: from aposti.net (aposti.net [185.119.170.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A7110E611
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
 s=mail; t=1787565387;
 bh=O6aT4Rf/MykLORdoytkIh+5Rcrdr1l9fkFTrsq/7v5M=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=DxNW/2pvWbkFY/Ed30zgbdmJZ7rKdOu0SIg26chx0hB8uZHAOqeCDzggyZJFa1ApG
 pDKdbyCwvgDw/Tq5BZnWF04Vj5SHt0rmXd2p3eVU/fbGMTnkXWUbw9xKoCjbuz4wEg
 kn6AqVZmKrSzXGtvBQR0yjNn18ZAF3YYnzF2muMk=
Message-ID: <0cf9366ba1a217ad743fd7f49d00813b32f104f2.camel@crapouillou.net>
Subject: Re: [PATCH v3] drm/ingenic: fix bridge allocation
From: Paul Cercueil <paul@crapouillou.net>
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
 wbx@openadk.org, 	kernel@pyra-handheld.com, stable@vger.kernel.org
Date: Mon, 24 Aug 2026 11:56:23 +0200
In-Reply-To: <a3b64245250cd092776cf23cddffe18318b48995.1787494377.git.hns@goldelico.com>
References: <a3b64245250cd092776cf23cddffe18318b48995.1787494377.git.hns@goldelico.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

Hi Nikolaus,

Le dimanche 23 ao=C3=BBt 2026 =C3=A0 16:12 +0200, H. Nikolaus Schaller a =
=C3=A9crit=C2=A0:
> Bridge allocation API has changed and ingenic/drm was broken
> leading to
>=20
> [=C2=A0=C2=A0 54.997593] dw-hdmi-ingenic 10180000.hdmi: Detected HDMI \X
> controller v1.31a with HDCP (DWC HDMI 3D TX PHY)
> [=C2=A0=C2=A0 55.491338] dw-hdmi-ingenic 10180000.hdmi: registered Design=
Ware
> HDMI I2C bus driver
> [=C2=A0=C2=A0 55.899132] [drm] DRM bridge corrupted or not allocated by
> devm_drm_bridge_alloc()
> [=C2=A0=C2=A0 55.904136] ------------[ cut here ]------------
> [=C2=A0=C2=A0 55.908753] WARNING: lib/refcount.c:25 at drm_bridge_get+0x5=
8/0x6c
> [drm], CPU#0: kworker/u4:2/36
> [=C2=A0=C2=A0 55.917538] refcount_t: addition on 0; use-after-free.
> ...
> [=C2=A0=C2=A0 56.354928] [<c04898b8>] drm_bridge_attach+0x80/0x208 [drm]
> ...
>=20
> Fixes: 9347f2fbb0183b0 ("drm/bridge: add warning for bridges using
> neither devm_drm_bridge_alloc() nor drm_bridge_add()")
> Tested-by: Waldemar Brodkorb <wbx@openadk.org> (on CI20 with HDMI)
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Waldemar Brodkorb <wbx@openadk.org>
> Cc: stable@vger.kernel.org
> ---
>=20
> Notes:
> =C2=A0=C2=A0=C2=A0 v3: fixed a malformed diff
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 v2: removed ib->bridge->ops =3D DRM_BRIDGE_OP_EDID |
> DRM_BRIDGE_OP_DETECT as suggested by Sashiko-reviews
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://sashiko.dev/#/patchset/400ba2fe0d4f76484e929d2efaa32f67a940163a.1=
787477392.git.hns@goldelico.com?part=3D1
>=20
> =C2=A0drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 23 +++++++++++++++++++-=
-
> --
> =C2=A01 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 42c86f195c66b3..8d7979a7859332 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -122,7 +122,7 @@ struct ingenic_drm {
> =C2=A0
> =C2=A0struct ingenic_drm_bridge {
> =C2=A0	struct drm_encoder encoder;
> -	struct drm_bridge bridge, *next_bridge;
> +	struct drm_bridge *bridge, *next_bridge;
> =C2=A0
> =C2=A0	struct drm_bus_cfg bus_cfg;
> =C2=A0};
> @@ -802,7 +802,7 @@ static int ingenic_drm_bridge_attach(struct
> drm_bridge *bridge,
> =C2=A0	struct ingenic_drm_bridge *ib =3D
> to_ingenic_drm_bridge(encoder);
> =C2=A0
> =C2=A0	return drm_bridge_attach(encoder, ib->next_bridge,
> -				 &ib->bridge, flags);
> +				 bridge, flags);
> =C2=A0}
> =C2=A0
> =C2=A0static int ingenic_drm_bridge_atomic_check(struct drm_bridge
> *bridge,
> @@ -1314,10 +1314,25 @@ static int ingenic_drm_bind(struct device
> *dev, bool has_components)
> =C2=A0
> =C2=A0		drm_encoder_helper_add(encoder,
> &ingenic_drm_encoder_helper_funcs);
> =C2=A0
> -		ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
> +		ib->bridge =3D devm_drm_bridge_alloc(priv->dev, struct
> drm_bridge,
> +						=C2=A0=C2=A0 base,
> &ingenic_drm_bridge_funcs);
> +		if (IS_ERR(ib->bridge)) {
> +			ret =3D PTR_ERR(ib->bridge);
> +			goto err_drvdata;
> +		}
> +
> +		ib->bridge->of_node =3D priv->dev->of_node;
> =C2=A0		ib->next_bridge =3D bridge;
> =C2=A0
> -		ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
> +		ib->bridge->interlace_allowed =3D true;

That one line feels like it doesn't belong here, but in its own patch.

Cheers,
-Paul

> +
> +		ret =3D devm_drm_bridge_add(priv->dev, ib->bridge);
> +		if (ret) {
> +			dev_err(dev, "Failed to register DRM bridge:
> %d\n", ret);
> +			goto err_drvdata;
> +		}
> +
> +		ret =3D drm_bridge_attach(encoder, ib->bridge, NULL,
> =C2=A0					DRM_BRIDGE_ATTACH_NO_CONNECT
> OR);
> =C2=A0		if (ret) {
> =C2=A0			dev_err(dev, "Unable to attach bridge\n");
