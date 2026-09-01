Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230E6C624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B04910E218;
	Tue,  1 Sep 2026 19:50:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VCnLgsV/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C9610E218
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:50:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8909B6022E;
 Tue,  1 Sep 2026 19:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085751F000E9;
 Tue,  1 Sep 2026 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788292216;
 bh=LNB6mCwfycAE3mE4jEYceLSAgZl/L0RsMy63uKYcOjU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VCnLgsV/M8U55BuY3MFrU8DHfrig6w3ceF73CSHwjg6BPri2hxt3prr+FjM1xxwfo
 XEIThYGoXL0YHflw9bfYMoULnhnHa9Py7H85Plf9OB/GT0zp7NsqLxiaxFQEPJJmfF
 o/1SC4gKp6CUa68uGtz6u1hcCLC5Uc+ZSANlHnTaVJHZI4WZn1nrmzfOO9K5FnR8BL
 MeLYC5JQWs+OD/H4TtgnIibKvRF6TZG5XyqA1KaMTRGYpU72ekpwWkThaX7PV+yJDg
 wOqdCwtq5BaNVw61fda7vZs4dlUbjRXwi/oSeWZq0V7JLYOjEgKUkYh2+8SnOGllIr
 QulL8p+hkAd+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 36/74] drm/rockchip: dw_hdmi_qp: Mask RK3576 HPD IRQ
 in io_init
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-36-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-36-bc12954a0688@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 19:50:15 +0000
Message-Id: <20260901195016.085751F000E9@smtp.kernel.org>
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
- [High] Component bind function leaks devm resources and creates use-after=
-free conditions with IRQ and workqueue.
--

commit 44b7706481ee59b636405417779ad4e2c3cd6fc8
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Mask RK3576 HPD IRQ in io_init
   =20
Start with HPD masked, matching RK3588, so the bridge framework controls
when interrupts are armed via hpd_enable().

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index dff4002331546..bcfa6646546eb 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -432,7 +432,7 @@ static void dw_hdmi_qp_rk3576_io_init(struct rockchip=
_hdmi_qp *hdmi)
> =20
>  	regmap_write(hdmi->vo_regmap, RK3576_VO0_GRF_SOC_CON14, val);
> =20
> -	val =3D FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 0);
> +	val =3D FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 1);
>  	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issue
in the component bind function:

drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:dw_hdmi_qp_rockchip_bind() {
[ ... ]
	hdmi =3D drmm_kzalloc(drm, sizeof(*hdmi), GFP_KERNEL);
[ ... ]
	ret =3D devm_request_threaded_irq(dev, irq,
					cfg->ctrl_ops->hardirq_callback,
					cfg->ctrl_ops->irq_callback,
					IRQF_SHARED, "dw-hdmi-qp-hpd",
					hdmi);
[ ... ]
}

Does this code create a use-after-free condition on unbind?=20

The hdmi context is allocated with drmm_kzalloc(), which ties its lifetime
to the DRM master device. However, the IRQ is requested using
devm_request_threaded_irq() on the component device.

When the DRM master is unbound, the hdmi context is freed, but since the
component device remains, the IRQ is not freed. If the IRQ triggers after
unbind, will it access the freed hdmi structure?

Additionally, if the driver unbinds and rebinds without being completely=20
removed, will the devm_* allocations leak and cause=20
devm_request_threaded_irq() to return -EBUSY, permanently breaking the driv=
er?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-dw-hdmi-qp=
-scramb-v11-0-bc12954a0688@collabora.com?part=3D36
