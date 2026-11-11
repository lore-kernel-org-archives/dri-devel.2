Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9B606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=u5oadQVn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52E510E639;
	Wed, 11 Nov 2026 13:06:10 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175B210E908
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:06:04 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jPkKh3KJ3zKvqc;
 Wed, 11 Nov 2026 14:06:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794402360; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q42OC0c9Pn7CRrdjSlnnwtksCQ1XJFWkVDKm+WIMTiU=;
 b=u5oadQVnRqRpnfQ1iEXvPmnaXM3Xc3vGrRD6VeDlPN2e1Z9z5WCsLIYe8O3Up5qTIf+TYP
 6fe1VPHMUGO8L/aEMX+Rj0geKYzQM+w9aswW2OpUJk5bRdOLKse9ExyaZ58pq0XAmr4l1z
 xvlIMJSgd646+BnVcy2QT2cstu5QWqMcxJKosqFb0ByG+8Vah4D6muy1ZLQhDsBNOL9Wfq
 NGgnRerKDSMl+jKEnf8O4iSEtvkdo/NlsYddYY1kZWAhf6L1qleDimyozjPLOs6gYkYl0W
 ZjUeXFtrieWdNrAaw11yL/GFPKUprafzWqaUFD9bigH/4ctr6t58q3PgWmdYuA==
Message-ID: <71ad23bcb3d48f771ce74270dbe4dfcf39827031.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Do not overaccount job runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, Gary
 Guo	 <gary@garyguo.net>, "Paul E. McKenney" <paulmck@kernel.org>
Date: Wed, 11 Nov 2026 14:05:58 +0100
In-Reply-To: <20261111105921.38710-1-tvrtko.ursulin@igalia.com>
References: <20261111105921.38710-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 8e20d91b689ee33448a
X-MBO-RS-META: cpxj78cnjmjkcot4aj67z7awf8joyn6k
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+Cc folks from my other RFC

On Wed, 2026-11-11 at 10:59 +0000, Tvrtko Ursulin wrote:
> Currently the starting timestamp of the next job on the timeline is
> adjusted to the end of a preceding job. This works if the next job has
> been submitted while the preceding job was still executing, but not if it
> was submitted in the window between it finishing and free job work runnin=
g
> the timestamp adjustment.
>=20
> This can happen because the run job and free job work items share the sam=
e
> ordered workqueue and run job can easily submit the next job before the
> free job gets a chance to run. This over accounting window is present
> especially with single credit schedulers, but not limited too.
>=20
> Fix it by only adjusting the starting timestamp if it is not already afte=
r
> the finish time of the preceding job.
>=20
> While at it move the logic to a helper to keep indendation at bay.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 1774baa64f93 ("drm/scheduler: Change scheduled fence track v2")

In antoher mail you mentioned a userspace change which motivated this
patch. What is that about, some performance issue? So you want it in
all old kernels or not?

> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 24 +++++++++++++++++++----=
-
> =C2=A01 file changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index a030061d0390..136880fc193d 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -898,6 +898,24 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sc=
hed)
> =C2=A0	return IS_ERR(entity) ? NULL : entity;
> =C2=A0}
> =C2=A0
> +static void
> +adjust_next_job_start(struct drm_sched_job *job, struct drm_sched_job *n=
ext)

Not nitty with that usually, but since literally all our functions
always start with drm_sched_, this one should probably be
drm_sched_job_XXX()

> +{
> +	struct dma_fence *next_scheduled =3D &next->s_fence->scheduled;
> +	ktime_t ts;
> +
> +	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &next_scheduled->flags))
> +		return;
> +
> +	/*
> +	 * If the next job has been submitted while the previous one was still
> +	 * running adjust it's starting timestamp to avoid accounting overlap.
> +	 */
> +	ts =3D dma_fence_timestamp(&job->s_fence->finished);
> +	if (ktime_after(ts, next_scheduled->timestamp))
> +		next_scheduled->timestamp =3D ts;
> +}
> +
> =C2=A0/**
> =C2=A0 * drm_sched_get_finished_job - fetch the next finished job to be d=
estroyed
> =C2=A0 *
> @@ -929,11 +947,7 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler =
*sched)
> =C2=A0						typeof(*next), list);
> =C2=A0		if (next) {
> =C2=A0			/* make the scheduled timestamp more accurate */
> -			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 &next->s_fence->scheduled.flags))
> -				next->s_fence->scheduled.timestamp =3D
> -					dma_fence_timestamp(&job->s_fence->finished);

Urgh, only now am I realizing that we just "conveniently" overwrite a
fence's internal timestamp, relying on how dma_fence works internally.

Do you know what ordering is like btw for all of this?

This is the *next* job's scheduled fence, so this sounds suspiciously
racy. Testing the bit and overwriting the timestamp, can't that race?

dma_fence_timestamp's cpu_relax() might serve as a barrier, but I can't
see ordering between bit check and overwriting the timestamp?

See my recent RFC where I strongly suspect that we have such race's
with fences' error codes [1].


P.


[1] https://lore.kernel.org/dri-devel/20261110155817.1492359-3-phasta@kerne=
l.org/
