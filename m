Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73FCC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3775910ED2D;
	Wed, 22 Jul 2026 10:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aQE93e2d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C529710ED2D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:04:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B1D964043F;
 Wed, 22 Jul 2026 10:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE861F000E9;
 Wed, 22 Jul 2026 10:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784714676;
 bh=Fgb7MQUp+otAth8uHqku9EbXp5J4Jr5pMjlQpfMVc4M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aQE93e2d9a0B4knHfWd4sq+Qr1C3IeNTNNrCRLPpT6Y+2MRcSRy7qgYz/MgaQhOs1
 NIpd2ehXtoAMh5Uu+XvSEq7DwS4fiD3Dg5MKN+pXEyAtOUUhlQ7w8HRg9xHcTkl1ZV
 lYxCxm1SM0j1SG0FKrkrN6F5LUb81AEW8Ya2v8KQ2C69G8HMdNGVM6aFOvEvngrJfr
 SOEgG6qRrmxgs/Zx1puoAIjd1vgPoKvupMTpx3KY7+dbW3ZjzFsOtB0/neLENF6lCN
 bUp6Xosx4lCmzUX6cGmemPK5k1p4Rcp3u4veLATiF2/iXA6Pjvs6ZKyqbvchVU+zv8
 fZjpiJBFXKdqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free in
 amdgpu_vram_mgr_fini() on init failure
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722095201.658119-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260722095201.658119-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 10:04:35 +0000
Message-Id: <20260722100436.6AE861F000E9@smtp.kernel.org>
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
- [High] If `amdgpu_vram_mgr_init()` fails early, structures like `ttm_reso=
urce_manager`, mutexes, and list heads remain zero-initialized. `amdgpu_vra=
m_mgr_fini()` runs unconditionally and accesses these, causing NULL pointer=
 dereferences and kernel panics.
--

--- Patch [1]: [PATCH] drm/amdgpu: Fix use-after-free in amdgpu_vram_mgr_fi=
ni() on init failure ---
commit 48887fb6b109845d375cd21461abab0a51f3196c
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

drm/amdgpu: Fix use-after-free in amdgpu_vram_mgr_fini() on init failure

The patch tries to fix a double-free or use-after-free when gpu_buddy_init()
fails by guarding gpu_buddy_fini() with ttm_resource_manager_used().

Closes: https://sashiko.dev/#/patchset/20260611173301.17473-1-thomas.hellst=
rom@linux.intel.com?part=3D1

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 2a241a5b12c42..38529a904deb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -954,6 +954,9 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>  	struct ttm_resource_manager *man =3D &mgr->manager;
>  	int ret;
>  	struct amdgpu_vram_reservation *rsv, *temp;
> +	bool was_used;
> +
> +	was_used =3D ttm_resource_manager_used(man);

[Severity: High]
This isn't a bug introduced by this patch, but does this function still
crash if amdgpu_vram_mgr_init() fails early?

If amdgpu_vram_mgr_init() fails (for example, if drmm_cgroup_register_regio=
n()
returns an error), it bails out before ttm_resource_manager_init() can
initialize the man->lru list heads or mutex_init() runs.

When the error path unwinds through amdgpu_vram_mgr_fini(), the code
unconditionally calls:

	ttm_resource_manager_set_used(man, false);
	ret =3D ttm_resource_manager_evict_all(&adev->mman.bdev, man);

This traverses the uninitialized man->lru lists in ttm_bo_evict_first(),
where list_empty() evaluates to false on zeroed memory (since NULL !=3D hea=
d),
causing list_first_entry() to return an invalid offset and eventually
dereferencing a NULL pointer.

If that doesn't crash, the function later unconditionally locks the
zero-initialized mutex and iterates over the zero-initialized list head:

	mutex_lock(&mgr->lock);
	list_for_each_entry_safe(rsv, temp, &mgr->reservations_pending, blocks)

Could we return early from amdgpu_vram_mgr_fini() if the manager wasn't
initialized, perhaps by using the was_used flag to skip these teardown
steps as well?

> =20
>  	ttm_resource_manager_set_used(man, false);
> =20
[ ... ]
> @@ -969,7 +972,7 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>  		gpu_buddy_free_list(&mgr->mm, &rsv->allocated, 0);
>  		kfree(rsv);
>  	}
> -	if (!adev->gmc.is_app_apu)
> +	if (!adev->gmc.is_app_apu && was_used)
>  		gpu_buddy_fini(&mgr->mm);
>  	mutex_unlock(&mgr->lock);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722095201.6581=
19-1-Arunpravin.PaneerSelvam@amd.com?part=3D1
