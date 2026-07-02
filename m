Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813AEC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1EAE10E506;
	Thu,  2 Jul 2026 15:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CaD00utj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D7C10E506
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:03:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AEC2601CA;
 Thu,  2 Jul 2026 15:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60AB1F000E9;
 Thu,  2 Jul 2026 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783004620;
 bh=ow3K1mtgPPALUIgeRDaKPLTMvtcgTYHMUQe9yqYtpg4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CaD00utjgKRBuFL0D28j2WqhDNLoXz7sLtBkNQu1clwdjlGCDPqirNJpVKeMkKUth
 skUCEXwYf0EQcYHTnVtICreJLzlmLBJAG3aZp+KphOoZvsxf8Oa+/JpBhI5763Rv3h
 ohSN74puC0/Z4iMSjt71whGb8FlFMik4dUddiEgitwzgpBIe5VNGyQjWvh2TW1aHYL
 JuK7WGCidRZDQt/753p/xMJhFTnwvn7QByO1kFJGDIu/3igeitgSihJpNWi+u56e/a
 gtVBxrSnQ4fKsyYibnttLLkIE481iGbbzfll62Z7t3pzzcFDWJvMJLi64JhwOt6aDY
 FHVtahLn2bwHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 22/39] drm/rockchip: dw_hdmi_qp: Use local dev
 variable consistently in bind()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-22-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-22-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:03:40 +0000
Message-Id: <20260702150340.C60AB1F000E9@smtp.kernel.org>
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
- [High] Component bind/unbind lifetime mismatch leading to Use-After-Free =
and resource leaks.
--

commit 53ed72bcdde7f86deb352e52bb664f24f880b84c
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Use local dev variable consistently in bind()

This patch updates dw_hdmi_qp_rockchip_bind() to use the local dev paramete=
r=20
instead of indirect struct device accesses. This improves consistency and=20
readability throughout the function.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 7bd0f6dcbe5dc..d2fcfa70ed168 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

> @@ -671,7 +670,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *de=
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
This is a pre-existing issue, but could this lifetime mismatch between the=
=20
component device and the DRM master lead to a use-after-free?

The hdmi context is allocated earlier in dw_hdmi_qp_rockchip_bind() using=20
drmm_kzalloc(), which ties its lifetime to the DRM master device:

    hdmi =3D drmm_kzalloc(drm, sizeof(*hdmi), GFP_KERNEL);

However, the HPD interrupt is requested using devm_request_threaded_irq()=20
with the component device (dev).

If the master DRM device is unbound, the hdmi context will be freed=20
automatically. Looking at dw_hdmi_qp_rockchip_unbind(), it only cancels the=
=20
delayed work but lacks manual cleanup of the IRQ:

static void dw_hdmi_qp_rockchip_unbind(struct device *dev,
				       struct device *master,
				       void *data)
{
	struct rockchip_hdmi_qp *hdmi =3D dev_get_drvdata(dev);

	cancel_delayed_work_sync(&hdmi->hpd_work);
}

If the HPD interrupt fires after the master DRM device is unbound but befor=
e=20
the component device is unbound, the dangling interrupt handler will execut=
e=20
with a freed hdmi pointer. Is it possible to tie the IRQ lifetime to the DR=
M=20
master or explicitly free it in the unbind path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D22
