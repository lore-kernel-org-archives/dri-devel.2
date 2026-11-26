Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C2606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=in+7UJLS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D14811258D;
	Thu, 26 Nov 2026 15:59:20 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC0211250E;
 Thu, 26 Nov 2026 15:59:14 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jb1SZ4kxpzKnxv;
 Thu, 26 Nov 2026 16:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795708750; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8RDHQecOSvwkPFk9Qkk7oLr1trdZz2TmN5Aaxweh42U=;
 b=in+7UJLSMG+SYjQ+AIIzDRvyho/J/dToB6rcSjjaertddvlnYx4fTYyhiMBLmE5bStqzpb
 b0hwkoybTK9GVvDA5Vt4cpObM6OWyzHS707D+J5ngblDxe+Zi6VySQfsNww/D08mg9uj+m
 VQpNyc5JEDWJ6dBLY5pp+ybP86mvat+2sFOLSBKuSnKUbFWQEeFUEPCYSBRMbmsRvlsR3v
 uGOiPgqqix9AXiyMlmNZSGpcNXWJDo0xfKbqKa4x577kj33mVaJvNWGmHVBmmlXS+xChSp
 cxCWcJ/Qt7Z6dkCEU2hJKylRFX34O+68nrw1znNpp02A8SjAjgKEEywoEsVrJw==
Message-ID: <f4c37f8d72c545dde2111bb8a3038ac05228800e.camel@mailbox.org>
Subject: Re: [RFC] drm/sched: Track sched fence scheduled and finished time
 directly
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
 amd-gfx@lists.freedesktop.org
Date: Thu, 26 Nov 2026 16:59:07 +0100
In-Reply-To: <20261126154200.71180-1-tvrtko.ursulin@igalia.com>
References: <20261126154200.71180-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: seb7bb6pmmz4mffau7cnssenfn71kigq
X-MBO-RS-ID: 0055c6263bf2eb29fe1
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
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-26 at 15:42 +0000, Tvrtko Ursulin wrote:
> Philipp reports the current usage of overwriting the dma-fence timestamp
> from the free_job worker is racy and unsafe due missing memory ordering
> and especially with drivers which use own unordered submit workqueue for
> the scheduler. Consider also that the timestamp field is the union in the
> dma-fence object.

Yeah, the union thing is also something I realized during the last
days. If that should ever be read misordered it would blow up the
entire scheduling algorithm because the fence's callback-list pointer
would be interpreted as a timestamp=E2=80=A6

> On top of these serious issue there is also a smaller problem where the
> said race can cause GPU time overaccounting.
>=20
> Lets try and solve all issues in one swoop by stopping messing with
> dma-fence internals and just track what we want in our own derived fence
> object.
>=20
> We care about fence submit and finish times and by adding a dedicated
> lock to manage them we can safely access both and adjust the former
> without any races.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> References: https://lore.kernel.org/dri-devel/20261119131830.2535266-2-ph=
asta@kernel.org/

After this thread, I started investigating timestamp-ordering in fence.
I have ideas how we might fix it and have started preparing patches,
also one that would touch the scheduler. But yours here seems to do
more of the heavy lifting.

