Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10477606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHdIXT6G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BED910FA28;
	Wed,  4 Nov 2026 07:53:01 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F2610FA25
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:52:54 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so265598f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793778773; x=1794383573; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cqycFgOKVSS6NgUhwtTP0dN9smWY70wXU/hFF4VXYvY=;
 b=mHdIXT6Gy9xmzpH7vNK3FvMn2g3HDXUS13u6EV1W4TkJ2DSNnxO8hwfVPuYlRzCsbp
 SrN5lrR8+u+ZdZMgxXsdoYd8L/w2ekZI6sdfOMTgh8EwQJMB2g6AEE8kY6Hsyz5CucM3
 fggK/VNhJAEFaBsH+e803jTmoR4If2cquCClUyD7mN2FRlzr/P8TEcUiomw6P1di2E6e
 SsQ1GrLGW2TI12V4oHhivZItwW0KuNR5q+6SphU0NXDR4Cg6tnNLYkaIWPY1IpU68SO9
 F9isxGlrRVIQVVqIK+PdDSPgOTwaweukqyEPUFcoXFBtfkO5pAJaE01mUdjmIyoxxPEV
 5cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793778773; x=1794383573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cqycFgOKVSS6NgUhwtTP0dN9smWY70wXU/hFF4VXYvY=;
 b=YSlSeJNT321jx0M3SqCLECyR42GDQ9HLVirvCJ40kOziWb10ZIlSV4yiWtD3ksqeYW
 53xp9l+s1aeNxbQS2u7qigL9pxU6DjIr4xjhZQYnOAtLgGOucIkYjCVQGxTA/i41aZXY
 P0XsQN200/8jIHRaw34S3UZ3AguaWLoIwMvik3nWDi6lJ9bB14fE2Os1al+uCA4x6dlL
 uCgMm5eK2tnVLDqqZJtfXHJh81PG5Y1BeFUjU4kjTA+6K0wjGq/EMeTFbSV+lgikQNeC
 poi/LyLe8c/PGpxnra0NTNfpERONxapyhAdiZ60jKqwFxal10upQJUkluXrATGzWzqnZ
 lUMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAP7h+RBqXELG/sSclb4VpqQag8uZLQdcfYmz83nRAeKSt519qJINGK0CLH50+7wZhqVlDQsXKVYo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+78BMcoAlHHwAmi/hpl0iKEpOypK4MHthZB33IKItIeSzzAJey
 40VCQDVLhHc6OOcUMDvw4D5nERbfTYkOvCaqu1LxK8vPKrzmveBiqTQo
X-Gm-Gg: AYBFou3N00CkQg5qzCnwVrFz9BUJEzFs9TRGRVP4gfvt0+a8pIxLx33m5t9z9MAmK5K
 x4UBs/YPIuFb1/sYWl8CF0SxkIqDNVSlnGOsiJ5H2s+dD/G/x0VKGD/GK5KwCnaMozGFWlGL0OG
 LNknTXlO02eQpOSC9yVVxJeHHx57v1fWgXXB6qMpOXHdtp21DfefricqtP1+E2c7svR3yEtnGOe
 J6w5lk9xiTHyoCNPbqRxV4CXY+SOOYfqrheAMPmWqZL4zzbHEQ7Rr2wdf9PRAg1M8HK2U7ZnWGl
 4tR042H65ErTANIYTES5Xsg8ezvQUggKqc9mx3o1E3dNZRsRNBeX7LeH3L8D4knwEiu1Ol24twk
 gbZsP4MfAb93N4w3JJh2NWQ+2dTI35hqsTwy+T43KTWY7+bRZcNnrY1cIDOJMTv+K6JwWbtyRPy
 6OM+/N3bOr1Z9nDpCB3V5X2z4sS2H1E8NR/ZUFYsB3GXe4C6SNJ25OfHj2Ngr1R4txpcEDtfmSl
 DUypGKokD5rGjr2J+5T1W8YCUX3RiBoVQDgAa5gzCj5MAw7WRmNuA53Dm82JsGfvGD/nB5MYaGB
 9XenT530AchXNILtFi1jpvnAmm/xTYKvmn6yldiW/VdaNz0VkAN3dQlz9ThW4J205kcALQEkZ06
 Z/WJLylmZDa0KEBk1W9IZUGXSE2rJwX7Ua1nHCTrc2eBeopkAs5k=
