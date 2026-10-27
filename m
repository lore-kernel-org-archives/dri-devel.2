Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60D606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzNrfIpc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0362210F848;
	Tue, 27 Oct 2026 21:39:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8C910F848
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 21:39:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B61E260236;
 Tue, 27 Oct 2026 21:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5087A1F01828;
 Tue, 27 Oct 2026 21:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793137185;
 bh=ntqipPOVe008veNzuoJJjYdZ7SJGWmzzYLn8+D6BzNE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=nzNrfIpciD8dw1ECzp+Nwr55tC0FE+1WTPv10qYJq4HS3ZiAu2DRsff9T9u+BCTMZ
 oeUWyiysl1XPZqJRD3KHB1PnHjaqU29HjUj1ogJVsbk2/XsZoorLojXjUmAW4Lm8ri
 JpbmZ7j7EaQggIYTGv1KWYn068xwGWn5klG/GP2VmlREnJZd5sGpKD4VWb08eNAxB5
 +ZNm+TvxFJH7F3Sf/+dbBeU3jf68IthNx0iw50fRe7iq/vi3ogrK7rsOH8naPy5Xcn
 CJF0vi+1QD8BlifYlTYekNyYrWgDpZyJEbTNvA6COnTWH6fIBmzA4OP2Q0qk1KOmMq
 7xwRYL5QgcBwg==
Message-ID: <sashiko-outbox-187133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] drm/vmwgfx: validate the framebuffer selected for
 cursor updates
To: "Zack Rusin" <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261027211729.646988-6-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-6-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 21:39:44 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/vmwgfx: cursor atomic_check accepts VMW_CURSOR_UPDATE_NONE f=
ramebuffers
--

commit 9cca2550f2f0603a47b5047da765ad6aeb14d8cc
Author: Zack Rusin <zack.rusin@broadcom.com>

drm/vmwgfx: validate the framebuffer selected for cursor updates

This commit resolves the user object directly from the selected framebuffer
during cursor plane validation and preparation rather than relying on the
duplicated plane state's previous user object. It also adds checks to reject
zero cursor dimensions and require a backing buffer object for GB-only and
MOB cursor updates.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/d=
rm/vmwgfx/vmwgfx_cursor_plane.c
> index f0661e5effeb1..9e8ea9e07f40f 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c

[ ... ]

> @@ -763,7 +775,21 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *=
plane,
>  	if (!fb)
>  		return 0;
> =20
> -	update_type =3D vmw_cursor_update_type(vmw, vps);
> +	if (!new_state->crtc_w || !new_state->crtc_h) {
> +		drm_dbg_kms(&vmw->drm,
> +			    "Cursor dimensions (%u, %u) must be nonzero\n",
> +			    new_state->crtc_w, new_state->crtc_h);
> +		return -EINVAL;
> +	}
> +
> +	/* The duplicated plane state's user object still belongs to the old FB=
. */
> +	uo =3D vmw_cursor_plane_user_object(fb);
> +	update_type =3D vmw_cursor_update_type(vmw, &uo);
> +	if ((update_type =3D=3D VMW_CURSOR_UPDATE_GB_ONLY ||
> +	     update_type =3D=3D VMW_CURSOR_UPDATE_MOB) &&
> +	    !vmw_user_object_buffer(&uo))
> +		return -EINVAL;
> +
>  	if (update_type =3D=3D VMW_CURSOR_UPDATE_LEGACY) {
>  		if (new_state->crtc_w !=3D VMW_CURSOR_SNOOP_WIDTH ||
>  		    new_state->crtc_h !=3D VMW_CURSOR_SNOOP_HEIGHT) {
> @@ -772,7 +798,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *p=
lane,
>  				 new_state->crtc_w, new_state->crtc_h);
>  			return -EINVAL;
>  		}
> -		surface =3D vmw_user_object_surface(&vps->uo);
> +		surface =3D vmw_user_object_surface(&uo);
>  		if (!surface || !surface->snooper.image) {
>  			drm_warn(&vmw->drm,
>  				 "surface not suitable for cursor\n");

[Severity: Medium]
Can this check for !surface || !surface->snooper.image ever be reached, and
what happens when update_type is VMW_CURSOR_UPDATE_NONE?

Looking at vmw_cursor_update_type(), it only returns VMW_CURSOR_UPDATE_LEGA=
CY
when surface && surface->snooper.image is already true. If vmw->has_mob is
false and the new framebuffer does not have a snooper image (for example, a
BO-backed dumb framebuffer or an atomic client surface where
surface->snooper.image is NULL), vmw_cursor_update_type() returns
VMW_CURSOR_UPDATE_NONE:

drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c:vmw_cursor_update_type() {
	struct vmw_surface *surface =3D vmw_user_object_surface(uo);

	if (surface && surface->snooper.image)
		return VMW_CURSOR_UPDATE_LEGACY;

	if (vmw->has_mob) {
		if ((vmw->capabilities2 & SVGA_CAP2_CURSOR_MOB) !=3D 0)
			return VMW_CURSOR_UPDATE_MOB;
		else
			return VMW_CURSOR_UPDATE_GB_ONLY;
	}
	drm_warn_once(&vmw->drm, "Unknown Cursor Type!\n");
	return VMW_CURSOR_UPDATE_NONE;
}

When vmw_cursor_update_type() returns VMW_CURSOR_UPDATE_NONE,
vmw_cursor_plane_atomic_check() skips the VMW_CURSOR_UPDATE_LEGACY,
VMW_CURSOR_UPDATE_GB_ONLY, and VMW_CURSOR_UPDATE_MOB branches and returns 0
at the end of the function.

Should vmw_cursor_plane_atomic_check() reject VMW_CURSOR_UPDATE_NONE with
-EINVAL so that non-snooped framebuffers on non-MOB devices are not accepte=
d?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027211729.6469=
88-1-zack.rusin@broadcom.com?part=3D5
