Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13087FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFD310E42B;
	Tue,  5 May 2026 14:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Zo2NNC6U";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9079D10E42B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:06:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C37E224C0;
 Tue,  5 May 2026 07:06:01 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A00C33F763;
 Tue,  5 May 2026 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777989967; bh=RZvyoxTCxXRjVJaFXhiWOVuOJVHUHB2e/Xmp4YZCn8k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zo2NNC6UTvAbVFwC6NXIU/sC+mHzAOIOZIxbnV5hedjZH7gPgueOaTT6IBChwbSgT
 8sP3zf5Xj5vAbgFzjbYix1ygPjPiNZkPJUaOZtbJlizTjmDYwnYpJFvcu1+pSQ0b2c
 OOO9XZ8qMNcTPtyY4YyFteYVruZ33shx+qExV9uA=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH 8/8] drm/panthor: Expose protected rendering features
Date: Tue,  5 May 2026 16:05:14 +0200
Message-ID: <20260505140516.1372388-9-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505140516.1372388-1-ketil.johnsen@arm.com>
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
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

Add query for protected rendering capability.
Add flag to group creation to specify need for protected rendering.
Bump panthor version number.

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c   | 21 +++++++++++-
 drivers/gpu/drm/panthor/panthor_sched.c | 21 +++++++-----
 include/uapi/drm/panthor_drm.h          | 45 +++++++++++++++++++++++--
 3 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 73fc983dc9b44..817df17f31f15 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -177,6 +177,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestamp), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_protected_info, features), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
@@ -928,12 +929,20 @@ static void panthor_query_group_priorities_info(struct drm_file *file,
 	}
 }
 
