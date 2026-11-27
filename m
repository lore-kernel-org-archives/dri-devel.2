Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71297606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIUwOYBO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12C510E470;
	Fri, 27 Nov 2026 11:45:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA74410E470;
 Fri, 27 Nov 2026 11:45:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5F6062A13;
 Fri, 27 Nov 2026 11:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C391F0089A;
 Fri, 27 Nov 2026 11:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795779946;
 bh=bjscMvn08cu5vuibkkmXhFX9YHaCU1LmqOCXviWhHmc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XIUwOYBO2xm+Au/+5WP0D6JcQ0JMk34TF192wzqhQR+I+mActigaEJoz5iz4oEOQ3
 YLHTRZkG57cy/mWOEeu+55aEqfClW40Z/VYakzUZ2wqOYK2LPIfHZJFnQek/tYcM8V
 RNyHVb0Y5yuM1YSvCCopY0/W7Y6OllATAbL4M/DR+Qm/V9+1Swskc10BLI1nyttIje
 iywhJIhiWKzZMcB+imyK+lpSRXHsAeQc4JiBASK7i5QyvjUD6KBz2Gcx2EbJAY3Zw6
 KtySwWJpbPGjVfxHIiypBDzJPdjMfKcqJ7CsE8pT3UeDWCpk6R95ghm6zOr+eem7Dc
 /BKWa8SAcun+Q==
Message-ID: <sashiko-outbox-237273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC v2] drm/sched: Track sched fence scheduled and finished
 time directly
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20261127112818.79237-1-tvrtko.ursulin@igalia.com>
References: <20261126154200.71180-1-tvrtko.ursulin@igalia.com>
 <20261127112818.79237-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 11:45:45 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/sched: skipped start_ts update in
  drm_sched_fence_advance_start_time()
--

commit 8d03d09146f11c7c74e02c09d184c1146771b9ad
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/sched: Track sched fence scheduled and finished time directly

This commit adds dedicated start_ts and finished_ts fields protected by
ts_lock to struct drm_sched_fence so that scheduled and finished
timestamps can be tracked and adjusted without modifying dma_fence
internals directly.

> diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm=
/scheduler/sched_internal.h
> index 32d3ddb820be6..b24bb1d7d4893 100644
> --- a/drivers/gpu/drm/scheduler/sched_internal.h
> +++ b/drivers/gpu/drm/scheduler/sched_internal.h
> @@ -67,6 +67,45 @@ void drm_sched_fence_scheduled(struct drm_sched_fence =
*fence,
>  			       struct dma_fence *parent);
>  void drm_sched_fence_finished(struct drm_sched_fence *fence, int result);
> =20
> +/**
> + * drm_sched_fence_advance_start_time - Advance scheduler fence schedule=
d timestamp
> + * @fence: scheduler fence
> + * @t: time to advance to
> + *
> + * Advances the scheduler fence scheduled time to @t if the fence has al=
ready
> + * been scheduled with an older timestamp.
> + */
> +static inline void
> +drm_sched_fence_advance_start_time(struct drm_sched_fence *fence, ktime_=
t t)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fence->ts_lock, flags);
> +	if (fence->start_ts && !fence->finished_ts &&
> +	    ktime_after(t, fence->start_ts))
> +		fence->start_ts =3D t;
> +	spin_unlock_irqrestore(&fence->ts_lock, flags);
> +}

[Severity: Medium]
Does checking !fence->finished_ts here prevent start_ts from being
advanced when multiple pipelined jobs complete before work_free_job
runs?

drm_sched_job_done_cb() runs in interrupt context when the parent fence
signals and calls drm_sched_fence_finished(), setting finished_ts
immediately and queueing work_free_job.  If a second job on pending_list
also completes before the worker calls drm_sched_get_finished_job() for
the first job, next->s_fence->finished_ts is already non-zero.
drm_sched_fence_advance_start_time() then leaves next->s_fence->start_ts
at its ring-submission timestamp, causing
drm_sched_entity_stats_job_add_gpu_time() and amdgpu_ctx_fence_time() to
overaccount GPU time across completed batches.

Should this check that fence->finished_ts is either zero or not before t
(e.g. !fence->finished_ts || !ktime_after(t, fence->finished_ts))
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127112818.7923=
7-1-tvrtko.ursulin@igalia.com?part=3D1
