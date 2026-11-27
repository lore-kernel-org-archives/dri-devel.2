Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C44606A704
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+rWz7fN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C08112B22;
	Fri, 27 Nov 2026 14:30:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB05112B25
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:30:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95B5445639;
 Fri, 27 Nov 2026 14:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F721F00A02;
 Fri, 27 Nov 2026 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795789836;
 bh=6uEJdRpzIecL7B4T/UaaujAOtHBrEgeZYaX/LhI1YXU=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=U+rWz7fNUZwT5gY0YEv0D4tQd0m3mK/TP7Y2N7Z5IA3moxhkpnGklUpPp6K9cWxWN
 wlHsiVgrD5fuXkq3Kc6u/ELaQ6WvUJ1bkHQwvCAY+jyTrghXHhA/+4auSEzI9SLD0R
 3R5XZxp24Tv/X81w9Cn3abgOdgb4Di7NNcwgTi9unYRMQ48HBy5rWws9BYS2a+Zgve
 BH74a2nmlrFD8+LlvzKUGX/CUhA1RT7IUbTdw7SzOz2btgg+Whvv4Mdr5v1ofw3LPF
 aRJgC3w0KyHUDT3R+CDsXbWUKopKw8LFYeGCyxtg6unkbQrEfY7jOyNhsYsXDuFcHk
 GatBj7AbhIa5Q==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 15:30:33 +0100
Message-Id: <DN62D8GGT0NN.1YHSKVVC6M67B@kernel.org>
Cc: "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, "Tvrtko Ursulin"
 <tvrtko.ursulin@igalia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
To: "Philipp Stanner" <phasta@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm/sched: Document reclaim restrictions for
 ops->prepare_job()
References: <20261127142425.2956053-3-phasta@kernel.org>
In-Reply-To: <20261127142425.2956053-3-phasta@kernel.org>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 27, 2026 at 3:24 PM CET, Philipp Stanner wrote:
> drm_sched_backend_ops->prepare_job() gets called from
> drm_sched_entity_pop_job(). Thus, it's in the fence critical path where
> a memory reclaim might wait for the job / fence to complete.
>
> Sleeping in general seems to be (currently) allowed in prepare_job(),
> but a sleeping allocation risks deadlock.
>
> Document the allocation pitfals for prepare_job().
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Didn't we recently discuss deprecating this callback for good?
> There's a great many users, though...
> ---
>  include/drm/gpu_scheduler.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 3b0978fa8cf0..1e4d0399a9b9 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -447,6 +447,10 @@ struct drm_sched_backend_ops {
>  	 *
>  	 * Can be NULL if no additional preparation to the dependencies are
>  	 * necessary. Skipped when jobs are killed instead of run.
> +	 *
> +	 * This gets called in the job submission path (dma_fence critical path=
).

I think "job submission path" is slightly misleading. Not all of the operat=
ions
a driver performs on job submission are within the DMA fence signaling crit=
ical
path.

Maybe something like "This is called after the job's fence may have been
published and hence must be considered a DMA fence sginaling critical secti=
on."

> +	 * You must not perform sleeping allocations in your implementation, or
> +	 * deadlock can occur.
>  	 */
>  	struct dma_fence *(*prepare_job)(struct drm_sched_job *sched_job,
>  					 struct drm_sched_entity *s_entity);
> --=20
> 2.56.0

