Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41E2C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6DD510F328;
	Fri, 21 Aug 2026 15:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i9cKFOlT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9988710F328
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:45:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 683E243F9A
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0601F000E9;
 Fri, 21 Aug 2026 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787327147;
 bh=Q6EUADJpc35o79cg7KK6VyrspF7oFLHNY1LWYm4xl4Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i9cKFOlTA3laF3UHIGKoIf0trRlvKGyImEqxFSiNQ9PyiWw4BVYyOnPAis0frNIwV
 ZBtKb+yOIe298a1cCPwXEb945KYdsNIy24Y1hv3YZpI806a1ZLthggX666wNyt973z
 QUKT2EUN2APr5t5TeGIGYAy9AySZ6EGlpYSdZnvqkATYWsy3+IL9x88qQZYLWBvhyT
 3Kock4OQ4oMfSuBd5WmhnVMLqAru4h/JEjZIMglxrFFUliD2ZlVot5fsz3xgxa/AMB
 +br6L4WLg8clFk43dKSxVkayztQRDbtxZVQrHTr3rvgYgsTrqHThr0J6fpy2KW6D3z
 QBDwNMGDLLRCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 69/70] drm/atomic-helper: Remove
 __drm_atomic_helper_crtc_reset
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-69-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-69-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:45:46 +0000
Message-Id: <20260821154547.2C0601F000E9@smtp.kernel.org>
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
- [Medium] Memory leak and unassigned CRTC state due to ignored return valu=
e from `atomic_create_state`.
--

--- Patch [69]: [PATCH 69/70] drm/atomic-helper: Remove __drm_atomic_helper=
_crtc_reset ---
commit 9dc0ccd39531b9bf90d43caf9838f04ca43ed26d
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset

This patch series converts users of __drm_atomic_helper_crtc_reset() to use
drm_atomic_helper_crtc_state_init() and atomic_create_state(). It then
removes the now unused __drm_atomic_helper_crtc_reset() helper entirely.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index d63688b9d93dd..e1cc74ba7a434 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c

[ ... ]

> @@ -757,9 +756,9 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager=
 *dm,
> =20
>  	drm_crtc_helper_add(&acrtc->base, &amdgpu_dm_crtc_helper_funcs);
> =20
> -	/* Create (reset) the plane state */
> -	if (acrtc->base.funcs->reset)
> -		acrtc->base.funcs->reset(&acrtc->base);
> +	/* Create the plane state */
> +	if (acrtc->base.funcs->atomic_create_state)
> +		acrtc->base.funcs->atomic_create_state(&acrtc->base);

[Severity: Medium]
Does this code leak the newly allocated state?

The old .reset() hook called __drm_atomic_helper_crtc_reset(), which intern=
ally
assigned crtc->state. The new .atomic_create_state() hook returns the alloc=
ated
state pointer, but the return value is ignored here.

Could this leave acrtc->base.state unassigned and leak the allocated
struct dm_crtc_state during driver initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D69
