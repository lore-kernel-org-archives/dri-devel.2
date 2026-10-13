Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBDCCC6B15
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 23:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E2610EA4A;
	Tue, 13 Oct 2026 23:07:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A7C10EA4A
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 23:07:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21C2E4030C;
 Tue, 13 Oct 2026 23:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A4E1F00893;
 Tue, 13 Oct 2026 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791932861;
 bh=W5r5eEYIFgRBhU6ZRqEzQqGi+fZeUNx978VT+rG2aaE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CtBi7SgaRT8zVHG8HbaMkh/1Hjeq0D/B0hysWPx1wx9KqddJ1WYNlTWeQ7tEhQmVP
 Fh2Y9IxL1VwUswFya1Rk8rI+zRZASBvK1XGXBfIEuZCb0wPA2gogV3Rimk7NqtqPes
 StKCkf4KKp9Q55tVFwuZI7NMjW1oPldipYdg/Ty3jRM67RvJ1XA8jF0jXxXfwqaFQ8
 DsVi+RAlHa6kGskubmBQENJwIg9Hqi31MYTzBmbwZxzQMOa7m7Ty3Zu71RsAawKH6O
 NqMum9L9hwk3qMM6GgEsBfkGKDif75bZwLsuTk/rTFt0dpKwZrtd/1TsEaxtHgFLao
 4DT14BPvcmnMg==
Message-ID: <sashiko-outbox-170627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/15] drm/rockchip: vop2: Reset AXI and DCLK to
 improve robustness
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-7-6fab0fe43a9b@collabora.com>
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-7-6fab0fe43a9b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 23:07:40 +0000
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
- [High] devm_reset_control_get_optional_exclusive in component bind causes=
 -EBUSY on rebind
- [Medium] drm/rockchip: vop2: AXI reset is ineffective if clocks are gated=
 during bind
- [Medium] drm/rockchip: asymmetrical teardown disables PM runtime before c=
ore clocks
--

commit e900afe14d3a61065ef92e05c15c885d78bc0d20
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: vop2: Reset AXI and DCLK to improve robustness

Assert the AXI reset in the bind and CRTC disable paths, and the VP DCLK
reset in the enable path. These resets are intended to leave the hardware
in a clean state for the next use.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 14c073f61c646..afa4bc6cbcc4d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c

[ ... ]

> @@ -953,6 +974,8 @@ static int vop2_enable(struct vop2 *vop2)
> =20
>  static void vop2_disable(struct vop2 *vop2)
>  {
> +	vop2_reset_assert_deassert(vop2, vop2->axi_rst);
> +
>  	rockchip_drm_dma_detach_device(vop2->drm, vop2->dev);
> =20
>  	pm_runtime_put_sync(vop2->dev);

[Severity: Medium]
This problem wasn't introduced by this patch, but does the hardware
support having the PM runtime domain disabled before the core clocks?

In vop2_disable(), pm_runtime_put_sync() drops the device's PM reference,
which can power off the domain. However, the core clocks (pclk, aclk, hclk)
are disabled later in vop2_core_clks_disable_unprepare().=20

Dropping the power domain while functional clocks are still running might
violate hardware teardown sequencing and cause lockups. Since this patch
modifies the disable sequence by adding the reset, could the asymmetry be
corrected here as well?

[ ... ]

> @@ -2596,6 +2621,12 @@ static int vop2_create_crtcs(struct vop2 *vop2)
>  			return dev_err_probe(drm->dev, PTR_ERR(vp->dclk),
>  					     "failed to get %s\n", dclk_name);
> =20
> +		vp->dclk_rst =3D devm_reset_control_get_optional_exclusive(vop2->dev,
> +									 dclk_name);

[Severity: High]
Will this leak the exclusive reset handle if the DRM master is unbound
and later rebound?

Since devm_reset_control_get_optional_exclusive() is tied to the component
device (vop2->dev) rather than the aggregate DRM master device, the devres
allocation won't be released when the component unbind callback executes
because the component device itself isn't removed.

Upon rebind, a second call to this function will find the reset line
already exclusively acquired. This triggers a WARN_ON() in the reset core
and fails the bind with -EBUSY, breaking the driver after an unbind cycle.

[ ... ]

> @@ -2955,6 +2986,13 @@ static int vop2_bind(struct device *dev, struct de=
vice *master, void *data)
>  		return dev_err_probe(drm->dev, PTR_ERR(vop2->pll_hdmiphy1),
>  				     "failed to get pll_hdmiphy1\n");
> =20
> +	vop2->axi_rst =3D devm_reset_control_get_optional_exclusive(vop2->dev, =
"axi");

[Severity: High]
Similar to the dclk_rst allocation in vop2_create_crtcs(), will allocating
this device-managed resource here in the component bind path cause an
-EBUSY failure on rebind?

> +	if (IS_ERR(vop2->axi_rst))
> +		return dev_err_probe(drm->dev, PTR_ERR(vop2->axi_rst),
> +				     "failed to get axi reset\n");
> +
> +	vop2_reset_assert_deassert(vop2, vop2->axi_rst);

[Severity: Medium]
Will this synchronous reset be effective if the AXI and AHB clocks are
gated at this point?

The reset pulse is sent immediately after acquiring the handle in
vop2_bind(), but this happens before pm_runtime_enable() is called and
before the core clocks are explicitly prepared and enabled.

If the driver is loaded as a module or probed late, the kernel's unused
clock framework may have already gated the clocks. Pulsing a synchronous
reset while the IP block's clocks are gated usually acts as a silent
no-op. When vop2_enable() later powers on the domain, the hardware might
wake up with its previous dirty state, defeating the purpose of the reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-dw-hdmi-qp=
-yuv-v5-0-6fab0fe43a9b@collabora.com?part=3D7
