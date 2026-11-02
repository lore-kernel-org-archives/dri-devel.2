Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D0606A338
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDYHF9no
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D8110E06A;
	Mon,  2 Nov 2026 10:06:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4238810E5D3;
 Mon,  2 Nov 2026 10:06:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD86D412B0;
 Mon,  2 Nov 2026 10:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818581F00919;
 Mon,  2 Nov 2026 10:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793614000;
 bh=iWIYPIvIFLRtwn+uC5U/H7f0a4miSU2EbQLKMw69uWU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=TDYHF9noC0GOvw2zO/WnRHKtxWHqKSfqnvpuKwhEGxyWrOYwKXMoe+pnHwyxmIVvo
 3Xxczhrr/U1/Wwl8oZzB2OD3cYINokvV4KnUEFh3sycHAovW6zpRI1DkEUfjRwmE+J
 DyAKdhNTROEit1tLKmfdwH9wzSgnpXJNn5BMz9Tc6q+vNxT07k5tNuNg3bSwY/iXif
 gJAraSiXPdTyJegZdadeJdV9pBpTSvzNHwxiTtyffHW8oae+SoubOAYZNFEmpvjtjx
 f35Rj6FvsUtqQtPSu4C5TdD90FaxFKyzacT9U4Xy4u9p9iUbB8gpydzj//IFiypgC2
 5JyOY7s7RFEhg==
Message-ID: <sashiko-outbox-193233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/xe: Tear down kernel mappings in release_notify
To: "Arvind Yadav" <arvind.yadav@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261102094529.785224-1-arvind.yadav@intel.com>
References: <20261102094529.785224-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 10:06:40 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/xe: missing kernel unmap when unplug eviction purges BO via tt=
m_bo_pipeline_gutting()
- [High] drm/xe: xe_bo_shrink() unmaps BO before waiting on reservation fen=
ces or early-exit checks
--

commit 5f1d487383f2c8c07f8f671e579bb556db6a0d58
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe: Tear down kernel mappings in release_notify

