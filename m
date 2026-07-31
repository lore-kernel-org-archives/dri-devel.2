Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08BCC55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 22:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0930110E244;
	Fri, 31 Jul 2026 22:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PYRFlF+G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C0810E244
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 22:04:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA844418C4;
 Fri, 31 Jul 2026 22:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424171F00AC4;
 Fri, 31 Jul 2026 22:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785535474;
 bh=JXs9BCuHgkbZAF5tkSCTQCC4CvdKPKdESfWS6QXArPM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PYRFlF+GPmfFC6YioYOKyzQsElmei62Tti44Rlj0t3e0NwmtEms6S/5r9I4hBKf+E
 1DXFI7yeO6qnPM5o/uNxpHgevbz5tJYKIruhfadvCG4SuQvvSplAyIkEXOEdbcd6yS
 3zc/lDNUKxSOR1kpI2coc1Ugoxvr69EB1t7Xb3f7DyD3X6OWm3qI/ZO3FX4tFGGgnX
 8GhvhOlGntnx7sdpvXWLHsTsWb9VRBAI8Fzk+5img13ERG20tBE+yiOsiNpWz0zMr0
 NuzrU0uk5r1TYaROJ+4WFYP1DBvVyZWYBlVYWNx2MNr0h+EzE2XVweaFfElPpBbMJL
 iIjQkHWG5fZTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 38/69] drm/rockchip: dw_hdmi_qp: Use
 dw_hdmi_qp_hpd_notify() for HPD reports
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-38-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-38-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:04:33 +0000
Message-Id: <20260731220434.424171F00AC4@smtp.kernel.org>
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
- [High] Resource leak and permanent driver re-bind failure due to componen=
t-level devm_ usage in bind().
--

--- Patch [38]: [PATCH v10 38/69] drm/rockchip: dw_hdmi_qp: Use dw_hdmi_qp_=
hpd_notify() for HPD reports ---
commit 494b956223c364f53e596d5709d4eefbf8153439
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Use dw_hdmi_qp_hpd_notify() for HPD reports
   =20
This commit updates the driver to notify only the affected connector instea=
d of
polling all of them, and ensures .detect_ctx() runs on reconnect to recover=
 SCDC
state.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 253da2162ce6f..bbdd47d4f3817 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:dw_hdmi_qp_rockchip_bind() {
    ...
	ret =3D devm_request_threaded_irq(dev, hdmi->hpd_irq,
					cfg->ctrl_ops->hardirq_callback,
					cfg->ctrl_ops->irq_callback,
					IRQF_NO_AUTOEN, "dw-hdmi-qp-hpd",
					hdmi);
    ...
}

[Severity: High]
This is a pre-existing issue, but does using devm_request_threaded_irq() in
bind() tied to the component device cause a resource leak on unbind?

Since the component device itself isn't destroyed during unbind, the IRQ is
never freed. When the DRM master is re-bound, could this cause the driver to
permanently fail initialization because requesting the same IRQ returns -EB=
USY?

Prior to the commit "drm/rockchip: dw_hdmi_qp: Control the HPD IRQ line via
the bridge HPD ops" removing the IRQF_SHARED flag, would this have succeeded
but registered a second handler with a dangling dev_id pointer, leading to a
use-after-free when the interrupt fired?

A similar issue appears in the bridge helper:

drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c:dw_hdmi_qp_bind() {
    ...
	ret =3D devm_request_threaded_irq(dev, plat_data->main_irq,
					dw_hdmi_qp_main_hardirq, NULL,
					IRQF_SHARED, dev_name(dev), hdmi);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this also leak the main IRQ and the
bridge allocation across unbind/rebind cycles for the same reason?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D38
