Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F907C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 11:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C43610E34A;
	Sat, 11 Jul 2026 11:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K/YsLIeL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA99C10E34A
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 11:57:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECA06601D9;
 Sat, 11 Jul 2026 11:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A7D1F000E9;
 Sat, 11 Jul 2026 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783771047;
 bh=5fghWZgD03N+xXUq7mmIzZJwZsUWTETRpLc7dkfy7BA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K/YsLIeL3JoD5lxDLJBm31fmYDCD1RYjMqY1nKuf5ZFrbVgPmil/H+Fj2Y3YCChwv
 i223MXw4uSEgwLq6O2AnBs/ji4M8ayEZMc5Nm0YB9LbB2tHBPUaIQZ70yZJo+gfitA
 UnXfFpcg68x60i5UANCCzvoI0lYt5OU1263IYBFE1uhSGDIWkOFy+9r6jZvW0TJn9Q
 z1+6NgpV74yad2alj8PgFB9JLq9wnsH2/k2yfIyOjjqkZ7XLbR4Nq2TL6MQCi675oP
 7aJGVayimE2jU5cnkF+idurJ/RrPv8wNgwKkKKJA94I1Mmqb5ypS+qRI7lWHXR5uDG
 K7lJRXd+uqJtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: ti-sn65dsi83: Support LVDS Channel B on
 SN65DSI84
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711-ti-sn65dsi83-fixes-v1-1-d85eb5342b98@geanix.com>
References: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
 <20260711-ti-sn65dsi83-fixes-v1-1-d85eb5342b98@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 11:57:26 +0000
Message-Id: <20260711115727.51A7D1F000E9@smtp.kernel.org>
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
- [Medium] Leftover debug `pr_warn` statements unconditionally print warnin=
gs on standard, valid hardware configurations during device probe.
--

--- Patch [1]: [PATCH 1/2] drm/bridge: ti-sn65dsi83: Support LVDS Channel B=
 on SN65DSI84 ---
commit f232cbf82d686f0a82f41ef8eedda5654e9deea0
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: ti-sn65dsi83: Support LVDS Channel B on SN65DSI84

This adds support for using SN65DSI84 in single-link mode with output to
LVDS Channel B.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index 42b451432bbb6..32e9eadd7452f 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c

[ ... ]

> @@ -904,29 +907,40 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx=
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
> -		of_node_put(port2);
> -		of_node_put(port3);
> =20
>  		if (dual_link =3D=3D DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS) {
> -			ctx->lvds_dual_link =3D true;
>  			/* Odd pixels to LVDS Channel A, even pixels to B */
> -			ctx->lvds_dual_link_even_odd_swap =3D false;
> -		} else if (dual_link =3D=3D DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS) {
>  			ctx->lvds_dual_link =3D true;
> +		} else if (dual_link =3D=3D DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS) {
>  			/* Even pixels to LVDS Channel A, odd pixels to B */
> -			ctx->lvds_dual_link_even_odd_swap =3D true;
> +			ctx->lvds_dual_link =3D true;
> +			ctx->lvds_channel_swap =3D true;
> +		} else if (port0 && !port1 && port2 && !port3) {
> +			/* DSI Channel A to LVDS Channel A */
> +			pr_warn("%s: DSI Channel A to LVDS Channel A\n", __func__);
> +		} else if (port0 && !port1 && !port2 && port3) {
> +			/* DSI Channel A to LVDS Channel B */
> +			pr_warn("%s: DSI Channel A to LVDS Channel B\n", __func__);

[Severity: Medium]
Are these pr_warn() statements leftover debugging code?

Since this patch introduces normal support for single-link modes, printing
unconditional warnings in sn65dsi83_parse_dt() on perfectly valid hardware=
=20
configurations (single-link DSI to LVDS channel A or B) will pollute the=20
dmesg log during device probe. This might cause false failures in CI system=
s=20
that check for kernel warnings, and confuse users into thinking there is a=
=20
hardware or driver issue.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-ti-sn65dsi=
83-fixes-v1-0-d85eb5342b98@geanix.com?part=3D1