> References: https://lore.kernel.org/dri-devel/20261117094324.8256-1-tvrtk=
o.ursulin@igalia.com/
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: amd-gfx@lists.freedesktop.org
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c=C2=A0=C2=A0=C2=A0 | 15 ++++=
----
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c=C2=A0=C2=A0 |=C2=A0 6 ++--
> =C2=A0drivers/gpu/drm/scheduler/sched_fence.c=C2=A0=C2=A0=C2=A0 | 20 ++++=
+++++--
> =C2=A0drivers/gpu/drm/scheduler/sched_internal.h | 41 +++++++++++++++++++=
+++
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 8 ++---
> =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 39 ++++++++++++++++++=
++
> =C2=A06 files changed, 113 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index 2f0349233695..1a6985283acc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -171,21 +171,20 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct a=
mdgpu_ctx *ctx, u32 hw_ip)
> =C2=A0static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
> =C2=A0{
> =C2=A0	struct drm_sched_fence *s_fence;
> +	ktime_t start, end;
> =C2=A0
> =C2=A0	if (!fence)
> =C2=A0		return ns_to_ktime(0);
> =C2=A0
> -	/* When the fence is not even scheduled it can't have spend time */
> =C2=A0	s_fence =3D to_drm_sched_fence(fence);
> -	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
> -		return ns_to_ktime(0);
> +	drm_sched_fence_get_times(s_fence, &start, &end);
> +
> +	/* When the fence is not even scheduled it can't have spend time */
> +	if (!start)
> +		return start;
> =C2=A0
> =C2=A0	/* When it is still running account how much already spend */
> -	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
> -		return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
> -
> -	return ktime_sub(s_fence->finished.timestamp,
> -			 s_fence->scheduled.timestamp);
> +	return ktime_sub(end ?: ktime_get(), start);

That's also a sequence I worked on.

First I wanted to fully lock dma_fence_timestamp() and use it here.

But guess what, I then couldn't use it because amdgpu_ctx_fence_time()
is called under fctx lock, which is the same as the fence lock ->
deadlock.

[=E2=80=A6]

> =C2=A0void drm_sched_fence_scheduled(struct drm_sched_fence *fence,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *parent)
> =C2=A0{
> +	ktime_t now =3D ktime_get();
> +	unsigned long flags;
> +
> =C2=A0	/* Set the parent before signaling the scheduled fence, such that,
> =C2=A0	 * any waiter expecting the parent to be filled after the job has
> =C2=A0	 * been scheduled (which is the case for drivers delegating waits
> @@ -74,14 +77,26 @@ void drm_sched_fence_scheduled(struct drm_sched_fence=
 *fence,
> =C2=A0	if (!IS_ERR_OR_NULL(parent))
> =C2=A0		drm_sched_fence_set_parent(fence, parent);
> =C2=A0
> -	dma_fence_signal(&fence->scheduled);
> +	spin_lock_irqsave(&fence->ts_lock, flags);
> +	fence->start_ts =3D now;
> +	spin_unlock_irqrestore(&fence->ts_lock, flags);

I get what you are doing here. I think it'll work, and also it's
partially necessary because we should not overwrite a dma_fence's
timestamp.

Nevertheless, it seems that you don't use dma_fence_timestamp() at all
anymore. Not even in amdgpu above.

So we are then tempted to wonder what dma_fence->timestamp is even good
for anymore, and if we're running danger of re-implementing parts of
the fence functionality in sched_fence?

Christian?

> +
> +	dma_fence_signal_timestamp(&fence->scheduled, now);

You write the fence timestamp, but it seems it's not read anymore since
sched_fence now does that? IOW, whom are you setting the timestamp for,
who will ever evaluate it who shouldn't instead evaluate the time
stamps of sched_fence?

> =C2=A0}
> =C2=A0
> =C2=A0void drm_sched_fence_finished(struct drm_sched_fence *fence, int re=
sult)
> =C2=A0{
> +	ktime_t now =3D ktime_get();
> +	unsigned long flags;
> +
> =C2=A0	if (result)
> =C2=A0		dma_fence_set_error(&fence->finished, result);
> -	dma_fence_signal(&fence->finished);
> +
> +	spin_lock_irqsave(&fence->ts_lock, flags);
> +	fence->finished_ts =3D now;
> +	spin_unlock_irqrestore(&fence->ts_lock, flags);
> +
> +	dma_fence_signal_timestamp(&fence->finished, now);

input from Christian will be needed; just recently we were envisioning
to reduce the number of signal-functions.

If you can wait a few days I would also like to present an RFC for the
memory ordering in dma_fence_timestamp().


P.
