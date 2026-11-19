Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B182606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=IJbLLc64
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74DB61121A5;
	Thu, 19 Nov 2026 08:49:00 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4131121A6
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795078132;
 bh=2FHraf9k5tLJvWx0QDAXPTlxhgruwXzkE4MjFtD3vwg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=IJbLLc64z2vZGcceBpOa+QCSbCT8vk3w/kTgT8O7KbCSJY20O07zsJ4k+Owa4rnxJ
 FoUOakHbfet0FiMBKDfwdU8aDQ95jiuDRKgm4DtQLrldMrJod2AOZtUQRxwnEyN9Xo
 WYbpDYHR6sXiGsjkGho4L5QN0s3gmIJfDyyHWO2y6vp7PnhcrCWED0eUWi9fvHHwMV
 aypewaycjlx02C95JUjNRWN3KyxvsaztwlVqUbIy6GzRCUBO71KUsfu4klKuq6ZX+v
 q53VmdpNmZZzv9jwogMTi5n75sIGGM8Aks2FEAzyps6svLVG5XP82tOy0DKSwoRqav
 p9t/eFC4SzUmA==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4C72517E0480;
 Thu, 19 Nov 2026 09:48:52 +0100 (CET)
Date: Thu, 19 Nov 2026 09:48:46 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Paul Toadere <paul.toadere@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>
Subject: Re: [PATCH v2 2/3] drm/panthor: Report the CS fatal errors through
 GROUP_GET_STATE
Message-ID: <20261119094846.5cc0f99a@fedora1.home>
In-Reply-To: <20261104-panthor-fault-info-v2-v2-2-673b31f3840c@igalia.com>
References: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
 <20261104-panthor-fault-info-v2-v2-2-673b31f3840c@igalia.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On Wed, 04 Nov 2026 08:52:40 +0100
Christian Gmeiner <christian.gmeiner@gmail.com> wrote:

> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> Keep the raw CS_FATAL and CS_FATAL_INFO in the queue that hit them and
> return them through GROUP_GET_STATE in an array indexed by queue.
> Userspace decodes the values. No memory is allocated in the fatal path.
> 
> A queue stops at its first fatal error, so one slot per queue is
> enough. The slot is a struct drm_panthor_queue_fatal, which is the uAPI
> struct, so the ioctl can copy it with one assignment. The CS_FATAL
> event handler writes the slot under events_lock. The ioctl reads it
> under the same lock. The slot is never cleared, so the values can be
> read again after the call.
> 
> The ioctl copies the slots of all queues to a stack array while the
> locks are held and copies them to userspace after the locks are
> dropped. It fills at most one entry per queue of the group and leaves
> the rest of the user array untouched.
> 
> A queue can be flagged in fatal_queues without a CS_FATAL, for example
> when the group was killed by a VM fault. Its entry then has a zero
> exception. The VM fault itself is available through VM_GET_STATE.
> 
> Old userspace that passes the shorter struct still works, the DRM core
> zero-fills the missing tail. A zero count skips the array.
> 
> Link: https://lore.kernel.org/r/20251215115457.2137485-3-lukas.zapolskas@arm.com
> Link: https://lore.kernel.org/r/20251215115457.2137485-6-lukas.zapolskas@arm.com
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c   | 20 ++++++++++++++++++--
>  drivers/gpu/drm/panthor/panthor_sched.c | 32 +++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_sched.h |  5 ++++-
>  include/uapi/drm/panthor_drm.h          | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 7572cd7d6423..fb5fdf848dec 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -181,7 +181,8 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs), \
> -		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size))
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_fatal, exception_info))
>  
>  /**
>   * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
> @@ -1254,10 +1255,25 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
>  static int panthor_ioctl_group_get_state(struct drm_device *ddev, void *data,
>  					 struct drm_file *file)
>  {
> +	struct drm_panthor_queue_fatal fatals[MAX_CS_PER_CSG];
>  	struct panthor_file *pfile = file->driver_priv;
>  	struct drm_panthor_group_get_state *args = data;
> +	u64 usr_ptr = args->queue_fatals.array;
> +	u32 stride = args->queue_fatals.stride;
> +	u32 count;
> +	int ret;
>  
> -	return panthor_group_get_state(pfile, args);
> +	ret = panthor_group_get_state(pfile, args, fatals, &count);
> +	if (ret)
> +		return ret;
> +
> +	for (u32 i = 0; i < count; i++) {
> +		ret = PANTHOR_UOBJ_SET(usr_ptr + (u64)i * stride, stride, fatals[i]);
> +		if (ret)
> +			return ret;
> +	}

Is it time for a PANTHOR_UOBJ_SET_ARRAY() helper? I know there would be
just one user for now, but I'd rather not encourage people to hand-code
this, and I know that some new VM_BIND use cases will require us to
return data to the user through drm_panthor_vm_bind_op, which is passed
as an indirect array too.

> +
> +	return 0;
>  }
>  
>  static int panthor_ioctl_tiler_heap_create(struct drm_device *ddev, void *data,
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index a343c5180e01..40400b2e4551 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -485,6 +485,15 @@ struct panthor_queue {
>  		/** @profiling.seqno: Index of the next available profiling information slot. */
>  		u32 seqno;
>  	} profiling;
> +
> +	/**
> +	 * @fatal: Last CS_FATAL reported on this queue.
> +	 *
> +	 * Never cleared, a later CS_FATAL overwrites it. A zero exception
> +	 * means no CS_FATAL was reported. Protected by
> +	 * panthor_scheduler::events_lock.
> +	 */
> +	struct drm_panthor_queue_fatal fatal;
>  };
>  
>  /**
> @@ -1412,10 +1421,20 @@ cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
>  	info = cs_iface->output->fatal_info;
>  
>  	if (group) {
> +		struct panthor_queue *queue = cs_id < group->queue_count ?
> +					      group->queues[cs_id] : NULL;
> +
>  		drm_warn(&ptdev->base, "CS_FATAL: pid=%d, comm=%s\n",
>  			 group->task_info.pid, group->task_info.comm);
>  
>  		atomic_or(BIT(cs_id), &group->fatal_queues);

We also update fatal_queues in the tiler OOM path if we get passed
inconsistent properties. Dunno if we should set execption=OUT_OF_MEMORY
in that case. fatal_queues is also forced "all-set" if the FW becomes
unresponsive in the tick update path, which could qualify as
FIRMWARE_INTERNAL_ERROR. My point being that, for any bit set in
fatal_queues, we should probably have a valid queue->fatal.exception
value set, even if it's not necessarily the HW telling us what went
wrong, so the UMD doesn't have to guess.

> +
> +		if (queue) {
> +			queue->fatal = (struct drm_panthor_queue_fatal){
> +				.exception = fatal,
> +				.exception_info = info,
> +			};
> +		}
>  	}
>  
>  	if (CS_EXCEPTION_TYPE(fatal) == DRM_PANTHOR_EXCEPTION_CS_UNRECOVERABLE) {
> @@ -3818,8 +3837,11 @@ static struct panthor_group *group_from_handle(struct panthor_group_pool *pool,
>  }
>  
>  int panthor_group_get_state(struct panthor_file *pfile,
> -			    struct drm_panthor_group_get_state *get_state)
> +			    struct drm_panthor_group_get_state *get_state,
> +			    struct drm_panthor_queue_fatal *fatals,
> +			    u32 *fatal_count)
>  {
> +	struct drm_panthor_obj_array queue_fatals = get_state->queue_fatals;
>  	struct panthor_group_pool *gpool = pfile->groups;
>  	struct panthor_device *ptdev = pfile->ptdev;
>  	struct panthor_scheduler *sched = ptdev->scheduler;
> @@ -3833,6 +3855,9 @@ int panthor_group_get_state(struct panthor_file *pfile,
>  		return -EINVAL;
>  
>  	memset(get_state, 0, sizeof(*get_state));
> +	get_state->queue_fatals = queue_fatals;
> +
> +	*fatal_count = min(queue_fatals.count, group->queue_count);
>  
>  	mutex_lock(&sched->lock);
>  	if (atomic_read(&group->timedout))
> @@ -3844,6 +3869,11 @@ int panthor_group_get_state(struct panthor_file *pfile,
>  
>  	if (group->innocent)
>  		get_state->state |= DRM_PANTHOR_GROUP_STATE_INNOCENT;
> +
> +	scoped_guard(spinlock, &sched->events_lock) {
> +		for (u32 i = 0; i < *fatal_count; i++)
> +			fatals[i] = group->queues[i]->fatal;
> +	}

I guess the fatal_queues state propagation should be done under that
lock, otherwise we might end up with inconsistent
fatals[]/fatal_queues values. That, or we re-order things so that
fatals[] gets updated before the atomic_or() in
cs_slot_process_fatal_event_locked().

>  	mutex_unlock(&sched->lock);
>  
>  	group_put(group);
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
> index d87cbdba4d40..dd3d31c06cf1 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.h
> +++ b/drivers/gpu/drm/panthor/panthor_sched.h
> @@ -14,6 +14,7 @@ struct drm_minor;
>  struct drm_panthor_group_create;
>  struct drm_panthor_queue_create;
>  struct drm_panthor_group_get_state;
> +struct drm_panthor_queue_fatal;
>  struct drm_panthor_queue_submit;
>  struct panthor_device;
>  struct panthor_file;
> @@ -26,7 +27,9 @@ int panthor_group_create(struct panthor_file *pfile,
>  			 u64 drm_client_id);
>  int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle);
>  int panthor_group_get_state(struct panthor_file *pfile,
> -			    struct drm_panthor_group_get_state *get_state);
> +			    struct drm_panthor_group_get_state *get_state,
> +			    struct drm_panthor_queue_fatal *fatals,
> +			    u32 *fatal_count);
>  
>  struct drm_sched_job *
>  panthor_job_create(struct panthor_file *pfile,
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index 85e197d7a528..c9a681762b96 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -1072,6 +1072,27 @@ enum drm_panthor_group_state_flags {
>  	DRM_PANTHOR_GROUP_STATE_INNOCENT = 1 << 2,
>  };
>  
> +/**
> + * struct drm_panthor_queue_fatal - Fatal error of a single queue.
> + */
> +struct drm_panthor_queue_fatal {
> +	/**
> +	 * @exception: Raw CS_FATAL value.
> +	 *
> +	 * Zero if no CS_FATAL was reported on this queue. A queue can be
> +	 * flagged in drm_panthor_group_get_state::fatal_queues without a
> +	 * CS_FATAL, for instance when the group was killed by a VM fault.

As I was saying above, I was hoping we could make it so any bit set in
fatal_queues gets a non-zero exception here, even if it's "fake". This
way, userspace doesn't have to guess what happened when a fatal event
is reported with no exception (is it tiler OOM handling failing? is it
a FW hang? and there's probably more of these situations to come with
newer gens).

> +	 * A later CS_FATAL overwrites the previous one.
> +	 */
> +	__u32 exception;
> +
> +	/** @pad: Will be zero on return. */
> +	__u32 pad;
> +
> +	/** @exception_info: Raw CS_FATAL_INFO value, valid if @exception is non-zero. */
> +	__u64 exception_info;
> +};
> +
>  /**
>   * struct drm_panthor_group_get_state - Arguments passed to DRM_IOCTL_PANTHOR_GROUP_GET_STATE
>   *
> @@ -1093,6 +1114,15 @@ struct drm_panthor_group_get_state {
>  
>  	/** @pad: MBZ */
>  	__u32 pad;
> +
> +	/**
> +	 * @queue_fatals: Array of struct drm_panthor_queue_fatal, indexed by queue.
> +	 *
> +	 * Entry N describes the queue at index N of the group creation array.
> +	 * The driver fills at most as many entries as the group has queues and
> +	 * leaves the rest untouched. A zero count skips the array.

Should we specify that these entries only need to be considered if the
associated bit is set in the fatal_queues field?

Other than these minor things, it looks good overall.

Regards,

Boris
