Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF3606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1C310E186;
	Tue, 20 Oct 2026 16:19:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565DF10E186
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 16:19:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C774441360;
 Tue, 20 Oct 2026 16:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9006D1F000C5;
 Tue, 20 Oct 2026 16:19:15 +0000 (UTC)
Message-ID: <sashiko-outbox-179337@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] drm/sched: Untangle the scheduler list mess
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261020154123.33631-9-tvrtko.ursulin@igalia.com>
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
 <20261020154123.33631-9-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:18:45 +0000
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/sched: NULL entity->rq dereference via drm_sched_entity_select=
_rq()
- [High] drm/sched: invalid flex-array embedding and layout in drm_sched_en=
tity
- [Medium] drm/sched: drm_sched_entity_set_priority() leaves rq_priority st=
ale
--

commit ea4d5caf1dfadd7f3c593ae875d3ce707b5c11f4
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/sched: Untangle the scheduler list mess

This commit reworks drm_sched_entity so that it owns a copy of its
scheduler list via a flexible array member (with a built-in single
scheduler slot), and updates rocket and amdgpu to provide trailing storage
for multi-scheduler entities.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 4bc4f9c8ee403..e29ec5755280d 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -511,18 +511,21 @@ void rocket_job_fini(struct rocket_core *core)
>  int rocket_job_open(struct rocket_file_priv *rocket_priv)
>  {
>  	struct rocket_device *rdev =3D rocket_priv->rdev;
> -	struct drm_gpu_scheduler **scheds =3D kmalloc_objs(*scheds,
> -							 rdev->num_cores);
> +	unsigned int num_cores =3D rdev->num_cores;
>  	unsigned int core;
>  	int ret;
> =20
> -	for (core =3D 0; core < rdev->num_cores; core++)
> -		scheds[core] =3D &rdev->cores[core].sched;
> +	if (WARN_ON_ONCE(num_cores > ARRAY_SIZE(rocket_priv->sched_list)))
> +		return -EINVAL;
> +
> +	for (core =3D 0; core < num_cores; core++)
> +		rocket_priv->sched_list[core] =3D &rdev->cores[core].sched;
> =20
> -	ret =3D drm_sched_entity_init(&rocket_priv->sched_entity,
> -				    DRM_SCHED_PRIORITY_NORMAL,
> -				    scheds,
> -				    rdev->num_cores, NULL);
> +	ret =3D __drm_sched_entity_init(&rocket_priv->sched_entity,
> +				      DRM_SCHED_PRIORITY_NORMAL,
> +				      rocket_priv->sched_list,
> +				      ARRAY_SIZE(rocket_priv->sched_list),
> +				      num_cores, NULL);

[Severity: High]
Because struct drm_sched_entity already includes one pointer slot in its
union (__sched__ and sched_list[]), rocket_priv->sched_list[0] is located
at &rocket_priv->sched_entity.sched_list[1] rather than at index 0.

When rocket_job_open() populates rocket_priv->sched_list[] and passes it
to __drm_sched_entity_init() -> drm_sched_entity_modify_sched(), memmove()
copies num_cores pointers from &sched_entity.sched_list[1] down into
&sched_entity.sched_list[0], shifting the entries in rocket_priv->sched_list
and leaving the two arrays out of sync.

More broadly, adding DECLARE_FLEX_ARRAY(struct drm_gpu_scheduler *,
sched_list) to struct drm_sched_entity makes it a structure with a
flexible array member, which C99/C11 and GCC 14+
(-Wflex-array-member-not-at-end) disallow from being embedded in the
middle of structs or in arrays. However, struct drm_sched_entity is
embedded in DECLARE_DRM_SCHED_ENTITY_WITH_STORAGE itself, in the middle of
struct amdgpu_ctx_entity (before fences[]), struct
amdgpu_ttm_buffer_entity, and struct amdgpu_vm, as well as in arrays across
several DRM drivers (such as amdgpu_mman::move_entities[],
etnaviv_file_private::sched_entity[], panfrost_jm_ctx::slot_entity[], and
v3d_file_priv::sched_entity[]).

Additionally, when drm_sched_entity_modify_sched() writes more than one
element to entity->sched_list, the write crosses the sub-object boundary
of struct drm_sched_entity into the adjacent listname array, which can
trip FORTIFY_SOURCE or UBSAN bounds checks.

Could DECLARE_DRM_SCHED_ENTITY_WITH_STORAGE use TRAILING_OVERLAP() (or a
different storage representation that avoids a flexible array member in
struct drm_sched_entity) so that struct drm_sched_entity can still be
safely embedded in structs and arrays, and listname[0] aliases
sched_list[0]?

[ ... ]

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 79ea20838328d..d4956c6de6ed1 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c

[ ... ]

> @@ -159,17 +165,20 @@ int drm_sched_entity_init(struct drm_sched_entity *=
entity,
>  	entity->priority =3D priority;
>  	entity->rq_priority =3D drm_sched_policy =3D=3D DRM_SCHED_POLICY_FAIR ?
>  			      DRM_SCHED_PRIORITY_KERNEL : priority;
> -	entity->rq =3D sched_list[0]->sched_rq[entity->rq_priority];
> =20
>  	spin_lock_init(&entity->lock);
>  	spsc_queue_init(&entity->job_queue);
> =20
> +	entity->max_sched_list =3D max_sched_list;
> +	drm_sched_entity_modify_sched(entity, sched_list, num_sched_list);
> +	drm_sched_entity_select_rq(entity);

[Severity: High]
What happens if all schedulers in sched_list have sched->ready =3D=3D false
when __drm_sched_entity_init() or drm_sched_entity_select_rq() runs (for
example in amdgpu when a ring fails IB ring tests during init/reset/resume
while ring->sched.sched_rq remains allocated)?

Previously, drm_sched_entity_init() unconditionally set:

	entity->rq =3D sched_list[0]->sched_rq[entity->rq_priority];

and for single-scheduler entities (num_sched_list =3D=3D 1), entity->sched_=
list
was set to NULL so drm_sched_entity_select_rq() returned early without
clearing entity->rq.

With this change, __drm_sched_entity_init() leaves entity->rq as NULL from
memset() and calls drm_sched_entity_select_rq():

	sched =3D drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
	rq =3D sched ? sched->sched_rq[entity->rq_priority] : NULL;
	if (rq !=3D entity->rq) {
		drm_sched_rq_remove_entity(entity->rq, entity);
		entity->rq =3D rq;
	}

Because drm_sched_pick_best() skips any scheduler where !sched->ready, it
returns NULL when no scheduler is ready. __drm_sched_entity_init() then
succeeds (returning 0) with entity->rq =3D=3D NULL, and
drm_sched_entity_select_rq() can also overwrite an existing non-NULL
entity->rq with NULL.

Won't subsequent calls to drm_sched_entity_destroy() ->
drm_sched_entity_flush():

	sched =3D entity->rq->sched;

or drm_sched_job_arm():

	drm_sched_entity_select_rq(entity);
	sched =3D entity->rq->sched;

or amdgpu_ctx_fini_entity() -> amdgpu_xcp_release_sched() trigger a NULL
pointer dereference on entity->rq?

[ ... ]

> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 76637e21284ac..38b50a84a8210 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -121,22 +121,11 @@ struct drm_sched_entity {
>  	struct drm_sched_entity_stats	*stats;
> =20
>  	/**
> -	 * @sched_list:
> +	 * @max_sched_list:
>  	 *
> -	 * A list of schedulers (struct drm_gpu_scheduler).  Jobs from this ent=
ity can
> -	 * be scheduled on any scheduler on this list.
> -	 *
> -	 * This can be modified by calling drm_sched_entity_modify_sched().
> -	 * Locking is entirely up to the driver, see the above function for more
> -	 * details.
> -	 *
> -	 * This will be set to NULL if &num_sched_list equals 1 and @rq has been
> -	 * set already.
> -	 *
> -	 * FIXME: This means priority changes through
> -	 * drm_sched_entity_set_priority() will be lost henceforth in this case.
> +	 * Maximum number of drm_gpu_schedulers in the @sched_list.
>  	 */
> -	struct drm_gpu_scheduler        **sched_list;
> +	unsigned int                    max_sched_list;

[Severity: Medium]
Does drm_sched_entity_set_priority() actually switch run-queues when
per-priority run-queues (such as DRM_SCHED_POLICY_FIFO or
DRM_SCHED_POLICY_RR) are used?

In drivers/gpu/drm/scheduler/sched_entity.c, __drm_sched_entity_init()
initializes both priority fields:

	entity->priority =3D priority;
	entity->rq_priority =3D drm_sched_policy =3D=3D DRM_SCHED_POLICY_FAIR ?
			      DRM_SCHED_PRIORITY_KERNEL : priority;

However, drm_sched_entity_set_priority() only updates entity->priority:

void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
				   enum drm_sched_priority priority)
{
	spin_lock(&entity->lock);
	entity->priority =3D priority;
	spin_unlock(&entity->lock);
}

When drm_sched_entity_select_rq() later selects a run-queue, it indexes
sched->sched_rq using entity->rq_priority:

	sched =3D drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
	rq =3D sched ? sched->sched_rq[entity->rq_priority] : NULL;

Since entity->rq_priority is never updated by
drm_sched_entity_set_priority(), won't the entity remain on its original
priority's run-queue when drm_sched_policy is not DRM_SCHED_POLICY_FAIR?

[ ... ]

> @@ -245,8 +234,38 @@ struct drm_sched_entity {
>  	 */
>  	struct rb_node			rb_tree_node;
> =20
> +	union {
> +		/**
> +		 * @__sched__:
> +		 *
> +		 * Built-in storage for callers who only need a single slot.
> +		 *
> +		 * MUST NOT be accessed.
> +		 */
> +		struct drm_gpu_scheduler 	*__sched__;
> +
> +		/**
> +		 * @sched_list:
> +		 *
> +		 * Flexible array of schedulers this entity can pick from, with
> +		 * the driver reponsibility to size the array correctly at
> +		 * declaration and initialization time, and populate the array
> +		 * via drm_sched_entity_init() and/or
> +		 * drm_sched_entity_modify_sched().
> +		 *
> +		 * It can be modified by calling
> +		 * drm_sched_entity_modify_sched().
> +		 */
> +		DECLARE_FLEX_ARRAY(struct drm_gpu_scheduler *, sched_list);
> +	};
>  };
> =20
> +#define DECLARE_DRM_SCHED_ENTITY_WITH_STORAGE(name, listname, max_scheds=
) \
> +struct { \
> +	struct drm_sched_entity (name); \
> +	struct drm_gpu_scheduler *(listname)[(max_scheds)]; \
> +}

[ ... ]

>|}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020154123.3363=
1-1-tvrtko.ursulin@igalia.com?part=3D8
