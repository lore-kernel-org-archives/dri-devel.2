Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AA606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=F79Wccyn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A76B10F265;
	Mon,  9 Nov 2026 12:46:18 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98FE10F266;
 Mon,  9 Nov 2026 12:46:11 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jNTzh0plZz8sXC;
 Mon, 09 Nov 2026 13:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794228368; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jf9U5zrpXnbFDIZWPqGV/mQ8FsXDvGQkaTzi+dX+5UI=;
 b=F79Wccyn3Q/SoGOOEhWLafnX1m2xnOJ7nVUi21UUiwRi0/gkwbE99cew76S/pA7tHJdyD8
 IVQHPDvO5h4ABHQ36vMwItCjMGGBsWtsOCEIsblE4JaLGux6/w8B2JWlQCqDiCD/u1ReEL
 L8cX3qgBoyIhw39eWkdiLHPa1c+iJCdaVSp+JkHBiHa9l37sIXYYjDGT9yjkulm/bk/nd3
 tSkA2OgiCWWkhRfG6DPUNf9zzbwWv8QBRC6G9PuPNMbFgBWwJslASwIpzoHI5ky/dTVo0O
 YUkwhnXpmqtvW/U2dv8fzAkftBg3QetT5nGR1wcpSJy24Z+jL6FqtIVgqTewNQ==
Message-ID: <e857e8e7edfe4c91aeda47478d6512a9d3ff5fe4.camel@mailbox.org>
Subject: Re: [PATCH 5/7] drm/amdgpu: Rework the
 amdgpu_job_stop_all_jobs_on_sched() hack
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Matthew Brost
 <matthew.brost@intel.com>, Simona Vetter <simona@ffwll.ch>,  Danilo
 Krummrich	 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Date: Mon, 09 Nov 2026 13:46:04 +0100
In-Reply-To: <20261106145702.61640-6-tvrtko.ursulin@igalia.com>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <20261106145702.61640-6-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 3687b2b71c76b728946
X-MBO-RS-META: aut6tot8nkuuden31dy3cn4e4o551kis
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-06 at 14:57 +0000, Tvrtko Ursulin wrote:=C2=A0
> -/*
> - * This is a duplicate function from DRM scheduler sched_internal.h.
> - * Plan is to remove it when amdgpu_job_stop_all_jobs_on_sched is remove=
d, due
> - * latter being incorrect and racy.
> - *
> - * See https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f=
539@amd.com/
> - */
> =C2=A0static struct drm_sched_job *
> =C2=A0drm_sched_entity_queue_pop(struct drm_sched_entity *entity)

Why remove that comment? A reader will still wonder why a drm_sched
function is defined here.

> =C2=A0{
> @@ -476,28 +469,66 @@ drm_sched_entity_queue_pop(struct drm_sched_entity =
*entity)
> =C2=A0	return container_of(node, struct drm_sched_job, queue_node);
> =C2=A0}
> =C2=A0
> -void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
> +static struct drm_sched_entity *
> +get_entity_with_jobs(struct drm_gpu_scheduler *sched) __acquires(&entity=
->lock)

[=E2=80=A6]

> +retry:
> =C2=A0	for (i =3D DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
> =C2=A0		struct drm_sched_rq *rq =3D sched->sched_rq[i];
> +
> =C2=A0		spin_lock(&rq->lock);
> -		list_for_each_entry(s_entity, &rq->entities, list) {
> -			while ((s_job =3D drm_sched_entity_queue_pop(s_entity))) {
> -				struct drm_sched_fence *s_fence =3D s_job->s_fence;
> +		list_for_each_entry(entity, &rq->entities, list) {
> +			/*
> +			 * This can false negative, but so could the previous
> +			 * approach of scanning the run-queues once when
> +			 * nothing prevents userspace to queue more jobs.
> +			 */
> +			if (!spsc_queue_count(&entity->job_queue))
> +				continue;
> =C2=A0
> -				dma_fence_signal(&s_fence->scheduled);
> -				dma_fence_set_error(&s_fence->finished, -EHWPOISON);
> -				dma_fence_signal(&s_fence->finished);
> +			/*
> +			 * We must trylock because normal locking order is
> +			 * entity then rq and here we already have rq locked
> +			 * in order to be able to walk the entities.
> +			 */
> +			if (spin_trylock(&entity->lock)) {
> +				/* Returns with a locked entity. */
> +				spin_unlock(&rq->lock);
> +				return entity;

Ah, now I understand.

Hmm. I guess considering the circumstances we're in that's the best-ish
option we have?

I hope the AMD folks can't see technical blockers.

> +			} else {
> +				/*
> +				 * Busy entity - we will try again looking for a
> +				 * window where trylock will succeed.
> +				 */
> +				spin_unlock(&rq->lock);
> +				goto retry;

In classic anti-deadlock strategies, wouldn't you want some random
delay here to avoid cycling?



P.
