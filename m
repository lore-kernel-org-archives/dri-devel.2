Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8EF60B504A
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pyjb+QGW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9417910E191;
	Mon, 19 Oct 2026 15:27:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFE510E191
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:27:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33D10601FD
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E961F000C4;
 Mon, 19 Oct 2026 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792423626;
 bh=tOhuzu1m7XMfiB5/eOVoMrVRywP28MoHd/l0L/s6SRM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pyjb+QGWPV07cScxPWIRsLnjFQ6qhW0NGEXwofHd+iYoz1f9y84brIUqDG/r2ozdP
 HRTtfp53eEckO3VaMNWT/xorjNEvSDOojSv2wMMUckPR/9MO84pKs1uP1bDCdaL1Ra
 Xkbw+JOmCJ0jcw6eJmWDfYy5fnwor0W8f+ujv9g9gVQanxB73midmg5QXCoq1LWQLM
 YTQJ7a5y0e+YBsk3r4LAF0caKejaxwcDNIjXjGASMob5PqSshMsQTieXF6UriYXT+A
 Hf2IFyMzPzW4PpadjjJBsQNBEFkVVRpvMKbl63g2QlXIbMxUkDNxpUd7KCEx1Ybqt0
 et2+11NdskrcA==
Message-ID: <sashiko-outbox-177726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/msm: Fix barriers accessing ctx vm
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-460-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-460-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:27:06 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm: missing smp_load_acquire() when reading ctx->vm in msm_ge=
m_close()
--

commit 8eb807a6c2ff148154f2d8bde5de68d598d4c695
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Fix barriers accessing ctx vm

This commit adds smp_load_acquire() and smp_store_release() barriers to
msm_context_vm() to prevent concurrent callers from observing a partially
initialized struct drm_gpuvm when ctx->vm is lazily created.

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index c2a8aaa33f84a..8094e5e7e9a54 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -226,18 +226,19 @@ struct drm_gpuvm *msm_context_vm(struct drm_device =
*dev, struct msm_context *ctx
>  {
>  	static DEFINE_MUTEX(init_lock);
>  	struct msm_drm_private *priv =3D dev->dev_private;
> +	struct drm_gpuvm *vm =3D smp_load_acquire(&ctx->vm);
> =20
>  	/* Once ctx->vm is created it is valid for the lifetime of the context:=
 */
> -	if (ctx->vm)
> -		return ctx->vm;
> +	if (vm)
> +		return vm;
> +
> +	guard(mutex)(&init_lock);
> =20
> -	mutex_lock(&init_lock);
>  	if (!ctx->vm) {
> -		ctx->vm =3D msm_gpu_create_private_vm(
> +		vm =3D msm_gpu_create_private_vm(
>  			priv->gpu, current, !ctx->userspace_managed_vm);
> -
> +		smp_store_release(&ctx->vm, vm);
>  	}
> -	mutex_unlock(&init_lock);
> =20
>  	return ctx->vm;
>  }

[Severity: High]
Does msm_gem_close() also need smp_load_acquire() to pair with this
smp_store_release(&ctx->vm, vm)?

When a process creates a GEM handle via msm_ioctl_gem_new() ->
msm_gem_new_handle() without MSM_BO_NO_SHARE, ctx->vm can still be NULL. If
one thread then triggers lazy VM creation via msm_context_vm() (for example
through msm_ioctl_gem_info_iova()) while another thread closes the GEM hand=
le
via drm_gem_handle_delete() -> drm_gem_object_release_handle() ->
msm_gem_close(), msm_gem_close() intentionally avoids calling msm_context_v=
m()
and reads ctx->vm directly without holding init_lock:

drivers/gpu/drm/msm/msm_gem.c:msm_gem_close() {
	...
	if (!ctx->vm)
		return;

	if (msm_context_is_vmbind(ctx))
		return;

	dma_resv_wait_timeout(obj->resv, DMA_RESV_USAGE_BOOKKEEP, false,
			      MAX_SCHEDULE_TIMEOUT);

	msm_gem_lock_vm_and_obj(&exec, obj, ctx->vm);
	put_iova_spaces(obj, ctx->vm, true, "close");
	drm_exec_fini(&exec);     /* drop locks */
}

Without smp_load_acquire(&ctx->vm) in msm_gem_close(), could a weakly-order=
ed
architecture observe a non-NULL ctx->vm pointer before the initialization
stores to the VM (such as vm->r_obj and its dma_resv lock initialized in
msm_gem_vm_create()) become visible when msm_gem_lock_vm_and_obj() and
put_iova_spaces() dereference it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-460-sashal@kernel.org?part=3D1
