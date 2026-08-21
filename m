Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061ACC5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB8710F2E4;
	Fri, 21 Aug 2026 15:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JFotEomp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D0010F2E4
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:28:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8801241825
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4066A1F000E9;
 Fri, 21 Aug 2026 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787326106;
 bh=Q9tYvrelnAjEV9jEEzFeQPt87XaOUr9WQGgVts27G6k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JFotEomp/DYNm9YwiNEJDmFtBknEVc6v6h4dhJ2kyR/vCRoNST+SMDcA9V/cnrkfX
 bAbwhqU5fi/EmOevIkm5K8b6Gt8p8BeWxBfwzyHtXCI5VJD0FXqypSPNGzBpPtSE8+
 UVOzBMtE7z2IrYg07Ly5KRlyXamOJuoV4eA3BIY4x7Ry9XTcvYELH1M8BoTd4KRIJx
 GWtHChMabVsL2kVCpKybibYFuGKssyBmLOgc9GtgjRmaXTkLAhZoxAszUtYtl7U5D3
 VK2Ea7jRsWEssxX/Nkz5D8e4lQKbkN1OSN8hgw+6azQnz45jg33lTi5TtF4vTC6fWu
 4Jh8mkFXJfpoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 44/70] drm/amdgpu: dm: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-44-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-44-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:28:25 +0000
Message-Id: <20260821152826.4066A1F000E9@smtp.kernel.org>
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
- [High] The return value of `atomic_create_state()` is completely discarde=
d during CRTC initialization, causing a memory leak and leaving `crtc->stat=
e` uninitialized (NULL).
--

--- Patch [44]: [PATCH 44/70] drm/amdgpu: dm: Convert to atomic_create_stat=
e ---
commit 680651b77d5bb2911f7b94020aa95ffc0ffde185
Author: Maxime Ripard <mripard@kernel.org>

drm/amdgpu: dm: Convert to atomic_create_state

The amdgpu display manager crtc implementation provides a custom reset hook.
This converts the implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

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

[Severity: High]
Does this drop the newly allocated state and leave acrtc->base.state
uninitialized (NULL)?

Previously, amdgpu_dm_crtc_reset_state() called
__drm_atomic_helper_crtc_reset(), which internally assigns the newly
allocated state to the crtc:

void __drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
                                    struct drm_crtc_state *crtc_state)
{
        if (crtc_state)
                __drm_atomic_helper_crtc_state_init(crtc_state, crtc);

        crtc->state =3D crtc_state;
}

With the new conversion, amdgpu_dm_crtc_create_state() allocates and returns
the state pointer:

static struct drm_crtc_state *amdgpu_dm_crtc_create_state(struct drm_crtc *=
crtc)
{
        struct dm_crtc_state *state;

        state =3D kzalloc_obj(*state);
        if (!state)
                return ERR_PTR(-ENOMEM);

        __drm_atomic_helper_crtc_state_init(&state->base, crtc);

        return &state->base;
}

However, amdgpu_dm_crtc_init() ignores the return value of
atomic_create_state() and does not assign it to the crtc.

Could this result in a memory leak of the returned dm_crtc_state object, as
well as a regression due to NULL pointer dereferences when crtc->state is
accessed later during driver initialization?

> =20
>  	acrtc->max_cursor_width =3D dm->adev->dm.dc->caps.max_cursor_size;
>  	acrtc->max_cursor_height =3D dm->adev->dm.dc->caps.max_cursor_size;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D44
