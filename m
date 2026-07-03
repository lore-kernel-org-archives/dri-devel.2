Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF7DC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A738810E60D;
	Fri,  3 Jul 2026 14:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="io7+jonG";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4AC10E60D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 14:47:19 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gsGmz2K5wz9tnx;
 Fri,  3 Jul 2026 16:47:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1783090035; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NstNPI3Yl6z18ZLCBhwhl1e5laiGgCjywIQQ7XGoi0w=;
 b=io7+jonG4i0IEqFYwLqSYd+32vedj9DY2NWtA1mzHCnvAc2BSryG1YISMX2GQuRcO/KMa2
 jdlBGbLphY0sw8hn9xOOrASIYZ/inh4ONINCbqkZznQvo16Wv/53mgZiWT+bidQR4JXC/n
 R75nqK/NFKogTdQCXwajFzGuYvxM+EuSYEVRE4gwA2Z0Vy2DIHDADJy+iGXMiUdXXyFIWm
 nP8vXCauQ/5delyYBfE58/m3C7mRqHOObLC00TXUnsa6+6mkbNwpcc4jgOUpedXRQtK4jT
 YqJMIIdvXhWEAWbu55oonfxHFWTdWsUUcqd8D9Av+QmRVy/XzgupscUmCmRxIQ==
Message-ID: <51fbde808bd059510d667d130afae179626303be.camel@mailbox.org>
Subject: Re: [PATCH 1/5] drm/sched: Protect entity->last_scheduled with
 spinlock
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard	 <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie	 <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal	 <sumit.semwal@linaro.org>,
 Marco Pagani <marco.pagani@linux.dev>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Date: Fri, 03 Jul 2026 16:47:08 +0200
In-Reply-To: <a4091099-1931-4ca2-a81a-9c3321b123a8@ursulin.net>
References: <20260701085920.3253248-2-phasta@kernel.org>
 <20260701085920.3253248-3-phasta@kernel.org>
 <a4091099-1931-4ca2-a81a-9c3321b123a8@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 8bx1aetxqqwi14hyoz5m6dj1nbunchzx
X-MBO-RS-ID: 33ffcc438f0fff36951
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

