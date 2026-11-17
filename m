Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195A8606A337
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksh+LMUj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6218E10E529;
	Tue, 17 Nov 2026 10:25:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A1D10E529;
 Tue, 17 Nov 2026 10:25:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7267540DC0;
 Tue, 17 Nov 2026 10:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD161F000C4;
 Tue, 17 Nov 2026 10:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794911121;
 bh=4bjv7fv7VU+YKdidh8lB22ySwKWrVdb8L0WXeVK709U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ksh+LMUj8A7N3QUp5oN8NLAsO3fDtNYeCQT+KRGW0lGkML8LYb7o7YjLldtPpVyZM
 rFydfLUNbXJHJP3jKyvq0HzjWCk6ikBpj0tXmmi8Gx8F8Z0IxNK71geySCNpewZFnI
 E5yrSjIYZA6BodV3P6701qn1tyiItnJVos32UH6bHL3K0eNotzfSUQDS0ivVnd/mjP
 3aZOQt8DhVDzW4Fq+vPQacni2/7AirZpVKEqVWPNrEnP990t6EFLYMjmKIez99iwZL
 jmTm16qSylxJvAv7PGX3UTJVZwZTWI/g5I4ktIeQCYZj6Los8JIyey2wCawNEPRt/5
 JjDSkxYlfw3xw==
Message-ID: <sashiko-outbox-218613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/sched: Remove the single scheduler special case
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117100654.8593-4-tvrtko.ursulin@igalia.com>
References: <20261117100654.8593-1-tvrtko.ursulin@igalia.com>
 <20261117100654.8593-4-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:25:20 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/sched: contradictory sched_list kernel-doc in
  drm_sched_entity_init()
--

commit 51236e2b589e5bb2f95788276a6d8bea43b26e11
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/sched: Remove the single scheduler special case

This commit stores a single scheduler pointer directly in a union with
sched_list in struct drm_sched_entity so that entities with a single
scheduler retain their scheduler reference for runtime priority changes.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index a18f637f9e998..6ff455373067f 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -102,7 +102,9 @@ ktime_t drm_sched_entity_stats_job_add_gpu_time(struc=
t drm_sched_job *job)
>   * @guilty: atomic_t set to 1 when a job on this queue
>   *          is found to be guilty causing a timeout
>   *
> - * Note that the &sched_list must have at least one element to schedule =
the entity.
> + * Note that the &sched_list must have exactly one element to schedule t=
he
> + * entity. Callers which pass more than one scheduler on the @sched_list=
 must
> + * ensure the list remains valid for the lifetime of the entity.

[Severity: Low]
Should this still say "at least one element" rather than "exactly one
element"?  drm_sched_entity_init() accepts one or more schedulers in
sched_list, as described in the following sentence.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117100654.8593=
-1-tvrtko.ursulin@igalia.com?part=3D3
