Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2181FC55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CCAB10F3DD;
	Fri, 31 Jul 2026 20:30:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="flvzPSKg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07AEA10F3DD
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 20:30:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF2F24121E;
 Fri, 31 Jul 2026 20:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7714B1F00ADB;
 Fri, 31 Jul 2026 20:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785529840;
 bh=mB0eGEoRMD/Vojrhox/Y22mUEzS3JxtE1aUum73MdpA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=flvzPSKgPrDkdQydmN/FGnamUXZXHqjZ/DAOlkNf/DR7znO/BueEMyS2n723u68e4
 emGxqz0fZ6vnrquRCIv8sVg978O3M7kMLBWpiJVSUjHhbIOauCtYV7HY+zzXvAC9DI
 xUeVJYUebkxhTyA8B5MU4lZAZHNnppsz4F/pwSmKMefxSULBxKbuyJtZFe4ZMFYf+8
 a6hfLSeyXZlfNMhP08jvtaDEYyGFoC5OPqj8k9TToXtWbeCY2FwWMhef4QSSBZ09/y
 VD+duwBvegope6Cb0e7qTOMq3X7Kknr2wmwGQ6IF0XhadEC6ogV2Vy/wey7o5+1Nxv
 29g4pDxZvNdSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 30/69] drm/rockchip: dw_hdmi_qp: Cancel pending HPD
 work on suspend
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-30-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-30-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 20:30:40 +0000
Message-Id: <20260731203040.7714B1F00ADB@smtp.kernel.org>
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

New issues:
- [High] Deadlock during suspend: disabling the main IRQ before cancelling =
the HPD work causes I2C timeouts.

Pre-existing issues:
- [High] Incomplete fix: HPD IRQ is not actually disabled, allowing delayed=
 work to be re-armed during suspend.
- [High] Use-After-Free of `hdmi` due to devres/drmm mismatch on component =
unbind.
--

--- Patch [30]: [PATCH v10 30/69] drm/rockchip: dw_hdmi_qp: Cancel pending =
HPD work on suspend ---
commit 9b084d07cd142a4d5581877b274f1d064cd6ebd9
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Cancel pending HPD work on suspend

This commit cancels the pending HPD work during the suspend callback.
The intent is to prevent the work from probing the connector and reading
the EDID after the HDMI controller's power domain has been powered off.

Closes: https://lore.kernel.org/all/20260723015909.7F79A1F000E9@smtp.kernel=
.org/

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 646a4cb968309..e9fda67b8ca94 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -728,8 +728,12 @@ static int __maybe_unused dw_hdmi_qp_rockchip_suspen=
d(struct device *dev)
>  {
>  	struct rockchip_hdmi_qp *hdmi =3D dev_get_drvdata(dev);
> =20
> -	if (hdmi)
> -		dw_hdmi_qp_suspend(dev, hdmi->hdmi);
> +	if (!hdmi)
> +		return 0;
> +
> +	dw_hdmi_qp_suspend(dev, hdmi->hdmi);
> +
> +	cancel_delayed_work_sync(&hdmi->hpd_work);

[Severity: High]
Does this code cause a deadlock during suspend if the HPD work is actively
running?

Because dw_hdmi_qp_suspend() is called first, it explicitly disables the
main IRQ.

If the HPD work is running and reads the EDID over DDC, the read relies on
dw_hdmi_qp_i2c_read(), which waits for a completion signaled by the main IRQ
handler.

Since the main IRQ is already disabled, will the I2C transfers time out
repeatedly, stalling cancel_delayed_work_sync() and completely hanging the
suspend process?

[Severity: High]
This isn't a bug introduced by this patch, but does this actually prevent t=
he
work from running on unpowered hardware?

The commit message assumes drm_kms_helper_poll_disable() disables the HPD I=
RQ
via the bridge .hpd_disable() op.

However, rk3588_hdmi_phy_ops does not implement .disable_hpd:

static const struct dw_hdmi_qp_phy_ops rk3588_hdmi_phy_ops =3D {
	.init		=3D dw_hdmi_qp_rk3588_phy_init,
	.disable	=3D dw_hdmi_qp_rk3588_phy_disable,
	.read_hpd	=3D dw_hdmi_qp_rk3588_read_hpd,
	.setup_hpd	=3D dw_hdmi_qp_rk3588_setup_hpd,
};

This makes the DRM core's attempt to mask the IRQ a no-op, and the separate
HPD IRQ requested in dw_hdmi_qp_rockchip_bind() remains unmasked.

If a hotplug event occurs after cancel_delayed_work_sync() returns, but
before suspend_noirq disables all IRQs, will the handler fire and re-arm the
work on system_percpu_wq?

Since this workqueue is not freezable, could the work still execute after t=
he
power domain is off?

[Severity: High]
This is a pre-existing issue, but does the component unbind path have a
use-after-free issue?

In dw_hdmi_qp_rockchip_bind(), the hdmi context is tied to the DRM device's
lifetime:

	hdmi =3D drmm_kzalloc(drm, sizeof(*hdmi), GFP_KERNEL);

However, the HPD IRQ is tied to the platform device's lifetime:

	ret =3D devm_request_threaded_irq(hdmi->dev, irq,
					cfg->ctrl_ops->hardirq_callback,
					cfg->ctrl_ops->irq_callback,
					IRQF_SHARED, "dw-hdmi-qp-hpd",
					hdmi);

When the component is unbound (e.g., driver removal or DRM teardown), the
DRM device frees all drmm memory, including the hdmi structure.

Because the platform device itself isn't removed, its devm resources are not
released, leaving the IRQ active.

If an HPD interrupt fires subsequently, will the handler dereference the
freed hdmi pointer?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D30
