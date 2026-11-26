Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F5A606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cT7WS+Np
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045F510E451;
	Thu, 26 Nov 2026 21:14:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6243110E451
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:14:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32087406CA;
 Thu, 26 Nov 2026 21:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8E41F000C1;
 Thu, 26 Nov 2026 21:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795727681;
 bh=L1lh4baSxVawc15OWah4ANc9eIkJT13onOH+4ImsAw8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cT7WS+NpGksZiCYKs0naFcKHN/vbxlX3BmgHRUjJLyOvPmmm7ZHXbh5EdlpGSYjdx
 mCNSp6fUajn4pZXuldhBIK7kERciURQfK+EvEgcxhbvUxZJb1cHBu5wHLRRcsa6Ln0
 aqALJmXabJdeg2KOBZHZGv+R7tngPkPtgUtKQo+z7w4oKa11aiQuFdZPPyj8PIqOZH
 Vz2peCuFgVVlDze0t68kN7xJw9VUblziBqYE2y984AJz+Y8Q0qxgKNdtpte1pSCyan
 D6cBNswHIk7ZNSnGjFuLOQKVX41mMy/Hsm82g3ZlwJhTQp//Qs9sIAIGaC6UI0FQOc
 jcTqr+S9goYvw==
Message-ID: <sashiko-outbox-236221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] drm/panthor: Add perf setup and session management
To: "Lukas Zapolskas" <lukas.zapolskas@arm.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261126-panthor-performance-counters-v8-1-6e7db0ec33f5@arm.com>
References: <20261126-panthor-performance-counters-v8-0-6e7db0ec33f5@arm.com>
 <20261126-panthor-performance-counters-v8-1-6e7db0ec33f5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 21:14:41 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] drm/panthor: 64-bit smp_load_acquire() in
  session_read_extract_idx()
- [High] drm/panthor: missing output handle field in struct
  drm_panthor_perf_session_create
- [High] drm/panthor: panthor_perf_bo_get() discards iosys_map is_iomem
  flag
- [Medium] drm/panthor: unreachable stopping check in
  session_try_sample()
- [Low] drm/panthor: format type mismatch for size_t in
  panthor_perf_bo_get()
- [Low] drm/panthor: split declaration of __free() vars in
  panthor_perf.c
--

commit e36bb7b1917c06a9ff609cb883067fc62562c67b
Author: Lukas Zapolskas <lukas.zapolskas@arm.com>

drm/panthor: Add perf setup and session management

This commit adds performance counter subsystem initialization and unplug
handling, along with user session lifecycle management and the associated
UAPI structures.

> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/pan=
thor/panthor_perf.c
> new file mode 100644
> index 0000000000000..a4167bbc33adc
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
[ ... ]
> +static int
> +panthor_perf_bo_get(struct drm_file *file, u32 handle, size_t min_size,
> +		    struct panthor_perf_bo *bo)
> +{
> +	struct drm_device *ddev =3D file->minor->dev;
> +	struct drm_gem_object *obj;
> +	struct iosys_map map;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!bo))
> +		return -EINVAL;
> +
> +	obj =3D drm_gem_object_lookup(file, handle);
> +	if (!obj) {
> +		drm_err(ddev, "Could not find handle %d!\n", handle);
> +		return -EINVAL;
> +	}
> +
> +	if (obj->size < min_size) {
> +		drm_err(ddev,
> +			"Perf BO expected min size %lu, passed BO with size %lu\n",
> +			min_size, obj->size);
> +		ret =3D -ENOMEM;
> +		goto err_put;
> +	}

[Severity: Low]
Both min_size and obj->size have type size_t, so formatting them with %lu
causes a -Wformat warning on 32-bit architectures. Should this use %zu
instead?

