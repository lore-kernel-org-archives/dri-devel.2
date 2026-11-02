Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59A606A32F
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTb9Uiib
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A1510EC35;
	Mon,  2 Nov 2026 08:46:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48CC710EC31;
 Mon,  2 Nov 2026 08:46:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31D334404C;
 Mon,  2 Nov 2026 08:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE1B1F00A17;
 Mon,  2 Nov 2026 08:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793609171;
 bh=zwp6ENeO1j+wKt4cmYLpzm2TmQvFNq8LzGJkzIegSm8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=fTb9UiibUWoo4/8aZ0xM8+9F0lfUFwfTXQPXGzqZPE8SpxCo5eAVSfzd8bIniJvl8
 NvzcTchJxozW0MHm5kwCpwonZi4Y+1R0Or+ViIOoNv+rPWiTlgd9X6WJDemg0+73rV
 ObUFGkdrOQzNxR2cEqtmVPfh97eKvSiq4yu5VuqiXVfgTfQIUUoWF/gP3rvfP5ofAF
 k4ukoZSssRfjjRb3kyxMxWZkX4snRk2dHRzkhDbgrrAie96dP3kVjqmL+IB1fdIUVD
 tRY6Ein5yEhPQkcF7Qwh5dBYDjrG1Bl9elt0Lqdnn5Gp9R/iZhOMLbAPAz6HljAYjL
 4Gb0fwY3pdgGA==
Message-ID: <sashiko-outbox-193137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe: Tear down kernel mappings in release_notify
To: "Arvind Yadav" <arvind.yadav@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261102082626.747462-1-arvind.yadav@intel.com>
References: <20261102082626.747462-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 08:46:10 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/xe: use-after-free in __xe_bo_vunmap() after xe_bo_shrink_purg=
e()
--

commit e49e34413e8a801c5062d0f07639d200170d532c
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe: Tear down kernel mappings in release_notify

This commit moves the __xe_bo_vunmap() call from xe_gem_object_free() to
xe_ttm_bo_release_notify() so that kernel mappings are torn down when the
TTM BO reference count reaches zero rather than when the GEM object
reference count drops to zero.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 42a6aa1a2e4a0..b7a982a9d81ac 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1866,6 +1866,12 @@ static void xe_ttm_bo_release_notify(struct ttm_bu=
ffer_object *ttm_bo)
>  	bo =3D ttm_to_xe_bo(ttm_bo);
>  	xe_assert(xe_bo_device(bo), !(bo->created && kref_read(&ttm_bo->base.re=
fcount)));
> =20
> +	/*
> +	 * The TTM BO refcount is zero, so eviction and swapout cannot
> +	 * take a reference. Unmap before TTM frees the backing store.
> +	 */
> +	__xe_bo_vunmap(bo);
> +
>  	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
>  		return;
> =20
> @@ -2056,7 +2062,6 @@ static void xe_gem_object_free(struct drm_gem_objec=
t *obj)
>  	 * driver ttm callbacks is allowed to use the ttm_buffer_object
>  	 * refcount directly if needed.
>  	 */
> -	__xe_bo_vunmap(gem_to_xe_bo(obj));
>  	ttm_bo_fini(container_of(obj, struct ttm_buffer_object, base));
>  }

[Severity: High]
Does deferring __xe_bo_vunmap() until xe_ttm_bo_release_notify() cause a
use-after-free and premature backing store free if the shrinker purges a BO
after its GEM refcount reaches zero?

When a kernel-mapped BO in XE_PL_TT (such as one created via
xe_bo_create_pin_map() or xe_bo_create_pin_map_at_aligned()) is unpinned and
its last GEM reference is dropped, bo->vmap and bo->kmap now remain active
while xe_gem_object_free() calls ttm_bo_fini().

If the shrinker grabs a TTM BO reference before ttm_bo_fini() drops the last
kref, xe_bo_shrink() sees that the GEM refcount is already zero and calls
xe_bo_shrink_purge() directly:

drivers/gpu/drm/xe/xe_bo.c:xe_bo_shrink() {
	...
	if (!xe_bo_is_xe_bo(bo) || !xe_bo_get_unless_zero(xe_bo))
		return xe_bo_shrink_purge(ctx, bo, scanned);
}

Unlike xe_bo_move(), xe_bo_shrink_purge() does not call xe_bo_move_notify()
or __xe_bo_vunmap():

drivers/gpu/drm/xe/xe_bo.c:xe_bo_shrink_purge() {
	...
	if (bo->resource->mem_type !=3D XE_PL_SYSTEM) {
		...
		xe_tt_unmap_sg(xe, bo->ttm);
		ttm_bo_move_null(bo, new_resource);
	}

	*scanned +=3D bo->ttm->num_pages;
	lret =3D ttm_bo_shrink(ctx, bo, (struct ttm_bo_shrink_flags)
			     {.purge =3D true,
			      .writeback =3D false,
			      .allow_move =3D false});
}

This purges the BO via ttm_bo_shrink() -> ttm_tt_backup() ->
ttm_pool_backup(), which resets the page caching attributes via
set_pages_array_wb() and frees the pages in tt->pages while bo->kmap is
still mapped.

When the shrinker later drops its TTM BO reference,
xe_ttm_bo_release_notify() -> __xe_bo_vunmap() -> ttm_bo_kunmap() will run
and call kunmap(map->page) on an already-freed struct page, or
vunmap(map->virtual) after the underlying physical pages were already freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102082626.7474=
62-1-arvind.yadav@intel.com?part=3D1
