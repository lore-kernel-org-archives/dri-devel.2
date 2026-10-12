Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8AACA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1061310F0A6;
	Mon, 12 Oct 2026 13:00:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 22BFC10F0A6
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:00:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A1A11655;
 Mon, 12 Oct 2026 06:00:21 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 923C13F66F;
 Mon, 12 Oct 2026 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791810024; bh=v7EmvNju9Oe0rmwSf6Sxhi8oR0v8qpfI9YQMwWDeJ1c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g74xb2An9R/OJxAFP2n8aA3wp4jqJolmnqbCRCY494h0LQP8l5JxWb1eABn86HBqV
 fMRadLjA8goZN5wIkfL/pl5FSSscEmNu6zOXt+QmBwl8jsJxDSn9PgFJCs88Zu75lk
 4N9fcy7kObogO2TJW/+kaoxOY1g/o1pTyR2JcQK4=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v4 11/12] drm/panthor: Protm support for groups
Date: Mon, 12 Oct 2026 14:59:39 +0200
Message-ID: <20261012125940.3291951-12-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125940.3291951-1-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Boris Brezillon <boris.brezillon@collabora.com>

Extends struct drm_panthor_group_create to allow user provided protm
suspend buffer. This is needed for protm execution with this group.

Make use of the user supplied suspend buffer (import).

Allow PROT_REGION instruction for groups which provided protm
suspend buffer.

Store the suspend buffer sizes (normal and protected) provided by FW
after FW start. Unsafe to read directly from FW as these will return
zero between FW load and FW start.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

---

v4:
- First version of this change as a separate commit
---
 drivers/gpu/drm/panthor/panthor_fw.c    | 24 ++++++++++
 drivers/gpu/drm/panthor/panthor_fw.h    |  2 +
 drivers/gpu/drm/panthor/panthor_sched.c | 59 ++++++++++++++++++++-----
 include/uapi/drm/panthor_drm.h          | 10 ++++-
 4 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 0af6addfd55a5..11c370ef86aad 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -269,6 +269,12 @@ struct panthor_fw {
 	/** @protm_init_lock: Used to serialize protm initialization. */
 	struct mutex protm_init_lock;
 
+	/** @suspend_size: Size of regular suspend buffer */
+	u32 suspend_size;
+
+	/** @protm_suspend_size: Size of protected suspend buffer size */
+	u32 protm_suspend_size;
+
 	/**
 	 * @req_waitqueue: FW request waitqueue.
 	 *
@@ -1006,6 +1012,14 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 	}
 
 	if (!csg_idx) {
+		/* We make a copy of these sizes, as csg_iface can read these
+		 * as zero during full GPU reset, between FW sections being
+		 * reloaded and FW fully booted.
+		 */
+		ptdev->fw->suspend_size = csg_iface->control->suspend_size;
+		ptdev->fw->protm_suspend_size =
+			csg_iface->control->protm_suspend_size;
+
 		ptdev->protm.info.group_protected_suspend_buf_size =
 			csg_iface->control->protm_suspend_size;
 	}
@@ -1523,6 +1537,16 @@ static void panthor_fw_ping_work(struct work_struct *work)
 	}
 }
 
+u32 panthor_fw_suspend_size(struct panthor_device *ptdev)
+{
+	return ptdev->fw->suspend_size;
+}
+
+u32 panthor_fw_protm_suspend_size(struct panthor_device *ptdev)
+{
+	return ptdev->fw->protm_suspend_size;
+}
+
 static bool wait_protm_enter(struct panthor_device *ptdev,
 			     s64 protm_session_seqno)
 {
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index 34bc9dc82314c..98576114cc803 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -531,6 +531,8 @@ void panthor_fw_unplug(struct panthor_device *ptdev);
 
 int panthor_fw_protm_init(struct drm_file *file,
 			  struct drm_panthor_protm_init *args);
+u32 panthor_fw_suspend_size(struct panthor_device *ptdev);
+u32 panthor_fw_protm_suspend_size(struct panthor_device *ptdev);
 int panthor_fw_protm_enter(struct panthor_device *ptdev);
 int panthor_fw_protm_exit(struct panthor_device *ptdev, u32 timeout_ms);
 int panthor_fw_protm_exit_wait(struct panthor_device *ptdev, u32 timeout_ms);
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index fff805fd794a5..d1178be178a48 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1462,10 +1462,15 @@ cs_slot_process_protm_pending_event_locked(struct panthor_device *ptdev,
 	if (!group)
 		return;
 
-	/* Do not allow user space work to switch into protected mode, as we
-	 * do not fully support this quite yet.
+	/* Do not allow user space work to switch into protected mode if we
+	 * do not support protected mode on this device.
+	 * User space should query (and init) this support before attempting
+	 * to use such GPU instructions.
 	 */
-	atomic_or(BIT(cs_id), &group->fatal_queues);
+	if (group->protm_suspend_buf)
+		atomic_or(BIT(cs_id), &group->protm_pending_queues);
+	else
+		atomic_or(BIT(cs_id), &group->fatal_queues);
 
 	sched_queue_delayed_work(sched, tick, 0);
 }
@@ -4074,6 +4079,7 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
 }
 
 #define MAX_GROUPS_PER_POOL		128