> +
> +	ret =3D drm_gem_vmap(obj, &map);
> +	if (ret)
> +		goto err_put;
> +
> +	bo->obj =3D obj;
> +	bo->vaddr =3D map.vaddr;
> +
> +	return 0;
> +
> +err_put:
> +	drm_gem_object_put(obj);
> +	return ret;
> +}
> +
> +static void panthor_perf_bo_put(struct panthor_perf_bo *bo)
> +{
> +	if (!bo->obj)
> +		return;
> +
> +	if (bo->vaddr) {
> +		struct iosys_map map =3D IOSYS_MAP_INIT_VADDR(bo->vaddr);
> +
> +		drm_gem_vunmap(bo->obj, &map);
> +	}

[Severity: High]
What happens if userspace passes a PRIME-imported GEM handle backed by
IOMEM to panthor_perf_bo_get()?

For imported objects, drm_gem_vmap() delegates to dma_buf_vmap(), which
can return an IOMEM mapping with map.is_iomem set to true. Because
panthor_perf_bo_get() discards map.is_iomem and stores only map.vaddr,
the driver dereferences session->control and session->samples directly as
regular system memory, and panthor_perf_bo_put() passes an iosys_map with
is_iomem =3D false to drm_gem_vunmap(), triggering
BUG_ON(!iosys_map_is_equal(&dmabuf->vmap_ptr, map)) in dma_buf_vunmap().

[ ... ]

> +#define DEFINE_SESSION_STATE_CHECK(name, _state)			     \
> +	static bool session_is_## name(struct panthor_perf_session *session) \
> +	{								     \
> +		lockdep_assert_held(&session->state_lock);		     \
> +									     \
> +		return session->state =3D=3D (_state);			    \
> +	}
> +
> +DEFINE_SESSION_STATE_CHECK(active, PANTHOR_PERF_SESSION_ACTIVE);
> +DEFINE_SESSION_STATE_CHECK(starting, PANTHOR_PERF_SESSION_STARTING);
> +DEFINE_SESSION_STATE_CHECK(stopping, PANTHOR_PERF_SESSION_STOPPING);
> +DEFINE_SESSION_STATE_CHECK(destroy, PANTHOR_PERF_SESSION_DESTROY);
> +
> +static bool session_has_overflow(struct panthor_perf_session *session)
> +{
> +	lockdep_assert_held(&session->state_lock);
> +
> +	return session->overflow;
> +}
> +
> +static void session_set_state(struct panthor_perf_session *session,
> +			      enum panthor_perf_session_state state)
> +{
> +	lockdep_assert_held(&session->state_lock);
> +
> +	session->state =3D state;
> +}
> +
> +static u64 session_read_extract_idx(struct panthor_perf_session *session)
> +{
> +	/* Userspace will update their own extract index to indicate that a sam=
ple is consumed
> +	 * from the ringbuffer, and we must ensure we read the latest value.
> +	 */
> +	return smp_load_acquire(&session->control->extract_idx);
> +}

[Severity: High]
Does smp_load_acquire(&session->control->extract_idx) compile on 32-bit
SMP architectures?

session->control->extract_idx is a __u64, and on 32-bit SMP targets
smp_load_acquire() triggers compiletime_assert_atomic_type() because
sizeof(__u64) exceeds sizeof(long).

[ ... ]

> +static int session_try_sample(struct panthor_perf_session *session, u64 =
user_data)
> +{
> +	guard(spinlock_irqsave)(&session->state_lock);
> +
> +	if (!session_is_active(session))
> +		return -EINVAL;
> +
> +	if (session_is_stopping(session))
> +		return -EBUSY;

[Severity: Medium]
Can session_is_stopping(session) ever be reached here?

session->state holds a single enum panthor_perf_session_state value, so
when the state is PANTHOR_PERF_SESSION_STOPPING, !session_is_active() is
 already true and session_try_sample() returns -EINVAL instead of -EBUSY.

[ ... ]

> +int panthor_perf_session_destroy(struct panthor_file *pfile, u32 handle)
> +{
> +	struct panthor_perf_session *session __free(session_put) =3D NULL;
> +	struct panthor_perf *perf =3D pfile->ptdev->perf;
> +	struct panthor_perf_pool *pool =3D pfile->sessions;
> +	int ret =3D -EINVAL;
> +
> +	if (!perf)
> +		return -EOPNOTSUPP;
> +
> +	session =3D session_from_handle(pool, handle);

[Severity: Low]
This isn't a bug, but cleanup.h guidelines prefer defining and
initializing __free() variables in a single statement rather than
initializing them to NULL at the top of the function and assigning them
later. The same pattern appears in panthor_perf_session_start(),
panthor_perf_session_stop(), and panthor_perf_session_sample().

> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_dr=
m.h
> index a2ff0f4ec6915..dfa852aa3690d 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
[ ... ]
> +struct drm_panthor_perf_session_create {
> +	/**
> +	 * @block_set: Set of performance counter blocks, member of
> +	 *             enum drm_panthor_perf_counter_set.
> +	 *
> +	 * This is a global configuration and only one set can be active at a t=
ime. If
> +	 * another client has already requested a counter set, any further requ=
ests
> +	 * for a different counter set will fail and return an -EBUSY.
> +	 *
> +	 * If the requested set does not exist, the request will fail and retur=
n an -EINVAL.
> +	 *
> +	 * Some sets have additional requirements to be enabled, and the setup =
request will
> +	 * fail with an -EACCES if these requirements are not satisfied.
> +	 */
> +	__u32 block_set;
> +
> +	/** @fd: eventfd for signalling the availability of a new sample. */
> +	__u32 fd;
> +
> +	/** @ringbuf_handle: Handle to the BO to write perf counter sample to. =
*/
> +	__u32 ringbuf_handle;
> +
> +	/**
> +	 * @control_handle: Handle to the BO containing a contiguous 16 byte ra=
nge, used for the
> +	 * insert and extract indices for the ringbuffer.
> +	 */
> +	__u32 control_handle;
> +
> +	/**
> +	 * @sample_slots: The number of slots available in the userspace-provid=
ed BO. Must be
> +	 * a power of 2 and at least 2, to leave space for a sample and the fin=
al STOP sample.
> +	 *
> +	 * If sample_slots * sample_size is smaller than the ringbuf BO, the se=
tup will fail.
> +	 */
> +	__u32 sample_slots;
> +
> +	/** @pad: MBZ. */
> +	__u32 pad;

[Severity: High]
Should struct drm_panthor_perf_session_create have an output field for the
allocated session handle instead of returning the handle via *sid as the
ioctl return value?

drm_ioctl() expects driver ioctl handlers to return 0 on success and a
negative errno on failure, and logs an error whenever the return code is
non-zero. Returning a positive session ID from the ioctl breaks standard
DRM userspace wrappers that check for a zero return value on success, and
differs from all other object-creation ioctls in panthor (VM_CREATE,
BO_CREATE, GROUP_CREATE, TILER_HEAP_CREATE).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-panthor-pe=
rformance-counters-v8-0-6e7db0ec33f5@arm.com?part=3D1
