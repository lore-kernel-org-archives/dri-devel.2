Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADF606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJZzHbd/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D4710E06B;
	Tue,  3 Nov 2026 09:24:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D7B10E06B
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 09:24:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDDC8601EF;
 Tue,  3 Nov 2026 09:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661811F00919;
 Tue,  3 Nov 2026 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793697882;
 bh=hGcZYYPFZk6D3uhjJkGyjB6A0jCFIuQiIBnp2G1jzaY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CJZzHbd/lv/2HWUI3vUH8cGCUyqumdcCtKQVhfvZghDTlex83AEsambbOKPbJAikQ
 7/I1RPZ/vNMgykPObmyVjqnLY/MX/fBdBSigg/Kt+qSXnoeOOw+ziW/s3zxFdAmSXp
 iWXjjHTsJGcocWIjcZFbxzeyXyvq0YXtNjZsG977tlLEfQgZVoR4uHJ4W/wAoePNKF
 rVXCHIHjGilm05bmD9NjNbZuIz4KmbIPGlx8xaE3gfk00a1GelaEa9zZeWvbT1Yd0m
 EnoAokgHJLxfdsF9g+xhcuJ6eqb6MLYSVFlgA57fvvxWSG/VcDQ5c+ZFRj9Mq4Sme1
 0Dc+Fy2G7E1Zg==
Message-ID: <sashiko-outbox-194952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/vmwgfx: unpin BOs without revalidating placement
To: =?utf-8?b?5r2Y54Wc5p2t?= <242270054@hdu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <93888c18-7ce4-4341-b387-a80a29847d3e@hdu.edu.cn>
References: <93888c18-7ce4-4341-b387-a80a29847d3e@hdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:24:42 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/vmwgfx: vestigial ttm_bo_validate() and BUG_ON() in vmw_bo_p=
in_reserved()
- [Medium] drm/vmwgfx: inaccurate commit description and email notes above =
tear line
--

commit 25af1e918639e493179b2c83013bfbfaba035064
Author: =E6=BD=98=E7=85=9C=E6=9D=AD <242270054@hdu.edu.cn>

drm/vmwgfx: unpin BOs without revalidating placement

This commit skips calling ttm_bo_validate() when unpinning a buffer object =
in
vmw_bo_pin_reserved() to avoid hitting BUG_ON() during PRIME/GEM teardown,
while retaining the ttm_bo_validate() call on the pin path.

