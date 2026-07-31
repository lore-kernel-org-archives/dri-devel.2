Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122E9C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F1C10F362;
	Fri, 31 Jul 2026 17:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nyktFBw7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59A310F362
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 17:10:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C888405B5;
 Fri, 31 Jul 2026 17:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197311F00AC4;
 Fri, 31 Jul 2026 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785517825;
 bh=XscTIa2Mo7UvG9fCspGZE/WFMGd8xvU4l27+JUe8Bjk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nyktFBw7b+wBO092KQuHq+uia73cKHNyntNI6phyuOO8e/WqKuZcVNPv0jC5yb4fq
 OdRK3sppTWBhfqN4o1gG1oxIqjPI7kx4B6gd1M4SitxEon45/dk5jMftVeXMLvf994
 Sm5asOGiJZ42jbNThGgpO0SUEbkc+p5uRhJ5kazTdTL54UGYhgvB/BtQtL+0cK+3w+
 Po+ZwgkhFW5DVF0m5k06qYKkVSEMjKUimUWYTt7Ml/Kx000iMY+NhweYs5Z7aQI2TB
 BfwLx/Qpp1mGbRxAWDhbghIemQq3WcXGa9/0LwOX8JTTX1Hhaw/brdERWWfoJSdjwo
 JBByyuo/0tOQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/21] drm/rockchip: dw_dp: Implement out-of-band HPD
 handling
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-13-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
 <20260731-synopsys-dw-dp-improvements-v8-13-ac1e6a75782f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:10:24 +0000
Message-Id: <20260731171025.197311F00AC4@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing runtime PM acquisition in `dw_dp_rockchip_hpd_sw_cfg` and =
`dw_dp_rockchip_hpd_sw_sel` causes potential SErrors when accessing `vo_grf=
`.
- [Medium] Logical flaw in `dw_dp_rockchip_get_vo_grf` prevents probing on =
future platforms, contrary to its comment.
--

--- Patch [13]: [PATCH v8 13/21] drm/rockchip: dw_dp: Implement out-of-band=
 HPD handling ---
commit 1e82a4f2c1a3fedc07fd8e258e2008997986261a
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Implement out-of-band HPD handling

This commit implements out-of-band hotplug handling for USB-C by accessing
the vo_grf directly.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index 005938dc66c9f..d516b3910b516 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c

[ ... ]

> @@ -23,12 +26,48 @@
> =20
>  #include "rockchip_drm_drv.h"
> =20
> +#define ROCKCHIP_MAX_CTRLS 2
> +
> +#define ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL BIT(10)
> +#define ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG BIT(11)

[ ... ]

> +static void dw_dp_rockchip_hpd_sw_sel(void *data, bool force_hpd_from_sw)
> +{
> +	struct rockchip_dw_dp *dp =3D data;
> +	u32 hpd_reg =3D dp->pdata->hpd_reg[dp->id];
> +
> +	regmap_write(dp->vo_grf, hpd_reg,
> +		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, force_hpd_from_s=
w));

[Severity: High]
Does this register access require a runtime PM reference?

The commit message notes that this register requires the power-domain from =
the
DP controller, and that moving the access here prevents massive SError prob=
lems
once runtime PM is enabled. However, it appears this code accesses the regi=
ster
without acquiring a runtime PM reference (e.g., pm_runtime_get_sync()).=20

If the DP controller is runtime suspended when a hotplug event occurs, won't
this regmap_write() still cause an SError?

> +}
> +
> +static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool hpd)
> +{
> +	struct rockchip_dw_dp *dp =3D data;
> +	u32 hpd_reg =3D dp->pdata->hpd_reg[dp->id];
> +
> +	dev_dbg(dp->dev, "Force HPD connected=3D%s\n", str_yes_no(hpd));
> +
> +	regmap_write(dp->vo_grf, hpd_reg,
> +		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, hpd));

[Severity: High]
Does this register access also require a runtime PM reference to prevent an
SError, for the same reasons as above?

> +}
> +
>  static int dw_dp_encoder_atomic_check(struct drm_encoder *encoder,
>  				      struct drm_crtc_state *crtc_state,
>  				      struct drm_connector_state *conn_state)

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

[Severity: Medium]
Will this compatibility check prevent the driver from probing on future
platforms?

The comment suggests that future platforms should add a "rockchip,vo-grf"
phandle in the DisplayPort controller DT node. However, if the PHY node does
not match the legacy compatibles, this code unconditionally returns
ERR_PTR(-ENODEV) and never attempts to parse the "rockchip,vo-grf" phandle
from the DP controller node.

Does this effectively break probe for any new platforms?

> +
> +	regmap =3D syscon_regmap_lookup_by_phandle(args.np, "rockchip,vo-grf");
> +
> +out_put_node:
> +	of_node_put(args.np);
> +	return regmap;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-synopsys-d=
w-dp-improvements-v8-0-ac1e6a75782f@collabora.com?part=3D13
