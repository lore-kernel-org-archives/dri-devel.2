Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D238C44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DEF10EF55;
	Thu, 23 Jul 2026 01:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R9KF3yPO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851FE10EF55
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:51:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E94C412E7;
 Thu, 23 Jul 2026 01:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0561F000E9;
 Thu, 23 Jul 2026 01:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771493;
 bh=yK8dZkZDgZz/rowkGvL7dSgIrXxpohN837PBMgSYhiE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R9KF3yPO7h72HM7V2mHO8q2noICNLtC9YbcnhGLMWDEwy+C1ytLhz7qISBJT3aQdq
 izz/49Y8lwjYNA8hB594kXB7OwNlXetFfMrDZcYmfeyvSZv6sI1KNPCRnHHAYtzVLm
 yu/Xj7TRalkHIR3SjmyX29iqQ0KsVKlcmlIhPbeonObtsiWpmYsDv/yaeimlLstRf6
 ug1n2qUgmlDi1syDyUVNxqyI5PA0Irnwd3V+i2Z4lSMoUEVlp9qCXYFF++TysTKIJK
 qk3h7iUojhQ/PxC0AbjohOluVHf9QAUFP2Bnu2nmNzHaBhV6/8DWtrJs2PhMgrNbBn
 1IpCMUU55eKtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 27/61] drm/rockchip: dw_hdmi_qp: Avoid spurious HPD
 IRQ thread wakeups
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-27-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-27-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:51:32 +0000
Message-Id: <20260723015133.1C0561F000E9@smtp.kernel.org>
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
- [High] Use-After-Free and resource leaks in component bind due to mismatc=
hed devm_ and drmm_ lifecycles.
--

--- Patch [27]: [PATCH v9 27/61] drm/rockchip: dw_hdmi_qp: Avoid spurious H=
PD IRQ thread wakeups ---
commit fe0521a96f0ae3fca18406e54bcdc6ddbecf6e85
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Avoid spurious HPD IRQ thread wakeups

The RK3576 and RK3588 HPD hardirq handlers read shared status registers
and currently wake the threaded handler whenever any bit in those
registers is set. This commit masks the status value with the SoC-specific
HPD interrupt bit to avoid spurious IRQ thread wakeups.

Link: https://lore.kernel.org/all/20260702151346.5A4EC1F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 2aceff11d14b5..7e3e86d056116 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

> @@ -381,6 +384,8 @@ static irqreturn_t dw_hdmi_qp_rk3588_hardirq(int irq,=
 void *dev_id)
> =20
>  	regmap_read(hdmi->regmap, RK3588_GRF_SOC_STATUS1, &intr_stat);
> =20
> +	intr_stat &=3D hdmi->port_id ? RK3588_HDMI1_OHPD_INT : RK3588_HDMI0_OHP=
D_INT;
> +

[Severity: High]
This is a pre-existing issue, but could this handler trigger a use-after-fr=
ee
after the component is unbound?

It looks like dw_hdmi_qp_rockchip_bind() allocates the hdmi context using
drmm_kzalloc() (tied to the DRM aggregate device), but registers this IRQ
handler using devm_request_threaded_irq() (tied to the platform device):

drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:dw_hdmi_qp_rockchip_bind() {
    ...
    ret =3D devm_request_threaded_irq(dev, irq,
                                    cfg->ctrl_ops->hardirq_callback,
                                    cfg->ctrl_ops->irq_callback,
                                    IRQF_SHARED, "dw-hdmi-qp-hpd",
                                    hdmi);
    ...
}

When the DRM component unbinds, drmm_ frees the hdmi struct. However, since
the platform device itself isn't removed, the devm_ allocated IRQ handler
remains active.

If an interrupt fires after unbind, wouldn't dw_hdmi_qp_rk3588_hardirq()
dereference the freed hdmi pointer when calling regmap_read()?

Should dw_hdmi_qp_rockchip_unbind() manually free the IRQ and other resourc=
es,
or should the IRQ be registered with a drmm_ wrapper instead?

>  	if (intr_stat) {
>  		if (hdmi->port_id)
>  			val =3D FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_MSK, 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D27
