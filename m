Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793F8C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD97310E778;
	Mon,  3 Aug 2026 18:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DRdCMe1u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099A810E063
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:46:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4C6843CC6;
 Mon,  3 Aug 2026 18:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CB11F0155A;
 Mon,  3 Aug 2026 18:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785782796;
 bh=6hT783PxJWRn5Td9TGHtiwX4oeNCedtPkNsMlRI8Zps=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DRdCMe1uDApNxZawX3Dmh7jpWcnjA6kb+AFYTVoFu4GyXMYGMbMuH8vIG6FuwCK9/
 bcFV3ltlEx0dS8y2B445jBILTRMHYW6FaVj9sT/5D1aFaMt6+RIrO1aI0I3keBwvaM
 HlgTYFYBj8nlsgnOdfiKZwr7ULVuQMSeSxSpioSbaLKdaCzjrCZVj99kVwWW4Lco6n
 81zEkjLDbDjyx6si0lGPyt0VQyQkk4yokPUHIaYgXKCwQXS0rTBHGUB9pVYGjx5miR
 ZODshsqpERc6ZnjP73HEd2m8ZjPtJhw89xE5xRFMaA3LwyFLir066EeuHzm0jQtben
 aglIwyGqY/9qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/22] drm/rockchip: dw_dp: Implement out-of-band HPD
 handling
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-14-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
 <20260803-synopsys-dw-dp-improvements-v9-14-2e6e46135312@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:46:35 +0000
Message-Id: <20260803184636.56CB11F0155A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unpowered Register Access (SError) in OOB HPD callbacks.
- [Medium] Unreachable fallback logic in `dw_dp_rockchip_get_vo_grf`.
- [Medium] Physical IO address truncation due to `u32` typing in `ctrl_ids`.
--

--- Patch [14]: [PATCH v9 14/22] drm/rockchip: dw_dp: Implement out-of-band=
 HPD handling ---
commit 48b6797379434de3ea2e6ba62d355e782a42ada0
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Implement out-of-band HPD handling

This patch implements out-of-band hotplug handling to receive external
hotplug information from the USB-C state machine via the vo_grf regmap.
It aims to avoid SError problems when runtime PM is enabled.

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
> +
> +struct rockchip_dw_dp_plat_data {
> +	u8 num_ctrls;
> +	u32 ctrl_ids[ROCKCHIP_MAX_CTRLS];

[Severity: Medium]
Will this truncate physical IO addresses on 64-bit architectures?=20

The ctrl_ids array stores base IO addresses using u32, but in=20
dw_dp_rockchip_probe() this is compared against the 64-bit=20
resource_size_t res->start:

	if (res->start =3D=3D plat_data_const->ctrl_ids[id]) {

If a future variant maps the DP controller above the 4GB boundary,=20
the upper 32 bits of the address will be lost, causing the hardware=20
controller ID lookup to fail.

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
>  };
> =20
> +static void dw_dp_rockchip_hpd_sw_sel(void *data, bool force_hpd_from_sw)
> +{
> +	struct rockchip_dw_dp *dp =3D data;
> +	u32 hpd_reg =3D dp->pdata->hpd_reg[dp->id];
> +
> +	regmap_write(dp->vo_grf, hpd_reg,
> +		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, force_hpd_from_s=
w));

[Severity: High]
Does this code risk triggering an SError by accessing unpowered registers?=
=20

The commit message states that accessing the vo_grf register requires the D=
P=20
controller power domain to be active. Since this function is called during=
=20
initialization and the driver enables runtime PM with autosuspend, the writ=
e=20
might execute against an unpowered register domain. Should this acquire a P=
M=20
runtime reference via pm_runtime_get_sync(dp->dev) first?

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
Similarly, because this out-of-band hotplug notification is triggered=20
asynchronously by the Type-C controller, could the DP controller be suspend=
ed=20
when this executes? This seems to risk triggering the exact SError the patc=
h=20
intended to fix if a wake up isn't performed before the regmap write.

> +}
> +
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
Will this unconditionally fail for future platforms instead of attempting=20
the fallback mechanism?=20

The comment above states that future platforms should add a VO GRF phandle=
=20
in the DP controller DT node. However, this logic explicitly returns -ENODE=
V=20
if the phy isn't one of the hardcoded compatible strings, without ever pars=
ing=20
the rockchip,vo-grf phandle from the DisplayPort node.=20

> +
> +	regmap =3D syscon_regmap_lookup_by_phandle(args.np, "rockchip,vo-grf");
> +
> +out_put_node:
> +	of_node_put(args.np);
> +	return regmap;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-synopsys-d=
w-dp-improvements-v9-0-2e6e46135312@collabora.com?part=3D14
