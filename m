Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF31C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D3810F44C;
	Thu,  2 Jul 2026 15:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JDwDrwHN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2653110F445
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:11:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB3E141A0F;
 Thu,  2 Jul 2026 15:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BDC1F000E9;
 Thu,  2 Jul 2026 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783005117;
 bh=ACmnxgF8Un/EPDp0TwEadhkVrz3GTaUov59BzUFBg6U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JDwDrwHNe7S3TGd05dFb01SxPlzSJXZOS0vdpUL2OT6apywNq85n49qm5rMdhzgqk
 7AEw9y0NvxeAxr2v69YVd41vHzf+1vbM6UKtC2j6MTlgqCWQX45j/nuriSNofAKEUu
 GrbWRyDT0Ig2Q1kGKfVOQP3Za1K9fbPE8ivtnPo2xTVIuDVhdmXODvoQDvGcFWB/E3
 p9tPfcNcs61duKNvgyGMjF1Qj5QVmOvl8CLlMO70SakHt3R0T5ZlHQhyJbmu862Tcy
 fr1Le59UgcV4ExuuypEVuRALZt8PkvC4UIkUTBGLCzKaztPCRzIjN+rMsWoVygCgpg
 H6repj2C7wtjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 24/39] drm/rockchip: dw_hdmi_qp: Defer HPD IRQ enable
 until after connector setup
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-24-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-24-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:11:57 +0000
Message-Id: <20260702151157.A2BDC1F000E9@smtp.kernel.org>
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
- [High] Missing `disable_irq()` or `devm_free_irq()` in component `unbind(=
)` leaves the HPD IRQ enabled, causing a Use-After-Free of the `hdmi` struc=
t if an interrupt fires after the DRM device is torn down.
--

commit ed0ca175c20c7a0b231242e1a45aec15890b9c5d
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Defer HPD IRQ enable until after connector setup

This commit defers enabling the HPD IRQ until the end of the initialization
sequence by using IRQF_NO_AUTOEN and calling enable_irq() later. It also
removes the incompatible IRQF_SHARED flag.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 33036f194e348..3de4b3e6ea85e 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

> @@ -694,6 +694,8 @@ static int dw_hdmi_qp_rockchip_bind(struct device *de=
v, struct device *master,
>  		return dev_err_probe(dev, PTR_ERR(connector),
>  				     "Failed to init bridge connector\n");
> =20
> +	enable_irq(irq);
> +
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does the hardware IRQ remain enabled after
component unbind?

Since the IRQ is requested with devm_request_threaded_irq(), it won't be
freed until driver detach. However, when the component is unbound
(e.g., via sysfs), dw_hdmi_qp_rockchip_unbind() is called:

static void dw_hdmi_qp_rockchip_unbind(struct device *dev, ...)
{
        struct rockchip_hdmi_qp *hdmi =3D dev_get_drvdata(dev);

        cancel_delayed_work_sync(&hdmi->hpd_work);
}

This cancels the delayed work but does not disable the IRQ. After unbind,
the DRM master completes teardown and frees the hdmi struct (which was
allocated via drmm_kzalloc).

If a physical HDMI hotplug event occurs after unbind, could the hardirq
handler dw_hdmi_qp_rk3588_hardirq() execute and dereference the freed
hdmi->regmap, causing a use-after-free?

Should dw_hdmi_qp_rockchip_unbind() include a matching disable_irq() or
devm_free_irq() to prevent the interrupt from firing after teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D24
