Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7B4CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7320210EC7D;
	Tue, 23 Jun 2026 20:11:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IRGy6bG3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6443010EC7F
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:11:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E051601D6;
 Tue, 23 Jun 2026 20:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BF61F00ACA;
 Tue, 23 Jun 2026 20:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782245496;
 bh=E4OQBvD/43yxCYHKK6cL5tCtMdhI9W+U0R4DGTGo988=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IRGy6bG3m9Px4v20b7iKO8eq+tdgUTXzQSGHGL/ZCR2FRg+/iDdfOnVVXHN14FXZy
 CqtrQ6prE0S1Y+vbaoKcMw90RlZOj5JdRgSR3NtuF+hwiLSc8QlxTF42L6G2oUkUe0
 F7b9B3R1b9s7l2LwVI+dhhKyYI52JBDNwWt/20jxeYmCBWReggrw6WyCXhbZeNv75m
 VfmASingrlCV+g6Ym5p54gbY6jZlxsq2QqNrvF71AbLHJFAcjt0IHaqDoT7t510LwG
 To4sWDL3uBiraYF2ZrmLFKYGfzl7ZGDX1PXVsaKuCoGMq0lNAp/u31euXAZgbS6Kt3
 TpZyGJfGmFC9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] drm/bridge: synopsys: dw-dp: Support software
 triggered OOB HPD
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260612-synopsys-dw-dp-improvements-v3-5-dc61e6352508@collabora.com>
References: <20260612-synopsys-dw-dp-improvements-v3-5-dc61e6352508@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:11:35 +0000
Message-Id: <20260623201136.15BF61F00ACA@smtp.kernel.org>
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

New issues:
- [High] Reference leak of the downstream bridge in `dw_dp_bind()` on both =
success and error paths.
- [High] The driver incorrectly treats the absence of a downstream bridge a=
s a fatal error, breaking backward compatibility.

Pre-existing issues:
- [High] Missing `cancel_work_sync()` for `dp->hpd_work` during unbind lead=
s to a Use-After-Free.
--

commit 121b9fc711d52bcdbd8b50a6dc50a5308864d167
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Support software triggered OOB HPD

Add support for USB-C DP AltMode out-of-band hotplug handling. The
handling itself is implemented in the platform specific driver as the
registers to force HPD state are not part of the Designware DisplayPort
IP itself. Instead the platform integration might provide the necessary
functionality to mux the HPD signal.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 98cff435dfb87..7fa38145e35ce 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -2078,6 +2107,13 @@ struct dw_dp *dw_dp_bind(struct device *dev, struc=
t drm_encoder *encoder,
>  		goto unregister_aux;
>  	}

[Severity: High]
Does dw_dp_bind() leak the reference to the downstream bridge?

of_drm_get_bridge_by_endpoint() returns a bridge pointer with an incremente=
d=20
reference count, which is stored in next_bridge:

	next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
	if (IS_ERR(next_bridge)) {
		ret =3D PTR_ERR(next_bridge);
        ...

The reference is not dropped after drm_bridge_attach() succeeds, nor is it=
=20
dropped on the error path before jumping to unregister_aux. Could this leak=
=20
the reference on both success and error paths, preventing the downstream=20
bridge from cleanly unloading?


[Severity: High]
Should the absence of a downstream bridge be treated as a fatal error?

If the device tree defines the DP controller as the end of the display chain
(i.e., no endpoint 1 is defined), of_drm_get_bridge_by_endpoint() returns
-ENODEV. The code unconditionally aborts initialization here instead of=20
gracefully ignoring it:

	next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
	if (IS_ERR(next_bridge)) {
		ret =3D PTR_ERR(next_bridge);
		dev_err_probe(dev, ret, "failed to get follow-up bridge.\n");
		goto unregister_aux;
	}

Could this break backward compatibility and cause the driver to fail to pro=
be=20
on boards that do not define a downstream bridge?

> =20
> +	if (dw_dp_is_routed_to_usb_c(encoder)) {
> +		dev_dbg(dev, "USB-C mode\n");
> +
> +		if (dp->plat_data.hpd_sw_sel)
> +			dp->plat_data.hpd_sw_sel(dp->plat_data.data, 1);
> +	}
> +
>  	dw_dp_init_hw(dp);

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does dw_dp_unbind() leave=20
pending work scheduled?

During bind, the driver initializes dp->hpd_work and schedules it in the=20
interrupt handler dw_dp_handle_hpd_event(). However, dw_dp_unbind() does no=
t=20
cancel it:

void dw_dp_unbind(struct dw_dp *dp)
{
	drm_dp_aux_unregister(&dp->aux);
}

Because the dp context is allocated with devm_drm_bridge_alloc(), it is=20
automatically freed shortly after unbind returns. If the scheduled work=20
executes after dp is freed, could it cause a use-after-free in=20
dw_dp_hpd_work()?

Should cancel_work_sync(&dp->hpd_work) be added to dw_dp_unbind()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-synopsys-d=
w-dp-improvements-v3-0-dc61e6352508@collabora.com?part=3D5
