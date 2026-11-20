Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568E606A33E
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki99Kswl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC1C10E525;
	Fri, 20 Nov 2026 21:41:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC6110E525
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 21:41:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EEF3404DC;
 Fri, 20 Nov 2026 21:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4E71F000C4;
 Fri, 20 Nov 2026 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795210890;
 bh=UyqqcjfyE4l4dWgBhS3dxX6/l47sjHvgsDeKxfEj1nQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Ki99KswlXtoq2B2MZRkW2Yt92J+6pBV1fbYzAWrTJqXAzn6XuoESM+7pPX2552SMh
 Teh5L3evK0eWx2XTBOljTjxz5Hfm9awgzMYAWQ9LbnguvFjs2CudcuIJkhasV3HvIc
 39Qh/AXf8yobrEIBEDot3UVDzsbbKLXWU80rUSmi1sVBijdu+g7/LuvCcNqaqcClDc
 dyH75AmktH7eEyzp+tMNvmREuOYOIvbDXvUKP8sffKpq6pmbMpNJSQTW/+rY5eLGKS
 1hzGK1FpwGm5MFkP/RWd77CpDZcYWi2Ta/UhlqqDGglGg8Hicj0/G1J8sTvBOhNICr
 lj/5oXJxuRBTQ==
Message-ID: <sashiko-outbox-226206@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] drm/vmwgfx: Reserve ttm object before resv usage
To: "Maaz Mombasawala" <maaz.mombasawala@broadcom.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261120212332.2025335-1-maaz.mombasawala@broadcom.com>
References: <20261120212332.2025335-1-maaz.mombasawala@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:41:30 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/vmwgfx: race and NULL deref on guest_memory_bo in
  crc_generate_worker()
- [Medium] drm/vmwgfx: crc_generate_worker() clears res_dirty in
  vmw_resource_unreserve()
--

commit 0a12649f28f55fc0f97ac247d686a2212c714dd0
Author: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

drm/vmwgfx: Reserve ttm object before resv usage

This commit reserves the surface resource under cmdbuf_mutex and reserves
its backing guest_memory_bo before computing the CRC in
crc_generate_worker().

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_vkms.c
> index 3d0d5dfa869f9..8ca8632b97eae 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> @@ -114,6 +114,7 @@ crc_generate_worker(struct work_struct *work)
>  	u64 frame_start, frame_end;
>  	u32 crc32 =3D 0;
>  	struct vmw_surface *surf =3D 0;
> +	bool valid_crc =3D false;
> =20
>  	spin_lock_irq(&du->vkms.crc_state_lock);
>  	crc_pending =3D du->vkms.crc_pending;
> @@ -131,6 +132,7 @@ crc_generate_worker(struct work_struct *work)
>  	spin_unlock_irq(&du->vkms.crc_state_lock);
> =20
>  	if (surf) {
> +		int ret;
>  		if (vmw_surface_sync(vmw, surf)) {
>  			drm_warn(
>  				crtc->dev,
> @@ -138,10 +140,35 @@ crc_generate_worker(struct work_struct *work)
>  			return;
>  		}
> =20
> -		compute_crc(crtc, surf, &crc32);
> +		if (surf->res.guest_memory_bo) {
> +			struct vmw_resource *res =3D &surf->res;
> +
> +			mutex_lock(&res->dev_priv->cmdbuf_mutex);
> +			ret =3D vmw_resource_reserve(res, false, true);
> +			if (ret !=3D 0)
> +				goto no_res_reserve;
> +			ret =3D ttm_bo_reserve(&res->guest_memory_bo->tbo, false,
> +					     false, NULL);

[Severity: High]
Can surf->res.guest_memory_bo still become NULL or be mid-teardown when
crc_generate_worker() reserves and maps it?

For dumb buffers, vmw_dumb_create() drops the surface's GEM reference on
vbo, leaving surf->res.guest_memory_bo as an unreferenced pointer that
vmw_bo_free() clears under cmdbuf_mutex when the last GEM reference is
dropped.  Checking surf->res.guest_memory_bo before acquiring
cmdbuf_mutex without re-checking it after locking leaves a race with
vmw_bo_free():

CPU0                                  CPU1 (kworker)
ttm_bo_release()
  ...
  vmw_bo_free()
                                      crc_generate_worker()
                                        if (surf->res.guest_memory_bo)
    mutex_lock(&cmdbuf_mutex)
    res->guest_memory_bo =3D NULL
    mutex_unlock(&cmdbuf_mutex)
    kfree(vbo)
                                        mutex_lock(&cmdbuf_mutex)
                                        vmw_resource_reserve(res, false, tr=
ue)
                                        ttm_bo_reserve(&res->guest_memory_b=
o->tbo, ...)
                                          <-- NULL pointer dereference

Even if surf->res.guest_memory_bo is checked under cmdbuf_mutex,
ttm_bo_release() calls ttm_bo_cleanup_memtype_use() (which frees
bo->resource and sets it to NULL) and unlocks bo->base.resv before
calling bo->destroy (vmw_bo_free()).  If crc_generate_worker() takes
cmdbuf_mutex after ttm_bo_cleanup_memtype_use() unlocks bo->base.resv
but before vmw_bo_free() takes cmdbuf_mutex, ttm_bo_reserve() succeeds on
the dying BO and compute_crc() -> vmw_bo_map_and_cache() -> ttm_bo_kmap()
dereferences a NULL bo->resource.

In addition, vmw_surface_sync() is called just above without holding
cmdbuf_mutex or reserving surf->res, and it unconditionally dereferences
surf->res.guest_memory_bo in ttm_bo_reserve(&bo->tbo, ...).

> +			if (ret !=3D 0) {
> +				drm_warn(&vmw->drm, "%s: failed reserve\n",
> +					 __func__);
> +				goto no_tbo_reserve;
> +			}
> +			compute_crc(crtc, surf, &crc32);
> +			valid_crc =3D true;
> +			ttm_bo_unreserve(&res->guest_memory_bo->tbo);
> +no_tbo_reserve:
> +			vmw_resource_unreserve(res, true, false, false, NULL,
> +					       0);

[Severity: Medium]
Should dirty_set be false in vmw_resource_unreserve() here?

Passing dirty_set =3D true and dirty =3D false unconditionally clears
res->res_dirty, including on the no_tbo_reserve error path or if the
resource was dirtied after vmw_surface_sync() ran outside cmdbuf_mutex,
which can cause later clean or eviction paths to skip reading back dirty
GPU surface data to the guest memory buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120212332.2025=
335-1-maaz.mombasawala@broadcom.com?part=3D1
