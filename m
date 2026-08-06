Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E23C55174
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 00:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9BE810F06F;
	Thu,  6 Aug 2026 00:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ABECskWP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F8010F06F
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 00:58:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5DFFC60A8C;
 Thu,  6 Aug 2026 00:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24C91F000E9;
 Thu,  6 Aug 2026 00:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785977902;
 bh=MMcTWvSmhK9444Sg4fPuErZrB/EQiapSLjQGOdSVvHk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ABECskWPvX+CIe0S56KqLuoxRI9nNBuZYz7stepVXziT5P4GMeWd3hVRk+sisBGXf
 8h+Mjfz9XUUU9LxR8IR5+Eu95SJqmn3MkVanwixlOLwZuIq6s2KUeEOicszLteu9N7
 ljVJMJ2JmvtB46eu2F4979aq1iBH1TaMdd0832a8Ofa82AMEHmhfLPH48So4n2TVgv
 FRzrPsqGiOAiEd02HlU7KwqBuYGKzWeTuazzeIjO2xgbXANJeJthJv9OOBSuUl58L4
 B6ESjjylvgabdVbG5efMvdwy6d1oSxgdzVX9c2IdFxHVNhq8sxEiyXPm2AgHjyvSOh
 WAl+x72XA1dfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 13/21] drm/rockchip: dw_dp: Implement out-of-band
 HPD handling
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-13-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v10-13-d84a26c303d6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 00:58:21 +0000
Message-Id: <20260806005821.D24C91F000E9@smtp.kernel.org>
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
- [Medium] The implementation of `dw_dp_rockchip_get_vo_grf()` contradicts =
its own documentation, lacking the intended fallback mechanism for future p=
latforms.
--

--- Patch [13]: [PATCH v10 13/21] drm/rockchip: dw_dp: Implement out-of-ban=
d HPD handling ---
commit 4123f78de42a676e261f49ecbc6c7175eb33efa4
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Implement out-of-band HPD handling

This commit implements out-of-band hotplug handling for the rockchip dw_dp
driver to receive external hotplug information from the USB-C state machine
via VO GRF, avoiding custom TypeC HPD info parsing in the USBDP PHY driver.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index 38e8fe75718e4..9e49e7dbf420f 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
[ ... ]
> @@ -71,6 +110,35 @@ static const struct drm_encoder_helper_funcs dw_dp_en=
coder_helper_funcs =3D {
>  	.atomic_check		=3D dw_dp_encoder_atomic_check,
>  };
> =20
> +static struct regmap *dw_dp_rockchip_get_vo_grf(struct rockchip_dw_dp *d=
p)
> +{
> +	struct device_node *np =3D dev_of_node(dp->dev);
> +	struct of_phandle_args args;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	ret =3D of_parse_phandle_with_args(np, "phys", "#phy-cells", 0, &args);
> +	if (ret)
> +		return ERR_PTR(-ENODEV);
> +
> +	/*
> +	 * Limit this workaround to RK3576 and RK3588, potential future platfor=
ms
> +	 * reusing the driver should just add a VO GRF phandle in the DisplayPo=
rt
> +	 * controller DT node.
> +	 */
> +	if (!of_device_is_compatible(args.np, "rockchip,rk3576-usbdp-phy") &&
> +	    !of_device_is_compatible(args.np, "rockchip,rk3588-usbdp-phy")) {
> +		regmap =3D ERR_PTR(-ENODEV);
> +		goto out_put_node;
> +	}
> +
> +	regmap =3D syscon_regmap_lookup_by_phandle(args.np, "rockchip,vo-grf");

[Severity: Medium]
The comment mentions that future platforms should add a VO GRF phandle dire=
ctly
in the DisplayPort controller DT node, but the code doesn't seem to check f=
or
it. Instead, it unconditionally requires a "phys" node that is compatible w=
ith
RK3576 or RK3588, and returns -ENODEV otherwise.

Should this function attempt to look up a VO GRF phandle on the controller =
node
(np) first, before falling back to this PHY workaround?

> +
> +out_put_node:
> +	of_node_put(args.np);
> +	return regmap;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v10-0-d84a26c303d6@collabora.com?part=3D13
