Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9F0C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A672E10F65C;
	Fri, 14 Aug 2026 15:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z1wOokNH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007EE10F65C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:13:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C56AB40421
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D57B1F000E9;
 Fri, 14 Aug 2026 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786720414;
 bh=INeoPs+kk3b7cY18SDqwiznql82/B5amIK4WbyCLSgc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z1wOokNHONYqWwxxMmv58Z34FkkPg1MRxI7UwPWiBDCookiKhLfe0W41dOuARrJS1
 lOzLFv3ZGYxJuKX+VPw7zo88q/K2Vjn79hAnxV8fE7VYFfyMhLesyZYrkn2wSSB2tj
 ehcYaH5XZWcbPuzsqmKubKScroQ2/YhNMemmjxhxFLS17lzboHu8XxeTIuMzwF7an8
 O85q/Osl4y3bASFTmOpKoLo/1h85DDV3PjR7yTwjtrjFGtUh2gZomtyxP7Cs6MH1K4
 yFxaG+diC1FDG4NxCKtgqxsC0XIMplMFOcaND/3+JJdMESlVfLhyCvN99DBA1vOgAt
 DeFdgevmwPBHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/61] drm/simple-kms: Add create_plane_state hook
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-1-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-1-82d2963dd134@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:13:34 +0000
Message-Id: <20260814151334.7D57B1F000E9@smtp.kernel.org>
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
- [Medium] The patch introduces the `atomic_create_state` pattern for simpl=
e-kms but fails to populate the `.atomic_create_state` hooks in the core DR=
M vtables, rendering the new pattern unusable.
--

--- Patch [1]: [PATCH v2 01/61] drm/simple-kms: Add create_plane_state hook=
 ---
commit 3bbdad5049ec3ee53628f35efd9dd90d236402b0
Author: Maxime Ripard <mripard@kernel.org>

drm/simple-kms: Add create_plane_state hook

The simple-kms helper provides a reset_plane hook to let drivers override
the default plane reset, but the hook is overloaded for multiple roles.
The atomic_create_state pattern was introduced to untangle this by providing
a hook that only allocates and initializes a pristine state. This patch adds
a create_plane_state hook to struct drm_simple_display_pipe_funcs.

> diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple=
_kms_helper.h
> index cb672ce0e856d..b58f6d5328201 100644
> --- a/include/drm/drm_simple_kms_helper.h
> +++ b/include/drm/drm_simple_kms_helper.h
> @@ -44,6 +44,7 @@ struct drm_simple_display_pipe_funcs {
>  	void (*destroy_crtc_state)(struct drm_simple_display_pipe *pipe,
>  				   struct drm_crtc_state *crtc_state);
>  	void (*reset_plane)(struct drm_simple_display_pipe *pipe);
> +	struct drm_plane_state * (*create_plane_state)(struct drm_simple_displa=
y_pipe *pipe);

[Severity: Medium]
As the atomic_create_state pattern is being introduced here for simple-kms,
should drm_simple_kms_plane_funcs also have its .atomic_create_state hook
populated?

If a driver converts to this new pattern and uses
drm_mode_config_create_initial_state(), it looks like it will see a NULL
hook in the core DRM vtables and skip creating the plane state:

static const struct drm_plane_funcs drm_simple_kms_plane_funcs =3D {
	.update_plane		=3D drm_atomic_helper_update_plane,
	.disable_plane		=3D drm_atomic_helper_disable_plane,
	.destroy		=3D drm_plane_cleanup,
	.reset			=3D drm_simple_kms_plane_reset,
	.atomic_duplicate_state	=3D drm_simple_kms_plane_duplicate_state,
	.atomic_destroy_state	=3D drm_simple_kms_plane_destroy_state,
	.format_mod_supported   =3D drm_simple_kms_format_mod_supported,
};

This would leave plane->state =3D NULL.

Similarly, is a .atomic_create_state hook also missing for
drm_simple_kms_crtc_funcs (along with a corresponding create_crtc_state hook
in drm_simple_display_pipe_funcs) to ensure the CRTC state is also properly
initialized?

>  	struct drm_plane_state * (*duplicate_plane_state)(struct drm_simple_dis=
play_pipe *pipe);
>  	void (*destroy_plane_state)(struct drm_simple_display_pipe *pipe,
>  				    struct drm_plane_state *plane_state);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-no-mor=
e-plane-reset-v2-0-82d2963dd134@kernel.org?part=3D1