+static void panthor_query_protected_info(struct panthor_device *ptdev,
+					 struct drm_panthor_protected_info *arg)
+{
+	arg->features =
+		ptdev->protm.heap ? DRM_PANTHOR_PROTECTED_FEATURE_BASIC : 0;
+}
+
 static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct drm_file *file)
 {
 	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
 	struct drm_panthor_dev_query *args = data;
 	struct drm_panthor_timestamp_info timestamp_info;
 	struct drm_panthor_group_priorities_info priorities_info;
+	struct drm_panthor_protected_info protected_info;
 	int ret;
 
 	if (!args->pointer) {
@@ -954,6 +963,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(priorities_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_PROTECTED_INFO:
+			args->size = sizeof(protected_info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -984,6 +997,11 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 		panthor_query_group_priorities_info(file, &priorities_info);
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, priorities_info);
 
+	case DRM_PANTHOR_DEV_QUERY_PROTECTED_INFO:
+		panthor_query_protected_info(ptdev, &protected_info);
+		return PANTHOR_UOBJ_SET(args->pointer, args->size,
+					protected_info);
+
 	default:
 		return -EINVAL;
 	}
@@ -1779,6 +1797,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
  *       - adds drm_panthor_gpu_info::selected_coherency
  * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
+ * - 1.9 - adds DEV_QUERY_PROTECTED_INFO query
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1792,7 +1811,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 8,
+	.minor = 9,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
 	.gem_prime_import = panthor_gem_prime_import,
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index acb04250c7def..0e8a1059de589 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3868,6 +3868,7 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
 }
 
 #define MAX_GROUPS_PER_POOL		128
+#define GROUP_CREATE_FLAGS DRM_PANTHOR_GROUP_CREATE_PROTECTED
 
 int panthor_group_create(struct panthor_file *pfile,
 			 const struct drm_panthor_group_create *group_args,
@@ -3882,10 +3883,10 @@ int panthor_group_create(struct panthor_file *pfile,
 	u32 gid, i, suspend_size;
 	int ret;
 
-	if (group_args->pad)
+	if (group_args->priority >= PANTHOR_CSG_PRIORITY_COUNT)
 		return -EINVAL;
 
-	if (group_args->priority >= PANTHOR_CSG_PRIORITY_COUNT)
+	if (group_args->flags & ~GROUP_CREATE_FLAGS)
 		return -EINVAL;
 
 	if ((group_args->compute_core_mask & ~ptdev->gpu_info.shader_present) ||
@@ -3937,12 +3938,16 @@ int panthor_group_create(struct panthor_file *pfile,
 		goto err_put_group;
 	}
 
-	suspend_size = csg_iface->control->protm_suspend_size;
-	group->protm_suspend_buf = panthor_fw_alloc_protm_suspend_buf_mem(ptdev, suspend_size);
-	if (IS_ERR(group->protm_suspend_buf)) {
-		ret = PTR_ERR(group->protm_suspend_buf);
-		group->protm_suspend_buf = NULL;
-		goto err_put_group;
+	if (group_args->flags & DRM_PANTHOR_GROUP_CREATE_PROTECTED) {
+		suspend_size = csg_iface->control->protm_suspend_size;
+		group->protm_suspend_buf =
+			panthor_fw_alloc_protm_suspend_buf_mem(ptdev,
+							       suspend_size);
+		if (IS_ERR(group->protm_suspend_buf)) {
+			ret = PTR_ERR(group->protm_suspend_buf);
+			group->protm_suspend_buf = NULL;
+			goto err_put_group;
+		}
 	}
 
 	group->syncobjs = panthor_kernel_bo_create(ptdev, group->vm,
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 0e455d91e77d4..914110003bcd1 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -253,6 +253,11 @@ enum drm_panthor_dev_query_type {
 	 * @DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO: Query allowed group priorities information.
 	 */
 	DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO,
+
+	/**
+	 * @DRM_PANTHOR_DEV_QUERY_PROTECTED_INFO: Query supported protected rendering information.
+	 */
+	DRM_PANTHOR_DEV_QUERY_PROTECTED_INFO,
 };
 
 /**
@@ -504,6 +509,28 @@ struct drm_panthor_group_priorities_info {
 	__u8 pad[3];
 };
 
+/**
+ * enum drm_panthor_protected_feature_flags - Supported protected rendering features
+ *
+ * Place new types at the end, don't re-order, don't remove or replace.
+ */
+enum drm_panthor_protected_feature_flags {
+	/** @DRM_PANTHOR_PROTECTED_FEATURE_BASIC: Protected rendering available */
+	DRM_PANTHOR_PROTECTED_FEATURE_BASIC = 1 << 0,
+};
+
+/**
+ * struct drm_panthor_protected_info - protected support information
+ *
+ * Structure grouping all queryable information relating to the allowed group priorities.
+ */
+struct drm_panthor_protected_info {
+	/**
+	 * @features: Combination of enum drm_panthor_protected_feature_flags flags.
+	 */
+	__u32 features;
+};
+
 /**
  * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
  */
@@ -843,6 +870,18 @@ enum drm_panthor_group_priority {
 	PANTHOR_GROUP_PRIORITY_REALTIME,
 };
 
+/**
+ * enum drm_panthor_group_create_flags - Group create flags
+ */
+enum drm_panthor_group_create_flags {
+	/**
+	 * @DRM_PANTHOR_GROUP_CREATE_PROTECTED: Support protected mode
+	 *
+	 * Enable protected rendering work to be executed on this group.
+	 */
+	DRM_PANTHOR_GROUP_CREATE_PROTECTED = 1 << 0,
+};
+
 /**
  * struct drm_panthor_group_create - Arguments passed to DRM_IOCTL_PANTHOR_GROUP_CREATE
  */
@@ -877,8 +916,10 @@ struct drm_panthor_group_create {
 	/** @priority: Group priority (see enum drm_panthor_group_priority). */
 	__u8 priority;
 
-	/** @pad: Padding field, MBZ. */
-	__u32 pad;
+	/**
+	 * @flags: Flags. Must be a combination of drm_panthor_group_create_flags flags.
+	 */
+	__u32 flags;
 
 	/**
 	 * @compute_core_mask: Mask encoding cores that can be used for compute jobs.
-- 
2.43.0

