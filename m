Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252BEC55172
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661A110E27B;
	Fri, 31 Jul 2026 21:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W4cTVDt7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9538810E27B
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:47:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CE187600C3;
 Fri, 31 Jul 2026 21:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DFE1F00AC4;
 Fri, 31 Jul 2026 21:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785534470;
 bh=l3hLVNuk7LoxvtAB2RHZljNG1db/eKUs5NKArSzTy7o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W4cTVDt7TaX3y1DsaW+oBIFfNAjhgH/JP3+wEGj/9ukrCEChZtcnKEyQJVYUMYwog
 07gx0tLmETDvexGe8AMOkidV3R7R68x+eT+VC4LekoS01A1CM4i1LLgucLsAuRqhXn
 YFv8sOZg3PRPcFZ/wpNIoca/TUXVrLGWcKJ0BJXMM8yCkzxdTmWNOxQpDjBkqXFPLn
 yCy6VS+wJ2AhwjPdTyPdLobnQpSGGxWKX2zbdcKj5UJCFt5amrS35P3KZJUF5qZ18M
 6dYlXPa95vLb2P8JuySW9CzIMisHzvn460NkJ5a0nZeIT1LASgtAizQCFfCa9/ShpH
 +svtjIBz1HUnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 37/69] drm/rockchip: dw_hdmi_qp: Control the HPD IRQ
 line via the bridge HPD ops
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-37-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-37-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:47:49 +0000
Message-Id: <20260731214750.31DFE1F00AC4@smtp.kernel.org>
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
- [High] Hardware is suspended before canceling asynchronous HPD work, crea=
ting a race condition that leads to I2C timeouts during system suspend.
- [Medium] The disable_hpd callbacks do not cancel the pending delayed HPD =
work, allowing spurious HPD events.
--

--- Patch [37]: [PATCH v10 37/69] drm/rockchip: dw_hdmi_qp: Control the HPD=
 IRQ line via the bridge HPD ops ---
commit ad6fbe00662ae75dcead6bf784de9de47ed9dd6c
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Control the HPD IRQ line via the bridge HPD ops

The HPD interrupt must not be delivered before the DRM connector is fully
set up, and it should be quiesced while the display pipeline is suspended.
On top of that, the threaded handler re-arms HPD unconditionally after the
hotplug debounce, which must not override an explicit disable requested by
the DRM core.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 46a61112c14f4..253da2162ce6f 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
[ ... ]
> @@ -308,12 +309,14 @@ static void dw_hdmi_qp_rk3588_enable_hpd(struct dw_=
hdmi_qp *dw_hdmi, void *data)
>  	struct rockchip_hdmi_qp *hdmi =3D (struct rockchip_hdmi_qp *)data;
> =20
>  	dw_hdmi_qp_rk3588_unmask_hpd(hdmi);
> +	enable_irq(hdmi->hpd_irq);
>  }
> =20
>  static void dw_hdmi_qp_rk3588_disable_hpd(struct dw_hdmi_qp *dw_hdmi, vo=
id *data)
>  {
>  	struct rockchip_hdmi_qp *hdmi =3D (struct rockchip_hdmi_qp *)data;
> =20
> +	disable_irq(hdmi->hpd_irq);
>  	dw_hdmi_qp_rk3588_mask_hpd(hdmi);
>  }

[Severity: Medium]
The DRM core disables HPD (e.g., during driver unbind or DRM pipeline disab=
le),
which invokes dw_hdmi_qp_rk3588_disable_hpd() and dw_hdmi_qp_rk3576_disable=
_hpd().
This disables the HPD IRQ but does not cancel the already queued hdmi->hpd_=
work.

Could this delayed work execute up to 150ms later, probing the connector and
running EDID reads when the driver expects HPD to be fully quiesced, result=
ing
in spurious HPD events?

[ ... ]
> @@ -688,14 +693,14 @@ static int dw_hdmi_qp_rockchip_bind(struct device *=
dev, struct device *master,
>  	if (plat_data.cec_irq < 0)
>  		return plat_data.cec_irq;
> =20
> -	irq =3D platform_get_irq_byname(pdev, "hpd");
> -	if (irq < 0)
> -		return irq;
> +	hdmi->hpd_irq =3D platform_get_irq_byname(pdev, "hpd");
> +	if (hdmi->hpd_irq < 0)
> +		return hdmi->hpd_irq;
> =20
> -	ret =3D devm_request_threaded_irq(dev, irq,
> +	ret =3D devm_request_threaded_irq(dev, hdmi->hpd_irq,
>  					cfg->ctrl_ops->hardirq_callback,
>  					cfg->ctrl_ops->irq_callback,
> -					IRQF_SHARED, "dw-hdmi-qp-hpd",
> +					IRQF_NO_AUTOEN, "dw-hdmi-qp-hpd",
>  					hdmi);
>  	if (ret)
>  		return ret;

[Severity: High]
When the system suspends, dw_hdmi_qp_rockchip_suspend() is called. It first
calls dw_hdmi_qp_suspend(), which disables the main_irq used for I2C
completions. It then calls cancel_delayed_work_sync(&hdmi->hpd_work):

dw_hdmi_qp_rockchip_suspend() {
    ...
    dw_hdmi_qp_suspend(dev, hdmi->hdmi);
    cancel_delayed_work_sync(&hdmi->hpd_work);
    ...
}

If the HPD work is executing concurrently, it will attempt to read the EDID=
 via
I2C, but since main_irq is disabled, the I2C read will time out.

Can this race condition lead to I2C timeouts and bus hangs during system
suspend?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D37
