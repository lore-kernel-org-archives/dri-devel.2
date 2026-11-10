Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D43606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Hiq2zJyu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A2610E1B2;
	Tue, 10 Nov 2026 15:49:23 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F42610F7C7;
 Tue, 10 Nov 2026 15:49:17 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jPB0V1SGLzMlG9;
 Tue, 10 Nov 2026 16:49:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794325754; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P2EkgWlLJ3wuROXjW7gW24XefXEqkNCVB1DKsjzG04M=;
 b=Hiq2zJyu3cr+rcIWhC5cguRJ5M3wGdIhRlhw3pibnh5k7PDLGaMrJUVbhifChJQuXYUqqh
 HBokWP5rqov7rrV6rNznQQ1FmSP7HX7v3WYjLZ2UldVhnG1on9bzOfmRzEX4p0B+1gqmVV
 CJiT2j0GFHvfP/m38T0DZCT29LNxKoE8rE96LP0AS3piT9/8ZBoF6nI0MVT8jvzZ/05LK0
 EMVh2QYwnY/zL2yviYMnRyg/n01Y0NlRYChZMHwqMKEpFMB1EOnhtpWXKijj92JAe5tvCN
 QECLmI482o0H3itcn/68n4ZLExExREXCSK9OxjZHsxEGDFv95LN471fEZNRDRA==
Message-ID: <c3e0decc799da64c09689b85c3db49b0b0a437b4.camel@mailbox.org>
Subject: Re: [PATCH 6/7] drm/sched: Replace the SPSC queue with a list and a
 spinlock
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
Date: Tue, 10 Nov 2026 16:49:11 +0100
In-Reply-To: <20261106145702.61640-7-tvrtko.ursulin@igalia.com>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <20261106145702.61640-7-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: r45t6esemhiem1ajun5zw7dbf1wgz5w6
X-MBO-RS-ID: 9a0c0fe9db83a3c31d4
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

Just taking a closer look now since I assumed this is some sort of RFC
for AMD to look first.

On Fri, 2026-11-06 at 14:57 +0000, Tvrtko Ursulin wrote:
> Migrate the entity job queue from the single user SPSC queue (single
> producer, single consumer) to the standard list_head plus a spinlock in
> order to make it easier to argue about correctnes and bring the code base
> close to the usual kernel patterns.
>=20
> The main thing which needs to be mentioned is the seeming usage of RCU,
> which isn't really so, but only for two trivial reasons:

If that were really the only way then we would, unfortunately, not at
all end up with "usual kernel patterns" :(

>=20
> 1.
> We need to use the list operations which are safe for unlocked access to
> the list head, while parallel (locked) threads can be appending other
> jobs.
>=20
> This so the run job worker is able to process the job dependencies which
> includes it calling a potentially sleeping prepare_job() callback. Hence
> it is not possible to hold the entity->lock during that stage.

Why can't it pull a job from the list, release the lock and then do
that? There is only ever 1 worker at a time.

> 2.
> We need to work around the infamous entity<->rq locking inversion which
> would now trigger slightly earlier in the run job worker, from the entity
> selection stage, where there was previosuly the other "spsc queue peek"
> call site.

Is spsc_queue_peek() the only place where an inversion would occur?

> All the list_*_rcu usage stem from those two requirements and there are n=
o
> actual RCU requirements.

IDK, having RCU functions (and all those ACCESS_ONCEs!) in the code
base that is now supposed to be a simple lock + list does not sound
like a good idea for maintainability at all, especially if it's RCU
that is no actual RCU.

[=E2=80=A6]


> =C2=A0static struct drm_sched_job *
> =C2=A0drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
> =C2=A0{
> -	struct spsc_node *node;
> +	struct drm_sched_job *next_job, *sched_job;
> =C2=A0
> -	node =3D spsc_queue_pop(&entity->job_queue);
> -	if (!node)
> +	lockdep_assert_held(&entity->lock);
> +
> +	sched_job =3D list_first_entry_or_null(&entity->job_queue,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 typeof(*sched_job), queue_link);
> +	if (!sched_job)
> =C2=A0		return NULL;
> =C2=A0
> -	return container_of(node, struct drm_sched_job, queue_node);
> +	list_del_rcu(&sched_job->queue_link);
> +
> +#if IS_ENABLED(CONFIG_TRACEPOINTS) || IS_ENABLED(CONFIG_DRM_SCHED_KUNIT_=
TEST)
> +	WRITE_ONCE(entity->job_count, entity->job_count - 1);

You're literally holding the entity->lock, what do you need read once
for?

> +#endif
> +
> +	next_job =3D list_first_entry_or_null(&entity->job_queue,
> +					=C2=A0=C2=A0=C2=A0 typeof(*next_job), queue_link);
> +	if (next_job)
> +		WRITE_ONCE(entity->job_credits, next_job->credits);
> +	else
> +		WRITE_ONCE(entity->job_credits, 0);

Same.

> +
> +	return sched_job;
> =C2=A0}
> =C2=A0
>=20

[=E2=80=A6]


> =C2=A0EXPORT_SYMBOL(drm_sched_entity_kill);
> @@ -557,10 +556,20 @@ struct drm_sched_job *drm_sched_entity_pop_job(stru=
ct drm_sched_entity *entity)
> =C2=A0	/* Helper to avoid dropping the reference while the entity lock is=
 held,
> =C2=A0	 * just to have some more robustness.
> =C2=A0	 */
> +	struct drm_sched_job *sched_job, *next_job;
> =C2=A0	struct dma_fence *prev_last_scheduled;
> -	struct drm_sched_job *sched_job;
> =C2=A0
> -	sched_job =3D drm_sched_entity_queue_peek(entity);
> +	/*
> +	 * We cannot lock the entity at this point since processing dependencie=
s
> +	 * needs to be able to call a sleeping ops->prepare_job(). Note that RC=
U
> +	 * lock is not stricly required since single workqueue is the only
> +	 * caller and that guarantees a single consumer. Ie. the job cannot
> +	 * disappear on us.
> +	 */
> +	rcu_read_lock();
> +	sched_job =3D list_first_or_null_rcu(&entity->job_queue,
> +					=C2=A0=C2=A0 typeof(*sched_job), queue_link);
> +	rcu_read_unlock();

You can take the lock, take the job, release the lock, do your sleeping
actions, and then take the lock again, can't you?


P.
