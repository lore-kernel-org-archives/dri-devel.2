Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DCBC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E87110E6DB;
	Thu,  9 Jul 2026 12:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ovt+O3fy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3660610E6DB
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:24:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DEC2D41A5F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C63C1F000E9;
 Thu,  9 Jul 2026 12:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783599863;
 bh=amCnJNUnxFpqnz1M4THYao3WctE4Z7iS5x02Med6Dd4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ovt+O3fy5SX/DtkROskQrz15wLKCpgIcUOh2RQN3Y8owpSt/jOnJSxCzAD/qBPXJf
 RC53i4axiMLgln4WvxqRHI/8sLMLvLrjb2V41wCLIG3GP4Srpx9nnwyruHuowBPsSO
 TygaRdOC2f4EdKtAaSFYtpkEJBo0watIKT6QwZDpFO4OTiyEMUH36b17ptHeSzv1vO
 fOrJxWyhEy3gcxIZvXRScMEdl9ElUoN1vuN1NmFmxDzdqWIPwzyn6d+yPDwl2T1B3A
 +WmCkPXYqdhg3Pat9YcUNfSbWq+DS4sKIs744gzgFa9ML1Ikg5qiu1fZK5UrOymXzv
 JEoiGVL/jECJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 32/60] drm/sun4i: sun8i: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-32-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-32-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:24:23 +0000
Message-Id: <20260709122423.8C63C1F000E9@smtp.kernel.org>
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
- [High] sun4i_crtc_init() returns NULL on plane creation failure, but the =
caller checks for errors using IS_ERR(), leading to a NULL pointer derefere=
nce.
--

--- Patch [32]: [PATCH 32/60] drm/sun4i: sun8i: Convert to atomic_create_st=
ate ---
commit f2f31601b0b32de3a56fe2a7c233cf40904cfee8
Author: Maxime Ripard <mripard@kernel.org>

drm/sun4i: sun8i: Convert to atomic_create_state

This commit converts the sun8i plane reset hooks to use
atomic_create_state instead of drm_atomic_helper_plane_reset. It was
generated using a Coccinelle semantic patch.

> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
> index 00756ab78b4eb..bad102134726b 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential NULL pointer=20
dereference in the sun4i display driver initialization path.=20

In sun4i_crtc_init(), if plane creation fails, it returns NULL:

drivers/gpu/drm/sun4i/sun4i_crtc.c:sun4i_crtc_init() {
	planes =3D sunxi_engine_layers_init(drm, engine);
	if (IS_ERR(planes)) {
		dev_err(drm->dev, "Couldn't create the planes\n");
		return NULL;
	}
    ...
}

However, the caller in sun4i_tcon_bind() checks the return value using=20
IS_ERR():

drivers/gpu/drm/sun4i/sun4i_tcon.c:sun4i_tcon_bind() {
    ...
	tcon->crtc =3D sun4i_crtc_init(drm, engine, tcon);
	if (IS_ERR(tcon->crtc)) {
		dev_err(dev, "Couldn't create our CRTC\n");
    ...
}

Since IS_ERR(NULL) evaluates to false, the error is missed and execution
continues. This NULL pointer is later dereferenced in sun4i_rgb_init():

drivers/gpu/drm/sun4i/sun4i_rgb.c:sun4i_rgb_init() {
    ...
	/* The RGB encoder can only work with the TCON channel 0 */
	rgb->encoder.possible_crtcs =3D drm_crtc_mask(&tcon->crtc->crtc);
    ...
}

Should sun4i_crtc_init() return an ERR_PTR (like ERR_PTR(-ENOMEM)) instead
of NULL when plane creation fails, so that the caller's IS_ERR() check=20
catches it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D32