X-Received: by 2002:a05:6000:4a13:b0:48b:9d2:1a6a with SMTP id
 ffacd0b85a97d-48e6e2b9ce9mr33693968f8f.1.1793778773094; 
 Tue, 03 Nov 2026 23:52:53 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda207d8sm2200785f8f.52.2026.11.03.23.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:52:52 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 04 Nov 2026 08:52:40 +0100
Subject: [PATCH v2 2/3] drm/panthor: Report the CS fatal errors through
 GROUP_GET_STATE
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-panthor-fault-info-v2-v2-2-673b31f3840c@igalia.com>
References: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
In-Reply-To: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 Paul Toadere <paul.toadere@arm.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

Keep the raw CS_FATAL and CS_FATAL_INFO in the queue that hit them and
return them through GROUP_GET_STATE in an array indexed by queue.
Userspace decodes the values. No memory is allocated in the fatal path.

A queue stops at its first fatal error, so one slot per queue is
enough. The slot is a struct drm_panthor_queue_fatal, which is the uAPI
struct, so the ioctl can copy it with one assignment. The CS_FATAL
event handler writes the slot under events_lock. The ioctl reads it
under the same lock. The slot is never cleared, so the values can be
read again after the call.

The ioctl copies the slots of all queues to a stack array while the
locks are held and copies them to userspace after the locks are
dropped. It fills at most one entry per queue of the group and leaves
the rest of the user array untouched.

A queue can be flagged in fatal_queues without a CS_FATAL, for example
when the group was killed by a VM fault. Its entry then has a zero
exception. The VM fault itself is available through VM_GET_STATE.

Old userspace that passes the shorter struct still works, the DRM core
zero-fills the missing tail. A zero count skips the array.

Link: https://lore.kernel.org/r/20251215115457.2137485-3-lukas.zapolskas@arm.com
Link: https://lore.kernel.org/r/20251215115457.2137485-6-lukas.zapolskas@arm.com
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c   | 20 ++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_sched.c | 32 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_sched.h |  5 ++++-
 include/uapi/drm/panthor_drm.h          | 30 ++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 7572cd7d6423..fb5fdf848dec 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -181,7 +181,8 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs), \
-		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size))
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_fatal, exception_info))
 
 /**
  * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
@@ -1254,10 +1255,25 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 static int panthor_ioctl_group_get_state(struct drm_device *ddev, void *data,
 					 struct drm_file *file)
 {
+	struct drm_panthor_queue_fatal fatals[MAX_CS_PER_CSG];
 	struct panthor_file *pfile = file->driver_priv;
 	struct drm_panthor_group_get_state *args = data;
+	u64 usr_ptr = args->queue_fatals.array;
+	u32 stride = args->queue_fatals.stride;
+	u32 count;
+	int ret;
 
-	return panthor_group_get_state(pfile, args);
+	ret = panthor_group_get_state(pfile, args, fatals, &count);
+	if (ret)
+		return ret;
+
+	for (u32 i = 0; i < count; i++) {
+		ret = PANTHOR_UOBJ_SET(usr_ptr + (u64)i * stride, stride, fatals[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int panthor_ioctl_tiler_heap_create(struct drm_device *ddev, void *data,
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a343c5180e01..40400b2e4551 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -485,6 +485,15 @@ struct panthor_queue {
 		/** @profiling.seqno: Index of the next available profiling information slot. */
 		u32 seqno;
 	} profiling;
