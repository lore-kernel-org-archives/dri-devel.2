Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2134C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41BC310EF0E;
	Wed,  5 Aug 2026 15:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AYX37UGP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38A7610EF0A
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:44:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8C35409BC;
 Wed,  5 Aug 2026 15:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8133B1F00A3A;
 Wed,  5 Aug 2026 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785944658;
 bh=AVihhZ1ns7Q8mz3Q4dAlLVL/F1DjJx4/r+DBf0Zs4tc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AYX37UGPyQjObk1vKA5+ZOdmegvCrXpBRUBkkvspuWSz+s1tL4KUTkyN2y5uoUoed
 /r61l2v8khmi2GYYGdIxGXRa32OPgiV5ZL42LIkcVGmZJ1ZRv9tmBA1pacQf8SXZSe
 qyg+6lhW2u6RXt9iwvFRC0P5iycDQWRyI2uQeD1bLpMgT1ljLPojaqZ9PGX92MtjG3
 1K0vc5Dm3bKNhydTMt5TaAcJvXryA6kVTGZhz34rkxJCqwKhcsW/ABIVrjMYQhDS/C
 3cGjPpe5wpFvhz79dz6nOTvOmGxPorMLizXYq0lDItJtEEonHNu5/Wqvd+plnsZuRW
 BRmwq7R/ONElg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace
 connector property
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805153416.8459-1-royalnet026@gmail.com>
References: <20260805153416.8459-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:44:18 +0000
Message-Id: <20260805154418.8133B1F00A3A@smtp.kernel.org>
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
- [High] Use-After-Free in HPD interrupt handler and workqueue due to misma=
tched devm and drmm lifecycles on bind error paths.
--

--- Patch [1]: [PATCH v2] drm/rockchip: dw_hdmi_qp: attach the HDMI Colorsp=
ace connector property ---
commit 2bdde0ebdaa05708637a2fd7def9b7106821d2d5
Author: Igor Paunovic <royalnet026@gmail.com>

drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace connector property

This commit attaches the HDMI Colorspace connector property to the RK3588
HDMI QP output, which allows userspace to request BT.2020 colorimetry. This
enables HDR support for every RK3588 HDMI output.

Link: https://lore.kernel.org/all/20260714202850.40999-1-royalnet026@gmail.=
com/
Link: https://lore.kernel.org/all/20260731-dw-hdmi-qp-scramb-v10-0-294364b2=
cf15@collabora.com/

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 9c4cf68d79d50..35d04680d0113 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
[ ... ]
> @@ -695,6 +695,13 @@ static int dw_hdmi_qp_rockchip_bind(struct device *d=
ev, struct device *master,
>  		return dev_err_probe(hdmi->dev, PTR_ERR(connector),
>  				     "Failed to init bridge connector\n");
> =20
> +	/* Passing 0 selects the full HDMI colorspace set defined by the core. =
*/
> +	ret =3D drm_mode_create_hdmi_colorspace_property(connector, 0);
> +	if (ret)
> +		return ret;
[Severity: High]
This is a pre-existing issue, but does adding this new error return path
introduce a use-after-free risk with the HPD interrupt handler?

As noted in the commit message, the uncancelled hpd_work queue is a known
issue on bind error paths, but the same problem applies to the IRQ handler.

In dw_hdmi_qp_rockchip_bind(), the hdmi struct is allocated via
drmm_kzalloc(), tying its lifetime to the DRM device:

	hdmi =3D drmm_kzalloc(drm, sizeof(*hdmi), GFP_KERNEL);

However, the interrupt is registered using devm_request_threaded_irq()
against the component's platform device (pdev->dev):

	ret =3D devm_request_threaded_irq(hdmi->dev, irq,
					cfg->ctrl_ops->hardirq_callback,
					cfg->ctrl_ops->irq_callback,
					IRQF_SHARED, "dw-hdmi-qp-hpd",
					hdmi);

If drm_mode_create_hdmi_colorspace_property() fails, the component bind
returns an error. This causes the master bind to fail and destroy the DRM
device, which frees the hdmi struct.

Because the component device itself remains successfully probed, its devm
resources (including the IRQ handler) are not rolled back. If the shared
IRQ line fires after this bind failure, will the kernel invoke the handler
with the freed hdmi pointer?

> +
> +	drm_connector_attach_colorspace_property(connector);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805153416.8459=
-1-royalnet026@gmail.com?part=3D1
