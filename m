Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F10C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01B410E3A4;
	Tue, 21 Jul 2026 18:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LBC3Akd2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4AD710E3A4
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:15:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 543D440620;
 Tue, 21 Jul 2026 18:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9B11F000E9;
 Tue, 21 Jul 2026 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784657759;
 bh=B/m+owWUBM6VQS1O2fFdRNrAMYihKIj+X1ZPFE5jqhA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LBC3Akd2OsuipYisFRaFBUKZGTmiLJKqzSSRorFJFFeNgKLPgyHBkoreUndRKDzL9
 q99qWWW+wdioMBKyixeV+E4+ZUCmYqPsJGilwtU4AKMoywtiqIagyvZhrSGYJ99y2A
 IUaLSd1NJuZV9MCJzZWG5s2KUMgUHMNl+tLMsvIa/JE0+mZei4q0gWITxZ6Rlit+1w
 3wrtWzZgaQd020XSeD63YG9CArlfM4WIzO/dlNrqE5yPipk1jrdeK6MhxZH49v518G
 7J+lGvn9STujiqczbUsiKa/a5aAV4FxDvv4nPRZmvpotSHfvyvwNimQpHfl9+1lqrv
 vsimACew7lqng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/10] drm/rockchip: dw_dp: Implement out-of-band HPD
 handling
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-synopsys-dw-dp-improvements-v4-6-f0f4a4ede712@collabora.com>
References: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
 <20260721-synopsys-dw-dp-improvements-v4-6-f0f4a4ede712@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 18:15:58 +0000
Message-Id: <20260721181558.DE9B11F000E9@smtp.kernel.org>
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

New issues:
- [Medium] The VO GRF regmap lookup fails to parse the DisplayPort DT node =
for new platforms, contradicting its documented design.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but missing cancel_w=
ork_sync() for hpd_work in dw_dp_unbind() causes a Use-After-Free.
--

--- Patch [6]: [PATCH v4 06/10] drm/rockchip: dw_dp: Implement out-of-band =
HPD handling ---
commit 78e1ce0dbd7ef8a004080f25b4449ba54b71de3a
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Implement out-of-band HPD handling

This patch implements out-of-band hotplug handling to receive external
hotplug information from the USB-C state machine. It uses the vo-grf
registers to control HPD signal routing and configuration.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index 005938dc66c9f..0ecbad24dd4e8 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
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
Will this fail to probe on new platforms?=20

The comment states new platforms should add a VO GRF phandle in the
DisplayPort DT node, but the code only looks up "rockchip,vo-grf" on the
phy node (args.np) after explicitly rejecting any phy other than rk3576 and
rk3588.=20

Should it try to parse the property from the DisplayPort node (np) instead?

> +
> +out_put_node:
> +	of_node_put(args.np);
> +	return regmap;
> +}
[ ... ]

While reviewing this patch, I also noticed a pre-existing issue in the
related dw_dp_unbind() teardown path:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_unbind() {
	...
	disable_irq(dp->irq);
	phy_exit(dp->phy);
	drm_bridge_put(dp->next_bridge);
	drm_dp_aux_unregister(&dp->aux);
	drm_bridge_remove(&dp->bridge);
}

[Severity: High]
This isn't a bug introduced by this patch, but can this cause a
use-after-free if an HPD interrupt fires right before disable_irq() is
called?=20

If dp->hpd_work is scheduled and the devm-allocated struct dw_dp is freed
during device removal, the background worker might execute dw_dp_hpd_work()
on freed memory.=20

Does dw_dp_unbind() need to call cancel_work_sync(&dp->hpd_work)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-synopsys-d=
w-dp-improvements-v4-0-f0f4a4ede712@collabora.com?part=3D6
