Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD52606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NpJIKDQh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2AC10E634;
	Wed, 28 Oct 2026 13:23:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD5F10E614;
 Wed, 28 Oct 2026 13:23:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C4BE600C8;
 Wed, 28 Oct 2026 13:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7201F01825;
 Wed, 28 Oct 2026 13:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793193803;
 bh=BKPRgqvNzSbVRO7mLpNlY0xvlQKn9KUQyaqJSqSTrzk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NpJIKDQh71bTT+qXIAWeeVbmojAPXIjHOnSe/GMBA5opcglpeM+4ZX/CXik8X7U2U
 OM0yllTN94qGk0fOlcxbKweh1J8Syt2M4vE9M9QT/a/GKcwQpAiWS3oJr4o8TfDSpd
 vEIcnTjop2fMHbCqhe8E6Lc1iQdD8bk/uhldDhPcP0pd8f7pB7w38pWJksS+lhs+If
 3jmebkAK+SMzWVXxK51DwUS4Fu8Va1aooJtLThNzgAu5laFo3ne7pc8hdxYL7HBFGY
 IXKxU6K6nTMXCv9afUJPq8+k3kH4UEoFqcNNQB5RiKb0kXm7ScZ2JXY7ViJs8ZWb8K
 GFFBKlUKDQEFw==
Message-ID: <sashiko-outbox-187909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/xe/ggtt: Cut GGTT initialization from 900 ms to
 37 ms
To: "Daniel Colascione" <dancol@dancol.org>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <87v76m1l9k.fsf@dancol.org>
References: <87v76m1l9k.fsf@dancol.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:23:23 +0000
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
- [High] drm/xe/ggtt: fs_reclaim lock inversion in ggtt_clear_gpu() under g=
gtt->lock
- [Low] drm/xe: missing kernel-parameters.txt entry for xe.ggtt_init_gpu
--

commit ed4c9843bc7f8d6478d283f57c556b54c7d8a262
Author: Daniel Colascione <dancol@dancol.org>

drm/xe/ggtt: Cut GGTT initialization from 900 ms to 37 ms

This patch uses the GPU copy engine to initialize GGTT page tables in batch=
es
via MI_UPDATE_GTT commands on Lunar Lake, deferring the initial GGTT hole
clear to xe_ggtt_init_late() after GuC startup. It also adds the
xe.ggtt_init_gpu module parameter to toggle this behavior.

> diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
> index 9ef2ce743770f..47d12e5e95458 100644
> --- a/drivers/gpu/drm/xe/xe_ggtt.c
> +++ b/drivers/gpu/drm/xe/xe_ggtt.c
[ ... ]
> @@ -456,18 +461,119 @@ ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); =
/* See xe_pci_probe() */
[ ... ]
> +static int ggtt_clear_gpu(struct xe_exec_queue *q, struct xe_bb *bb,
> +			  u64 pte, u64 start, u64 end)
> +{
> +	while (start < end) {
> +		struct xe_sched_job *job;
> +		int err;
> +
> +		bb->len =3D 0;
> +		while (start < end && bb->len < GGTT_INIT_BATCH_DWORDS) {
> +			u32 count =3D min_t(u64, (end - start) >> XE_PTE_SHIFT,
> +					  GGTT_INIT_PTES_PER_PACKET);
> +
> +			bb->cs[bb->len++] =3D MI_UPDATE_GTT | (2 * count);
> +			bb->cs[bb->len++] =3D start;
> +			memset64((u64 *)&bb->cs[bb->len], pte, count);
> +			bb->len +=3D 2 * count;
> +			start +=3D (u64)count << XE_PTE_SHIFT;
> +		}
> +
> +		job =3D xe_bb_create_job(q, bb);
> +		if (IS_ERR(job))
> +			return PTR_ERR(job);
[ ... ]
> +static int xe_ggtt_initial_clear(struct xe_ggtt *ggtt, struct xe_hw_engi=
ne *hwe)
> +{
[ ... ]
> +	/* Preserve boot mappings and exclude allocator changes until completio=
n. */
>  	mutex_lock(&ggtt->lock);
> -	drm_mm_for_each_hole(hole, &ggtt->mm, start, end)
> -		xe_ggtt_clear(ggtt, ggtt->start + start, end - start);
> +	drm_mm_for_each_hole(hole, &ggtt->mm, start, end) {
> +		if (q)
> +			err =3D ggtt_clear_gpu(q, bb, pte, ggtt->start + start, ggtt->start +=
 end);
> +		else
> +			xe_ggtt_clear(ggtt, ggtt->start + start, end - start);
> +		if (err)
> +			goto unlock;
> +	}

[Severity: High]
Does calling ggtt_clear_gpu() while holding ggtt->lock cause an fs_reclaim
lock inversion?

During allocation in xe_ggtt_alloc(), primelockdep() in
drivers/gpu/drm/xe/xe_ggtt.c establishes the ordering fs_reclaim ->
ggtt->lock because BO destruction during memory reclaim acquires ggtt->lock:

    static void primelockdep(struct xe_ggtt *ggtt)
    {
        if (!IS_ENABLED(CONFIG_LOCKDEP))
            return;

        fs_reclaim_acquire(GFP_KERNEL);
        might_lock(&ggtt->lock);
        fs_reclaim_release(GFP_KERNEL);
    }

However, on Lunar Lake with xe.ggtt_init_gpu enabled,
gt_init_with_all_forcewake() -> xe_ggtt_init_late() -> xe_ggtt_initial_clea=
r()
acquires ggtt->lock and calls ggtt_clear_gpu(), which invokes
xe_bb_create_job() -> __xe_bb_create_job() -> xe_sched_job_create().

Inside xe_sched_job_create(), several GFP_KERNEL allocations occur under
ggtt->lock, including job_alloc() in drivers/gpu/drm/xe/xe_sched_job.c:

    static struct xe_sched_job *job_alloc(bool parallel)
    {
        return kmem_cache_zalloc(parallel ? xe_sched_job_parallel_slab :
                                 xe_sched_job_slab, GFP_KERNEL);
    }

as well as drm_sched_job_init() and xe_lrc_alloc_seqno_fence() ->
xe_hw_fence_alloc() -> fence_alloc() in drivers/gpu/drm/xe/xe_hw_fence.c:

    return kmem_cache_zalloc(xe_hw_fence_slab, GFP_KERNEL);

Wouldn't this violate the fs_reclaim -> ggtt->lock hierarchy, triggering a
lockdep circular locking warning under CONFIG_PROVE_LOCKING during probe and
risking a reclaim deadlock if direct reclaim attempts to free a GGTT-mapped
BO?

> diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_modul=
e.c
> index 897724cb5cfb8..44cc0107cf53a 100644
> --- a/drivers/gpu/drm/xe/xe_module.c
> +++ b/drivers/gpu/drm/xe/xe_module.c
> @@ -22,6 +22,7 @@
>  #include "xe_sched_job.h"
> =20
>  struct xe_modparam xe_modparam =3D {
> +	.ggtt_init_gpu =3D		true,
>  	.probe_display =3D	XE_DEFAULT_PROBE_DISPLAY,
>  	.guc_log_level =3D	XE_DEFAULT_GUC_LOG_LEVEL,
>  	.force_probe =3D		XE_DEFAULT_FORCE_PROBE,
> @@ -34,6 +35,10 @@ struct xe_modparam xe_modparam =3D {
>  	/* the rest are 0 by default */
>  };
> =20
> +module_param_named(ggtt_init_gpu, xe_modparam.ggtt_init_gpu, bool, 0444);
> +MODULE_PARM_DESC(ggtt_init_gpu,
> +		 "GPU GGTT initialization on Lunar Lake (default: true)");

[Severity: Low]
Should this new xe.ggtt_init_gpu module parameter also be documented in
Documentation/admin-guide/kernel-parameters.txt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/87v76m1l9k.fsf@danc=
ol.org?part=3D1