+
+	/**
+	 * @fatal: Last CS_FATAL reported on this queue.
+	 *
+	 * Never cleared, a later CS_FATAL overwrites it. A zero exception
+	 * means no CS_FATAL was reported. Protected by
+	 * panthor_scheduler::events_lock.
+	 */
+	struct drm_panthor_queue_fatal fatal;
 };
 
 /**
@@ -1412,10 +1421,20 @@ cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
 	info = cs_iface->output->fatal_info;
 
 	if (group) {
+		struct panthor_queue *queue = cs_id < group->queue_count ?
+					      group->queues[cs_id] : NULL;
+
 		drm_warn(&ptdev->base, "CS_FATAL: pid=%d, comm=%s\n",
 			 group->task_info.pid, group->task_info.comm);
 
 		atomic_or(BIT(cs_id), &group->fatal_queues);
+
+		if (queue) {
+			queue->fatal = (struct drm_panthor_queue_fatal){
+				.exception = fatal,
+				.exception_info = info,
+			};
+		}
 	}
 
 	if (CS_EXCEPTION_TYPE(fatal) == DRM_PANTHOR_EXCEPTION_CS_UNRECOVERABLE) {
@@ -3818,8 +3837,11 @@ static struct panthor_group *group_from_handle(struct panthor_group_pool *pool,
 }
 
 int panthor_group_get_state(struct panthor_file *pfile,
-			    struct drm_panthor_group_get_state *get_state)
+			    struct drm_panthor_group_get_state *get_state,
+			    struct drm_panthor_queue_fatal *fatals,
+			    u32 *fatal_count)
 {
+	struct drm_panthor_obj_array queue_fatals = get_state->queue_fatals;
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_scheduler *sched = ptdev->scheduler;
@@ -3833,6 +3855,9 @@ int panthor_group_get_state(struct panthor_file *pfile,
 		return -EINVAL;
 
 	memset(get_state, 0, sizeof(*get_state));
+	get_state->queue_fatals = queue_fatals;
+
+	*fatal_count = min(queue_fatals.count, group->queue_count);
 
 	mutex_lock(&sched->lock);
 	if (atomic_read(&group->timedout))
@@ -3844,6 +3869,11 @@ int panthor_group_get_state(struct panthor_file *pfile,
 
 	if (group->innocent)
 		get_state->state |= DRM_PANTHOR_GROUP_STATE_INNOCENT;
+
+	scoped_guard(spinlock, &sched->events_lock) {
+		for (u32 i = 0; i < *fatal_count; i++)
+			fatals[i] = group->queues[i]->fatal;
+	}
 	mutex_unlock(&sched->lock);
 
 	group_put(group);
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index d87cbdba4d40..dd3d31c06cf1 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -14,6 +14,7 @@ struct drm_minor;
 struct drm_panthor_group_create;
 struct drm_panthor_queue_create;
 struct drm_panthor_group_get_state;
+struct drm_panthor_queue_fatal;
 struct drm_panthor_queue_submit;
 struct panthor_device;
 struct panthor_file;
@@ -26,7 +27,9 @@ int panthor_group_create(struct panthor_file *pfile,
 			 u64 drm_client_id);
 int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle);
 int panthor_group_get_state(struct panthor_file *pfile,
-			    struct drm_panthor_group_get_state *get_state);
+			    struct drm_panthor_group_get_state *get_state,
+			    struct drm_panthor_queue_fatal *fatals,
+			    u32 *fatal_count);
 
 struct drm_sched_job *
 panthor_job_create(struct panthor_file *pfile,
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 85e197d7a528..c9a681762b96 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -1072,6 +1072,27 @@ enum drm_panthor_group_state_flags {
 	DRM_PANTHOR_GROUP_STATE_INNOCENT = 1 << 2,
 };
 
+/**
+ * struct drm_panthor_queue_fatal - Fatal error of a single queue.
+ */
+struct drm_panthor_queue_fatal {
+	/**
+	 * @exception: Raw CS_FATAL value.
+	 *
+	 * Zero if no CS_FATAL was reported on this queue. A queue can be
+	 * flagged in drm_panthor_group_get_state::fatal_queues without a
+	 * CS_FATAL, for instance when the group was killed by a VM fault.
+	 * A later CS_FATAL overwrites the previous one.
+	 */
+	__u32 exception;
+
+	/** @pad: Will be zero on return. */
+	__u32 pad;
+
+	/** @exception_info: Raw CS_FATAL_INFO value, valid if @exception is non-zero. */
+	__u64 exception_info;
+};
+
 /**
  * struct drm_panthor_group_get_state - Arguments passed to DRM_IOCTL_PANTHOR_GROUP_GET_STATE
  *
@@ -1093,6 +1114,15 @@ struct drm_panthor_group_get_state {
 
 	/** @pad: MBZ */
 	__u32 pad;
+
+	/**
+	 * @queue_fatals: Array of struct drm_panthor_queue_fatal, indexed by queue.
+	 *
+	 * Entry N describes the queue at index N of the group creation array.
+	 * The driver fills at most as many entries as the group has queues and
+	 * leaves the rest untouched. A zero count skips the array.
+	 */
+	struct drm_panthor_obj_array queue_fatals;
 };
 
 /**

-- 
2.56.0

