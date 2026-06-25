Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1936DCDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F04310F297;
	Thu, 25 Jun 2026 12:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gXdjnABg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DDD10F290
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:11:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B379E600C3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB3A1F000E9;
 Thu, 25 Jun 2026 12:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782389462;
 bh=1MRPIQmtUNIQaabA/BqhDw3w6mLeAlbiGcjBvj/XYls=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gXdjnABgMqYzHGP3oiz6103CesVc3YYqBXfYDM6TZ+2O8vEj8VWYhOX3pcB3vZ3XD
 m/Yl8WFyV2aep8klhSSe2XTXienkxRLOKzBaZs6r9FACOIs/93Eqyt/5QdWrhm2kcE
 fMmsoyMxx2ScktkTv/2QpF4kbi1nnyR5yuiOvhcp/LsrUelj7l9VnbnSH98+iZ8jqh
 BqYVHIh/qvxPwrOuZmuEAq+GpDbi9H/BeAUegJh6SZ2pICeD29DwtFCZcDQE8uTIP1
 TvOjU7DRxTJhQY1duzPcqUbefLgguguF2o0fm6uVRk9DhQ2vvpxNcq05+t09LQrs1v
 AB4/FhzOnQOGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sched: Remove useless BUG_ON()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625120151.1757146-2-phasta@kernel.org>
References: <20260625120151.1757146-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 12:11:01 +0000
Message-Id: <20260625121102.3AB3A1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Invalid pointer calculation and subsequent dereference when no sch=
edulers are ready.
--

commit 9f3c42b74323f1ffa6b677518014a9ecac0a6163
Author: Philipp Stanner <phasta@kernel.org>

drm/sched: Remove useless BUG_ON()

This commit removes a BUG_ON() in drm_sched_job_arm() that checks for a NULL
entity pointer, reasoning that a NULL pointer exception will happen anyway
and it is better not to explicitly crash the entire kernel.

> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 818d3d4434b57..da9210632d81e 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -646,7 +646,6 @@ void drm_sched_job_arm(struct drm_sched_job *job)
>  	struct drm_gpu_scheduler *sched;
>  	struct drm_sched_entity *entity =3D job->entity;
> =20
> -	BUG_ON(!entity);
>  	drm_sched_entity_select_rq(entity);
>  	sched =3D container_of(entity->rq, typeof(*sched), rq);

[Severity: High]
This is a pre-existing issue, but can this container_of() produce a negative
pointer if all schedulers are not ready?

If an entity has multiple schedulers and all of them have ready =3D=3D fals=
e (for
example, during a GPU reset), drm_sched_pick_best() returns NULL:

drm_sched_entity_select_rq() {
	...
	sched =3D drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
	rq =3D sched ? &sched->rq : NULL;
	if (rq !=3D entity->rq) {
		drm_sched_rq_remove_entity(entity->rq, entity);
		entity->rq =3D rq;
	}
	...
}

When drm_sched_entity_select_rq() returns, entity->rq is NULL. Back in
drm_sched_job_arm(), the container_of() calculation yields an invalid negat=
ive
pointer because rq is not at offset 0 of struct drm_gpu_scheduler.

Later, when drm_sched_entity_push_job() is called, it recomputes this negat=
ive
pointer and dereferences it, causing an immediate page fault:

drm_sched_entity_push_job() {
	...
	struct drm_gpu_scheduler *sched =3D
		container_of(entity->rq, typeof(*sched), rq);
	...
	atomic_inc(sched->score);
	...
}

Is there a way to safely handle the case where no schedulers are ready here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625120151.1757=
146-2-phasta@kernel.org?part=3D1
