Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D6606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxsk+xG3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7E710E62F;
	Fri, 23 Oct 2026 15:01:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4271210E62F
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:00:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 155B160211;
 Fri, 23 Oct 2026 15:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F581F01825;
 Fri, 23 Oct 2026 15:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792767652;
 bh=O+/BzAgEJ166eTsKKZnPFKUQ4nP0YcwzI5LLbqNgc4M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cxsk+xG3IX+0fbNnHGDF4vji3o1gVsyCVTqAEIJDKMBXJSc3lM4HQ8dRCGIA3milR
 mNvw1hn+ySseoTY3nag0vneDg6QHAtZLJeUueo7/bcFXK9ALeYIO1q1dxCPlCyWCCb
 e6J7Z3TW4aDKOc3BCfv6Dsw3lu9lRFOsd0dcPjzrgjyuvurd9cIsuVx5s44GF4GiMV
 BO1VaL25NdDBPHwiBLfbytUjMno2HKVnTR4slg16Ve4Sc1u0p3RJ8Suy7v5YvgbPc8
 8lDUGg4UfSYqaeS5LTXID1zcVut6Eptwbvzk6YqwozBHoKfrjcgPRWrvFnsZt2KfYx
 kbUhSfalTGMPA==
Message-ID: <sashiko-outbox-182885@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau: idle the channel before destroying an
 engine object via abi16
To: Alex <xnderv@yandex.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261023144219.46478-1-xnderv@yandex.com>
References: <20261023144219.46478-1-xnderv@yandex.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 15:00:52 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/nouveau: race between nouveau_abi16_ioctl_del() and chan->sche=
d jobs
--

commit 4bc27237b92dfdc3db9914229dd5c55e2c5a4d5a
Author: Alex <xnderv@yandex.com>

drm/nouveau: idle the channel before destroying an engine object via abi16

This commit records the owning channel on engine objects created via
nouveau_abi16_ioctl_new() and idles that channel in nouveau_abi16_ioctl_del=
()
before destroying the engine object. When a channel is destroyed first in
nouveau_abi16_chan_fini(), any channel references held by engine objects are
cleared.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/no=
uveau/nouveau_abi16.c
> index edf867c1fdcb0..f130a127d8bb2 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c

[ ... ]

> @@ -788,8 +796,16 @@ nouveau_abi16_ioctl_del(struct nouveau_abi16 *abi16,=
 struct nvif_ioctl_v0 *ioctl
> =20
>  	obj =3D nouveau_abi16_obj_find(abi16, ioctl->object);
>  	if (obj) {
> -		if (obj->type =3D=3D ENGOBJ)
> +		if (obj->type =3D=3D ENGOBJ) {
> +			/* Synchronize with the user channel before destroying the
> +			 * engine object, as the legacy GPUOBJ_FREE path does.  The
> +			 * channel may still have work queued that needs the engine
> +			 * context which is about to be unbound.
> +			 */
> +			if (obj->chan && obj->chan->chan)
> +				nouveau_channel_idle(obj->chan->chan);
>  			nvif_object_dtor(&obj->engobj);
> +		}

[Severity: High]
Can calling nouveau_channel_idle(obj->chan->chan) here race with jobs runni=
ng
on obj->chan->sched when VM_BIND is enabled?

When a client initializes VM_BIND via DRM_IOCTL_NOUVEAU_VM_INIT,
nouveau_abi16_ioctl_channel_alloc() creates a per-channel scheduler in
chan->sched, and DRM_IOCTL_NOUVEAU_EXEC submits jobs to chan->sched->entity.
Those jobs execute nouveau_exec_job_run() asynchronously on drm->sched_wq
without holding cli->mutex:

drivers/gpu/drm/nouveau/nouveau_exec.c:nouveau_exec_job_run() {
	...
	for (i =3D 0; i < exec_job->push.count; i++) {
		struct drm_nouveau_exec_push *p =3D &exec_job->push.s[i];
		bool no_prefetch =3D p->flags & DRM_NOUVEAU_EXEC_PUSH_NO_PREFETCH;

		nvif_chan_gpfifo_push(&chan->chan, p->va, p->va_len, no_prefetch);
	}

	nvif_chan_gpfifo_post(&chan->chan);

	ret =3D nouveau_fence_emit(fence);
	...
}

Meanwhile, nouveau_channel_idle() emits a fence directly onto the channel v=
ia
nouveau_fence_new() -> nouveau_fence_emit():

drivers/gpu/drm/nouveau/nouveau_fence.c:nouveau_fence_emit() {
	...
	if (priv->uevent)
		dma_fence_init(&fence->base, &nouveau_fence_ops_uevent,
			       &fctx->lock, fctx->context, ++fctx->sequence);
	else
		dma_fence_init(&fence->base, &nouveau_fence_ops_legacy,
			       &fctx->lock, fctx->context, ++fctx->sequence);
	kref_get(&fctx->fence_ref);

	ret =3D fctx->emit(fence);
	...
}

Unlike nouveau_abi16_chan_fini(), which stops chan->sched->entity before
idling the channel, calling nouveau_channel_idle() in
nouveau_abi16_ioctl_del() without synchronizing with obj->chan->sched allows
nouveau_fence_emit() and fctx->emit() to run concurrently with
nouveau_exec_job_run(), modifying fctx->sequence, chan->chan.push, and
chan->chan.gpfifo without synchronization.

In addition, if DRM_NOUVEAU_EXEC jobs are still queued in
obj->chan->sched->entity (for example, waiting on in_sync dependencies), th=
ey
will not have been pushed to the hardware ring yet when nouveau_channel_idl=
e()
waits on its fence, so nvif_object_dtor(&obj->engobj) can still unbind the
engine context before those queued jobs run on the GPU.

Should nouveau_abi16_ioctl_del() drain or synchronize with obj->chan->sched
before calling nouveau_channel_idle(obj->chan->chan)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023144219.4647=
8-1-xnderv@yandex.com?part=3D1
