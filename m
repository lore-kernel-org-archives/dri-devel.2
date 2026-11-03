Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C94C606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6Kao+78
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB5810E7A3;
	Tue,  3 Nov 2026 09:15:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923A810E7A3
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 09:15:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5CA36020A;
 Tue,  3 Nov 2026 09:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBE31F000C1;
 Tue,  3 Nov 2026 09:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793697350;
 bh=bwdtvmm5ZCMIT9r9ZD0X+8S+JoBw3ts8zp8gm4S2e4A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z6Kao+78Jeu7n8NI1RUXHiDVx3b3KOlvPHOu35VlYsrSa6Rcvs0fNeQzJnIE1wNZo
 Nte6Xz2lXgW4r7dywenne609MWgZan2rAYbbQknMqw9HMwRDsd/tMJOadb9t5xYPrP
 lFwVPvQCTa4aVd8cuesq4pHZXEqZqAivWKvL0h+R848rBvkPcIsTeAOaMy+frqFKb/
 IiDt+dEUrwRjenLMZxZYZ03slPGEPCVbVfvE9C9xsPeB3h0tSJQSwbaQ+KFRR4jrtL
 h4qfH/VhIi2OA3keEFNfr5rXxmPNIcWMspp7ZOJsgMq8+mCtgU6nnkHSjZQN3MVi3L
 J+uaezwjxLscw==
Message-ID: <sashiko-outbox-194946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/vmwgfx: unpin BOs without revalidating placement
To: =?utf-8?b?5r2Y54Wc5p2t?= <242270054@hdu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <064da7ba-58ca-4027-88a9-12fb41e8b7d4@hdu.edu.cn>
References: <064da7ba-58ca-4027-88a9-12fb41e8b7d4@hdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:15:49 +0000
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
- [Low] drm/vmwgfx: email text and inaccurate claim in vmw_bo_pin_reserved(=
) commit log
--

commit da725c3c2e0e2c05d0e0cf86657330ca0fde440a
Author: =E6=BD=98=E7=85=9C=E6=9D=AD <242270054@hdu.edu.cn>

drm/vmwgfx: unpin BOs without revalidating placement

This commit skips calling ttm_bo_validate() when unpinning a buffer object =
in
vmw_bo_pin_reserved() to avoid triggering BUG_ON() when validation fails on=
 a
pinned buffer object during PRIME cleanup.

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

[Severity: Low]
This isn't a bug in the code, but should the introductory greeting ("Hello,
I apologize...") be moved below the "---" separator line so that it is not
recorded in the permanent git commit history?

Also, is the statement in the commit message that validation on the pin path
"is needed to establish the requested placement before pinning" accurate?
Looking at vmw_bo_pin_reserved() in drivers/gpu/drm/vmwgfx/vmwgfx_bo.c, it =
is
documented to pin or unpin a buffer object without moving it, takes no
placement parameter, and only copies bo->resource->mem_type and
bo->resource->placement from the already-allocated resource (a leftover from
when TTM pinned and unpinned BOs by toggling TTM_PL_FLAG_NO_EVICT via
ttm_bo_validate() prior to commit fbe86ca56791).

In the trace shown in the commit message, flags=3D0x10 is TTM_PL_FLAG_FALLB=
ACK:
ttm_resource_compatible() rejects TTM_PL_FLAG_FALLBACK on the first validat=
ion
pass when force_space is false, which causes ttm_bo_validate() to reach the
if (bo->pin_count) return -EINVAL check.

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

[Severity: Medium]
Should the ttm_bo_validate() call and BUG_ON() in vmw_bo_pin_reserved() be
removed from the pin path as well?

When a buffer object resides in a fallback placement, bo->resource->placeme=
nt
has TTM_PL_FLAG_FALLBACK (0x10) set via placement_flags() in
drivers/gpu/drm/vmwgfx/vmwgfx_bo.c. When vmw_bo_pin_reserved(vbo, true) is
called (for example via vmw_gem_object_pin(), vmw_resource_pin(), or
vmw_execbuf_process()), it copies bo->resource->placement into pl.flags and
calls ttm_bo_validate(bo, &placement, &ctx):

drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:vmw_bo_pin_reserved() {
	pl.fpfn =3D 0;
	pl.lpfn =3D 0;
	pl.mem_type =3D bo->resource->mem_type;
	pl.flags =3D bo->resource->placement;
	...
	ret =3D ttm_bo_validate(bo, &placement, &ctx);

	BUG_ON(ret !=3D 0 || bo->resource->mem_type !=3D old_mem_type);
}

On the first pass of ttm_bo_validate() (where force_space is false),
ttm_resource_compatible() rejects TTM_PL_FLAG_FALLBACK and returns false:

drivers/gpu/drm/ttm/ttm_resource.c:ttm_resource_compatible() {
		if (place->flags & (evicting ? TTM_PL_FLAG_DESIRED :
				    TTM_PL_FLAG_FALLBACK))
			continue;
}

Because ttm_resource_compatible() returns false, ttm_bo_validate() calls
ttm_bo_alloc_resource(), which calls dma_resv_reserve_fences() before skipp=
ing
the fallback placement and retrying with force_space set to true:

drivers/gpu/drm/ttm/ttm_bo.c:ttm_bo_alloc_resource() {
	ticket =3D dma_resv_locking_ctx(bo->base.resv);
	ret =3D dma_resv_reserve_fences(bo->base.resv, TTM_NUM_MOVE_FENCES);
	if (unlikely(ret))
		return ret;
}

If dma_resv_reserve_fences() fails with -ENOMEM under memory pressure,
ttm_bo_validate() returns -ENOMEM and triggers BUG_ON(ret !=3D 0 ||
bo->resource->mem_type !=3D old_mem_type) on the pin path.

Prior to commit fbe86ca56791 ("drm/vmwgfx: switch over to the new pin
interface v2"), TTM pinned and unpinned BOs by toggling TTM_PL_FLAG_NO_EVICT
in pl.flags and calling ttm_bo_validate() to update the placement flag
in-place. Once commit fbe86ca56791 switched to ttm_bo_pin() and
ttm_bo_unpin(), the ttm_bo_validate() call in vmw_bo_pin_reserved() became
vestigial on both paths: whenever ttm_bo_validate() succeeds here, it retur=
ns
0 early at the ttm_resource_compatible() check without moving the buffer or
creating a TTM, and callers needing a specific placement already call
ttm_bo_validate() beforehand.

Could vmw_bo_pin_reserved() drop the ttm_bo_validate() block and unused loc=
al
variables (ctx, pl, placement, old_mem_type, ret) and simply call
ttm_bo_pin(bo) or ttm_bo_unpin(bo) when pin !=3D !!bo->pin_count?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/064da7ba-58ca-4027-=
88a9-12fb41e8b7d4@hdu.edu.cn?part=3D1
