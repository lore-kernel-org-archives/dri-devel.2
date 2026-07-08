Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0EBC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED97310F30D;
	Wed,  8 Jul 2026 22:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aoQKQUDE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF0D10F30D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 22:10:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DC106001A;
 Wed,  8 Jul 2026 22:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2161F000E9;
 Wed,  8 Jul 2026 22:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783548650;
 bh=SWJ8sPmqHVbsLGhyEvK9o1+S/8Vl3p1/HlTYdnUF91o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aoQKQUDE/L+0HRikPp2Q86ZpPDeixAnlGLun0xnVvVFvEhVg1LzHTim1BjMyGr5go
 8b4jPAzeaBIHNvvVV+bCsyCxt0UByEgUuBxKKXd+SJec/r4GsDsj3P5Zm9P8ZSCKWC
 ClqG0jiD0ZUUua8sMTkOYjOdM11OFHOAULqJt8jJgZtl9tIcSLkxx8RK3KqYSMW6x9
 AMf09G1xTe1y1/5/q5D1GskEMuWId3jpUKzFS9rmMaZ6qunWKiO21sgRQ4HaHLVqZ7
 jziSuBzPV0lBuQqymefBSx15PYxNGq1VmHyKabrLan930ycsKEP8m/6FKLPuduD4/Y
 sJG5/y+1xGsEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/14] drm/rockchip: vop2: Reset AXI and DCLK to
 improve robustness
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260709-dw-hdmi-qp-yuv-v3-7-a4a982a9f2e7@collabora.com>
References: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
 <20260709-dw-hdmi-qp-yuv-v3-7-a4a982a9f2e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:10:49 +0000
Message-Id: <20260708221050.0A2161F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Using devm_* APIs in component bind callbacks causes memory leaks,=
 duplicate resource registrations on unbind/rebind, and fatal bind failures=
. The new patch exacerbates this by requesting exclusive reset controls.
--

--- Patch [7]: [PATCH v3 07/14] drm/rockchip: vop2: Reset AXI and DCLK to i=
mprove robustness ---
commit 9b374dfb00e64eeab45f2b86b059f7b28a55a177
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Reset AXI and DCLK to improve robustness

This patch adds assertions for the AXI reset in the CRTC disable path and t=
he
VP DCLK reset in the enable path. These optional resets are intended to lea=
ve
the hardware in a clean state and prevent random display output glitches on
platforms like RK3588.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c

[ ... ]

> @@ -2596,6 +2621,12 @@ static int vop2_create_crtcs(struct vop2 *vop2)
>  			return dev_err_probe(drm->dev, PTR_ERR(vp->dclk),
>  					     "failed to get %s\n", dclk_name);
> =20
> +		vp->dclk_rst =3D devm_reset_control_get_optional_exclusive(vop2->dev,
> +									 dclk_name);
> +		if (IS_ERR(vp->dclk_rst))
> +			return dev_err_probe(drm->dev, PTR_ERR(vp->dclk_rst),
> +					     "failed to get %s reset\n", dclk_name);
> +

[Severity: High]
This is a pre-existing issue, but will this exclusive reset control request
fail with -EBUSY on component rebind?

Because vop2_create_crtcs() is called from the component bind path in
vop2_bind() in drivers/gpu/drm/rockchip/rockchip_drm_vop2.c, any resources
allocated with devm_ functions tied to the platform device (vop2->dev) are
not released when the component is unbound.=20

When the component is rebound, the previous exclusive reset control is still
held. It appears this might cause devm_reset_control_get_optional_exclusive=
()
to deterministically fail with -EBUSY since the prior exclusive grab was
never released.

Should this use reset_control_get_optional_exclusive() instead and be
manually released in the unbind path, or use a component-specific managed
API?

>  		np =3D of_graph_get_remote_node(dev->of_node, i, -1);
>  		if (!np) {
>  			drm_dbg(vop2->drm, "%s: No remote for vp%d\n", __func__, i);

[ ... ]

> @@ -2955,6 +2986,11 @@ static int vop2_bind(struct device *dev, struct de=
vice *master, void *data)
>  		return dev_err_probe(drm->dev, PTR_ERR(vop2->pll_hdmiphy1),
>  				     "failed to get pll_hdmiphy1\n");
> =20
> +	vop2->axi_rst =3D devm_reset_control_get_optional_exclusive(vop2->dev, =
"axi");
> +	if (IS_ERR(vop2->axi_rst))
> +		return dev_err_probe(drm->dev, PTR_ERR(vop2->axi_rst),
> +				     "failed to get axi reset\n");
> +

[Severity: High]
This is also a pre-existing issue, but will requesting an exclusive reset
control tied to the platform device here also cause a fatal -EBUSY error
during a component rebind?

Similar to the dclk_rst allocation, vop2->axi_rst is allocated in vop2_bind=
()
with the devm_ API. When the DRM component master is unbound and then rebou=
nd,
vop2_bind() executes again and attempts to grab the exclusive reset control.
Since the previous devm_ allocation is tied to the persistent platform devi=
ce
and wasn't released during component unbind, will this fail immediately with
-EBUSY?

>  	vop2->irq =3D platform_get_irq(pdev, 0);
>  	if (vop2->irq < 0)
>  		return dev_err_probe(drm->dev, vop2->irq, "cannot find irq for vop2\n"=
);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-dw-hdmi-qp=
-yuv-v3-0-a4a982a9f2e7@collabora.com?part=3D7
