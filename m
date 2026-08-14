Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49051C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 00:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65EB810E0A8;
	Fri, 14 Aug 2026 00:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c/xW+J8I";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1DF310E0A8
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 00:18:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EA964600AF;
 Fri, 14 Aug 2026 00:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AFA1F000E9;
 Fri, 14 Aug 2026 00:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786666732;
 bh=RRo//RUuVnZRQfOLlltOs+eFMqdXSbJi39KV9fELxlg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c/xW+J8IM+sBY0/2YfPmkFAOTwSY5fIm+IjEs233e0gEFf+QreRzVTjuAJE723pcU
 zDMzAc4Yp6t+zV9UC3AXLf4ZnLKyM0J1WohEK3AvSLqZpEyEewRIgYwJYs2fFaVd20
 xArO1LYJCWFEPc5N0u6IYzf2Vq7S7ld2coNVq+X/pRjsPMK3tABGhnu/f24/gXpVCL
 DSnqUbf3ZoJ4rEtUAdrmBVVQim9xpHa3qofRxHRXq/AWnPX0PuAMT4kaJYVc7JiWBq
 M9cxlrUt9Ai5ZXRFdE/IRuy2QUFYQTrLBcinCqUfH5/v8lr/D7nlxEYCbtZIl+hZ6m
 /gySL3z3cIxLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/21] drm/panel: himax-hx8394: set prepare_prev_first
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260413-waveshare-dsi-touch-v3-8-3aeb53022c32@oss.qualcomm.com>
References: <20260413-waveshare-dsi-touch-v3-8-3aeb53022c32@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:18:47 +0000
Message-Id: <20260814001852.45AFA1F000E9@smtp.kernel.org>
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
- [High] Incorrectly setting `prepare_prev_first =3D true` reverses the pow=
er-on sequence, causing the DSI host to drive the PHY (LP-11) before the pa=
nel is powered on, risking hardware latch-up.
--

--- Patch [8]: [PATCH v3 08/21] drm/panel: himax-hx8394: set prepare_prev_f=
irst ---
commit c09b3f2141b3b76647c1bce815022a8389dcf60f
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/panel: himax-hx8394: set prepare_prev_first

This commit sets the prepare_prev_first flag for the Himax hx8394 panel.
The flag reverses the pre_enable and prepare ordering in the DRM bridge
chain so the DSI host powers on before the panel.

> Sending DSI commands from the prepare() callback requires DSI link to be
> up at that point.

Is this description accurate? Looking at panel-himax-hx8394.c, the DSI
commands are actually sent in the enable callback, not prepare():

drivers/gpu/drm/panel/panel-himax-hx8394.c:hx8394_enable() {
    ...
    ctx->desc->init_sequence(&dsi_ctx);
    ...
}

During enable, the DSI host is already fully powered on and initialized,
rendering prepare_prev_first unnecessary.

> diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm=
/panel/panel-himax-hx8394.c
> index c4d3e09a228da..d64f3521eb15b 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
> @@ -792,6 +792,8 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
>  	if (ret)
>  		return ret;
> =20
> +	ctx->panel.prepare_prev_first =3D true;
> +

[Severity: High]
Does setting this flag reverse the power-on sequence, causing the DSI host
to drive the PHY (LP-11) before the panel is powered on?

Because of this flag, panel power-on executes after the host has already
driven the DSI lanes. For example, in hx8394_prepare():

drivers/gpu/drm/panel/panel-himax-hx8394.c:hx8394_prepare() {
    ...
    ret =3D regulator_enable(ctx->vcc);
    ...
}

This executes after the host is initialized, which is a hardware sequencing
violation. Could this lead to current leakage, potential hardware latch-up,
or PHY initialization timeouts on strict DSI hosts?

>  	drm_panel_add(&ctx->panel);
> =20
>  	ret =3D mipi_dsi_attach(dsi);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413-waveshare-=
dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com?part=3D8
