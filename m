Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37209C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EBEB10F620;
	Fri, 14 Aug 2026 15:08:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VeLa+SAW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F73810F620
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:08:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A94D14027E
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1781F00A3A;
 Fri, 14 Aug 2026 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786720121;
 bh=mzL8+zdhhdhg5vT/j5JV/O216JPawonzVTpss29K3Qg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VeLa+SAWPnvvG1ggqZ4udTaEaId1vKLs7c2PEFUJHKNyCHzANHwXnzfdpx0+RGtD7
 bNnQ30eW7KPwoVCG4+AEL/w/tbvrhQyQHHJihJ1+QHJMUCJ+DMSPsCSGoupvBee52C
 lVlwEifiw76K2w3F+h7WMhjpZCCFLJldWCF+qTcEUQHrFRzVHVHupkAozWv/ZKKFpz
 Mpp354l+3/I8YboIdfQtiOdfF5BaOQSAgbkO+U6O/79Q7T2wFoRqX4VJWfpALfUqAi
 Ln3LPq43YWVvcrvtasP/rXUhqPETk6vRsGvDFiBT87n+8EM2Hgvl6t+a7Xf0+PekWI
 i7Axv7fFf7bRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/61] drm/fsl-dcu: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-15-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-15-82d2963dd134@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:08:40 +0000
Message-Id: <20260814150841.6C1781F00A3A@smtp.kernel.org>
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
- [High] Unconditional NULL pointer dereference in the error path of fsl_dc=
u_drm_primary_create_plane().
--

--- Patch [15]: [PATCH v2 15/61] drm/fsl-dcu: Convert to atomic_create_stat=
e ---
commit 29c8546f32e570013853685338e1cf8ea2d14508
Author: Maxime Ripard <mripard@kernel.org>

drm/fsl-dcu: Convert to atomic_create_state

The plane only initializes a pristine state in its reset hook
using drm_atomic_helper_plane_reset(), which is equivalent to what
atomic_create_state expects. Convert to it.

> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/dr=
m/fsl-dcu/fsl_dcu_drm_plane.c
> index b34f880c1e098..92794b337512c 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
> @@ -177,7 +177,7 @@ static const struct drm_plane_funcs fsl_dcu_drm_plane=
_funcs =3D {
>  	.atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
>  	.destroy =3D drm_plane_helper_destroy,
>  	.disable_plane =3D drm_atomic_helper_disable_plane,
> -	.reset =3D drm_atomic_helper_plane_reset,
> +	.atomic_create_state =3D drm_atomic_helper_plane_create_state,
>  	.update_plane =3D drm_atomic_helper_update_plane,
>  };

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the changes
in this file I noticed an unconditional NULL pointer dereference in the
error path of fsl_dcu_drm_primary_create_plane().

If drm_universal_plane_init() fails, it sets primary to NULL:

	if (ret) {
		kfree(primary);
		primary =3D NULL;
	}

And then drm_plane_helper_add() is called with the primary pointer, which
dereferences it unconditionally:

	drm_plane_helper_add(primary, &fsl_dcu_drm_plane_helper_funcs);

Could this cause a kernel crash if plane initialization fails during device
probe? Would it be better to return early if drm_universal_plane_init() fai=
ls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-no-mor=
e-plane-reset-v2-0-82d2963dd134@kernel.org?part=3D15
