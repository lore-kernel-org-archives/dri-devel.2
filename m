Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28853C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 00:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4468110E0C4;
	Fri, 14 Aug 2026 00:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FyuoLxxd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCDAA10E0B1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 00:51:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CE2943A09
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 00:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364221F000E9;
 Fri, 14 Aug 2026 00:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786668711;
 bh=JsqqL/deUkNJ2+ZXVRiFsjuN8xS1rdte+9bC2Tqgjmw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FyuoLxxdXet8TuWIFsziIohe2SQJuMumSo99rPhHGJFm3Lolt65pwvOtodIEN3OzY
 QpJbKbY3d007WbjPsKlw9SlqrHqbV6FJAJt3DtuiRwx46dYZDxHc6Ks1/FEXxNnrcO
 +bqKJzD/ryhW6pzW88BBK81MG2x+q/HeI5Gchi837PHhXgNLDMZc9jXof2Raj/q2Ly
 uFBHd8g2wAtooMX98m8pDXlo9LpT9kixUcHW0qg+Ds3oTauyoHt5OkgVqMl2dMxUvQ
 SNgLwZX5d8OphDE/01bV8TMsux73T75yYx6IXpeKtelcCtxLR3lGMtLEzE2t1KIy7a
 Nk88tp2g5yhJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 49/78] drm/mediatek: dp: Switch to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-49-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-49-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:51:45 +0000
Message-Id: <20260814005151.364221F000E9@smtp.kernel.org>
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
- [High] Modifying persistent driver state in atomic_check callback.
--

--- Patch [49]: [PATCH v2 49/78] drm/mediatek: dp: Switch to atomic_create_=
state ---
commit b93fba0abd0877816145c393b463fd7e217d61b5
Author: Maxime Ripard <mripard@kernel.org>

drm/mediatek: dp: Switch to atomic_create_state

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.
Switch to the atomic_create_state callback and its counterpart.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index eefbc7e0f9c8d..f656b85b84212 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -2578,7 +2578,7 @@ static const struct drm_bridge_funcs mtk_dp_bridge_=
funcs =3D {
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
>  	.atomic_get_output_bus_fmts =3D mtk_dp_bridge_atomic_get_output_bus_fmt=
s,
>  	.atomic_get_input_bus_fmts =3D mtk_dp_bridge_atomic_get_input_bus_fmts,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,

[Severity: High]
This isn't a bug introduced by this patch, but reviewing changes to the
bridge functions struct prompted a check of the other callbacks.

Is it safe for mtk_dp_bridge_atomic_check() to modify the persistent
mtk_dp->info state directly?

mtk_dp_bridge_atomic_check() {
    ...
    mtk_dp->info.format =3D DP_PIXELFORMAT_YUV422;
    ...
    drm_display_mode_to_videomode(&crtc_state->adjusted_mode, &mtk_dp->info=
.vm);
    ...
}

If a userspace compositor issues a test-only commit with a different
display mode, atomic_check runs and mutates this persistent state. If
the system then suspends and resumes, drm_atomic_helper_resume
directly commits the saved pre-suspend state without re-running
atomic_check.

Could this cause the bridge's atomic_enable callback to program the
hardware using the poisoned mtk_dp->info parameters from the aborted
test commit instead of the actual restored state?

>  	.attach =3D mtk_dp_bridge_attach,
>  	.detach =3D mtk_dp_bridge_detach,
>  	.atomic_enable =3D mtk_dp_bridge_atomic_enable,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D49
