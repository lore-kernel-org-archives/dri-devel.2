Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A22C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E36E810EE60;
	Thu, 17 Sep 2026 12:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZJZLDNjD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4603210EE60
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:15:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D86F440672;
 Thu, 17 Sep 2026 12:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D89C1F000FF;
 Thu, 17 Sep 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789647315;
 bh=v+iKZCvUzGwRx9637EGE5iO/2rb+bBh1L4O7ptr78C8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZJZLDNjDPyao2nTe444ecWF76EGLbm3mBMhY+qp9BNKhtYIaCvl1geo2LdGRqUn57
 uioz+xr6+yWjw+hT14vnsGEYs1lyIDQraVBVTSrMlRoZ+oD36yaQJ3NfKFOQNHocBo
 su5ORUNwb9kDledrBwsonikDKdCkxVPWh3zdRL1JU2cMwsIyUJ2E2GwUBUNQFU+Yfj
 zLmeIAEYbGFVXHxD4JniMhNFKrpJZPEggEln2wCHm2jo8UOMMKEISYIxLM+P3kmS93
 92Mm4Zrn4utcgSZdae/bgWWcrRK9kZgAYzu/dzy4vZA0zvYFJtQNE6l5FBHonYO70e
 BKJ9sa3josJwA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 2/2] drm/amdgpu: Wire up DRM memory stats reporting
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260917120444.86471-3-tvrtko.ursulin@igalia.com>
References: <20260917120444.86471-1-tvrtko.ursulin@igalia.com>
 <20260917120444.86471-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 12:15:15 +0000
Message-Id: <20260917121515.9D89C1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] amdgpu: data race and OOB read in amdgpu_drm_memory_info lazy init
- [High] amdgpu: embedded flexible array member causes UB and FORTIFY panics
- [Medium] amdgpu: array index mismatch in fdinfo mixes up memory stats
- [Medium] amdgpu: unprotected concurrent updates to region->used_mb cause =
data race
--

commit 0821285be07eaef79323cee5db70d046b94e519f
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
drm/amdgpu: Wire up DRM memory stats reporting

This commit wires up the driver agnostic DRM memory reporting for the VRAM
and GTT memory regions. It keeps the persistent storage at the device level
and exports a helper for standardized region names.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 79b69d74eb2e5..8c00f76cfc7b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -965,6 +965,9 @@ struct amdgpu_device {
> =20
>  	struct amdgpu_uma_carveout_info uma_info;
> =20
> +	struct drm_memory_info		memory_info;
> +	struct drm_memory_region_info	__memory_region_info[2]; /* Storage for m=
emory_info */
> +

[Severity: High]
Does embedding a structure with a flexible array member in the middle
of another struct cause undefined behavior and compiler warnings?

struct drm_memory_info ends with a flexible array member (region[]).
Embedding it here before __memory_region_info[2] means the compiler
evaluates the size of memory_info as only its fixed members (4 bytes).

When writing to info->region[i] later, FORTIFY/UBSAN checks may panic
as the access exceeds the recognized object bounds.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_fdinfo.c
> index b349bb3676d5f..3bbd053cd9f7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
[ ... ]
> @@ -85,15 +104,12 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struc=
t drm_file *file)
> =20
>  	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(pl_name); i++) {
> -		if (!pl_name[i])
> -			continue;
> -
> +	for (i =3D 0; i < ARRAY_SIZE(regions); i++) {
>  		drm_print_memory_stats(p,
> -				       &stats[i].drm,
> +				       &stats[i].drm,
>  				       DRM_GEM_OBJECT_RESIDENT |
>  				       DRM_GEM_OBJECT_PURGEABLE,
> -				       pl_name[i]);
> +				       amdgpu_ttm_pl_to_name(regions[i]));
>  	}

[Severity: Medium]
Is there an array index mismatch here?

The stats array is populated by amdgpu_vm_get_memory() which maps
placement IDs directly to indices (e.g., TTM_PL_SYSTEM is 0,
TTM_PL_VRAM is 2).

However, the loop iterates using a sequential index i (0 to 7) and
fetches &stats[i].drm, but labels it with amdgpu_ttm_pl_to_name(regions[i]).

For i=3D0, regions[0] is TTM_PL_VRAM (2), meaning it fetches stats[0]
(CPU memory) but labels it as VRAM.

Should the fetch use &stats[regions[i]].drm to correctly match the data
with the placement ID?

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 0ca9b1669e0fe..d6da850eadc97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -3026,3 +3026,40 @@ void amdgpu_ttm_debugfs_init(struct amdgpu_device =
*adev)
> =20
>  #endif
>  }
> +
> +const struct drm_memory_info *amdgpu_drm_memory_info(struct drm_device *=
drm)
> +{
> +	struct amdgpu_device *adev =3D drm_to_adev(drm);
> +	struct drm_memory_info *info =3D &adev->memory_info;
[ ... ]
> +	if (!info->num_regions) {
> +		for (i =3D 0; i < ARRAY_SIZE(regions); i++) {
> +			region =3D &info->region[i];
> +			strscpy(region->name,
> +				amdgpu_ttm_pl_to_name(regions[i]),
> +				sizeof(region->name));
> +			man =3D ttm_manager_type(&adev->mman.bdev, regions[i]);
> +			region->total_mb =3D man->size >> 20;
> +			info->num_regions++;
> +		}
> +	}

[Severity: High]
Is this lockless lazy initialization safe against concurrent access?

If multiple threads query DRM memory info concurrently via fdinfo, they
can simultaneously enter the if (!info->num_regions) block. Both threads
could execute info->num_regions++ in a loop.

Since the backing array (__memory_region_info) only has 2 elements,
concurrent increments can push num_regions to 4. When the DRM core later
iterates up to num_regions, will this lead to out-of-bounds memory reads?

> +
> +	for (i =3D 0; i < ARRAY_SIZE(regions); i++) {
> +		region =3D &info->region[i];
> +		man =3D ttm_manager_type(&adev->mman.bdev, regions[i]);
> +		region->used_mb =3D ttm_resource_manager_usage(man) >> 20;
> +	}
> +
> +	return &adev->memory_info;
> +}

[Severity: Medium]
Can unprotected concurrent updates to region->used_mb cause data races?

Because amdgpu_drm_memory_info() updates region->used_mb directly within
the globally shared adev->memory_info structure without synchronization,
concurrent readers and writers might race, leading to torn reads or
KCSAN splats.

Would it be safer to allocate a drm_memory_info struct per-query instead
of caching it globally?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917120444.8647=
1-1-tvrtko.ursulin@igalia.com?part=3D2
