Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3D6070F09
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTyZb6EG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AAA10E5A8;
	Fri, 13 Nov 2026 17:30:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EBE710E5A8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:29:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB4EC62D70;
 Fri, 13 Nov 2026 17:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA571F000C5;
 Fri, 13 Nov 2026 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794590998;
 bh=Q7WS2Zf7tVnDb3prprYQoffhKFriVeBfZ9Uq0W7td1Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BTyZb6EG9X+U8vuJ6hqdyyuV0IAppT47fLxAaeD1t6ByDe8weivRyLnAR68JgF4pH
 5Qzxxn7Hr8TZSFZG7i7YQm+CTHV5PyYwEylwB53PdngOwe6yRZahPvMwlr3VamtnGc
 n2Ew67S0zDYb7OtY3mPTsyMX719Wrm33ki4GBEvtrcvDMRiorWGa2tTzX91Yl+xNcP
 mqj3ltGRgwm3HoVI7E2dc/AcNgUILJdxqmthH9NIWvNyTU1I4fsgT1S9ASxJhNpi9c
 Ag/v27crED8y5xwM1WNVceiYSjzxR8OhexFEIRF6e810JmK8sj64EF0aEo87nMurzH
 4eOkgmTv4fofw==
Message-ID: <sashiko-outbox-213309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panthor: Fix unlocked pool->vm access in
 panthor_heap_create()
To: "Jiwoo Kim" <arpe1618@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261113171211.836427578-1-arpe1618@gmail.com>
References: <20261113171211.836427578-1-arpe1618@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:29:57 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/panthor: use-after-free of pool->gpu_contexts in
  panthor_heap_grow() [1]
--

commit 8965445d49e12381fc8f429998271cbb17e58ff7
Author: Jiwoo Kim <arpe1618@gmail.com>

drm/panthor: Fix unlocked pool->vm access in panthor_heap_create()

This commit passes an explicit panthor_vm pointer to
panthor_alloc_heap_chunk() and panthor_alloc_heap_chunks() so that
panthor_heap_create() uses the VM reference acquired under pool->lock
rather than reading pool->vm unlocked.

> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/pan=
thor/panthor_heap.c
> index 99311abdf1e91..46f53699a2601 100644
> --- a/drivers/gpu/drm/panthor/panthor_heap.c
> +++ b/drivers/gpu/drm/panthor/panthor_heap.c

[ ... ]

> @@ -473,7 +479,7 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>  	 * further jobs in this queue fail immediately instead of having to
>  	 * wait for the job timeout.
>  	 */
> -	ret =3D panthor_alloc_heap_chunk(pool, heap, false);
> +	ret =3D panthor_alloc_heap_chunk(pool, pool->vm, heap, false);
>  	if (ret)
>  		goto out_unlock;
> =20

[Severity: High]
This problem wasn't introduced by this patch, but can panthor_heap_grow()
(and panthor_heap_return_chunk()) trigger a use-after-free on
pool->gpu_contexts [1] when racing with panthor_heap_pool_destroy()?

drivers/gpu/drm/panthor/panthor_heap.c:panthor_heap_grow() {
	u64 offset =3D heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
	u32 heap_id =3D (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
    ...
	if (offset > U32_MAX || heap_id >=3D MAX_HEAPS_PER_POOL)
		return -EINVAL;

	down_read(&pool->lock);
    ...
}

group_process_tiler_oom() grabs a reference to the heap pool under
sched->lock and drops the lock before calling panthor_heap_grow().
Because panthor_vm_destroy() does not flush sched->heap_alloc_wq,
panthor_heap_pool_destroy() can destroy pool->gpu_contexts under
pool->lock while the pool stays alive through the worker's reference:

kworker                         CPU0
group_tiler_oom_work()
  group_process_tiler_oom()
    panthor_vm_get_heap_pool()
                                panthor_vm_destroy()
                                  panthor_heap_pool_destroy()
                                    down_write(&pool->lock)
                                    panthor_kernel_bo_destroy(...)
                                    up_write(&pool->lock)
    panthor_heap_grow()
      panthor_kernel_bo_gpuva(...)  <-- use-after-free

Both panthor_heap_grow() and panthor_heap_return_chunk() dereference
pool->gpu_contexts via panthor_kernel_bo_gpuva() before acquiring
pool->lock and checking whether the pool has been destroyed.

[1] https://sashiko.dev/#/bug/linux-7cebf7b5-5dd3-4267-b0af-8d80a7aa727d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171211.8364=
27578-1-arpe1618@gmail.com?part=3D1
