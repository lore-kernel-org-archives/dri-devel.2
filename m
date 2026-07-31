Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF58DC55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C895B10E09D;
	Fri, 31 Jul 2026 21:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T4dGNBqt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2923C10E1AF
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:14:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 07EA2600C3;
 Fri, 31 Jul 2026 21:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2891F00AC4;
 Fri, 31 Jul 2026 21:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785532441;
 bh=0+PsXSi9WOoj167CExU1ZB74WXeNBYQvaj4DuB3jRnc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T4dGNBqtxZVYL/XkcIlXhJnvFrCwv9vsHn/VfcLGae5RBXcXaqeBYuxq47bx3Qpe2
 Q97OUIrKBR4CpWoybyJK8oiiNEUMlY8ep4DR+2klfS5XkzZg8B6bhNFRbYnBsGIk/U
 qszFMk9VbLcYtEc2kElNznp6VTgEsZ0Aq9vF0Q1lj0rsRrabfj0q6vprymCA6Y/s6R
 fUwp76TYN7QsoYQfSMkSF5+MvPRGFEFqcY8O3hZ3vDeti9jqgOY9uQM25eH+XSYV/o
 td7CM7s55WsUq2CW9B9JwlxYPNcQFG2xg2m6CQrnle9ZeAawybUSrqK/qe3Zl07Egw
 zqJVwpSC7rLlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 34/69] drm/rockchip: dw_hdmi_qp: Mask RK3576 HPD IRQ
 in io_init
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-34-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-34-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:14:00 +0000
Message-Id: <20260731211401.4D2891F00AC4@smtp.kernel.org>
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
- [Medium] Logic error: HPD interrupt is unconditionally unmasked during `s=
etup_hpd`, defeating the patch's intent to defer arming to the bridge frame=
work.

Pre-existing issues:
- [High] High-severity Use-After-Free and resource leaks due to improper us=
e of `devm_*` APIs in the component `bind` callback.
- [High] RK3588 HPD IRQ handler clears the interrupt status a second time w=
hen unmasking, causing potential loss of hotplug events.
--

--- Patch [34]: [PATCH v10 34/69] drm/rockchip: dw_hdmi_qp: Mask RK3576 HPD=
 IRQ in io_init ---
commit 1e56140d6c0038883d14ac31b8ac46f871e3f59e
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Mask RK3576 HPD IRQ in io_init

This commit masks the HPD interrupt during I/O initialization for RK3576,
intending to defer interrupt arming to the bridge framework.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
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

[Severity: Medium]
Does this change actually defer the interrupt arming?

Looking at dw_hdmi_qp_rk3576_setup_hpd() in the same file, the interrupt
appears to be unconditionally unmasked later during hardware initialization:

drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:dw_hdmi_qp_rk3576_setup_hpd(=
) {
    ...
    val =3D (FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_CLR, 1) | FIELD_PREP_WM16(=
RK3576_HDMI_HPD_INT_MSK, 0));
    ...
}

Additionally, it appears that rk3576_hdmi_phy_ops lacks the .enable_hpd and
.disable_hpd callbacks. Can the bridge framework actually control the
interrupt without these callbacks implemented?

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
in the component bind/unbind lifecycle.

In dw_hdmi_qp_rockchip_bind(), devm_request_threaded_irq() is used to
allocate the IRQ handler on the platform device:

drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:dw_hdmi_qp_rockchip_bind() {
    ...
    ret =3D devm_request_threaded_irq(dev, irq, ...);
    ...
}

However, the dev_id passed is hdmi, which is allocated via
drmm_kzalloc(). Since devm_ resources are tied to the device probe/remove
lifecycle rather than the component bind/unbind lifecycle, the IRQ is not
freed in dw_hdmi_qp_rockchip_unbind().

If the master unbinds, the drmm memory is freed, but the IRQ handler remains
active. Could an interrupt firing after unbind cause a use-after-free when
it accesses the freed hdmi pointer?

[Severity: High]
This is a pre-existing issue, but does dw_hdmi_qp_rk3588_irq() accidentally
clear the interrupt a second time when unmasking?

drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:dw_hdmi_qp_rk3588_irq() {
    ...
    val |=3D FIELD_PREP_WM16(RK3588_HDMI0_HPD_INT_MSK, 0);
    regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
    ...
}

Because this uses a bitwise OR, val retains the RK3588_HDMI0_HPD_INT_CLR
write-enable mask and data bit from earlier in the function. Does this
second regmap_write() clear the interrupt again, potentially losing hotplug
events that occurred between the two writes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D34
