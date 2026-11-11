Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CF606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCU6c0Ug
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF57710E35F;
	Wed, 11 Nov 2026 06:14:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0188410E39A
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:14:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D251414E1;
 Wed, 11 Nov 2026 06:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDED1F00A05;
 Wed, 11 Nov 2026 06:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794377650;
 bh=7l98wBRsNl/j44YWc8X9SzvCW4SEEOFrYYyvduEdD3Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mCU6c0UgXNoMrUlQHRHGkDwstHP6xRCp43aazbkLWrr1rUaLOx0GwC5F4RycnN5ok
 zZ7/dEkx/x+yVCcyAUA5Rc5y2Zbtl6+Iedzp9iAS7TLyiyToZR4/NbovbuAcFz/t3g
 mgEypxoiFiVb5u75UmgaRWuvk2B5WuDRcYEL/FAwlG9W1sv4FAA0seaOGBN/9ogHAi
 qdEdbFRsKc7kUb45LrkeML5T4QhbvdIRerkktYTEHdj/ORj3LxC4yPFHCA0+cN+s73
 PjpOnIr8vO+qhkadnmodGnycvlGnkmH7IWHn470gD21vnJLz0Yzbutqo89ZpXmPQbB
 OZhFzpLBivhYg==
Message-ID: <sashiko-outbox-208400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/disp: Set
 drm_mode_config_funcs.atomic_(check|commit) (attempt 2)
To: "Dave Airlie" <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261111-nouveau-atomic-fix-v1-1-118e65d3a2f5@redhat.com>
References: <20261111-nouveau-atomic-fix-v1-1-118e65d3a2f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:14:09 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/nouveau/disp: missing closing quote in Fixes: trailer
  subject
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/nouveau: wrong dtor order and disp leak in
  nouveau_display_create() [1]
--

commit cf4b32d591c8a8a0033562aad54661c60e5b35bf
Author: Dave Airlie <airlied@redhat.com>

> drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit) (attemp=
t 2)
>=20
> commit 604826acb3f5 attempted to add these flags but
> commit 6c65db809796 reverted it due to it
> failing on hw from pre-atomic times.
>=20
> So use a second set of functions.
>=20
> original commit msg from Lyude:
> "Apparently we never actually filled these in, despite the fact that we do
> in fact technically support atomic modesetting.
>=20
> Since not having these filled in causes us to potentially forget to disab=
le
> fbdev and friends during suspend/resume, let's fix it."
>=20
> Reported-by: Ruben Wauters <rubenru09@aol.com>
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/517
> Fixes: 6c65db809796 ("Revert "drm/nouveau/disp: Set drm_mode_config_funcs=
.atomic_(check|commit)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dave Airlie <airlied@redhat.com>

[Severity: Low]
The Fixes: trailer is missing the closing quote from the reverted commit's
subject:

  Fixes: 6c65db809796 ("Revert "drm/nouveau/disp: Set drm_mode_config_funcs=
.atomic_(check|commit)"")

> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/=
nouveau/nouveau_display.c
> index d71dcfc6ee66b..07882624a7f6f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
[ ... ]
> @@ -654,7 +659,11 @@ nouveau_display_create(struct drm_device *dev)
>  	drm_mode_create_scaling_mode_property(dev);
>  	drm_mode_create_dvi_i_properties(dev);
> =20
> -	dev->mode_config.funcs =3D &nouveau_mode_config_funcs;
> +	/* this only gets set if the driver has the ATOMIC flag */
> +	if (drm_drv_uses_atomic_modeset(dev))
> +		dev->mode_config.funcs =3D &nouveau_mode_config_funcs_atomic;
> +	else
> +		dev->mode_config.funcs =3D &nouveau_mode_config_funcs;
> =20
>  	dev->mode_config.min_width =3D 0;
>  	dev->mode_config.min_height =3D 0;

[Severity: High]
This problem wasn't introduced by this patch, but can the error unwind paths
in nouveau_display_create() cause a NULL pointer dereference and leak
disp [1]?

drivers/gpu/drm/nouveau/nouveau_display.c:nouveau_display_create() {
	...
vblank_err:
	disp->dtor(dev);
disp_create_err:
	drm_kms_helper_poll_fini(dev);
	drm_mode_config_cleanup(dev);
	return ret;
}

When drm_vblank_init() fails, vblank_err calls disp->dtor(dev) before
drm_mode_config_cleanup(dev), which is the opposite of the order in
nouveau_display_destroy().  On pre-NV50 hardware, nv04_display_destroy()
clears nouveau_display(dev)->priv to NULL and frees struct nv04_display; wh=
en
drm_mode_config_cleanup() then runs nv_crtc_destroy(), nv04_display(crtc->d=
ev)
returns NULL and dereferencing disp->image[nv_crtc->index] crashes.

In addition, neither error path calls nvif_disp_dtor(&disp->disp) or
kfree(disp), and nouveau_drm_device_init() skips nouveau_display_destroy() =
on
failure, leaking both objects and leaving drm->display dangling.

[1] https://sashiko.dev/#/bug/linux-dd1d9372-c030-413b-9ce8-94b2029fab64

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-nouveau-at=
omic-fix-v1-1-118e65d3a2f5@redhat.com?part=3D1
