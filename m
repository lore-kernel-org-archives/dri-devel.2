Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C7606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTvZkA38
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4408C11233A;
	Thu, 29 Oct 2026 14:25:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6798011233A
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:25:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A16A60210;
 Thu, 29 Oct 2026 14:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E431F01825;
 Thu, 29 Oct 2026 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793283915;
 bh=7xhPuH0RIwbK9c9aflak+/btPEP3Gf0e4n3aG4R6W2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WTvZkA38ip5BV5HMgXNUd4kIvrMs3V1f+C5dKjB/zI4W898P5WeOYqQhBtGHf2Pw1
 WaQwCrFpE+BeIhYoeay6vsqmDKpbI6QcjEEAeVMbHFxGmIfESuZnYh/sl1HFJ9pAwc
 Hqj+YwfM0oyGoc5c1VSqHc4AH4FmcsFNC59N4ptjgH41GksgW9B9CReDZ6uM+Qt6Zg
 Dgi9OteiL7KxO8aESLQku+U0aTLmu7Eo0Zi4Jnh2gkx0L0LWu0GPDzYnuwNjBE7PF9
 ZMztvgb4wTF3rRUV5VeBwElmQ/Hevj+mO/5L+gGTAXwpZQmQfyzLt8reKIonfqEFt1
 +ZLP1EFd1nJgA==
Message-ID: <sashiko-outbox-189510@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 10/14] drm/msm: Add LPAC submitqueue
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-10-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-10-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:25:14 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/msm: memory leak of queue in msm_submitqueue_create() when rin=
g is NULL
- [High] drm/msm: broken GPU hang recovery and hangcheck for LPAC ring
- [Medium] drm/msm/a6xx: mismatched always-on counter for LPAC in a7xx_subm=
it()
- [Low] drm/msm/a6xx: unused variable timestamp_iova in a7xx_submit()
--

commit b513ca2d3a9d2c681ec6e6cf4dcbe0f4500714aa
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

drm/msm: Add LPAC submitqueue

This commit adds the MSM_SUBMITQUEUE_LPAC UAPI flag and driver support
for creating LPAC submitqueues and dispatching submissions to the LPAC
ringbuffer.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index e7bc12de650ca..e82d0c0bc10ff 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
[ ... ]
> @@ -493,7 +498,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct =
msm_gem_submit *submit)
>  	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
>  	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
>  	struct msm_ringbuffer *ring =3D submit->ring;
> -	u32 rbbm_perfctr_cp0, cp_always_on_context;
> +	u32 rbbm_perfctr_cp0, cp_always_on_context,
> +	    cp_always_on_counter;
> +	bool is_lpac =3D ring =3D=3D gpu->lpac_rb;
> +	u64 timestamp_iova;

[Severity: Low]
Is timestamp_iova needed in a7xx_submit()? It appears to be unused, which
triggers an unused-variable warning at build time (and breaks the build
when CONFIG_WERROR is enabled).

>  	unsigned int i, ibs =3D 0;
> =20
>  	adreno_check_and_reenable_stall(adreno_gpu);
> @@ -511,19 +519,24 @@ static void a7xx_submit(struct msm_gpu *gpu, struct=
 msm_gem_submit *submit)
>  	 * If preemption is enabled, then set the pseudo register for the save
>  	 * sequence
>  	 */
> -	if (gpu->nr_rings > 1)
> +	if (gpu->nr_rings > 1 && !is_lpac)
>  		a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, submit->queue);
> =20
>  	if (adreno_is_a8xx(adreno_gpu)) {
>  		rbbm_perfctr_cp0 =3D REG_A8XX_RBBM_PERFCTR_CP(0);
>  		cp_always_on_context =3D REG_A8XX_CP_ALWAYS_ON_CONTEXT;
> +		cp_always_on_counter =3D REG_A8XX_CP_ALWAYS_ON_COUNTER;
>  	} else {
>  		rbbm_perfctr_cp0 =3D REG_A7XX_RBBM_PERFCTR_CP(0);
>  		cp_always_on_context =3D REG_A6XX_CP_ALWAYS_ON_CONTEXT;
> +		cp_always_on_counter =3D REG_A6XX_CP_ALWAYS_ON_COUNTER;
>  	}
> =20
>  	get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, c=
pcycles_start));
> -	get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, inde=
x, alwayson_start));
> +	if (is_lpac)
> +		get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ring, ind=
ex, alwayson_start));
> +	else
> +		get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, ind=
ex, alwayson_start));

[Severity: Medium]
Should the corresponding alwayson_end sample in a7xx_submit() also use
cp_always_on_counter when is_lpac is true?

After emitting the IB commands, a7xx_submit() still unconditionally
reads cp_always_on_context:

    get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, c=
pcycles_end));
    get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, inde=
x, alwayson_end));

When retire_submit() later computes:

    elapsed =3D (stats->alwayson_end - stats->alwayson_start) * 10000;

