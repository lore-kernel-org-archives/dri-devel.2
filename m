Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75710C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF0FD10F244;
	Thu, 23 Jul 2026 22:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hzgbXbQ2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1214210F244
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:35:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D262541772;
 Thu, 23 Jul 2026 22:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A4B1F000E9;
 Thu, 23 Jul 2026 22:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784846100;
 bh=GB228A9k2sPmfF2f9TDya3acVUEyr0p80xKC2WBp3hk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hzgbXbQ2dFu9YOy2i/PeSXk480HfViw8ytoposOIls91EbP2JJVHnmZbCW5AeyzrQ
 tHFehrlpwNklQfduvTJ/9OQBUuNI49u6rr4OBEmLsm/TtWeaMSJ8lCgAdQiT+FrGKj
 XeqYjmQzWnjlAR89g7i/Bz4SAaog/SxUXgYWVGTlv48HQ6r8iJHvNjm3FUHhxTgmw1
 kumpeURm8eXGYCyFDiiSvu20ikA0IUKW/Xu1z7T1ezS2hrYR9hyPbg23x4fiYXAlS7
 NRocOlDdOX4NQHRYdSRiznm1AAZaZKwFiUAPK9b0Sbes4pxg3NQDqPSiME6KF1O5Ld
 RkBgAiKvvYVjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/15] drm/rockchip: dw_dp: Implement out-of-band HPD
 handling
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v5-9-9445c2e87441@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
 <20260724-synopsys-dw-dp-improvements-v5-9-9445c2e87441@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:34:59 +0000
Message-Id: <20260723223500.63A4B1F000E9@smtp.kernel.org>
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
- [High] Out-of-band HPD callbacks write to hardware registers without ensu=
ring the DP controller's power domain is active, risking system crashes.
- [Medium] The VO GRF lookup unconditionally searches the PHY node, entirel=
y failing to support new platforms that provide the VO GRF phandle directly=
 in the DP node.
--

--- Patch [9]: [PATCH v5 09/15] drm/rockchip: dw_dp: Implement out-of-band =
HPD handling ---
commit d5d5b2e640507cef02b65193fd2c17e492af4958
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Implement out-of-band HPD handling

This commit implements out-of-band hotplug handling for the Rockchip
DesignWare DisplayPort driver. It moves the HPD register access from the
USBDP PHY driver to this driver to better detect cable plug events from the
USB-C state machine.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index 005938dc66c9f..0ecbad24dd4e8 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c

[ ... ]

> @@ -23,12 +26,54 @@
> =20
>  #include "rockchip_drm_drv.h"
> =20
> +#define ROCKCHIP_MAX_CTRLS 2
> +
> +#define ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL BIT(10)
> +#define ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG BIT(11)
> +
> +struct rockchip_dw_dp_plat_data {
> +	u8 num_ctrls;
> +	u32 ctrl_ids[ROCKCHIP_MAX_CTRLS];
> +	u32 max_link_rate;
> +	u8 pixel_mode;
> +	u32 hpd_reg[ROCKCHIP_MAX_CTRLS];
> +};
> +
>  struct rockchip_dw_dp {
>  	struct dw_dp *base;
>  	struct device *dev;
> +	const struct rockchip_dw_dp_plat_data *pdata;
> +	struct regmap *vo_grf;
>  	struct rockchip_encoder *encoder;
> +	int id;
> +	bool hpd_sel;
> +	bool hpd_cfg;
>  };
> =20
> +static void dw_dp_rockchip_hpd_sw_sel(void *data, bool force_hpd_from_sw)
> +{
> +	struct rockchip_dw_dp *dp =3D data;
> +	u32 hpd_reg =3D dp->pdata->hpd_reg[dp->id];
> +
> +	dp->hpd_sel =3D force_hpd_from_sw;
> +
> +	regmap_write(dp->vo_grf, hpd_reg,
> +		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, dp->hpd_sel));

[Severity: High]
Does this out-of-band hotplug callback require power management before writ=
ing
to the VO GRF register?

The commit message notes that this register requires the power-domain from =
the
DP controller, but dw_dp_rockchip_hpd_sw_sel() executes without first calli=
ng
pm_runtime_get_sync() or similar power management functions.

If the display pipeline is suspended when the USB-C state machine triggers
an event, could this unclocked register write lead to a bus hang or
synchronous external abort?

> +}
> +
> +static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool hpd)
> +{
> +	struct rockchip_dw_dp *dp =3D data;
> +	u32 hpd_reg =3D dp->pdata->hpd_reg[dp->id];
> +
> +	dev_dbg(dp->dev, "Force HPD connected=3D%s\n", str_yes_no(hpd));
> +
> +	dp->hpd_cfg =3D hpd;
> +
> +	regmap_write(dp->vo_grf, hpd_reg,
> +		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp->hpd_cfg));

[Severity: High]
Similar to the concern in dw_dp_rockchip_hpd_sw_sel(), does this register
write also require the DP controller's power domain to be active?

> +}
> +
>  static int dw_dp_encoder_atomic_check(struct drm_encoder *encoder,

[ ... ]

> @@ -71,6 +116,34 @@ static const struct drm_encoder_helper_funcs dw_dp_en=
coder_helper_funcs =3D {
>  	.atomic_check		=3D dw_dp_encoder_atomic_check,
>  };
> =20
> +static struct regmap *dp_dp_rockchip_get_vo_grf(struct rockchip_dw_dp *d=
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
> +	 * Limit this workaround to RK3576 and RK3588, new platforms should
> +	 * add a VO GRF phandle in the DisplayPort DT node.
> +	 */
> +	if (!of_device_is_compatible(args.np, "rockchip,rk3576-usbdp-phy") &&
> +	    !of_device_is_compatible(args.np, "rockchip,rk3588-usbdp-phy")) {
> +		regmap =3D ERR_PTR(-ENODEV);
> +		goto out_put_node;
> +	}
> +
> +	regmap =3D syscon_regmap_lookup_by_phandle(args.np, "rockchip,vo-grf");

[Severity: Medium]
Will this function fail to support the new platforms mentioned in the comme=
nt?

If a new platform does not have the "phys" property, of_parse_phandle_with_=
args()
will fail early and return ERR_PTR(-ENODEV). It appears there is no fallback
to check for the VO GRF phandle directly in the DP node, which would prevent
new platforms from probing successfully.

> +
> +out_put_node:
> +	of_node_put(args.np);
> +	return regmap;
> +}
> +
>  static int dw_dp_rockchip_bind(struct device *dev, struct device *master=
, void *data)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-synopsys-d=
w-dp-improvements-v5-0-9445c2e87441@collabora.com?part=3D9