+#define GROUP_CREATE_FLAGS DRM_PANTHOR_GROUP_CREATE_PROTECTED
 
 int panthor_group_create(struct drm_file *file,
 			 const struct drm_panthor_group_create *group_args,
@@ -4083,14 +4089,10 @@ int panthor_group_create(struct drm_file *file,
 	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_scheduler *sched = ptdev->scheduler;
-	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, 0);
 	struct panthor_group *group = NULL;
-	u32 gid, i, suspend_size;
+	u32 gid, i;
 	int ret;
 
-	if (group_args->pad)
-		return -EINVAL;
-
 	if (group_args->priority >= PANTHOR_CSG_PRIORITY_COUNT)
 		return -EINVAL;
 
@@ -4136,14 +4138,51 @@ int panthor_group_create(struct drm_file *file,
 		goto err_put_group;
 	}
 
-	suspend_size = csg_iface->control->suspend_size;
-	group->suspend_buf = panthor_fw_alloc_suspend_buf_mem(ptdev, suspend_size);
+	group->suspend_buf = panthor_fw_alloc_suspend_buf_mem(
+		ptdev, panthor_fw_suspend_size(ptdev));
 	if (IS_ERR(group->suspend_buf)) {
 		ret = PTR_ERR(group->suspend_buf);
 		group->suspend_buf = NULL;
 		goto err_put_group;
 	}
 
+	if (group_args->protected_suspend_bo_handle) {
+		struct drm_gem_object *obj;
+
+		/* Read a correct snapshot of the state */
+		if (!(smp_load_acquire(&ptdev->protm.info.state) &
+		      DRM_PANTHOR_PROTM_INITIALIZED)) {
+			ret = -EINVAL;
+			goto err_put_group;
+		}
+
+		obj = drm_gem_object_lookup(
+			file, group_args->protected_suspend_bo_handle);
+		if (!obj) {
+			ret = -ENOENT;
+			goto err_put_group;
+		}
+
+		if (obj->size <
+		    ptdev->protm.info.group_protected_suspend_buf_size) {
+			drm_gem_object_put(obj);
+			ret = -EINVAL;
+			goto err_put_group;
+		}
+
+		group->protm_suspend_buf = panthor_kernel_bo_create_from_gem(
+			ptdev, panthor_fw_vm(ptdev), to_panthor_bo(obj),
+			DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
+			PANTHOR_VM_KERNEL_AUTO_VA,
+			panthor_fw_protm_suspend_size(ptdev));
+		drm_gem_object_put(obj);
+		if (IS_ERR(group->protm_suspend_buf)) {
+			ret = PTR_ERR(group->protm_suspend_buf);
+			group->protm_suspend_buf = NULL;
+			goto err_put_group;
+		}
+	}
+
 	group->syncobjs = panthor_kernel_bo_create(ptdev, group->vm,
 						   group_args->queues.count *
 						   sizeof(struct panthor_syncobj_64b),
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index d2d21e3e6bb39..a0ed16041e178 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -956,8 +956,14 @@ struct drm_panthor_group_create {
 	/** @priority: Group priority (see enum drm_panthor_group_priority). */
 	__u8 priority;
 
-	/** @pad: Padding field, MBZ. */
-	__u32 pad;
+	/**
+	 * @protected_suspend_bo_handle: BO to use as a protected suspend buffer.
+	 *
+	 * This BO must have been allocated from a protected DMA-BUF heap and
+	 * imported in panthor. It's size must be at least
+	 * drm_panthor_protm_info::group_protected_suspend_buf_size.
+	 */
+	__u32 protected_suspend_bo_handle;
 
 	/**
 	 * @compute_core_mask: Mask encoding cores that can be used for compute jobs.
-- 
2.43.0

