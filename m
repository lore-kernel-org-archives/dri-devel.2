Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855FCC55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA97C10F3E2;
	Fri, 31 Jul 2026 20:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ncRNFEto";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7390010F3DD
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 20:19:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EFF3D410AF;
 Fri, 31 Jul 2026 20:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A571F00AC4;
 Fri, 31 Jul 2026 20:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785529191;
 bh=xOZn1i0jgKuJQOQlgCyw59slkR7aYhE0j14rGgjKk4k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ncRNFEtoiUHyFD8H78jIciAixolJyk/B2/+rq8M5gcEDaqSt7FlhGmMVxTue8udsl
 VFZQMRxQdWe1a9LgugBmxbXgNONU6FsyvIkSDXKTs+E7X4XsEdOI4CH4I6V7aybLd7
 kkNdDXrAJqcbx1AodJerQrk99LuZYlPQroGaOrMLjEHRbZ88//+O48rL+5TcSRiqJE
 39AalAYnQ9lZR1gfcABAFqT3LKntKc31pqUUO44IJIO7xuF+AXIr96JO0JnNfmwxtB
 XiN7sKNyQfvmElQfHFY/ZthwyUKfpiAwdM8ZjL6FRml/gMLpYXcUyeDJIBW6WedrG4
 LchQP+0ukd3dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 29/69] drm/rockchip: dw_hdmi_qp: Fix invalid drvdata
 access in PM ops
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-29-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-29-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 20:19:51 +0000
Message-Id: <20260731201951.A8A571F00AC4@smtp.kernel.org>
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

Pre-existing issues:
- [High] Use-After-Free of `hdmi` struct due to `devm_request_threaded_irq`=
 being used in component bind, leaking the IRQ on unbind.
- [High] The HPD hardirq handler checks the raw SOC status register instead=
 of the interrupt pending status, breaking unplug detection and stealing sh=
ared IRQs.
--

--- Patch [29]: [PATCH v10 29/69] drm/rockchip: dw_hdmi_qp: Fix invalid drv=
data access in PM ops ---
commit fc12a8c8d5e7177cf76cf4554fb62df0ebde5bbd
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Fix invalid drvdata access in PM ops

The system-sleep PM callbacks fetch the driver state via dev_get_drvdata()
and dereference it unconditionally. This patch ensures non-NULL drvdata
always represents live state, allowing each PM callback to rely on a single
NULL check.

Closes: https://lore.kernel.org/all/20260702151550.8E14D1F000E9@smtp.kernel=
.org/
Closes: https://lore.kernel.org/all/20260723014811.1F9F01F000E9@smtp.kernel=
.org/

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 9c4cf68d79d50..646a4cb968309 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

> @@ -704,6 +704,8 @@ static void dw_hdmi_qp_rockchip_unbind(struct device =
*dev,
>  {
>  	struct rockchip_hdmi_qp *hdmi =3D dev_get_drvdata(dev);
> =20
> +	dev_set_drvdata(dev, NULL);
> +
>  	cancel_delayed_work_sync(&hdmi->hpd_work);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to rely on
devm_request_threaded_irq() for the HPD interrupt when lifecycle is managed
via component bind and unbind?

Looking at dw_hdmi_qp_rockchip_bind(), the IRQ is requested with devm on the
component device:

    ret =3D devm_request_threaded_irq(dev, hdmi->hpd_irq, ...);

Because devm resources are tied to the device's probe and remove lifecycle,
the IRQ is not freed when the component is unbound. When the aggregate DRM
device is torn down, hdmi (allocated via drmm_kzalloc) is freed.

If the HPD interrupt fires afterwards, the still-active IRQ handler will
dereference the freed hdmi pointer.

Also, calling cancel_delayed_work_sync() here doesn't prevent the active IRQ
handler from immediately re-arming the workqueue.

Should this use a non-devm request_threaded_irq() in dw_hdmi_qp_rockchip_bi=
nd()
and call free_irq() here in dw_hdmi_qp_rockchip_unbind()?

[Severity: High]
This is also a pre-existing issue, but does the hardirq handler properly ha=
ndle
interrupts on unplug events?

Looking at dw_hdmi_qp_rk3588_hardirq() and dw_hdmi_qp_rk3576_hardirq(), they
read the raw level register without masking:

    regmap_read(hdmi->regmap, RK3588_GRF_SOC_STATUS1, &intr_stat);
    if (intr_stat) {
        ...

When the HDMI cable is unplugged, the HPD level goes to 0, which triggers t=
he
interrupt. If no other unrelated bits in this 32-bit register are set,
intr_stat evaluates to 0 and the handler returns IRQ_NONE without clearing =
the
interrupt.

Could this cause the kernel to see an unhandled interrupt and disable it
permanently?

Conversely, if any unrelated bit is 1, it will always return IRQ_WAKE_THREA=
D,
falsely claiming interrupts for other devices on this shared IRQ line.

Should this check the interrupt pending status instead of the raw SOC status
register?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D29