>     drm/vmwgfx: unpin BOs without revalidating placement
>    =20
>     Hello,
>    =20
>     I apologize for the repeated mistakes in my previous messages and pat=
ch
>     submissions. Thank you for your patience. This version includes the c=
orrected
>     Fixes tag and an unwrapped patch diff.
>    =20
>     Unpinning a buffer object does not change its placement. Avoid calling
>     ttm_bo_validate() on the unpin path, where a placement validation fai=
lure
>     currently triggers BUG_ON() and crashes the kernel during PRIME clean=
up.
>    =20
>     Keep validation on the pin path, where it is needed to establish the
>     requested placement before pinning.
>    =20
>     During PRIME/GEM cleanup, vmw_gem_object_unpin() calls
>     vmw_bo_pin_reserved(vbo, false). The latter currently calls
>     ttm_bo_validate() for both pin and unpin operations. In the observed =
Linux
>     7.3 QEMU run, ttm_bo_validate() returned -EINVAL on the unpin path; t=
he
>     following BUG_ON() caused a kernel BUG during process teardown.
>    =20
>     The path is:
>    =20
>       exit_group()
>         -> GEM/PRIME object cleanup
>         -> vmw_gem_object_unpin()
>         -> vmw_bo_pin_reserved(vbo, false)
>         -> ttm_bo_validate() returns -EINVAL
>         -> BUG_ON(ret !=3D 0 || bo->resource->mem_type !=3D old_mem_type)
>    =20
>     Observed report excerpt:
>    =20
>       [BO_PIN_TRACE] before-validate pin=3D0 old_mem_type=3D0 target_mem_=
type=3D0 flags=3D0x10
>       [BO_PIN_TRACE] after-validate ret=3D-22 old_mem_type=3D0 new_mem_ty=
pe=3D0 ...
>       kernel BUG at drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:342!
>       RIP: vmw_bo_pin_reserved+0x36d/0x380
>    =20
>     The change skips placement validation when unpinning and retains it o=
n the
>     pin path.
>    =20
>     Fixes: fbe86ca56791 ("drm/vmwgfx: switch over to the new pin interfac=
e v2")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Yuhang Pan <242270054@hdu.edu.cn>

[Severity: Medium]
Should the opening greeting and submission notes be moved below the ---
separator so they are not recorded in the permanent git commit log?

Also, is the statement "Keep validation on the pin path, where it is needed
to establish the requested placement before pinning" accurate?

Looking at the kernel-doc above vmw_bo_pin_reserved() in
drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:

    /**
     * vmw_bo_pin_reserved - Pin or unpin a buffer object without moving it.
     *
     * @vbo: The buffer object. Must be reserved.
     * @pin: Whether to pin or unpin.
     *
     */

vmw_bo_pin_reserved() does not take or establish a requested placement; it
constructs a temporary struct ttm_place from the BO's existing
bo->resource->mem_type and bo->resource->placement and asserts via BUG_ON()
that mem_type does not change, which is a leftover from how
TTM_PL_FLAG_NO_EVICT was toggled prior to commit fbe86ca56791 ("drm/vmwgfx:
switch over to the new pin interface v2").

In addition, would it be helpful for the commit message to explain why
ttm_bo_validate() returned -EINVAL when flags=3D0x10 (TTM_PL_FLAG_FALLBACK)?
Commits a78a8da51b36 ("drm/ttm: replace busy placement with flags v6") and
cc941c70df39 ("drm/ttm: improve idle/busy handling v5") caused
vmw_bo_placement_set() to mark fallback placements with TTM_PL_FLAG_FALLBACK
and made ttm_resource_compatible() reject TTM_PL_FLAG_FALLBACK on the
non-evicting first pass of ttm_bo_validate(), causing ttm_bo_validate() to
fall through to:

    if (bo->pin_count)
        return -EINVAL;

when called on an already-pinned BO.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index 9c7a73c0b0dc3..14d28e2ff0481 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -308,6 +308,11 @@ void vmw_bo_pin_reserved(struct vmw_bo *vbo, bool pi=
n)
>  	if (pin =3D=3D !!bo->pin_count)
>  		return;
> =20
> +	if (!pin) {
> +		ttm_bo_unpin(bo);
> +		return;
> +	}
> +
>  	pl.fpfn =3D 0;
>  	pl.lpfn =3D 0;
>  	pl.mem_type =3D bo->resource->mem_type;
> @@ -321,10 +326,7 @@ void vmw_bo_pin_reserved(struct vmw_bo *vbo, bool pi=
n)
> =20
>  	BUG_ON(ret !=3D 0 || bo->resource->mem_type !=3D old_mem_type);
> =20
> -	if (pin)
> -		ttm_bo_pin(bo);
> -	else
> -		ttm_bo_unpin(bo);
> +	ttm_bo_pin(bo);
>  }

[Severity: Medium]
Should ttm_bo_validate(), BUG_ON(), and the now-unused local variables (ctx,
pl, placement, old_mem_type, ret) be removed from the pin path of
vmw_bo_pin_reserved() as well, so that it simply calls ttm_bo_pin(bo) or
ttm_bo_unpin(bo)?

Prior to commit fbe86ca56791 ("drm/vmwgfx: switch over to the new pin
interface v2"), TTM represented pinned BOs via TTM_PL_FLAG_NO_EVICT in
bo->mem.placement, so vmw_bo_pin_reserved() copied the current placement in=
to
pl, toggled TTM_PL_FLAG_NO_EVICT, and called ttm_bo_validate() solely to
update the flag and LRU state in-place without moving the BO. Once commit
fbe86ca56791 replaced TTM_PL_FLAG_NO_EVICT with ttm_bo_pin() and
ttm_bo_unpin(), the ttm_bo_validate() call and BUG_ON() became a vestige on
both pin and unpin paths. All callers that require a specific placement
(vmw_bo_pin_in_placement(), vmw_bo_pin_in_vram_or_gmr(),
vmw_bo_pin_in_start_of_vram(), vmw_resource_pin(), and
vmw_query_bo_switch_commit()) already call ttm_bo_validate() prior to calli=
ng
vmw_bo_pin_reserved(vbo, true).

Leaving ttm_bo_validate() and BUG_ON() on the pin path still causes a probl=
em
when pinning a BO whose resource was allocated in a fallback busy_domain so
that bo->resource->placement has TTM_PL_FLAG_FALLBACK (0x10) set, reachable
via:

    drm_gem_map_attach()
      -> vmw_gem_object_pin()
        -> vmw_bo_pin_reserved(vbo, true)

or:

    vmw_resource_pin()
      -> vmw_bo_pin_reserved(vbo, true)

When vmw_bo_pin_reserved(vbo, true) copies bo->resource->placement into
pl.flags, the first pass of ttm_bo_validate() (force_space =3D=3D false) ca=
lls
ttm_resource_compatible() in drivers/gpu/drm/ttm/ttm_resource.c:

    if (place->flags & (evicting ? TTM_PL_FLAG_DESIRED :
                        TTM_PL_FLAG_FALLBACK))
        continue;

which rejects TTM_PL_FLAG_FALLBACK when evicting is false and returns false.
Because bo->pin_count is 0, ttm_bo_validate() then enters
ttm_bo_alloc_resource() in drivers/gpu/drm/ttm/ttm_bo.c:

    ticket =3D dma_resv_locking_ctx(bo->base.resv);
    ret =3D dma_resv_reserve_fences(bo->base.resv, TTM_NUM_MOVE_FENCES);
    if (unlikely(ret))
        return ret;

before skipping the TTM_PL_FLAG_FALLBACK placement, returning -ENOSPC, and
only succeeding on the second pass (force_space =3D=3D true). If
dma_resv_reserve_fences() fails with -ENOMEM, ttm_bo_validate() returns
-ENOMEM and triggers BUG_ON(ret !=3D 0 || bo->resource->mem_type !=3D
old_mem_type) in vmw_bo_pin_reserved().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/93888c18-7ce4-4341-=
b387-a80a29847d3e@hdu.edu.cn?part=3D1
