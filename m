Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CECC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC4110F05E;
	Wed, 15 Jul 2026 13:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kNqEKsXj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE4C10F05E
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:18:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C9027600BB;
 Wed, 15 Jul 2026 13:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544FE1F00A3A;
 Wed, 15 Jul 2026 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784121504;
 bh=mWFxM/YkO4pK8/S/Tj9uHsXnOe192aSQI/HoWD7JBZY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kNqEKsXjf+Ms9AED8CzoZclJdj+AMmsDco17ysbLYCnx3rUmFfzp+HDOBGa2QVlyM
 gD/w7lL1gB9ZgdW1ducmKv61JE3+grHHRUGsN7pU4Tr8Zta0nphPF6Xps29AWLCBLO
 cSGG78C70eZnLSeUQ3Vs8iFNafDXLorLJRxPgrHXYSatQ9jdxp8/uifS07/mwjCp/A
 gFpiOvm0lGYBrGNkoUImO/4emajq4vfBJLuL05ixy1bwOp/L0Rv4CG05oK2nPaPoLj
 rjHtxVeKhBJTzWM3PT7QXD1D8ojQ/U2MHnKElke1KgqheU/HDbqYGzH89J2rLXiXV6
 ZZq5JyxwgCsQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/bridge: ti-sn65dsi83: Support LVDS Channel B
 on SN65DSI84
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715-ti-sn65dsi83-fixes-v2-3-ebc4c3fe29b6@geanix.com>
References: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
 <20260715-ti-sn65dsi83-fixes-v2-3-ebc4c3fe29b6@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 13:18:23 +0000
Message-Id: <20260715131824.544FE1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The logic to detect single-link LVDS Channel B requires `port@2`=
 to be absent from the device tree, but the DT binding strictly requires `p=
ort@2` to be present.
--

--- Patch [3]: [PATCH v2 3/3] drm/bridge: ti-sn65dsi83: Support LVDS Channe=
l B on SN65DSI84 ---
commit e7655ab4d66cbec701adf0102160008944fa2a88
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: ti-sn65dsi83: Support LVDS Channel B on SN65DSI84

This adds support for using SN65DSI84 in single-link mode with output to
LVDS Channel B.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index 7e73035d77986..02ae2b8179b07 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
[ ... ]
> @@ -904,29 +907,38 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx=
, enum sn65dsi83_model model)
>  		return ret;
> =20
>  	ctx->lvds_dual_link =3D false;
> -	ctx->lvds_dual_link_even_odd_swap =3D false;
> +	ctx->lvds_channel_swap =3D false;
>  	if (model !=3D MODEL_SN65DSI83) {
> -		struct device_node *port2, *port3;
> +		struct device_node *port0, *port1, *port2, *port3;
>  		int dual_link;
> =20
> +		port0 =3D of_graph_get_port_by_id(dev->of_node, 0);
> +		port1 =3D of_graph_get_port_by_id(dev->of_node, 1);
>  		port2 =3D of_graph_get_port_by_id(dev->of_node, 2);
>  		port3 =3D of_graph_get_port_by_id(dev->of_node, 3);
>  		dual_link =3D drm_of_lvds_get_dual_link_pixel_order(port2, port3);
> =20
>  		if (dual_link =3D=3D DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS) {
>  			/* Odd pixels to LVDS Channel A, even pixels to B */
>  			ctx->lvds_dual_link =3D true;
>  		} else if (dual_link =3D=3D DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS) {
>  			/* Even pixels to LVDS Channel A, odd pixels to B */
>  			ctx->lvds_dual_link =3D true;
> +			ctx->lvds_channel_swap =3D true;
> +		} else if (port0 && !port1 && port2 && !port3) {
> +			/* DSI Channel A to LVDS Channel A */
> +		} else if (port0 && !port1 && !port2 && port3) {
                                              ^^^^^^

[Severity: Medium]
Will this !port2 condition prevent the single-link LVDS Channel B feature
from working with a standard-compliant device tree?

If a user provides a compliant device tree by including an empty or
unconnected port@2 to satisfy the DT schema required list for this binding,
of_graph_get_port_by_id() will return a valid node.

The driver would then fail this check, fall through leaving panel_port =3D =
2,
and subsequently fail to probe when it cannot find a panel connected to the
empty port@2.

> +			/* DSI Channel A to LVDS Channel B */
> +			ctx->lvds_channel_swap =3D true;
> +			panel_port =3D 3;
>  		}
> +		of_node_put(port0);
> +		of_node_put(port1);
> +		of_node_put(port2);
> +		of_node_put(port3);
>  	}
> =20
> -	panel_bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
> +	panel_bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, panel_port, =
0);
>  	if (IS_ERR(panel_bridge))
>  		return dev_err_probe(dev, PTR_ERR(panel_bridge), "Failed to get panel =
bridge\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-ti-sn65dsi=
83-fixes-v2-0-ebc4c3fe29b6@geanix.com?part=3D3
