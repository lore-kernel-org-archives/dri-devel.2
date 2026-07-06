Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503EEC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADAB410E2E4;
	Mon,  6 Jul 2026 05:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U9vfvXKd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4155610E2E4
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:50:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68AD4600FC;
 Mon,  6 Jul 2026 05:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9EB1F00A3A;
 Mon,  6 Jul 2026 05:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783317053;
 bh=IGOKU0JJLC+2TYI4zCR9KWh508rWcTM1rdUgsfkS7tg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U9vfvXKdBaaJs106GVMC1IACxVEoRINjy+FnkU1QtTb/5yKy0PDjwjLn/tNH5cCIq
 CkysPLtG0oQ2NTEp8Za3qfEpgRFmy/wj31GahVc5smlXmV8TgEJjAI3ZbYRFfksAtH
 1LVXqn2gIZBSIrImtoAdNm4TbGJoJod8WNiJJabojC57Ww6frgWl2SRgRf3ntXTsPU
 eL5Fdg1KK1DQm1pR7rxPBe4TNiOwvgkh1twlUiujMjbREtt6FirpE74I27jm1E/nM2
 WbFxoZmdidHgw8cdS8NmFrC6+ghfk05+f3dWTS4o0U7Dge9fl7jITUoPamZQnFU2tr
 DiE8wmySr0JoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] xe: create a flag to enable memcg accounting for
 XE as well.
To: "Dave Airlie" <airlied@gmail.com>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260706052330.1110909-11-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <20260706052330.1110909-11-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:50:52 +0000
Message-Id: <20260706055052.CF9EB1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Dumb buffer allocations bypass memory cgroup accounting.
- [High] Internal userspace-triggered buffer allocations (seqno_bo and cgp_=
bo) bypass memory cgroup accounting.
- [High] Page tables dynamically allocated in asynchronous contexts bypass =
memory cgroup accounting.
--

commit d0632a50e763992c9a7f84d8a817feb26c078e3a
Author: Maarten Lankhorst <dev@lankhorst.se>
Date:   Mon Jul 6 05:22:39 2026 +0000

    xe: create a flag to enable memcg accounting for XE as well.
   =20
    This adds support for memcg accounting to ttm object used by xe driver.
   =20
    Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
    Signed-off-by: Dave Airlie <airlied@redhat.com>

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 62f1da04ca2b1..e016f0314d861 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -2384,6 +2385,9 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *x=
e, struct xe_bo *bo,
>  	placement =3D (type =3D=3D ttm_bo_type_sg ||
>  		     bo->flags & XE_BO_FLAG_DEFER_BACKING) ? &sys_placement :
>  		&bo->placement;
> +
> +	if (bo->flags & XE_BO_FLAG_ACCOUNTED)
> +		ttm_bo_set_cgroup(&bo->ttm, get_obj_cgroup_from_current());

[Severity: High]
Will get_obj_cgroup_from_current() correctly account memory when page tables
are allocated dynamically?

Page tables are sometimes created asynchronously in worker threads, such as
during SVM page fault handling or preempt rebinds via xe_pt_create(). In th=
ese
cases, "current" refers to the kworker thread rather than the user process.

Since set_active_memcg() isn't used to restore the original user's memcg
context in the worker, will get_obj_cgroup_from_current() evaluate against
the worker's cgroup and bypass the user's memcg limits?

>  	err =3D ttm_bo_init_reserved(&xe->ttm, &bo->ttm, type,
>  				   placement, alignment,
>  				   &ctx, NULL, resv, xe_ttm_bo_destroy);

[ ... ]

> @@ -3361,7 +3365,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, voi=
d *data,
>  	if (XE_IOCTL_DBG(xe, args->size & ~PAGE_MASK))
>  		return -EINVAL;
> =20
> -	bo_flags =3D 0;
> +	bo_flags =3D XE_BO_FLAG_ACCOUNTED;

[Severity: High]
Does xe_bo_dumb_create() also need to set this flag?

When userspace calls DRM_IOCTL_MODE_CREATE_DUMB, it is handled by
xe_bo_dumb_create(), which calls xe_bo_create_user():

	bo =3D xe_bo_create_user(xe, NULL, args->size,
			       DRM_XE_GEM_CPU_CACHING_WC,
			       XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
			       XE_BO_FLAG_FORCE_WC |
			       XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);

This appears to bypass the newly added memcg accounting because
XE_BO_FLAG_ACCOUNTED is not passed in the bitmask here.

>  	if (args->flags & DRM_XE_GEM_CREATE_FLAG_DEFER_BACKING)
>  		bo_flags |=3D XE_BO_FLAG_DEFER_BACKING;
> =20

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> index a4292a11391d3..61aa5033a2920 100644
> --- a/drivers/gpu/drm/xe/xe_lrc.c
> +++ b/drivers/gpu/drm/xe/xe_lrc.c
> @@ -1661,7 +1661,8 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct x=
e_hw_engine *hwe, struct xe_v
>  		   XE_BO_FLAG_GGTT_INVALIDATE;
> =20
>  	if ((vm && vm->xef) || init_flags & XE_LRC_CREATE_USER_CTX) /* userspac=
e */
> -		bo_flags |=3D XE_BO_FLAG_PINNED_LATE_RESTORE | XE_BO_FLAG_FORCE_USER_V=
RAM;
> +		bo_flags |=3D XE_BO_FLAG_PINNED_LATE_RESTORE | XE_BO_FLAG_FORCE_USER_V=
RAM |
> +			    XE_BO_FLAG_ACCOUNTED;
> =20
>  	bo =3D xe_bo_create_pin_map_novm(xe, tile, bo_size,
>  				       ttm_bo_type_kernel,

[Severity: High]
Should we also add XE_BO_FLAG_ACCOUNTED to the auxiliary buffers created for
userspace queues?

Just below this allocation in xe_lrc_init(), seqno_bo is allocated without
the flag:

	bo =3D xe_bo_create_pin_map_novm(xe, tile, PAGE_SIZE,
				       ttm_bo_type_kernel,
				       XE_BO_FLAG_GGTT |
				       XE_BO_FLAG_GGTT_INVALIDATE |
				       XE_BO_FLAG_SYSTEM, false);

Similarly, in xe_exec_queue_group_init(), cgp_bo is also allocated for
userspace queues without XE_BO_FLAG_ACCOUNTED:

	bo =3D xe_bo_create_pin_map_novm(xe, tile, SZ_4K, ttm_bo_type_kernel,
				       XE_BO_FLAG_VRAM_IF_DGFX(tile) |
				       XE_BO_FLAG_PINNED_LATE_RESTORE |
				       XE_BO_FLAG_FORCE_USER_VRAM |
				       XE_BO_FLAG_GGTT_INVALIDATE |
				       XE_BO_FLAG_GGTT, false);

If these are triggered by DRM_IOCTL_XE_EXEC_QUEUE_CREATE, could an applicat=
ion
spawn many execution queues and consume unaccounted memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706052330.1110=
909-1-airlied@gmail.com?part=3D10
