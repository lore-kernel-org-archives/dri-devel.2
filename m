Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F403CA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F46510E4C5;
	Sat,  3 Oct 2026 01:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O4CFYHG9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5799F10E4C5;
 Sat,  3 Oct 2026 01:33:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D13B460A97;
 Sat,  3 Oct 2026 01:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507811F00893;
 Sat,  3 Oct 2026 01:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991194;
 bh=b+CszPn4z8NlMSYnXDDjwV0QzLUq2OVdNluq964l+As=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O4CFYHG9/oRQUMctNw0wGCxHBtaw5WVok/qs/oNlFCtCxVVdIRl6JjsB7H6tSdv7L
 +PhRm00GOoo7Ykr6J8axjaJ7zX/gNFtFVZmZwLG/zR2Yl4Pr6NCv1Hhijc6OKkNsNK
 ERB625UGWy+5JiL6XKUahJNQo8lqzVXs0PEA5BaIhjcADOnmbfnuojX6LgYsE8qB7C
 E9cV3c2+OEgaVHpyyb5upOV9nKpyUq1UPox4jtpfCVS1xV0JIUYQKxNAMD5r83ht9e
 JKsOeFpyS+KpRMXpYRhJXAf0WnxnlVhcYAKtgSsHW7NVicFLnvbWYfT9riKa4AL5Cp
 8ayeQ5weyTKPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] drm/sched: Replace completion with a flush
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261002154713.77591-9-tvrtko.ursulin@igalia.com>
References: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
 <20261002154713.77591-9-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:13 +0000
Message-Id: <20261003013314.507811F00893@smtp.kernel.org>
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
- [High] drm/sched: cross-entity deadlock via flush_work() in drm_sched_ent=
ity_kill()
--

commit 3786a3d89362d00183a97f456e4eaeb1dff144f4
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/sched: Replace completion with a flush

This commit removes the per-entity completion used to synchronize entity
teardown, replacing it with a direct flush of the scheduler's run job
worker. The goal is to achieve the same synchronization guarantee without
requiring the scheduler to signal a completion when an entity goes idle.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
[ ... ]
> @@ -304,16 +299,23 @@ static void drm_sched_entity_kill_jobs_cb(struct dm=
a_fence *f,
>  void drm_sched_entity_kill(struct drm_sched_entity *entity)
>  {
[ ... ]
> -	/* Make sure this entity is not used by the scheduler at the moment */
> -	wait_for_completion(&entity->entity_idle);
> +	/*
> +	 * Make sure this entity is not used by the scheduler at the moment.
> +	 *
> +	 * Scheduler is guaranteed to be stable after the entity was stopped and
> +	 * removed from the run-queue.
> +	 */
> +	if (sched)
> +		drm_sched_flush_run_work(sched);

[Severity: High]
Could this introduce a cross-entity deadlock regression during context tear=
down?

Because drm_sched_flush_run_work calls flush_work on the scheduler's shared
worker, it synchronously waits for the worker to finish its current executi=
on.
This might cause it to wait on a job belonging to a completely different
entity.

If a process destroys its device context and triggers drm_sched_entity_kill
while holding a driver-specific lock, and the shared worker is concurrently
running drm_sched_run_job_work for an unrelated entity, that driver-provided
run_job callback might attempt to acquire the same driver lock.

The original code used a per-entity completion (entity_idle) which explicit=
ly
avoided waiting on other entities. Does this flush create a new cross-entity
dependency that could lead to a deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002154713.7759=
1-1-tvrtko.ursulin@igalia.com?part=3D8