This commit moves the final kernel BO unmap from xe_gem_object_free() to
xe_ttm_bo_release_notify() so that TTM eviction cannot race with
__xe_bo_vunmap(). It also calls xe_bo_vunmap() in xe_bo_shrink() under the =
BO
reservation lock before shrinking.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 42a6aa1a2e4a0..0793ed59a90a5 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1454,6 +1454,10 @@ long xe_bo_shrink(struct ttm_operation_ctx *ctx, s=
truct ttm_buffer_object *bo,
>  	if (!xe_bo_eviction_valuable(bo, &place))
>  		return -EBUSY;
> =20
> +	/* Shrinking can free pages without calling xe_bo_move_notify(). */
> +	if (xe_bo_is_xe_bo(bo))
> +		xe_bo_vunmap(xe_bo);

[Severity: High]
Does calling xe_bo_vunmap() here tear down bo->vmap before waiting on the
BO's reservation fences and before the early-exit checks in xe_bo_shrink()?

During xe_pt_update_ops_run(), if a VM_BIND batch has an operation that
stages a page-table update on a page-table BO (for example clearing PTEs in
op 0) and a subsequent operation in the same batch frees that page table (op
1), xe_pt_commit() -> xe_pt_destroy() unpins pt->bo and drops its GEM
refcount to zero via xe_bo_put_deferred() while deferring the final put on
pt_job_ops->deferred until the asynchronous CPU bind job finishes:

drivers/gpu/drm/xe/xe_pt.c:xe_pt_destroy() {
	...
	xe_bo_unpin(pt->bo);
	xe_bo_put_deferred(pt->bo, deferred, &added);
	...
}

While that asynchronous job is still waiting to run, kswapd can run the
second pass of xe_shrinker_walk() with ctx->no_wait_gpu set to false. In th=
at
pass, ttm_bo_shrink_suitable() allows BOs with unsignaled fences into
xe_bo_shrink(), relying on ttm_bo_wait_ctx() inside xe_bo_shrink_purge() or
ttm_bo_shrink() to wait for the reservation fences before reclaiming the BO.

Because xe_bo_vunmap() now runs before xe_bo_shrink_purge() calls
ttm_bo_wait_ctx(), xe_bo_shrink() clears pt_bo->vmap while the CPU bind job
is still in flight and then blocks in ttm_bo_wait_ctx() waiting for that jo=
b.
When run_pt_job() executes xe_cpu_bind_update_pgtables_execute(),
update->pt_bo->vmap is already cleared, hitting the assertion and
dereferencing a NULL mapping pointer in ops->clear():

drivers/gpu/drm/xe/xe_cpu_bind.c:xe_cpu_bind_update_pgtables_execute() {
	...
			xe_assert(vm->xe, !iosys_map_is_null(&update->pt_bo->vmap));

			if (pt_op->bind && !force_clear)
				ops->populate(tile, &update->pt_bo->vmap,
					      update);
			else
				ops->clear(vm, tile, &update->pt_bo->vmap,
					   update);
	...
}

In addition, for live unpinned BOs where xe_bo_get_unless_zero() succeeds,
calling xe_bo_vunmap() at the top of xe_bo_shrink() unmaps bo->vmap even wh=
en
xe_bo_shrink() does not shrink the BO (such as when
xe_pm_runtime_get_if_active() fails and jumps to out_unref, or when
ttm_bo_shrink() returns -EBUSY during the non-writeback pass).

> +
>  	if (!xe_bo_is_xe_bo(bo) || !xe_bo_get_unless_zero(xe_bo))
>  		return xe_bo_shrink_purge(ctx, bo, scanned);
> =20
> @@ -1866,6 +1870,12 @@ static void xe_ttm_bo_release_notify(struct ttm_bu=
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

[Severity: High]
Can an unplug eviction purge the BO's backing pages and resource before
xe_ttm_bo_release_notify() runs __xe_bo_vunmap()?

When a kernel-mapped BO is unpinned during teardown (for example via
xe_bo_unpin_map_no_vm() or xe_pt_destroy()) and the device is unplugged
(such as in xe_device_remove() -> drm_dev_unplug() ->
xe_bo_pci_dev_remove_all() -> ttm_resource_manager_evict_all()), TTM can
evict the BO while holding a ttm_buffer_object kref before the final TTM BO
reference is dropped.

During ttm_bo_evict(), xe_evict_flags() selects purge_placement when the
device is unplugged:

drivers/gpu/drm/xe/xe_bo.c:xe_evict_flags() {
	...
	if (device_unplugged && !tbo->base.dma_buf) {
		*placement =3D purge_placement;
		return;
	}
	...
}

Because purge_placement has num_placement =3D=3D 0, ttm_bo_evict() bypasses
ttm_bo_handle_move_mem(), xe_bo_move(), and xe_bo_move_notify(), and instead
calls ttm_bo_pipeline_gutting() directly:

drivers/gpu/drm/ttm/ttm_bo.c:ttm_bo_evict() {
	...
	if (!placement.num_placement) {
		ret =3D ttm_bo_wait_ctx(bo, ctx);
		if (ret)
			return ret;

		/*
		 * Since we've already synced, this frees backing store
		 * immediately.
		 */
		return ttm_bo_pipeline_gutting(bo);
	}
	...
}

Since ttm_bo_wait_ctx() has just completed, ttm_bo_pipeline_gutting()
immediately calls ttm_tt_unpopulate() and ttm_resource_free() while bo->vmap
and bo->kmap are still active. When the last TTM BO reference is then dropp=
ed
and xe_ttm_bo_release_notify() calls __xe_bo_vunmap() -> ttm_bo_kunmap(), a
single-page cached BO (ttm_bo_map_kmap) will call kunmap(map->page) on a
struct page already freed by ttm_tt_unpopulate(), and multi-page vmap/iomap
BOs retain a dangling mapping to freed pages or IO memory until
release_notify runs. Should xe_evict_flags() also call xe_bo_vunmap() when
selecting purge_placement for an Xe BO?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102094529.7852=
24-1-arvind.yadav@intel.com?part=3D1
