Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F9DC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647C810E40C;
	Wed, 12 Aug 2026 12:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TzG+InON";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BD410E40C
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:20:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1E2E41FD5;
 Wed, 12 Aug 2026 12:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EF21F000E9;
 Wed, 12 Aug 2026 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786537218;
 bh=M++JHH9FE3FNHJ33/UcXJPT1h5likwtm4j+ioYhQc+I=;
 h=Date:From:To:Cc:Subject;
 b=TzG+InONulOKXHgqr4xNQ4ZqmpP3f7+zB+586TXlZ6az6RNQ6G4+gHra8QfRtmIah
 uA6f1asjs+Ld+LG7DqVHLRMw9wCHsFKjGAXZ6WtVnAhqND2iw4xW4P9RWaJIEuGJZq
 UC9udG4CHomjnE/W8AY+XOFbt82u8woAfqJRc69a2Li1Pc39X8GvzW/E+vqeZ+TCO2
 SXvnCRb1bok0744UfzPinpfqituk9JGwXW+Jyzbou8kAaraVyWbHWiipIDfrdKIsSe
 aeZimWJPjSAkoRYKyVtbQZg4lhckYJ53ZzOfSgYMLIxSKozyJXbk3G+iQaSC+OAuXc
 gM1KcnWYD485Q==
Date: Wed, 12 Aug 2026 13:20:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes tree
Message-ID: <anxk_iYSi8waaGvh@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vk8sGFR1HbDB4ZBv"
Content-Disposition: inline
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--vk8sGFR1HbDB4ZBv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/scheduler/sched_entity.c

between commits:

  67cf83ac8316a ("Revert "drm/sched: Embed run queue singleton into the sch=
eduler"")

