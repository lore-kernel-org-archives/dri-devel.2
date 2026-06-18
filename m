Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2925CCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABF710F2CA;
	Thu, 18 Jun 2026 12:43:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MrVUIrm2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F70010F2CA
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:43:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F110543306;
 Thu, 18 Jun 2026 12:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E3F1F000E9;
 Thu, 18 Jun 2026 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781786627;
 bh=sVeaZIq1EulYcBkmHkY9GYRdde55n8N/AZOkReBBh6w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MrVUIrm2eD0cos4funSyTvHpP1L+aBDQ9m7ljZ9O5L0EhjviizycqOT1D3rHDn3QU
 vn6lCUsjruH3PP21Iw47N/mcck+ALTXkPVx0thnkZ6CC76O3nAN8oafJIeYtomnp+B
 LAXlqgUueo3dG1LSCkCrC8+sGUj0h9hMTebGaG2KoGwySQ9LkKtz9QMuvu+2FVycnB
 NtdZq5riGhrIFyCxMTRpAxMXnqWYZwFduTQdEQ5bTR+Z0aI4huZ/xP0xdTdGprQDAB
 JeciaNUYkr8pte1ut6HN7FNovRqIw+NbxiTc+1Z3bKgPGyS9YscikN7l6qSfRUu5B0
 LJBeQiknMmPgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] drm/hibmc: Use gem-shmem with shadow-plane
 helpers for memory management
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618123142.92298-7-tzimmermann@suse.de>
References: <20260618123142.92298-1-tzimmermann@suse.de>
 <20260618123142.92298-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 12:43:47 +0000
Message-Id: <20260618124347.B6E3F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Missing bounds check on framebuffer size and pitch allows an o=
ut-of-bounds write into the memory mapped VRAM.
- [High] Sleep in atomic context due to manual call of `drm_gem_fb_begin_cp=
u_access()` inside plane atomic update.
--

commit dadf851669fd23173dce5357fbb44cac3db06b77
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/hibmc: Use gem-shmem with shadow-plane helpers for memory management

Replace the gem-vram memory manager with gem-shmem. Makes the driver more
robust and enables dma-buf sharing with other hardware.

[ ... ]

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu=
/drm/hisilicon/hibmc/hibmc_drm_de.c
> index fe73b365e5474..b4ab53db1c087 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -100,22 +102,35 @@ static int hibmc_plane_atomic_check(struct drm_plan=
e *plane,
>  static void hibmc_plane_atomic_update(struct drm_plane *plane,
>  				      struct drm_atomic_commit *state)
>  {
> +	struct hibmc_drm_private *priv =3D to_hibmc_drm_private(plane->dev);
>  	struct drm_plane_state *new_state =3D drm_atomic_get_new_plane_state(st=
ate, plane);
> +	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(new_state);
>  	struct drm_framebuffer *fb =3D new_state->fb;
> +	struct drm_plane_state *old_state =3D drm_atomic_get_old_plane_state(st=
ate, plane);
> +	u32 gpu_addr =3D 0;
>  	u32 reg;
> -	s64 gpu_addr =3D 0;
>  	u32 line_l;
> -	struct hibmc_drm_private *priv =3D to_hibmc_drm_private(plane->dev);
> -	struct drm_gem_vram_object *gbo;
> =20
>  	if (!fb)
>  		return;
> =20
> -	gbo =3D drm_gem_vram_of_gem(fb->obj[0]);
> +	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE) =3D=3D 0) {

[Severity: High]
Is it safe to call drm_gem_fb_begin_cpu_access() here?

This function can sleep (for example, by acquiring dma_resv_lock for
imported dma-bufs), but hibmc_plane_atomic_update() runs in atomic context
where sleeping is forbidden.

Also, since the driver uses DRM_GEM_SHADOW_PLANE_HELPER_FUNCS which
automatically registers .begin_fb_access =3D drm_gem_begin_shadow_fb_access,
doesn't the DRM core already handle buffer mapping and synchronization
outside the atomic section?

> +		struct drm_rect damage;
> +		struct drm_atomic_helper_damage_iter iter;
> +
> +		drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
> +		drm_atomic_for_each_plane_damage(&iter, &damage) {
> +			struct iosys_map dst[DRM_FORMAT_MAX_PLANES] =3D {
> +				IOSYS_MAP_INIT_VADDR_IOMEM(priv->vram + gpu_addr),
> +			};
> =20
> -	gpu_addr =3D drm_gem_vram_offset(gbo);
> -	if (WARN_ON_ONCE(gpu_addr < 0))
> -		return; /* Bug: we didn't pin the BO to VRAM in prepare_fb. */
> +			iosys_map_incr(&dst[0],
> +				       drm_fb_clip_offset(fb->pitches[0], fb->format, &damage));
> +			drm_fb_memcpy(dst, fb->pitches, shadow_plane_state->data, fb, &damage=
);

[Severity: Critical]
Could this overflow the priv->vram I/O memory mapping?

With the transition from gem-vram to gem-shmem, the driver no longer
implicitly restricts the GEM object size to the physical VRAM size. If
userspace provides a framebuffer with a pitch that exceeds what fits in
priv->vram_size, it appears this drm_fb_memcpy() operation will write past
the end of priv->vram.

Should there be a bounds check on the pitch during the atomic check phase
or during framebuffer creation to ensure the memory footprint fits within
priv->vram_size?

> +		}
> +
> +		drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618123142.9229=
8-1-tzimmermann@suse.de?part=3D6
