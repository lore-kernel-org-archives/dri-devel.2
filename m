Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE32606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dM25Iaa4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DAF10F4EA;
	Tue, 24 Nov 2026 11:20:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CB910F4E2;
 Tue, 24 Nov 2026 11:20:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D365E623C5;
 Tue, 24 Nov 2026 11:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9D71F000D3;
 Tue, 24 Nov 2026 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795519199;
 bh=3IlYSWC1hVkK8jlUoOVsKhe0KqJX/Vyhfc8KdZrTq7s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dM25Iaa4l54EQFI1PzVyQZvI07v2GXsENmbmPM+RugaC8CfooMKRiOkzicVLhV84E
 0KKeOqI8NqsjtiVg3EKxTJZK27KhJRZ/DI3WgnhuVgcrudOjhVHjytZpU2fGI9NzhP
 buguWKva17hlWa/J8JzyH2Kxo0cEvG284UiwT5QUsKC8Ye6Wp3fYwxz1L1VGM5Fkfj
 a5e5EzJe+YljYhXe05iwIxmY68DsXx3stLu4++L76ypSsgqTnCzOLTfpLRKfURIUBW
 jH79HNOhEqfMtsWFCMblXW8ndkT22Gpm13y5gl/1IyA8hmz6r2DV1MGh24olIrcTxI
 W0weigv2ssH1w==
Message-ID: <sashiko-outbox-231037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] drm/i915: Implement plane atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261124-drm-i915-conversion-state-readout-v1-4-b7132f72644d@kernel.org>
References: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
 <20261124-drm-i915-conversion-state-readout-v1-4-b7132f72644d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 11:19:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/i915: UAF and VMA leak in drm_mode_config_reset() via
  atomic_create_state
--

commit 464346083e71e6c63fc65d310b5b8531a2b40785
Author: Maxime Ripard <mripard@kernel.org>

drm/i915: Implement plane atomic_create_state

This commit adds intel_plane_create_state() and wires it up to
.atomic_create_state on all i915/xe plane function tables.

> diff --git a/drivers/gpu/drm/i915/display/i9xx_plane.c b/drivers/gpu/drm/=
i915/display/i9xx_plane.c
> index 0902b17d02693..bfaa74a669d34 100644
> --- a/drivers/gpu/drm/i915/display/i9xx_plane.c
> +++ b/drivers/gpu/drm/i915/display/i9xx_plane.c
> @@ -884,6 +884,7 @@ static const struct drm_plane_funcs i965_plane_funcs =
=3D {
>  	.update_plane =3D drm_atomic_helper_update_plane,
>  	.disable_plane =3D drm_atomic_helper_disable_plane,
>  	.destroy =3D intel_plane_destroy,
> +	.atomic_create_state =3D intel_plane_create_state,
>  	.atomic_duplicate_state =3D intel_plane_duplicate_state,
>  	.atomic_destroy_state =3D intel_plane_destroy_state,
>  	.format_mod_supported =3D i965_plane_format_mod_supported,

[Severity: High]
Can populating .atomic_create_state cause a use-after-free and double free
of old_plane_state when drm_mode_config_reset() runs during D3cold resume?

drm_mode_config_reset() is also a caller of .atomic_create_state: when a
plane implements this hook, drm_mode_config_plane_reset_with_create_state()
destroys the existing plane->state via .atomic_destroy_state() and replaces
it with a newly allocated default state.

In xe, xe_display_disable_d3cold() calls drm_mode_config_reset() on runtime
PM resume from D3cold.  When an atomic commit runs while the device is in
D3cold, drm_atomic_get_plane_state() captures state->planes[i].old_state =3D
plane->state before intel_atomic_commit() wakes the device via
intel_display_rpm_get() -> xe_display_disable_d3cold() ->
drm_mode_config_reset().  That reset frees plane->state while it is still
referenced as old_plane_state, after which intel_atomic_prepare_commit()
and intel_atomic_swap_state() read and swap the freed old_plane_state and
queue it to be freed a second time.

Even outside an atomic commit, exiting D3cold while a plane holds a pinned
framebuffer on a DPMS-off CRTC destroys plane->state without calling
intel_cleanup_plane_fb(), triggering the ggtt_vma/dpt_vma warnings in
intel_plane_destroy_state(), leaking the pinned VMAs, and wiping the plane
software state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-drm-i915-c=
onversion-state-readout-v1-0-b7132f72644d@kernel.org?part=3D4
