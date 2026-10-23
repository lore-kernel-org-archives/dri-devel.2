Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0B4606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WYXGgmD2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459BF10E1E9;
	Fri, 23 Oct 2026 14:25:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3892A10E1E9
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 14:25:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66AC43294
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:25:05 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 494533F673
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792765508; bh=8wgBzMmQmgcwDMA3gMHG9NeDs1p81gRg9NRdmxL5KZQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WYXGgmD20+3HqpiMfUjS6zhFnXrepE1XqYBBoX+Z83ZT5GJzoWT6gS5BLIrOuLSq1
 /FUlnMSFILtCP4eVW8yRNhUddQ/cP8yYDByV80PXXfjWGGYWQbw78OlimPiaepPOpb
 q9FCe5sQ0xqhAndmy2G3Lhs3256uKQdc4aV1QRXQ=
Date: Fri, 23 Oct 2026 15:24:55 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v7 5/8] drm/panthor: Introduce sampling sessions to
 handle userspace clients
Message-ID: <attuN9c169vUGVm0@e142607>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-5-12c32495062f@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011-panthor-performance-counters-v7-5-12c32495062f@arm.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 11, 2026 at 06:36:52PM +0100, Lukas Zapolskas wrote:
> To allow for combining the requests from multiple userspace clients,
> an intermediary layer between the HW/FW interfaces and userspace is
> created, containing the information for the counter requests and
> tracking of insert and extract indices. Each session starts inactive
> and must be explicitly activated via PERF_SESSION_START and
> explicitly stopped via PERF_SESSION_STOP. Userspace identifies a
> single client with its session ID and the panthor file it is
> associated with.
> 
> The SAMPLE and STOP commands both produce a single sample when called,
> and these samples can be disambiguated via the opaque user data field
> passed in the PERF_SESSION uAPI. If this functionality is not desired,
> these fields can be kept as zero, as the kernel copies this value into
> the corresponding sample without attempting to interpret it.
> 
> Currently, only manual sampling sessions are supported, providing
> samples when userspace calls PERF_CONTROL_SAMPLE, and only a single
> session is allowed at a time. Multiple sessions and periodic sampling
> will be enabled in following patches.
> 
> No protection is provided against the 32-bit hardware counter
> overflows, so for the moment it is up to userspace to ensure that
> the counters are sampled at a reasonable frequency.
> 
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_perf.c | 657 ++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_perf.h |  11 +
>  2 files changed, 664 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
> index ba466e22c50d..76c346981150 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
> @@ -2,10 +2,12 @@
>  /* Copyright 2023 Collabora Ltd */
>  /* Copyright 2025 Arm ltd. */
>  
> -#include <linux/bitops.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_gem.h>
>  #include <drm/drm_managed.h>
>  #include <drm/panthor_drm.h>
>  #include <drm/drm_print.h>
> +#include <linux/bitops.h>
>  
>  #include "panthor_device.h"
>  #include "panthor_fw.h"
> @@ -27,14 +29,130 @@
>  
>  #define MAX_SESSIONS_PER_FILE 1
>  
> +/**
> + * PANTHOR_PERF_EM_BITS - Number of bits in a user-facing enable mask. This must correspond
> + *                        to the maximum number of counters available for selection on the newest
> + *                        Mali GPUs (128 as of the Mali-Gx15).
> + */
> +#define PANTHOR_PERF_EM_BITS (BITS_PER_TYPE(u64) * 2)
> +
> +enum panthor_perf_session_state {
> +	/** @PANTHOR_PERF_SESSION_STOPPED: The session cannot sample. It starts out stopped. */
> +	PANTHOR_PERF_SESSION_STOPPED = 0,
> +
> +	/** @PANTHOR_PERF_SESSION_STARTING: The session has not yet been started and is in the
> +	 *				    process of handling the clearing sample.
> +	 */
> +	PANTHOR_PERF_SESSION_STARTING,
> +
> +	/** @PANTHOR_PERF_SESSION_ACTIVE: The session is active and can be used for sampling. */
> +	PANTHOR_PERF_SESSION_ACTIVE,
> +
> +	/** @PANTHOR_PERF_SESSION_STOPPING: The session is currently stopping. After emitting the
> +	 *				    next sample, it will transition to inactive.
> +	 */
> +	PANTHOR_PERF_SESSION_STOPPING,
> +};
> +
> +struct panthor_perf_enable_masks {
> +	/**
> +	 * @mask: Array of bitmasks indicating the counters userspace requested, where
> +	 *        one bit represents a single counter. Used to build the firmware configuration
> +	 *        and ensure that userspace clients obtain only the counters they requested.
> +	 */
> +	unsigned long mask[DRM_PANTHOR_PERF_BLOCK_MAX][BITS_TO_LONGS(PANTHOR_PERF_EM_BITS)];
> +};