for an LPAC submission, it will subtract CP_ALWAYS_ON_COUNTER from
CP_ALWAYS_ON_CONTEXT, corrupting the per-submit elapsed time,
ctx->elapsed_ns, and frequency statistics.

[ ... ]
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index aa3d6ff456fda..4244d9324cda7 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -537,8 +537,8 @@ static void recover_worker(struct kthread_work *work)
>  	 * needs to happen after msm_rd_dump_submit() to ensure that the
>  	 * bo's referenced by the offending submit are still around.
>  	 */
> -	for (i =3D 0; i < gpu->nr_rings; i++) {
> -		struct msm_ringbuffer *ring =3D gpu->rb[i];
> +	for (i =3D 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
> +		struct msm_ringbuffer *ring =3D i < gpu->nr_rings ? gpu->rb[i] : gpu->=
lpac_rb;
> =20
>  		uint32_t fence =3D ring->memptrs->fence;
> =20
> @@ -561,8 +561,8 @@ static void recover_worker(struct kthread_work *work)
>  	 * Replay all remaining submits starting with highest priority
>  	 * ring
>  	 */
> -	for (i =3D 0; i < gpu->nr_rings; i++) {
> -		struct msm_ringbuffer *ring =3D gpu->rb[i];
> +	for (i =3D 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
> +		struct msm_ringbuffer *ring =3D i < gpu->nr_rings ? gpu->rb[i] : gpu->=
lpac_rb;
>  		unsigned long flags;
> =20
>  		spin_lock_irqsave(&ring->submit_lock, flags);

[Severity: High]
How does recover_worker() handle a hang or fault originating on
gpu->lpac_rb?

At the start of recover_worker(), cur_ring is looked up via
gpu->funcs->active_ring(gpu) (a6xx_active_ring()), which returns
a6xx_gpu->cur_ring:

    struct msm_ringbuffer *cur_ring =3D gpu->funcs->active_ring(gpu);
    ...
    submit =3D find_submit(cur_ring, cur_ring->memptrs->fence + 1);
    if (!submit)
        goto out_unlock;

Because a6xx_gpu->cur_ring only tracks the 3D rings (gpu->rb[]) and is
never set to gpu->lpac_rb, two things can go wrong when an LPAC
submission triggers a6xx_fault_detect_irq() or a7xx_sw_fuse_violation_irq():

1. If cur_ring is idle, find_submit(cur_ring, ...) returns NULL and
recover_worker() bails out via goto out_unlock without running
gpu->funcs->recover(gpu), after a6xx_fault_detect_irq() has already
written 0 to REG_A6XX_RBBM_INT_0_MASK, leaving GPU interrupts disabled.

2. If cur_ring has an unrelated 3D submit in flight, recover_worker()
attributes the fault to that 3D submit, marks its VM unusable, and in
the fence update loop:

    if (ring =3D=3D cur_ring)
        ring->memptrs->fence =3D ++fence;

advances cur_ring->memptrs->fence while leaving
gpu->lpac_rb->memptrs->fence unadvanced, so the replay loop re-submits
the hung LPAC job.

Similarly, hangcheck_handler() only checks gpu->funcs->active_ring(gpu),
and in a6xx_irq():

    if (priv->disable_err_irq)
        status &=3D A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;

A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS_LPAC is masked out when
disable_err_irq is set, dropping LPAC completion interrupts.

> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/=
msm_submitqueue.c
> index 1a5a77b280163..a0249430bd005 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
[ ... ]
> @@ -209,6 +210,16 @@ int msm_submitqueue_create(struct drm_device *drm, s=
truct msm_context *ctx,
>  			return ret;
> =20
>  		queue =3D kzalloc_obj(*queue);
> +
> +		if (flags & MSM_SUBMITQUEUE_LPAC) {
> +			ring_nr =3D priv->gpu->nr_rings;
> +			ring =3D priv->gpu->lpac_rb;
> +		} else {
> +			ring =3D priv->gpu->rb[ring_nr];
> +		}
> +
> +		if (!ring)
> +			return -EINVAL;
>  	}

[Severity: High]
Does msm_submitqueue_create() leak queue when ring is NULL?

In the non-MSM_SUBMITQUEUE_VM_BIND path (reachable from userspace via
DRM_IOCTL_MSM_SUBMITQUEUE_NEW -> msm_ioctl_submitqueue_new()), queue is
allocated with kzalloc_obj(*queue) before checking whether ring is
non-NULL. If userspace passes MSM_SUBMITQUEUE_LPAC on a GPU where
priv->gpu->lpac_rb is NULL, returning -EINVAL here leaks queue (and if
kzalloc_obj() also returned NULL, checking !ring before !queue returns
-EINVAL instead of -ENOMEM). Should the ring lookup and !ring check happen
before allocating queue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-descriptiv=
e-name-lpac-upstream-v2-0-a21a5c850961@gmail.com?part=3D10