On Fri, 2026-07-03 at 12:27 +0100, Tvrtko Ursulin wrote:
>=20
> On 01/07/2026 09:59, Philipp Stanner wrote:
> > The entity->last_scheduled field has always been set and read with
> > special RCU functions in addition to memory barriers.
> >=20
> > This was added in
> >=20
> > commit 70102d77ff22 ("drm/scheduler: add drm_sched_entity_error and use=
 rcu for last_scheduled")
> >=20
> > however, no proper justification for that mechanism was provided. There
> > seems to be no obvious reason, since the entity lock is available and
> > taken at all places that evaluate the last_scheduled field. The only
> > exception is drm_sched_entity_error(), which is not performance critica=
l
> > in any way.
> >=20
> > Improve robustness, readability and maintainability by replacing RCU an=
d
> > barriers with the lock.
>=20
> First thing, and regardless of other strands of discussion, I think it=
=20
> should be squashed with 3/5 instead of that one undoing the introduction=
=20
> of lock-unlock-lock-unlock.

I agree that there should not be a do-undo pattern, but I don't want to
squash that, it's quite a distinctive action. One patch adds locks, the
other moves them.

But what I can do is move that patch before =E2=84=961 here so that it beco=
mes
understandable as a preparational commit.

>=20
> For what the main topic is concerned, I really like the removal of all=
=20
> the rcu_dereference_check(, true) lines and the memory barriers.
>=20
> But I also think the commit message should explain better what code=20
> paths are now taking an extra lock - under which circumstances is the
> lock now taken for all scheduler users, and which amdgpu paths use=20
> drm_sched_entity_error() a lot so could be affected. I doubt it creates=
=20
> a measurable performance impact but it needs to be explained.

I think it can detail which functions will now be locked; but
mentioning the users would be overkill and is uncommon for API reworks.

>=20
> I am also happy to give it a spin on the Steam Deck to see if I can=20
> observe anything.

Could be interesting.

>=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0 drivers/gpu/drm/scheduler/sched_entity.c | 50 ++++++++++--------=
------
> > =C2=A0 include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++---
> > =C2=A0 2 files changed, 25 insertions(+), 34 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm=
/scheduler/sched_entity.c
> > index c51101ec70c1..91aec20611ad 100644
> > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > @@ -135,7 +135,6 @@ int drm_sched_entity_init(struct drm_sched_entity *=
entity,
> > =C2=A0=C2=A0	entity->num_sched_list =3D num_sched_list;
> > =C2=A0=C2=A0	entity->sched_list =3D num_sched_list > 1 ? sched_list : N=
ULL;
> > =C2=A0=C2=A0	entity->rq =3D &sched_list[0]->rq;
> > -	RCU_INIT_POINTER(entity->last_scheduled, NULL);
> > =C2=A0=C2=A0	RB_CLEAR_NODE(&entity->rb_tree_node);
> > =C2=A0=C2=A0	init_completion(&entity->entity_idle);
> > =C2=A0=20
> > @@ -201,10 +200,10 @@ int drm_sched_entity_error(struct drm_sched_entit=
y *entity)
> > =C2=A0=C2=A0	struct dma_fence *fence;
> > =C2=A0=C2=A0	int r;
> > =C2=A0=20
> > -	rcu_read_lock();
> > -	fence =3D rcu_dereference(entity->last_scheduled);
> > +	spin_lock(&entity->lock);
> > +	fence =3D entity->last_scheduled;
> > =C2=A0=C2=A0	r =3D fence ? fence->error : 0;
> > -	rcu_read_unlock();
> > +	spin_unlock(&entity->lock);
> > =C2=A0=20
> > =C2=A0=C2=A0	return r;
> > =C2=A0 }
> > @@ -287,9 +286,10 @@ void drm_sched_entity_kill(struct drm_sched_entity=
 *entity)
> > =C2=A0=C2=A0	/* Make sure this entity is not used by the scheduler at t=
he moment */
> > =C2=A0=C2=A0	wait_for_completion(&entity->entity_idle);
> > =C2=A0=20
> > -	/* The entity is guaranteed to not be used by the scheduler */
> > -	prev =3D rcu_dereference_check(entity->last_scheduled, true);
> > +	spin_lock(&entity->lock);
> > +	prev =3D entity->last_scheduled;
> > =C2=A0=C2=A0	dma_fence_get(prev);
> > +	spin_unlock(&entity->lock);
> > =C2=A0=C2=A0	while ((job =3D drm_sched_entity_queue_pop(entity))) {
> > =C2=A0=C2=A0		struct drm_sched_fence *s_fence =3D job->s_fence;
> > =C2=A0=20
> > @@ -381,8 +381,7 @@ void drm_sched_entity_fini(struct drm_sched_entity =
*entity)
> > =C2=A0=C2=A0		entity->dependency =3D NULL;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
> > -	RCU_INIT_POINTER(entity->last_scheduled, NULL);
> > +	dma_fence_put(entity->last_scheduled);
> > =C2=A0=C2=A0	drm_sched_entity_stats_put(entity->stats);
> > =C2=A0 }
> > =C2=A0 EXPORT_SYMBOL(drm_sched_entity_fini);
> > @@ -507,6 +506,10 @@ drm_sched_job_dependency(struct drm_sched_job *job=
,
> > =C2=A0=20
> > =C2=A0 struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_=
entity *entity)
> > =C2=A0 {
> > +	/* Helper to avoid dropping the reference while the entity lock is he=
ld,
> > +	 * just to have some more robustness.
> > +	 */
>=20
> I don't get this comment. Neither the placement or the content.

It explains the purpose of the variable 'prev_last_scheduled', which
exists so that a reference does not drop under lock protection.


P.
