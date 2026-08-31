Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB604C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B9C10EAD7;
	Mon, 31 Aug 2026 19:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oj2anrYo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0937110EAD7
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:47:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9217640176
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6541F000E9;
 Mon, 31 Aug 2026 19:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788205620;
 bh=7Nzrz12Dk312Vwut8KJhIVYBVv/rTDzLRKOO6R6+mhM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Oj2anrYorXLp8JJS0nQXpq1nS8LyzAdh5Ok6LCgtH/x57ybX6HezbfN+AbFpss8GY
 AitMKmSck/ADjfNaKqJ3Piw7SW06S/yqIHL06t2+scAeVPVSSz+6qSO6RVh/yiJxKO
 Q1w7dL2DZR+1e4l8k75TqXeSvs/JyAEkxR1orpVT1L7LLVPme9TvJPfnIJB8wH7Whl
 k0bzN3XlkZaPhZEu8s548KuzeFig77fZK9/kB9xbzlq4NnOpCwJOCrBGjUvBtBahnG
 Xk7k6ZX+syLmhKFLPp9loY3WI12DCNbVfgGFiwARS/u7ZkIHyt+ov2ACl33fHqKGvq
 ppBiJhw6nunYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] drm/tilcdc: Switch to
 drm_atomic_helper_crtc_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-5-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-5-4500d49a337f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:46:59 +0000
Message-Id: <20260831194700.4B6541F000E9@smtp.kernel.org>
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
- [High] Unconditional dereference of potentially NULL crtc->helper_private=
 pointer when checking for the hw_reset hook.
--

commit 64d66423bd9e9cda8a92c70fb8fec4016d121ea0
Author: Maxime Ripard <mripard@kernel.org>

drm/tilcdc: Switch to drm_atomic_helper_crtc_create_state

The tilcdc crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcd=
c/tilcdc_crtc.c
> index b299d73ce3856..f619b7a6e70d9 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -714,7 +714,7 @@ static void tilcdc_crtc_hw_reset(struct drm_crtc *crt=
c)
>  static const struct drm_crtc_funcs tilcdc_crtc_funcs =3D {
>  	.set_config     =3D drm_atomic_helper_set_config,
>  	.page_flip      =3D drm_atomic_helper_page_flip,
> -	.reset		=3D drm_atomic_helper_crtc_reset,
> +	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,

[Severity: High]
Does this change expose a NULL pointer dereference in the core DRM API?

By switching to .atomic_create_state, drm_mode_config_reset() will now call
drm_mode_config_crtc_reset_with_create_state() during driver probe or
system resume.

Looking at drm_mode_config_crtc_reset_with_create_state() in
drivers/gpu/drm/drm_mode_config.c:

drm_mode_config_crtc_reset_with_create_state() {
	const struct drm_crtc_helper_funcs *crtc_funcs =3D crtc->helper_private;
	...
	if (crtc_funcs->hw_reset)
		crtc_funcs->hw_reset(crtc);

	return 0;
}

The crtc_funcs pointer is dereferenced here without a preceding NULL guard.=
=20
If a driver does not use CRTC helpers, crtc->helper_private will be NULL.=20
Wouldn't this unconditional dereference to check for hw_reset lead to a=20
crash for any driver leaving helper_private unpopulated?

>  	.atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,
>  	.enable_vblank	=3D tilcdc_crtc_enable_vblank,
>  	.disable_vblank	=3D tilcdc_crtc_disable_vblank,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-crtc-reset-v2-0-4500d49a337f@kernel.org?part=3D5
