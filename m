Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F57CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A1E710E49B;
	Mon, 12 Oct 2026 13:12:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E630710E49B
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:12:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F96060AB0;
 Mon, 12 Oct 2026 13:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8431F0089B;
 Mon, 12 Oct 2026 13:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810729;
 bh=PNVLsBXcheH7sO+jMkHQOPv9Gshh7C7fFcxRLpsgGxo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MrvCACoOOvpoLOesHtO5RsOEWg11G3H7vvrgWp2vpOfHScASrmnoBg0T2OkN9iY8c
 IOJjM0EZ137mbhVM3+HaCTwevMO5b1SEVpYT/FAjBSIAfOIThOM6Az867M2uSWjrns
 fvHowcUcKYRgfiTI8ZAUr2xjg+oQDeyeIho6MjNVlb04F6hsbCtOHQBW4mp1doF5CS
 bT/BvKMIMFuKavnIrGjVTPA5n2AEIUOk59zRNaTxOxGYs7QQ16uQJlgE309GhfAlp+
 M5suwuNgFJFwpED/KynBDA7y9Ag2nmF7VACPrfFYs7FiiM3Epy9/+spmuP6UHvLmRN
 aDwjF8ldLMvTQ==
Message-ID: <sashiko-outbox-168147@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/12] drm/panthor: Create kernel BO from existing GEM
To: "Ketil Johnsen" <ketil.johnsen@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012125940.3291951-10-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-10-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:12:08 +0000
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
- [Medium] drm/panthor: integer truncation of size_t to u32 in panthor_kern=
el_bo_create_from_gem()
- [Low] drm/panthor: unused usage_flags parameter in panthor_gem_create()
--

commit e696a47bb56852d031f4d4fbdb9474523f19a3f1
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Create kernel BO from existing GEM

Refactors/splits existing panthor_kernel_bo_create(). Adds
panthor_kernel_bo_create_from_gem() so we can create kernel BOs
from imported protected memory in future change.

> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/pant=
hor/panthor_gem.c
> index 0af4ae47780be..ec6eba8e2ac3a 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
[ ... ]
> @@ -1036,7 +1036,6 @@ panthor_gem_create(struct drm_device *dev, size_t s=
ize, uint32_t flags,
>  		bo->base.resv =3D bo->exclusive_vm_root_gem->resv;
>  	}
> =20
> -	panthor_gem_debugfs_add_usage_flags(bo, usage_flags);
>  	panthor_gem_debugfs_bo_add(bo);
>  	return bo;

[Severity: Low]
Since the call to panthor_gem_debugfs_add_usage_flags() is removed here, do=
es
this leave the usage_flags parameter entirely unused in panthor_gem_create(=
)?=20

Should the parameter be removed from the function signature as well to avoid
dead code?

[ ... ]
> @@ -1274,46 +1275,33 @@ void panthor_kernel_bo_destroy(struct panthor_ker=
nel_bo *bo)
>  }
> =20
>  /**
> - * panthor_kernel_bo_create() - Create and map a GEM object to a VM
> + * panthor_kernel_bo_create_from_gem() - Create kernel BO from existing =
GEM object
[ ... ]
>  struct panthor_kernel_bo *
> -panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm=
 *vm,
> -			 size_t size, u32 bo_flags, u32 vm_map_flags,
> -			 u64 gpu_va, const char *name)
> +panthor_kernel_bo_create_from_gem(struct panthor_device *ptdev,
> +				  struct panthor_vm *vm,
> +				  struct panthor_gem_object *bo,
> +				  u32 vm_map_flags, u64 gpu_va, u32 vm_map_size)

[Severity: Medium]
Does this cause an implicit integer truncation on 64-bit platforms?

The panthor_kernel_bo_create() function takes size as a size_t (which is 64
bits wide), but passes it to vm_map_size here, which is declared as a u32:

panthor_kernel_bo_create(..., size_t size, ...)
{
        ...
        kbo =3D panthor_kernel_bo_create_from_gem(ptdev, vm, bo, vm_map_fla=
gs,
                                                gpu_va, size);
        ...
}

Could this lead to silent partial allocations or out-of-bounds accesses if a
kernel BO size ever exceeds 4GB?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012125940.3291=
951-1-ketil.johnsen@arm.com?part=3D9
