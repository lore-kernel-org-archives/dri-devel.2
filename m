Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E636AC55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01EA910E1DD;
	Fri, 31 Jul 2026 20:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NKyTkzeK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622F410E1DD
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 20:47:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2C52434B6;
 Fri, 31 Jul 2026 20:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9631F00AC4;
 Fri, 31 Jul 2026 20:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785530875;
 bh=1PWoVFKN/j9vlqmtQHQzZaa8PW26d4prfhdEjMYRxCY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NKyTkzeKQZJ5e5U3DCoONwa0OvCT/fvNYSFFayfJPj8GgyXhqxol11WxkH1k7ni8C
 C8AhUKI0BngrRw13MWzPZ+Lj09a6uhibvNWn9b9QxC+WQbTuxEr/XemRcXmj5Bqh6d
 1z0gn/Rr4S9nU12JfnS+nsJjVsmYH2mCTRUoXIxdM35ah/hUgUQZCwtH9AFol9S3Fq
 qdoVwLMBhphjtN/o+6lJ7W24nsKEVxJCuSsIb0rtVRFCiFnXTFaR7gzSHDOuNtrjn/
 Bg0QkyH6RUlkgvC2L1px1Uck1Pe0QC1xvVyc6jTiQj1NY80srbf3V1dnNgZBtm3m5I
 E9n4w81vQXsYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 32/69] drm/rockchip: dw_hdmi_qp: Use local dev
 variable consistently in bind()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-32-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-32-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 20:47:55 +0000
Message-Id: <20260731204755.8A9631F00AC4@smtp.kernel.org>
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

Pre-existing issues:
- [High] Use-After-Free and resource leaks due to devm_ allocations in comp=
onent bind callback.
- [High] Pending delayed work is not canceled on error paths, leading to Us=
e-After-Free.
- [High] Missing cleanup for dw_hdmi_qp_bind() on the error path leads to r=
esource and bridge leaks.
--

--- Patch [32]: [PATCH v10 32/69] drm/rockchip: dw_hdmi_qp: Use local dev v=
ariable consistently in bind() ---
commit 43fdb5eca012528d707389ce53b62eb4132b9532
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Use local dev variable consistently in bind()

Replace indirect struct device accesses via hdmi->dev and pdev->dev with
the local dev parameter already available in dw_hdmi_qp_rockchip_bind(),
for consistency and readability.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 8b48558deb3e7..36043bf82273c 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

> @@ -670,7 +669,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *de=
v, struct device *master,
>  	if (irq < 0)
>  		return irq;
> =20
> -	ret =3D devm_request_threaded_irq(hdmi->dev, irq,
> +	ret =3D devm_request_threaded_irq(dev, irq,
>  					cfg->ctrl_ops->hardirq_callback,
>  					cfg->ctrl_ops->irq_callback,
>  					IRQF_SHARED, "dw-hdmi-qp-hpd",
>  					hdmi);

[Severity: High]
This isn't a bug introduced by this patch, but does the use of devm_ here
cause a use-after-free and resource leak on component unbind?

The hdmi context is allocated via drmm_kzalloc, tying its lifetime to the
DRM master device. However, devm_request_threaded_irq ties the HPD IRQ
handler to the platform device's lifecycle, not the component bind/unbind
lifecycle.

If the component is unbound (e.g. the DRM master is removed), drmm will free
the hdmi context, but the IRQ remains active. A subsequent HPD interrupt
will trigger the handler, which dereferences the freed hdmi pointer. Also,
every bind retry leaks devm resources like clocks and GPIOs since they
aren't tied to the bind lifecycle.

>  	if (ret)
>  		return ret;
> =20
>  	drm_encoder_helper_add(encoder, &dw_hdmi_qp_rockchip_encoder_helper_fun=
cs);
>  	ret =3D drmm_encoder_init(drm, encoder, NULL, DRM_MODE_ENCODER_TMDS, NU=
LL);
>  	if (ret)
> -		return dev_err_probe(hdmi->dev, ret, "Failed to init encoder\n");
> +		return dev_err_probe(dev, ret, "Failed to init encoder\n");

[Severity: High]
This is a pre-existing issue, but does this error path lead to a
use-after-free?

The HPD IRQ is requested earlier and can fire immediately, scheduling
hdmi->hpd_work. If drmm_encoder_init() fails here, we return directly
without calling cancel_delayed_work_sync().

The DRM core handles the component bind failure by tearing down the DRM
device, causing drmm to free the hdmi structure. The pending delayed work
will then execute and dereference the freed hdmi pointer.

> =20
>  	hdmi->hdmi =3D dw_hdmi_qp_bind(pdev, encoder, &plat_data);
>  	if (IS_ERR(hdmi->hdmi))
> -		return dev_err_probe(hdmi->dev, PTR_ERR(hdmi->hdmi),
> +		return dev_err_probe(dev, PTR_ERR(hdmi->hdmi),
>  				     "Failed to bind dw-hdmi-qp\n");
> =20
>  	connector =3D drm_bridge_connector_init(drm, encoder);
>  	if (IS_ERR(connector))
> -		return dev_err_probe(hdmi->dev, PTR_ERR(connector),
> +		return dev_err_probe(dev, PTR_ERR(connector),
>  				     "Failed to init bridge connector\n");

[Severity: High]
This isn't a bug introduced by this patch, but does this error path
permanently leak devm-managed bridges?

dw_hdmi_qp_bind() allocates state and registers a DRM bridge using devm_
functions tied to the platform device. If drm_bridge_connector_init() fails,
we return directly without calling dw_hdmi_qp_unbind() or cleaning up the
bridge.

Because the resources are managed by devm_ tied to the platform device, they
won't be freed when the component bind fails. Every retry of the component
bind will allocate new memory and register duplicate DRM bridges in the
global list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D32
