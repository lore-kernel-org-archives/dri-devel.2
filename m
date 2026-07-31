Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63365C55172
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2AD410F411;
	Fri, 31 Jul 2026 21:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fRnaWzSU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C147F10F411
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:27:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 75D9C43BBE;
 Fri, 31 Jul 2026 21:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C12F1F00AC4;
 Fri, 31 Jul 2026 21:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785533236;
 bh=Ergl1Hui+9gYGNiR0GgUuTgnMaWsogDKknGojG74nww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fRnaWzSUoRHcSFuIhU/uoe8g6IWFutzVEydc5MSmru3f2IfF5YRplKCvzQZkAbxhW
 Mdl75S/e0V91IKKADtZ6AOefGEtksfKbglMGO1toGFLC8Sbx+PCNfZs68WQuVKRP1X
 mcEMh3m7FcWmcxL3qAIo5ManqQZn40tQnQTBpiveKXvwKO3GrTRNOH+5yjbfCr9RMg
 OcaHdGlqjE7M0+Bs73Naf30NrU318qL5dI+CCKlsM2P6biOihqD5snWvtMKFJuYWzA
 EFSzi6rc0WDJVhEOi5Anf5z+ABWSBbNh63Q4Xba19ISXDabdUkW+gxMwtskx8Z3Gox
 et+q3qqly4u+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 35/69] drm/rockchip: dw_hdmi_qp: Implement
 .{enable,disable}_hpd() PHY ops
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-35-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-35-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:27:15 +0000
Message-Id: <20260731212716.2C12F1F00AC4@smtp.kernel.org>
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

New issues:
- [High] The threaded IRQ handlers unconditionally call `.enable_hpd()` to =
unmask the HPD interrupt, which overrides the DRM core's explicit request t=
o disable HPD via `.disable_hpd()`.

Pre-existing issues:
- [High] Vulnerability to Use-After-Free during unbind/teardown because the=
 delayed work can be re-queued by an active IRQ after it has been canceled.
--

--- Patch [35]: [PATCH v10 35/69] drm/rockchip: dw_hdmi_qp: Implement .{ena=
ble,disable}_hpd() PHY ops ---
commit f5a2c115ab2bc65d86865686a80a9dc03bbb514c
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Implement .{enable,disable}_hpd() PHY ops

This commit implements .enable_hpd() and .disable_hpd() phy ops for RK3576
and RK3588 SoCs. It consolidates the interrupt clear-and-unmask sequence
into enable_hpd() and the mask-only operation into disable_hpd(), replacing
open-coded register writes.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 64e8e4c12cbd2..1965641fbadf1 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
[ ... ]
> @@ -364,15 +385,11 @@ static irqreturn_t dw_hdmi_qp_rk3576_hardirq(int ir=
q, void *dev_id)
>  static irqreturn_t dw_hdmi_qp_rk3576_irq(int irq, void *dev_id)
>  {
>  	struct rockchip_hdmi_qp *hdmi =3D dev_id;
> -	u32 val;
> =20
> -	val =3D FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_CLR, 1);
> -	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
>  	mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
>  			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
> =20
> -	val =3D FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_MSK, 0);
> -	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
> +	dw_hdmi_qp_rk3576_enable_hpd(NULL, hdmi);

[Severity: High]
Does this unconditionally unmask the HPD interrupt, potentially overriding
the DRM core's desired HPD state?

If an HPD interrupt is triggered right before the DRM core calls
dw_hdmi_qp_rk3576_disable_hpd() (e.g., during display teardown or suspend),
the hardirq handler will mask the interrupt and schedule this threaded
handler. If the DRM core then disables HPD, keeping it masked, will this
unconditional call to dw_hdmi_qp_rk3576_enable_hpd() in the threaded handler
override the DRM core's request and unmask the interrupt again?

Also, this isn't a bug introduced by this patch, but does calling
mod_delayed_work() here leave a use-after-free window during teardown?

During dw_hdmi_qp_rockchip_unbind(), cancel_delayed_work_sync(&hdmi->hpd_wo=
rk)
is called. However, since the HPD IRQ is managed by devm_request_threaded_i=
rq()
on the platform device, the IRQ remains active during unbind. If a hardware
HPD interrupt fires immediately after cancel_delayed_work_sync() completes,
could this threaded handler run and re-queue the work right before the hdmi
structure is freed?

> =20
>  	return IRQ_HANDLED;
>  }
[ ... ]
> @@ -401,22 +414,11 @@ static irqreturn_t dw_hdmi_qp_rk3588_hardirq(int ir=
q, void *dev_id)
>  static irqreturn_t dw_hdmi_qp_rk3588_irq(int irq, void *dev_id)
>  {
>  	struct rockchip_hdmi_qp *hdmi =3D dev_id;
> -	u32 val;
> -
> -	if (hdmi->port_id)
> -		val =3D FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_CLR, 1);
> -	else
> -		val =3D FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_CLR, 1);
> -	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
> =20
>  	mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
>  			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
> =20
> -	if (hdmi->port_id)
> -		val |=3D FIELD_PREP_WM16(RK3588_HDMI1_HPD_INT_MSK, 0);
> -	else
> -		val |=3D FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_MSK, 0);
> -	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
> +	dw_hdmi_qp_rk3588_enable_hpd(NULL, hdmi);

[Severity: High]
Could the unconditional call to dw_hdmi_qp_rk3588_enable_hpd() here
unintentionally re-enable the HPD interrupt when the DRM core expected it
to remain disabled?

As with the RK3576 path, if a hardware event triggers just before teardown,
this threaded handler might run after the DRM core has already requested
the interrupt be disabled, breaking the intended HPD state machine.

Also, this is a pre-existing issue, but is there a use-after-free risk
during driver unbind?

If a hardware interrupt fires after cancel_delayed_work_sync() has run in
dw_hdmi_qp_rockchip_unbind(), the still-active IRQ handler will call
mod_delayed_work() and re-queue the work right before the hdmi structure
gets freed.

> =20
>  	return IRQ_HANDLED;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D35
