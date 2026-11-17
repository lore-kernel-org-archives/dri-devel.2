Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BB606A33B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TF4+AunV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7429610F10C;
	Tue, 17 Nov 2026 09:46:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51C610F10C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:46:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9AC87469B4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566051F000D4;
 Tue, 17 Nov 2026 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794908774;
 bh=xJPeXAU4phUO0g3GQHB/ZpE2IbpkU2oVrj1LnqIuVug=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TF4+AunVWRrE6ZCvC/UktVCxZN8lKqoS2rztXp0Js06Ucc1ok3OYFxT3SJ0x6UBoQ
 nVCO1nA9NCXcWLQVOmu+jkpkw1a6jj9lW8clpQhjPGg5rRI4Q58hRz08N0QuM3FJcf
 6hvO3zgoMLJzJhP55ddi78qLvmeCGE8Oy4eAy3gfODLkMp44QMryS2M6GSQL8ka3kA
 bcZGOetIjC3dVILKTZuM0Umeu3HBvD3gYoV4E6/hAKDMq+3O69aIreBi0sE5WTUuv4
 18CF0KnTncc1Oelmyy8txeQPYn2EBXmr4Jb2cxsIkQ1OscufoUEcuDm+6fyxt/ovOi
 9WJPGq7up1Gjg==
Message-ID: <sashiko-outbox-218518@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sched: Extend locking in drm_sched_entity_select_rq()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261117093708.647488-2-phasta@kernel.org>
References: <20261117093708.647488-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:46:13 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] drm/sched: out-of-bounds array read in
  drm_sched_entity_select_rq() [1]
--

commit fd8a3dbada3c5189d04991dce47c3b6554b565d5
Author: Philipp Stanner <phasta@kernel.org>

drm/sched: Extend locking in drm_sched_entity_select_rq()

This commit moves spin_lock(&entity->lock) to the start of
drm_sched_entity_select_rq() so that entity->sched_list and
spsc_queue_count(&entity->job_queue) are evaluated under lock protection.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 03e68b4102d50..3856d5e507d7f 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -577,22 +577,21 @@ void drm_sched_entity_select_rq(struct drm_sched_en=
tity *entity)
>  	struct drm_gpu_scheduler *sched;
>  	struct drm_sched_rq *rq;
> =20
> +	spin_lock(&entity->lock);
> +
>  	/* single possible engine and already selected */
>  	if (!entity->sched_list)
> -		return;
> +		goto unlock;
> =20
>  	/* queue non-empty, stay on the same engine */
>  	if (spsc_queue_count(&entity->job_queue))
> -		return;
> +		goto unlock;
> =20
> -	spin_lock(&entity->lock);
>  	fence =3D entity->last_scheduled;
> =20
>  	/* stay on the same engine if the previous job hasn't finished */
> -	if (fence && !dma_fence_is_signaled(fence)) {
> -		spin_unlock(&entity->lock);
> -		return;
> -	}
> +	if (fence && !dma_fence_is_signaled(fence))
> +		goto unlock;
> =20
>  	sched =3D drm_sched_pick_best(entity->sched_list, entity->num_sched_lis=
t);
>  	rq =3D sched ? sched->sched_rq[entity->rq_priority] : NULL;

[Severity: Critical]
This problem wasn't introduced by this patch, but can
sched->sched_rq[entity->rq_priority] read out of bounds here [1]?

drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_init() {
	...
	if (!sched_list[0]->sched_rq) {
		...
		pr_warn("%s: called with uninitialized scheduler\n", __func__);
	} else if (priority >=3D sched_list[0]->num_user_rqs) {
		...
		priority =3D max_t(s32,
				 (s32)sched_list[0]->num_user_rqs - 1,
				 (s32)DRM_SCHED_PRIORITY_KERNEL);
	}

	entity->priority =3D priority;
	entity->rq_priority =3D drm_sched_policy =3D=3D DRM_SCHED_POLICY_FAIR ?
			      DRM_SCHED_PRIORITY_KERNEL : priority;
	...
}

When drm_sched_entity_init() is called with an uninitialized scheduler
(!sched_list[0]->sched_rq), it warns and skips clamping priority against
num_user_rqs, storing the unvalidated value into entity->priority and
entity->rq_priority.  Later, drm_sched_entity_select_rq() indexes
sched->sched_rq[entity->rq_priority] and drm_sched_entity_update_vruntime()
indexes vruntime_shift[entity->priority] out of bounds, which can crash the
kernel.

[1] https://sashiko.dev/#/bug/linux-588f726e-4d3a-4204-b39b-8ff2cd63a19c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117093708.6474=
88-2-phasta@kernel.org?part=3D1
