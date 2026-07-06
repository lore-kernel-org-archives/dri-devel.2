Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEB5C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 03:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8BD510E723;
	Mon,  6 Jul 2026 03:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XoD1jW3Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A1310E720
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:14:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E695600BB;
 Mon,  6 Jul 2026 03:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2C41F000E9;
 Mon,  6 Jul 2026 03:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783307647;
 bh=JUX9+YEPckBcA5J63SAon0NtjBhJ548ZpTmAlUVv1z0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XoD1jW3QmtSQeAhFpU7VK40c+6qC4FrB3TI5xsunF//nfSFiGkWR9hyiELLBAjSrQ
 Mi6LTID7vRmH38k8KBR09GHpuYlJtNMFpK213s1tB9KnKBPNts/QQd05e3v7qllnF/
 wNJ1LZfYr8KIhbOrN6m4aZks3NIkZnBxAVpGwx1R6zrWZoSig/wQsPlMt5inNXSoUF
 b+axbsO/rAVX8EU1GgvlzfQ0evYhsjJjclmhtg+im5Rx2Udg+YkwDMbHHNnsxbEDUU
 Yw5QJMoUUzQBI3quxTHdc0iyJEK5TT70+AdTheEqpMOGj8UyGNkn0o43zVauDYFOX/
 d2Vlo53300SaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] amdgpu: add support for memory cgroups
To: "Dave Airlie" <airlied@gmail.com>
Cc: mkoutny@suse.com, tj@kernel.org, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
In-Reply-To: <20260706024122.853329-9-airlied@gmail.com>
References: <20260706024122.853329-1-airlied@gmail.com>
 <20260706024122.853329-9-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:14:06 +0000
Message-Id: <20260706031406.BB2C41F000E9@smtp.kernel.org>
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
- [High] Evicted GPU buffers bypass memory cgroup limits because the memcg =
accounting flag is cleared during VRAM eviction and pages are never recharg=
ed upon re-validation.
- [Low] Missing dummy implementations for GPU page memory control functions=
 when CONFIG_MEMCG is disabled causes a linker error.
--

commit 14a7ef9775310750fa8f3933b124ce94b537e5c7
Author: Dave Airlie <airlied@redhat.com>

amdgpu: add support for memory cgroups
   =20
This adds support for adding a obj cgroup to a buffer object,
and passing in the placement flags to make sure it's accounted
properly.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 8062b3d611574..1c8123c564ac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -155,11 +155,14 @@ static void amdgpu_evict_flags(struct ttm_buffer_ob=
ject *bo,
>  			amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_GTT |
>  							AMDGPU_GEM_DOMAIN_CPU);
>  		}
> +		for (int i =3D 0; i < abo->placement.num_placement; i++)
> +			abo->placements[i].flags &=3D ~TTM_PL_FLAG_MEMCG;

[Severity: High]
Does clearing TTM_PL_FLAG_MEMCG during eviction allow memory cgroup limits =
to
be bypassed?

When a user forces eviction (for example, by allocating more VRAM), the flag
is cleared in amdgpu_evict_flags() and TTM moves the buffer to system memor=
y.
The pages are then allocated via ttm_pool_alloc() with memcg_account set to
false, leaving them uncharged.

If the user later re-validates the buffer into GTT, ttm_bo_validate() calls
ttm_resource_compatible(). This function only checks the memory type and
contiguous flags, ignoring TTM_PL_FLAG_MEMCG.

This seems to allow the buffer to remain backed by uncharged system pages,
potentially letting a containerized workload exhaust host system memory.

>  		break;
>  	case TTM_PL_TT:
>  	case AMDGPU_PL_PREEMPT:
>  	default:
>  		amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);
> +		abo->placements[0].flags &=3D ~TTM_PL_FLAG_MEMCG;

[Severity: High]
Does this also allow bypassing memory cgroup limits for TTM_PL_TT evictions
to the CPU domain for the same reason?

[ ... ]

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4c682b91cbbee..625de4a287eb3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3032,6 +3032,7 @@ __always_inline struct obj_cgroup *current_obj_cgro=
up(void)
> =20
>  	return rcu_dereference_check(root_mem_cgroup->nodeinfo[nid]->objcg, 1);
>  }
> +EXPORT_SYMBOL_GPL(current_obj_cgroup);
> =20
>  struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
>  {

[Severity: Low]
Will this series cause a linker error when CONFIG_DRM_TTM=3Dy and CONFIG_ME=
MCG=3Dn?

It looks like mem_cgroup_charge_gpu_page(), mem_cgroup_uncharge_gpu_page(),
and mem_cgroup_move_gpu_page_reclaim() are declared unconditionally in
include/linux/memcontrol.h.

However, their definitions in mm/memcontrol.c are skipped when CONFIG_MEMCG=
 is
disabled.

Since ttm_pool_alloc_page() in drivers/gpu/drm/ttm/ttm_pool.c calls these
without ifdef guards, this seems to lead to undefined references during
linking.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706024122.8533=
29-1-airlied@gmail.com?part=3D8