=66rom the drm-misc-fixes tree and commit:

  2df5efb45425b ("drm/sched: Remove redundant entity->rq initialization and=
 checks")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/scheduler/sched_entity.c
index 672b5c57ed8e9,c51101ec70c16..0000000000000
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@@ -129,43 -129,14 +129,42 @@@ int drm_sched_entity_init(struct drm_sc
  		return -ENOMEM;
 =20
  	INIT_LIST_HEAD(&entity->list);
- 	entity->rq =3D NULL;
  	entity->guilty =3D guilty;
  	entity->priority =3D priority;
  	entity->last_user =3D current->group_leader;
 +	entity->rq_priority =3D drm_sched_policy =3D=3D DRM_SCHED_POLICY_FAIR ?
 +			      DRM_SCHED_PRIORITY_KERNEL : priority;
  	entity->num_sched_list =3D num_sched_list;
  	entity->sched_list =3D num_sched_list > 1 ? sched_list : NULL;
 -	entity->rq =3D &sched_list[0]->rq;
  	RCU_INIT_POINTER(entity->last_scheduled, NULL);
  	RB_CLEAR_NODE(&entity->rb_tree_node);
 +
 +	if (!sched_list[0]->sched_rq) {
 +		/* Since every entry covered by num_sched_list
 +		 * should be non-NULL and therefore we warn drivers
 +		 * not to do this and to fix their DRM calling order.
 +		 */
 +		pr_warn("%s: called with uninitialized scheduler\n", __func__);
 +	} else {
 +		enum drm_sched_priority p =3D entity->priority;
 +
 +		/*
 +		 * The "priority" of an entity cannot exceed the number of
 +		 * run-queues of a scheduler. Protect against num_rqs being 0,
 +		 * by converting to signed. Choose the lowest priority
 +		 * available.
 +		 */
 +		if (p >=3D sched_list[0]->num_user_rqs) {
 +			dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u num=
_user_rqs:%u\n",
 +				p, sched_list[0]->num_user_rqs);
 +			p =3D max_t(s32,
 +				  (s32)sched_list[0]->num_user_rqs - 1,
 +				  (s32)DRM_SCHED_PRIORITY_KERNEL);
 +			entity->priority =3D p;
 +		}
 +		entity->rq =3D sched_list[0]->sched_rq[entity->rq_priority];
 +	}
 +
  	init_completion(&entity->entity_idle);
 =20
  	/* We start in an idle state. */
@@@ -308,9 -279,6 +307,6 @@@ void drm_sched_entity_kill(struct drm_s
  	struct drm_sched_job *job;
  	struct dma_fence *prev;
 =20
- 	if (!entity->rq)
- 		return;
-=20
  	spin_lock(&entity->lock);
  	entity->stopped =3D true;
  	drm_sched_rq_remove_entity(entity->rq, entity);
@@@ -357,14 -325,11 +353,11 @@@ EXPORT_SYMBOL(drm_sched_entity_kill)
   */
  long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
  {
- 	struct drm_gpu_scheduler *sched;
+ 	struct drm_gpu_scheduler *sched =3D
+ 		container_of(entity->rq, typeof(*sched), rq);
  	struct task_struct *last_user;
  	long ret =3D timeout;
 =20
- 	if (!entity->rq)
- 		return 0;
-=20
- 	sched =3D entity->rq->sched;
  	/*
  	 * The client will not queue more jobs during this fini - consume
  	 * existing queued ones, or discard them on SIGKILL.
@@@ -445,10 -410,12 +438,10 @@@ static void drm_sched_entity_wakeup(str
  {
  	struct drm_sched_entity *entity =3D
  		container_of(cb, struct drm_sched_entity, cb);
 -	struct drm_gpu_scheduler *sched =3D
 -		container_of(entity->rq, typeof(*sched), rq);
 =20
  	entity->dependency =3D NULL;
  	dma_fence_put(f);
 -	drm_sched_wakeup(sched);
 +	drm_sched_wakeup(entity->rq->sched);
  }
 =20
  /**
@@@ -475,7 -442,8 +468,7 @@@ EXPORT_SYMBOL(drm_sched_entity_set_prio
  static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *e=
ntity,
  					       struct drm_sched_job *sched_job)
  {
 -	struct drm_gpu_scheduler *sched =3D
 -		container_of(entity->rq, typeof(*sched), rq);
 +	struct drm_gpu_scheduler *sched =3D entity->rq->sched;
  	struct dma_fence *fence =3D entity->dependency;
  	struct drm_sched_fence *s_fence;
 =20
@@@ -609,7 -577,7 +602,7 @@@ void drm_sched_entity_select_rq(struct=20
 =20
  	spin_lock(&entity->lock);
  	sched =3D drm_sched_pick_best(entity->sched_list, entity->num_sched_list=
);
 -	rq =3D sched ? &sched->rq : NULL;
 +	rq =3D sched ? sched->sched_rq[entity->rq_priority] : NULL;
  	if (rq !=3D entity->rq) {
  		drm_sched_rq_remove_entity(entity->rq, entity);
  		entity->rq =3D rq;
@@@ -633,8 -601,9 +626,8 @@@
  void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
  {
  	struct drm_sched_entity *entity =3D sched_job->entity;
 -	struct drm_gpu_scheduler *sched =3D
 -		container_of(entity->rq, typeof(*sched), rq);
  	bool first;
 +	ktime_t submit_ts;
 =20
  	trace_drm_sched_job_queue(sched_job, entity);
 =20
@@@ -645,22 -614,18 +638,22 @@@
  		xa_for_each(&sched_job->dependencies, index, entry)
  			trace_drm_sched_job_add_dep(sched_job, entry);
  	}
 -	atomic_inc(sched->score);
 +	atomic_inc(entity->rq->sched->score);
  	WRITE_ONCE(entity->last_user, current->group_leader);
 =20
  	/*
  	 * After the sched_job is pushed into the entity queue, it may be
  	 * completed and freed up at any time. We can no longer access it.
 +	 * Make sure to set the submit_ts first, to avoid a race.
  	 */
 +	sched_job->submit_ts =3D submit_ts =3D ktime_get();
  	first =3D spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
 =20
  	/* first job wakes up scheduler */
  	if (first) {
 -		sched =3D drm_sched_rq_add_entity(entity);
 +		struct drm_gpu_scheduler *sched;
 +
 +		sched =3D drm_sched_rq_add_entity(entity, submit_ts);
  		if (sched)
  			drm_sched_wakeup(sched);
  	}

--vk8sGFR1HbDB4ZBv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp8ZP0ACgkQJNaLcl1U
h9AGpwf+KP1qSuFZf8wAC3Yw3KnffYPbrIbarqq+/S5i+TozpssFS2VIsRSgKBYg
442CyjTm/EjgNSVHyFrfYJj4FcIDNupWljPRDDz78V8Ej5sULM5LeoRUoMab41o5
d99L49TccY/4EDGY9N7m3RKxFJhH3/PqCpmhEzs1SGVxNGRcirxOW9p4qi5g9f4/
Uw9IF6eSeAS08E1LtzWNfzwnkYEtcYI6caDFsxHjvcj/DvucIxJRMMKeK7imOWaL
dC/ckOuc9BPuidIfuPsUze19ZT6r7LlkgMVMLate6PczZAIzGKBljztf3SbxEqCq
N+TniMDdamkc0w9cNtFC8i7qBY1l9w==
=66VA
-----END PGP SIGNATURE-----

--vk8sGFR1HbDB4ZBv--
