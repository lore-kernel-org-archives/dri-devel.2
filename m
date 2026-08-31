Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFB7C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 957E010E1A0;
	Mon, 31 Aug 2026 22:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DAIx9Q/3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA8C010E1A0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 22:58:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EFC0D601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 22:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779DC1F000E9;
 Mon, 31 Aug 2026 22:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788217135;
 bh=TN+AjySWejZuT6KKSaAfH4juJOGwzz3fL1eJ5016p2k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DAIx9Q/30cBtHxQaRFsEnt3R7mY08akPuxiagii8xV7VVy9oAzLMscPAcJk/aRtka
 a2IG99CsWAeOHB3L+zNi49KuIb5GQu4m36ZstcNWHYP+mC6H6I4AmYNFcAdeoH6ate
 3oddLrXp1swlH08swxghm0saDnTW3uEs3Y4R8qiyBZ6M01AzpCPyapBGWWuBdL5sxq
 KxEvgd+kS0jnL1q5wNQs68FLEWZs4rGwoi6ROLOPBgREp1IM23OEsCUIEgSeu3JfXh
 cqW3K14+3iImU+uKsyEeDep5VW+pvuBcWdBf/WAA+BmE4PuNZDllCgHapFMO8YqjWO
 1UrGUX9WdIEGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 38/40] drm/vmwgfx: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-38-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
 <20260831-drm-no-more-plane-reset-v3-38-1877c7aa57b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:58:55 +0000
Message-Id: <20260831225855.779DC1F000E9@smtp.kernel.org>
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
- [High] Dangling pointer leading to Use-After-Free in vmw_du_connector_res=
et when kzalloc_obj fails.
--

commit 0910404d300f75561678f127f981fe7f17dcd288
Author: Maxime Ripard <mripard@kernel.org>

drm/vmwgfx: Convert to atomic_create_state

The plane reset implementation creates a custom state
subclass, but only initializes a pristine state without resetting any
hardware. This is equivalent to what atomic_create_state expects.
Convert to it.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index 0b470809661c7..9031dccad31d7 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -279,27 +279,24 @@ vmw_du_plane_duplicate_state(struct drm_plane *plan=
e)
> =20
> =20
>  /**
> - * vmw_du_plane_reset - creates a blank vmw plane state
> + * vmw_du_plane_create_state - creates a blank vmw plane state
>   * @plane: drm plane
>   *
> - * Resets the atomic state for @plane by freeing the state pointer (whic=
h might
> - * be NULL, e.g. at driver load time) and allocating a new empty state o=
bject.
> + * Allocates a new empty state object.
>   */
> -void vmw_du_plane_reset(struct drm_plane *plane)
> +struct drm_plane_state *vmw_du_plane_create_state(struct drm_plane *plan=
e)
>  {
>  	struct vmw_plane_state *vps;
> =20
> -	if (plane->state)
> -		vmw_du_plane_destroy_state(plane, plane->state);
> -
>  	vps =3D kzalloc_obj(*vps);
> -
>  	if (!vps) {
>  		DRM_ERROR("Cannot allocate vmw_plane_state\n");
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this change I
noticed a similar pre-existing issue remains in vmw_du_connector_reset().

When kzalloc_obj() fails during memory pressure (e.g., during device probe,
modeset, or hotplug handling), connector->state is left dangling as a point=
er
to the previously freed memory:

drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:vmw_du_connector_reset() {
	if (connector->state) {
		__drm_atomic_helper_connector_destroy_state(connector->state);
		kfree(vmw_connector_state_to_vcs(connector->state));
	}

	vcs =3D kzalloc_obj(*vcs);

	if (!vcs) {
		DRM_ERROR("Cannot allocate vmw_connector_state\n");
		return;
	}
	...
}

Does this leave connector->state pointing to freed memory, leading to a
use-after-free when the DRM core later accesses it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-plane-reset-v3-0-1877c7aa57b3@kernel.org?part=3D38
