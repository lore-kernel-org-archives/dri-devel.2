Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82E2CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA38710FA49;
	Wed,  3 Jun 2026 08:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="P3VTW11a";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630B110FA49
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 08:37:48 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gVh0T42JTz9vNd;
 Wed,  3 Jun 2026 10:37:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780475865; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePf8yL2Jyc9l9xY3i/poqI3wyp0xXC2ASdOHZw2oyDM=;
 b=P3VTW11a4nVbkSHtsFPxzMpfrNiLuMPGIAgOMOJtJeCczvLEJqQbDTG9S7OYmH0Em25JGH
 um6HZmWPf4xrWkhytE6kZFp6XYjoe9XNyjlG2D32DJskrjCy6BfmoQ4GldnfZvoCJuRXHq
 zwaqiFLmcCiiE3MIcNAhjLesDCPsi6X/A4c7W30nyqCHIHhRuOrv2GyxzrM5IrKOcMsSBm
 m5uJLlMasHN3NuUyZ4JRmuRF1ci/ohN4VQ2VGFI1eHwnFB5DHsyQznf4XWTxziKcEEGyfm
 OuoPhnCBXWh7M5YuvfXVlvAE8q4xfDZNlc5lhn0f13AFBZh+BW7zYtp/jYMeBQ==
Message-ID: <4e7e282983939dd64b9303d53302e6806361076c.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Remove redundant entity->rq initialization
 and checks
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
Date: Wed, 03 Jun 2026 10:37:41 +0200
In-Reply-To: <20260602153339.43453-1-tvrtko.ursulin@igalia.com>
References: <20260602153339.43453-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 8ee2a14cfebe5b2846f
X-MBO-RS-META: jxjcx9mne8f5a5zqnzhcte58xh6roqmg
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, 2026-06-02 at 16:33 +0100, Tvrtko Ursulin wrote:
> Commit
> 28c5bf28763d ("drm/sched: Disallow initializing entities with no schedule=
rs")
> failed to notice clearing of entity->rq in drm_sched_entity_init() is now

By clearing you also mean the setting to NULL?

I'd just use "initialization" consistently, like in the commit title.

> redundant and can be removed.
>=20
> Given that entity->rq can now never be NULL, we also remove two impossibl=
e
> checks, from drm_sched_entity_kill() and drm_sched_entity_flush()
> respectively.
>=20
> Similarly, we can also remove the !entity->rq check in
> drm_sched_job_init(). And for the better, given that the error message, i=
f
> it ever triggered, would have dereferenced the yet un-initialized job->
> sched (only initialized later in drm_sched_job_arm()). This appears to
> have been theoretically broken ever since commit
> 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable number of=
 run-queues")
> .
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 11 ++---------
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0 |=C2=A0 9 ------=
---
> =C2=A02 files changed, 2 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 4ebb513255ed..c51101ec70c1 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -129,7 +129,6 @@ int drm_sched_entity_init(struct drm_sched_entity *en=
tity,
> =C2=A0		return -ENOMEM;
> =C2=A0
> =C2=A0	INIT_LIST_HEAD(&entity->list);
> -	entity->rq =3D NULL;

It would seem that has always been redundant because of the memset(0)
directly above.

> =C2=A0	entity->guilty =3D guilty;
> =C2=A0	entity->priority =3D priority;
> =C2=A0	entity->last_user =3D current->group_leader;
> @@ -280,9 +279,6 @@ void drm_sched_entity_kill(struct drm_sched_entity *e=
ntity)
> =C2=A0	struct drm_sched_job *job;
> =C2=A0	struct dma_fence *prev;
> =C2=A0
> -	if (!entity->rq)
> -		return;
> -
> =C2=A0	spin_lock(&entity->lock);
> =C2=A0	entity->stopped =3D true;
> =C2=A0	drm_sched_rq_remove_entity(entity->rq, entity);
> @@ -329,14 +325,11 @@ EXPORT_SYMBOL(drm_sched_entity_kill);
> =C2=A0 */
> =C2=A0long drm_sched_entity_flush(struct drm_sched_entity *entity, long t=
imeout)
> =C2=A0{
> -	struct drm_gpu_scheduler *sched;
> +	struct drm_gpu_scheduler *sched =3D
> +		container_of(entity->rq, typeof(*sched), rq);
> =C2=A0	struct task_struct *last_user;
> =C2=A0	long ret =3D timeout;
> =C2=A0
> -	if (!entity->rq)
> -		return 0;
> -
> -	sched =3D container_of(entity->rq, typeof(*sched), rq);
> =C2=A0	/*
> =C2=A0	 * The client will not queue more jobs during this fini - consume
> =C2=A0	 * existing queued ones, or discard them on SIGKILL.
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 818d3d4434b5..d2ca01b31ee4 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -588,15 +588,6 @@ int drm_sched_job_init(struct drm_sched_job *job,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 credits, void *owner,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t drm_client_id)
> =C2=A0{
> -	if (!entity->rq) {
> -		/* This will most likely be followed by missing frames
> -		 * or worse--a blank screen--leave a trail in the
> -		 * logs, so this can be debugged easier.
> -		 */
> -		dev_err(job->sched->dev, "%s: entity has no rq!\n", __func__);
> -		return -ENOENT;
> -	}
> -
> =C2=A0	if (unlikely(!credits)) {
> =C2=A0		pr_err("*ERROR* %s: credits cannot be 0!\n", __func__);
> =C2=A0		return -EINVAL;

But overall a very nice cleanup


P.
