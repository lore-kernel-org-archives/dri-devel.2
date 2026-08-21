Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46B9C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1743589109;
	Fri, 21 Aug 2026 15:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eNTcTHL5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A5289109
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:12:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C425410CD
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC081F00A3A;
 Fri, 21 Aug 2026 15:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787325154;
 bh=1qIxlelW6GO+clJiEDLuqs9LPoIB2mcTKDcKb+OyS4o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eNTcTHL5efd6jeBoOfPzRhCis+4/PyHckd4gpT1ezH46nG9GYPP+yUvGMbdgzlm5P
 ya8Qb5tV8FFzHn9DUSX3jIhI/a27hpHaumYZy0khfSiDAoAFAB8mwbNuHaN3LkZTCR
 qikWmW5GLA8aCMJ4pZ+k/UTHEJIfiynYBgwTnLFepr5x3ZiQo8lLjmsj35b3o/PAzT
 2wt44r5gXe1gMFndrdB/IH49Vcc2x9Zw7z86CYCTGiab71YNpuht/BfzD2ZzoREoDm
 8wac4131sZ61JJcjF8blvSUMUmwXE5fU3X7/CbuxTNVm74V21BhZtI4npCMe6kwsTB
 UMN2ltbrfbwng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/70] drm/mxs: mxsfb: Switch to
 drm_atomic_helper_crtc_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-18-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-18-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:12:33 +0000
Message-Id: <20260821151234.0FC081F00A3A@smtp.kernel.org>
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
- [High] Use-After-Free in DRM cleanup paths on driver unbind due to devm_k=
zalloc allocated driver private data.
--

--- Patch [18]: [PATCH 18/70] drm/mxs: mxsfb: Switch to drm_atomic_helper_c=
rtc_create_state ---
commit 176787b6391787b0d414456f33f183b472ea7c41
Author: Maxime Ripard <mripard@kernel.org>

drm/mxs: mxsfb: Switch to drm_atomic_helper_crtc_create_state

This commit replaces the deprecated drm_atomic_helper_crtc_reset() hook
with drm_atomic_helper_crtc_create_state() for the mxsfb CRTC implementatio=
n.

> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mx=
sfb_kms.c
> index d8ebebc5314bb..36ea285182b48 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -484,7 +484,7 @@ static const struct drm_crtc_helper_funcs mxsfb_crtc_=
helper_funcs =3D {
>  };
> =20
>  static const struct drm_crtc_funcs mxsfb_crtc_funcs =3D {
> -	.reset =3D drm_atomic_helper_crtc_reset,
> +	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,
>  	.destroy =3D drm_crtc_cleanup,
>  	.set_config =3D drm_atomic_helper_set_config,
>  	.page_flip =3D drm_atomic_helper_page_flip,

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the mxsfb
driver, I noticed a potential use-after-free during driver unbind.

The driver private structure is allocated with devm_kzalloc() in mxsfb_load=
()
in drivers/gpu/drm/mxsfb/mxsfb_drv.c:

    mxsfb =3D devm_kzalloc(&pdev->dev, sizeof(*mxsfb), GFP_KERNEL);

And the DRM device is allocated independently via drm_dev_alloc() in
mxsfb_probe():

    drm =3D drm_dev_alloc(&mxsfb_driver, &pdev->dev);

During driver unbind, mxsfb_remove() calls drm_dev_put(drm). If user space
currently holds an open file descriptor for the DRM device, the DRM device's
refcount is > 0 and it will not be freed immediately.

When mxsfb_remove() returns, devres cleanup will free the mxsfb_drm_private
structure. Later, when user space closes the file descriptor,
drm_dev_release() will trigger drmm_mode_config_cleanup().=20

Since drmm_mode_config_cleanup() will access CRTCs and planes embedded
within the already-freed mxsfb_drm_private structure, could this result in
a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D18