Is the array properly sized here? If one bit is a single counter and we can have up to
PANTHOR_PERF_EM_BITS number of counters in each block up to DRM_PANTHOR_PERF_BLOCK_MAX blocks,
then what's the sizeof(unsigned long) doing here?

Could we use the bitmap.h API instead? Also, use u64 kernel type instead of 'unsigned long'.

> +
>  struct panthor_perf_counter_block {
>  	struct drm_panthor_perf_block_header header;
>  	u64 counters[];
>  };
>  
> +struct panthor_perf_bo {
> +	struct drm_gem_object *obj;
> +	void *vaddr;
> +};
> +
> +struct panthor_perf_session {
> +	/** @state_lock: Used to protect session state information and overflow bit. */
> +	struct mutex state_lock;
> +
> +	/** @state: The current state of the session. */
> +	enum panthor_perf_session_state state;
> +
> +	/** @overflow: The session is affected by a FW ring buffer overflow. */
> +	bool overflow;
> +
> +	/**  @insert_idx: The insert index in the user-visible buffer for the current session. */
> +	u64 insert_idx;
> +
> +	/**
> +	 * @accum_idx: Insert index of the populated slot. When this matches @insert_idx,
> +	 *             accumulate into that slot; otherwise populate a new slot.
> +	 */
> +	u64 accum_idx;
> +
> +	/** @sample_start_ns: Sample request time, obtained from a monotonic raw clock. */
> +	u64 sample_start_ns;
> +
> +	/**
> +	 * @user_data: Opaque handle passed in when starting a session, requesting a sample (for
> +	 *             manual sampling sessions only) and when stopping a session. This handle
> +	 *             allows the disambiguation of a sample in the ringbuffer.
> +	 */
> +	u64 user_data;
> +
> +	/**
> +	 * @eventfd: Event file descriptor context used to signal userspace of a new sample
> +	 *           being emitted.
> +	 */
> +	struct eventfd_ctx *eventfd;
> +
> +	/**
> +	 * @enabled_counters: This session's requested counters. Note that these cannot change
> +	 *                    for the lifetime of the session.
> +	 */
> +	struct panthor_perf_enable_masks *enabled_counters;
> +
> +	/** @ringbuf_slots: Slots in the user-facing ringbuffer. */
> +	size_t ringbuf_slots;
> +
> +	/** @ring_buf: BO and mapping for the userspace ringbuffer. */
> +	struct panthor_perf_bo ring_buf;
> +
> +	/**
> +	 * @control_buf: BO and mapping for the insert and extract indices.
> +	 */
> +	struct panthor_perf_bo control_buf;
> +
> +	/** @control: The mapped insert and extract indices. */
> +	struct drm_panthor_perf_ringbuf_control *control;
> +
> +	/** @samples: The mapping of the @ring_buf into the kernel's VA space. */
> +	u8 *samples;
> +
> +	/**
> +	 * @sessions: The list node tracking all registered sessions.
> +	 */
> +	struct list_head sessions;
> +
> +	/**
> +	 * @ref: Session reference count. The sample delivery to userspace is asynchronous, meaning
> +	 *       the lifetime of the session must extend at least until the sample is exposed to
> +	 *       userspace.
> +	 */
> +	struct kref ref;
> +};
> +
>  struct panthor_perf {
>  	/** @info: Pointer to the previously initialized perf info. */
>  	struct drm_panthor_perf_info *info;
> +
> +	/**
> +	 * @op_lock: Serializes session operations. Acquire before looking up session
> +	 *           handles and before a session's state_lock.
> +	 */
> +	struct mutex op_lock;
>  };
>  
>  struct panthor_perf_pool {
> @@ -43,6 +161,9 @@ struct panthor_perf_pool {
>  
>  	/** @xa: Xarray used to manage session handles. */
>  	struct xarray xa;
> +
> +	/** @next: Next handle to allocate. */
> +	u32 next;
>  };
>  
>  static size_t get_annotated_block_size(size_t counters_per_block)
> @@ -87,6 +208,163 @@ static void panthor_perf_info_init(struct panthor_device *const ptdev)
>  	perf_info->sample_size = session_get_sample_size(perf_info);
>  }
>  
> +static struct panthor_perf_enable_masks *
> +panthor_perf_create_em(struct drm_panthor_perf_session_create *const create_args)
> +{
> +	struct panthor_perf_enable_masks *const em = kmalloc(sizeof(*em), GFP_KERNEL);
> +
> +	if (IS_ERR_OR_NULL(em))
> +		return em;
> +
> +	bitmap_from_arr64(em->mask[DRM_PANTHOR_PERF_BLOCK_FW],
> +			  create_args->fw_enable_mask, PANTHOR_PERF_EM_BITS);

I think you should move PANTHOR_PERF_EM_BITS into panthor_drm.h and use it to define
the drm_panthor_perf_session_create structure, otherwise things will get out of sync.

> +	bitmap_from_arr64(em->mask[DRM_PANTHOR_PERF_BLOCK_CSHW],
> +			  create_args->cshw_enable_mask, PANTHOR_PERF_EM_BITS);
> +	bitmap_from_arr64(em->mask[DRM_PANTHOR_PERF_BLOCK_TILER],
> +			  create_args->tiler_enable_mask, PANTHOR_PERF_EM_BITS);
> +	bitmap_from_arr64(em->mask[DRM_PANTHOR_PERF_BLOCK_MEMSYS],
> +			  create_args->memsys_enable_mask, PANTHOR_PERF_EM_BITS);
> +	bitmap_from_arr64(em->mask[DRM_PANTHOR_PERF_BLOCK_SHADER],
> +			  create_args->shader_enable_mask, PANTHOR_PERF_EM_BITS);
> +
> +	return em;
> +}
> +
> +static struct panthor_perf_session *
> +session_get(struct panthor_perf_session *session)
> +{
> +	if (session)
> +		kref_get(&session->ref);
> +
> +	return session;
> +}
> +
> +static int
> +panthor_perf_bo_get(struct drm_file *file, u32 handle, size_t expected_size,
> +		    struct panthor_perf_bo *bo)
> +{
> +	struct drm_device *ddev = file->minor->dev;
> +	struct drm_gem_object *obj;
> +	struct iosys_map map;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!bo))
> +		return -EINVAL;
> +
> +	obj = drm_gem_object_lookup(file, handle);
> +	if (!obj) {
> +		drm_err(ddev, "Could not find handle %d!\n", handle);
> +		return -EINVAL;
> +	}
> +
> +	if (expected_size && obj->size != PFN_ALIGN(expected_size)) {
> +		drm_err(ddev,
> +			"Incorrect BO size from userspace: user %zu vs kernel %lu\n",
> +			obj->size, PFN_ALIGN(expected_size));
> +		ret = -ENOMEM;
> +		goto err_put;
> +	}
> +
> +	ret = drm_gem_vmap(obj, &map);
> +	if (ret)
> +		goto err_put;
> +
> +	bo->obj = obj;
> +	bo->vaddr = map.vaddr;
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
> +		struct iosys_map map = IOSYS_MAP_INIT_VADDR(bo->vaddr);
> +
> +		drm_gem_vunmap(bo->obj, &map);
> +	}
> +
> +	drm_gem_object_put(bo->obj);
> +
> +	memset(bo, 0, sizeof(*bo));
> +}
> +
> +static void session_free(struct kref *ref)
> +{
> +	struct panthor_perf_session *session = container_of(ref, typeof(*session), ref);
> +
> +	panthor_perf_bo_put(&session->ring_buf);
> +	panthor_perf_bo_put(&session->control_buf);
> +
> +	kfree(session->enabled_counters);
> +
> +	eventfd_ctx_put(session->eventfd);
> +
> +	kfree(session);
> +}
> +
> +static void session_put(struct panthor_perf_session *session)
> +{
> +	kref_put(&session->ref, session_free);
> +}
> +
> +/**
> + * session_from_handle - Find a session associated with the pool and session_handle.
> + *
> + * @pool: Per-file pool.
> + * @handle: Session handle.
> + *
> + * The reference count of a valid session is increased to ensure it does not disappear
> + * in the window between the XA lock being dropped and the internal session functions
> + * being called.
> + *
> + * Return: valid session pointer or NULL.
> + */
> +static struct panthor_perf_session *
> +session_from_handle(struct panthor_perf_pool *pool, unsigned long handle)
> +{
> +	struct panthor_perf_session *session;
> +
> +	xa_lock(&pool->xa);
> +	session = session_get(xa_load(&pool->xa, handle));
> +	xa_unlock(&pool->xa);
> +
> +	return session;
> +}
> +
> +#define DEFINE_SESSION_STATE_CHECK(name, _state)			     \
> +	static bool session_is_## name(struct panthor_perf_session *session) \
> +	{								     \
> +		lockdep_assert_held(&session->state_lock);		     \
> +									     \
> +		return session->state == (_state);			    \
> +	}
> +
> +DEFINE_SESSION_STATE_CHECK(active, PANTHOR_PERF_SESSION_ACTIVE);
> +DEFINE_SESSION_STATE_CHECK(starting, PANTHOR_PERF_SESSION_STARTING);
> +DEFINE_SESSION_STATE_CHECK(stopping, PANTHOR_PERF_SESSION_STOPPING);
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
> +	session->state = state;
> +}
> +
>  /**
>   * panthor_perf_init - Initialize the performance counter subsystem.
>   * @ptdev: Panthor device
> @@ -110,6 +388,10 @@ int panthor_perf_init(struct panthor_device *ptdev)
>  	if (!perf)
>  		return -ENOMEM;
>  
> +	ret = drmm_mutex_init(&ptdev->base, &perf->op_lock);
> +	if (ret)
> +		return ret;
> +
>  	drm_info(&ptdev->base, "Performance counter subsystem initialized");
>  
>  	perf->info = &ptdev->perf_info;
> @@ -118,6 +400,371 @@ int panthor_perf_init(struct panthor_device *ptdev)
>  	return ret;
>  }
>  
> +/**
> + * panthor_perf_session_create - Create a user-visible session.
> + *
> + * @file: DRM file associated with the request.
> + * @create_args: Creation arguments passed in via ioctl.
> + * @sid: Session identifier output.
> + *
> + * Creates a new session associated with the session ID returned. When initialized, the
> + * session must explicitly request sampling to start with a successive call to PERF_SESSION_START.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int panthor_perf_session_create(struct drm_file *file,
> +				struct drm_panthor_perf_session_create *create_args,
> +				unsigned long *sid)
> +{
> +	struct panthor_file *pfile = file->driver_priv;
> +	struct panthor_device *ptdev = pfile->ptdev;
> +	struct panthor_perf_bo ringbuffer = {}, control = {};
> +	const size_t slots = create_args->sample_slots;
> +	struct panthor_perf_pool *pool = pfile->sessions;
> +	struct panthor_perf_session *session;
> +	struct panthor_perf_enable_masks *em;
> +	size_t user_sample_size;
> +	u32 session_id;
> +	int ret;
> +
> +	if (!ptdev->perf)
> +		return -EOPNOTSUPP;
> +
> +	if (!pool)
> +		return -EINVAL;
> +
> +	if (!perfmon_capable())
> +		return -EACCES;
> +
> +	session = kzalloc_obj(*session);
> +	if (ZERO_OR_NULL_PTR(session))
> +		return -ENOMEM;
> +
> +	if (!is_power_of_2(slots)) {
> +		drm_err(&ptdev->base,
> +			"Number of slots is not power-of-2 aligned\n");
> +		ret = -EINVAL;
> +		goto cleanup_session;
> +	}
> +
> +	user_sample_size = ptdev->perf_info.sample_size * slots;
> +
> +	ret = panthor_perf_bo_get(file, create_args->ringbuf_handle,
> +				  user_sample_size, &ringbuffer);
> +	if (ret)
> +		goto cleanup_session;
> +
> +	ret = panthor_perf_bo_get(file, create_args->control_handle, 0, &control);
> +	if (ret)
> +		goto cleanup_ringbuf;
> +
> +	session->eventfd = eventfd_ctx_fdget(create_args->fd);
> +	if (IS_ERR(session->eventfd)) {
> +		drm_err(&ptdev->base, "Invalid eventfd %d!\n", create_args->fd);
> +		ret = PTR_ERR_OR_ZERO(session->eventfd) ?: -EINVAL;
> +		goto cleanup_control;
> +	}
> +
> +	em = panthor_perf_create_em(create_args);
> +	if (IS_ERR_OR_NULL(em)) {
> +		ret = -ENOMEM;
> +		goto cleanup_eventfd;
> +	}
> +
> +	kref_init(&session->ref);
> +	INIT_LIST_HEAD(&session->sessions);
> +	mutex_init(&session->state_lock);
> +	session->control = control.vaddr;
> +	*session->control = (struct drm_panthor_perf_ringbuf_control) { 0 };
> +	session->samples = ringbuffer.vaddr;
> +	session->enabled_counters = em;
> +	session->ring_buf = ringbuffer;
> +	session->ringbuf_slots = slots;
> +	session->control_buf = control;
> +	session->accum_idx = U32_MAX;
> +
> +	ret = xa_alloc_cyclic(&pfile->sessions->xa, &session_id, session,
> +			      pfile->sessions->session_range,
> +			      &pfile->sessions->next, GFP_KERNEL);
> +	if (ret < 0) {
> +		drm_err(&ptdev->base, "File session limit exceeded.\n");
> +		ret = -EBUSY;
> +		goto cleanup_obj;
> +	}
> +
> +	*sid = session_id;
> +	return 0;
> +
> +cleanup_obj:
> +	session_put(session);
> +	return ret;
> +
> +cleanup_eventfd:
> +	eventfd_ctx_put(session->eventfd);
> +
> +cleanup_control:
> +	panthor_perf_bo_put(&control);
> +
> +cleanup_ringbuf:
> +	panthor_perf_bo_put(&ringbuffer);
> +
> +cleanup_session:
> +	kfree(session);
> +
> +	return ret;

It's a bit hard to tell what the right answer is here, as there is no user of this function yet,
but shouldn't sid be cleared even if we return an error?


> +}
> +
> +static int session_try_stop(struct panthor_perf_session *session, u64 user_data)
> +{
> +	guard(mutex)(&session->state_lock);
> +
> +	if (!session_is_active(session))
> +		return 0;
> +
> +	if (session_is_starting(session))
> +		return -EBUSY;
> +
> +	if (session_is_stopping(session))
> +		return 1;
> +
> +	session_set_state(session, PANTHOR_PERF_SESSION_STOPPING);
> +	session->user_data = user_data;
> +
> +	return 1;
> +}
> +
> +static int session_stop(struct panthor_perf *perf, struct panthor_perf_session *session,
> +			u64 user_data)
> +{
> +	int ret;
> +
> +	ret = session_try_stop(session, user_data);
> +	if (ret <= 0)
> +		return ret;
> +
> +	/* TODO Calls to the FW interface will go here in later patches. */
> +	return 0;
> +}
> +
> +static int session_try_start(struct panthor_perf_session *session, u64 user_data)
> +{
> +	guard(mutex)(&session->state_lock);
> +
> +	if (session_is_active(session))
> +		return 0;

This can be removed as it is checked later?

> +
> +	if (session_is_stopping(session))
> +		return -EBUSY;
> +
> +	if (session_is_active(session) || session_is_starting(session))
> +		return 0;

session_try_stop() returns 1 if session_is_stopping(), but here session_try_start() is
returning 0 if session_is_starting(). Is that intentional? Can we document the meaning
of the return values as we can't see yet how they are going to be used?

> +
> +	session_set_state(session, PANTHOR_PERF_SESSION_STARTING);
> +	session->user_data = user_data;
> +
> +	return 1;
> +}
> +
> +static int session_start(struct panthor_perf *perf, struct panthor_perf_session *session,
> +			 u64 user_data)
> +{
> +	int ret;
> +
> +	ret = session_try_start(session, user_data);
> +	if (ret <= 0)
> +		return ret;
> +
> +	/* TODO Calls to the FW interface will go here in later patches. */
> +	return 0;
> +}
> +
> +static int session_try_sample(struct panthor_perf_session *session, u64 user_data)
> +{
> +	guard(mutex)(&session->state_lock);
> +
> +	if (!session_is_active(session))
> +		return -EINVAL;
> +
> +	if (session_is_stopping(session))
> +		return -EBUSY;
> +
> +	if (session_has_overflow(session))
> +		return -EACCES;
> +
> +	session->user_data = user_data;
> +
> +	return 1;
> +}
> +
> +static int session_sample(struct panthor_perf *perf, struct panthor_perf_session *session,
> +			  u64 user_data)
> +{
> +
> +	int ret;
> +
> +	ret = session_try_sample(session, user_data);
> +	if (ret <= 0)
> +		return ret;
> +
> +	/* TODO Calls to the FW interface will go here in later patches. */
> +	return 0;
> +}
> +
> +static int session_try_destroy(struct panthor_perf_session *session)
> +{
> +	guard(mutex)(&session->state_lock);
> +
> +	if (session_is_active(session))
> +		return -EINVAL;
> +
> +	if (session_is_starting(session) || session_is_stopping(session))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +/**
> + * panthor_perf_session_destroy - Destroy the session associated with @handle.
> + * @pfile: Open panthor file.
> + * @handle: Session identifier.
> + *
> + * Only stopped sessions can be destroyed. Other session states return an error.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int panthor_perf_session_destroy(struct panthor_file *pfile, u32 handle)
> +{
> +	struct panthor_perf_session *session;
> +	struct panthor_perf *perf = pfile->ptdev->perf;
> +	int ret;
> +
> +	if (!perf)
> +		return -EOPNOTSUPP;
> +
> +	scoped_guard(mutex, &perf->op_lock) {
> +		session = xa_load(&pfile->sessions->xa, handle);
> +		if (!session)
> +			return -EINVAL;
> +
> +		ret = session_try_destroy(session);
> +		if (ret)
> +			return ret;
> +
> +		xa_erase(&pfile->sessions->xa, handle);
> +	}
> +
> +	session_put(session);
> +
> +	return ret;
> +}
> +
> +/**
> + * panthor_perf_session_start - Start sampling on a stopped session.
> + * @pfile: Open panthor file.
> + * @handle: Session identifier for the desired session.
> + * @user_data: Opaque value passed in from userspace.
> + *
> + * A session counts as stopped when it is created or when it is explicitly stopped after being
> + * started. Starting an active session is treated as a no-op.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int panthor_perf_session_start(struct panthor_file *pfile, u32 handle, u64 user_data)
> +{
> +	struct panthor_perf_session *session;
> +	struct panthor_perf *perf = pfile->ptdev->perf;
> +	int err;
> +
> +	if (!perf)
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&perf->op_lock);
> +
> +	session = session_from_handle(pfile->sessions, handle);
> +	if (IS_ERR_OR_NULL(session))
> +		return IS_ERR(session) ? PTR_ERR(session) : -EINVAL;
> +
> +	err = session_start(perf, session, user_data);
> +
> +	session_put(session);
> +
> +	return err;
> +}
> +
> +/**
> + * panthor_perf_session_stop - Stop sampling on an active session.
> + * @pfile: Open panthor file.
> + * @handle: Session identifier for the desired session.
> + * @user_data: An opaque value passed in from userspace.
> + *
> + * A session counts as active when it has been explicitly started via the PERF_SESSION_START
> + * ioctl. Stopping a stopped session is treated as a no-op.
> + *
> + * To ensure data is not lost when sampling is stopping, there must always be at least one slot
> + * available for the final automatic sample, and the stop command will be rejected if there is not.
> + *
> + * The @user_data will always be associated with the final sample.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int panthor_perf_session_stop(struct panthor_file *pfile, unsigned int handle, u64 user_data)
> +{
> +	struct panthor_perf_session *session;
> +	struct panthor_perf *perf = pfile->ptdev->perf;
> +	int err;
> +
> +	if (!perf)
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&perf->op_lock);
> +
> +	session = session_from_handle(pfile->sessions, handle);
> +	if (IS_ERR_OR_NULL(session))
> +		return IS_ERR(session) ? PTR_ERR(session) : -EINVAL;
> +
> +	err = session_stop(perf, session, user_data);
> +
> +	session_put(session);
> +
> +	return err;
> +}
> +
> +/**
> + * panthor_perf_session_sample - Request a sample on a manual sampling session.
> + * @pfile: Open panthor file.
> + * @handle: Session identifier for the desired session.
> + * @user_data: An opaque value passed in from userspace.
> + *
> + * Only an active manual sampler is permitted to request samples directly. Failing to meet either
> + * of these conditions will cause the sampling request to be rejected. Requesting a manual sample
> + * with a full ringbuffer will see the request being rejected.
> + *
> + * The @user_data will always be unambiguously associated one-to-one with the resultant sample.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int panthor_perf_session_sample(struct panthor_file *pfile, u32 handle, u64 user_data)
> +{
> +	struct panthor_perf_session *session;
> +	struct panthor_perf *perf = pfile->ptdev->perf;
> +	int err;
> +
> +	if (!perf)
> +		return -EOPNOTSUPP;
> +
> +	guard(mutex)(&perf->op_lock);
> +
> +	session = session_from_handle(pfile->sessions, handle);
> +	if (IS_ERR_OR_NULL(session))
> +		return IS_ERR(session) ? PTR_ERR(session) : -EINVAL;
> +
> +	err = session_sample(perf, session, user_data);
> +
> +	session_put(session);
> +
> +	return err;
> +}
> +
>  /**
>   * panthor_perf_unplug - Terminate the performance counter subsystem.
>   * @ptdev: Panthor device.
> @@ -156,13 +803,15 @@ int panthor_perf_pool_create(struct panthor_file *pfile)
>  void panthor_perf_pool_destroy(struct panthor_file *pfile)
>  {
>  	struct panthor_perf_pool *pool = pfile->sessions;
> +	unsigned long handle;
> +	struct panthor_perf_session *session;
>  
>  	if (IS_ERR_OR_NULL(pool))
>  		return;
>  
> -	if (!xa_empty(&pool->xa)) {
> -		drm_err(&pfile->ptdev->base,
> -			"Performance counter sessions active when unplugging the driver!");
> +	xa_for_each(&pool->xa, handle, session) {
> +		xa_erase(&pool->xa, handle);
> +		session_put(session);
>  	}
>  
>  	xa_destroy(&pool->xa);
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
> index ad01fc88f18f..641a88edd75a 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.h
> +++ b/drivers/gpu/drm/panthor/panthor_perf.h
> @@ -7,8 +7,11 @@
>  
>  #include <linux/types.h>
>  
> +struct drm_file;
> +struct drm_panthor_perf_session_create;
>  struct panthor_device;
>  struct panthor_file;
> +struct panthor_perf;
>  struct panthor_perf_pool;
>  
>  int panthor_perf_pool_create(struct panthor_file *pfile);
> @@ -17,5 +20,13 @@ void panthor_perf_pool_destroy(struct panthor_file *pfile);
>  int panthor_perf_init(struct panthor_device *ptdev);
>  void panthor_perf_unplug(struct panthor_device *ptdev);
>  
> +int panthor_perf_session_create(struct drm_file *file,
> +				struct drm_panthor_perf_session_create *setup_args,
> +				unsigned long *sid);
> +int panthor_perf_session_destroy(struct panthor_file *pfile, unsigned int handle);
> +int panthor_perf_session_start(struct panthor_file *pfile, u32 handle, u64 user_data);
> +int panthor_perf_session_stop(struct panthor_file *pfile, unsigned int sid, u64 user_data);
> +int panthor_perf_session_sample(struct panthor_file *pfile, unsigned int handle, u64 user_data);
> +
>  #endif /* __PANTHOR_PERF_H__ */
>  
> 
> -- 
> 2.43.0
> 

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
