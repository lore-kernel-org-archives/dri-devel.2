Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A33606A333
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fwkXyKD7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB1810EF88;
	Mon, 16 Nov 2026 11:29:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5530F10EF79
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:27:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01FA11713;
 Mon, 16 Nov 2026 03:27:01 -0800 (PST)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 958343F632;
 Mon, 16 Nov 2026 03:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794828423; bh=Fk2QlCBdVnqpSznardjwR8kkNHajMJu5bJ+kviEg9GI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fwkXyKD7xMddwMa3NYYVpkH0P+7JyYJ/qiJcfGWLXfeerwazF5BdS9bao9oOKCEQd
 eW/AsmSIfjLBedoBFihXGTua5HstJSFcX2HnQymaBrk4JdB7WUhAWHcr7+Q/wUnezQ
 4KkBVy9F7cHo5dGzhJTbty9FVmeWPFPSzFSVI36c=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v5 11/13] drm/panthor: Support FW init of protm
Date: Mon, 16 Nov 2026 12:25:59 +0100
Message-ID: <20261116112601.3483649-12-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116112601.3483649-1-ketil.johnsen@arm.com>
References: <20261116112601.3483649-1-ketil.johnsen@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Boris Brezillon <boris.brezillon@collabora.com>

The Mali GPU FW needs some protected memory when executing in protected
mode. This FW memory section is assigned a VA during device init.
A user space process with the needed privileges (CAP_SYS_MODULE) must
provide a suitable memory buffer before the Mali GPU is capable of
executing in protected mode.

Adds user query of FW protm state, min FW section size and min protm
suspend buffer size.
Adds user initiated init of FW protm section.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

---

v5:
- Ditched the lockless approach, now using a simpler mutex.
- Handle potential races reported by Sashiko.
- Do not write to protected FW section memory (during GPU reset).
- No longer mix guard() and goto error handling in panthor_fw_protm_init()

v4:
- First version of this change as a separate commit
---
 drivers/gpu/drm/panthor/panthor_drv.c |  21 +++-
 drivers/gpu/drm/panthor/panthor_fw.c  | 146 ++++++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_fw.h  |   5 +
 include/uapi/drm/panthor_drm.h        |  75 +++++++++++++
 4 files changed, 238 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 7edb8d329a705..ffea1eef134f5 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -177,11 +177,13 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_mmu_info, page_size_bitmap), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestamp), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_protm_info, pad), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs), \
-		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size))
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_protm_init, pad))
 
 /**
  * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
@@ -934,6 +936,8 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 	struct drm_panthor_dev_query *args = data;
 	struct drm_panthor_timestamp_info timestamp_info;
 	struct drm_panthor_group_priorities_info priorities_info;
+	struct drm_panthor_protm_info protm_info;
+
 	int ret;
 
 	if (!args->pointer) {
@@ -958,6 +962,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(ptdev->mmu_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_PROTM_INFO:
+			args->size = sizeof(protm_info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -991,6 +999,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
 
+	case DRM_PANTHOR_DEV_QUERY_PROTM_INFO:
+		panthor_fw_query_protm_info(file, &protm_info);
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, protm_info);
+
 	default:
 		return -EINVAL;
 	}
@@ -1584,6 +1596,12 @@ static int panthor_ioctl_bo_query_info(struct drm_device *ddev, void *data,
 	return 0;
 }
 
+static int panthor_ioctl_protm_init(struct drm_device *ddev, void *data,
+				    struct drm_file *file)
+{
+	return panthor_fw_protm_init(file, data);
+}
+
 static int
 panthor_open(struct drm_device *ddev, struct drm_file *file)
 {
@@ -1660,6 +1678,7 @@ static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
 	PANTHOR_IOCTL(SET_USER_MMIO_OFFSET, set_user_mmio_offset, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(BO_SYNC, bo_sync, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(BO_QUERY_INFO, bo_query_info, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PROTM_INIT, protm_init, DRM_RENDER_ALLOW),
 };
 
 static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index b565b362f401f..af86b1844ead8 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -13,8 +13,10 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/capability.h>
 
 #include <drm/drm_drv.h>
+#include <drm/drm_file.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
@@ -267,6 +269,18 @@ struct panthor_fw {
 		struct delayed_work ping_work;
 	} watchdog;
 
+	struct  {
+		/** @protm.init_lock: Used to serialize protm initialization. */
+		struct mutex init_lock;
+
+		/** @protm.inited: set to true when protm.section is initialized */
+		bool inited;
+
+		/** @protm.section: The protected mode section. */
+		struct panthor_fw_section *section;
+
+	} protm;
+
 	/**
 	 * @req_waitqueue: FW request waitqueue.
 	 *
@@ -460,7 +474,7 @@ static int panthor_fw_binary_sub_iter_init(struct panthor_device *ptdev,
 static void panthor_fw_init_section_mem(struct panthor_device *ptdev,
 					struct panthor_fw_section *section)
 {
-	bool was_mapped = !!section->mem->kmap;
+	bool was_mapped;
 	struct sg_table *sgt;
 	int ret;
 
@@ -468,6 +482,14 @@ static void panthor_fw_init_section_mem(struct panthor_device *ptdev,
 	    !(section->flags & CSF_FW_BINARY_IFACE_ENTRY_ZERO))
 		return;
 
+	if (section->flags & CSF_FW_BINARY_IFACE_ENTRY_PROT)
+		return;
+
+	if (!section->mem)
+		return;
+
+	was_mapped = !!section->mem->kmap;
+
 	ret = panthor_kernel_bo_vmap(section->mem);
 	if (drm_WARN_ON(&ptdev->base, ret))
 		return;
@@ -637,12 +659,6 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 		return -EINVAL;
 	}
 
-	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
-		drm_warn(&ptdev->base,
-			 "Firmware protected mode entry is not supported, ignoring");
-		return 0;
-	}
-
 	if (hdr.va.start == CSF_MCU_SHARED_REGION_START &&
 	    !(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_SHARED)) {
 		drm_err(&ptdev->base,
@@ -694,7 +710,22 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 	section->size = section_size;
 	section->va = hdr.va.start;
 
-	if (section_size) {
+	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
+		guard(mutex)(&ptdev->fw->protm.init_lock);
+
+		if (ptdev->fw->protm.section) {
+			drm_err(&ptdev->base,
+				"Only one protected section supported\n");
+			return -EINVAL;
+		}
+
+		ptdev->fw->protm.section = section;
+	}
+
+	/* Defer the section->mem creation if this is a protected entry.
+	 * This will be populated when DRM_IOCTL_PANTHOR_PROTM_INIT is called.
+	 */
+	if (section->size && !(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT)) {
 		u32 vm_map_flags = section_vm_map_flags(section);
 
 		section->mem = panthor_kernel_bo_create(
@@ -1610,6 +1641,101 @@ int panthor_fw_protm_exit(struct panthor_device *ptdev, u32 timeout_ms)
 	return panthor_fw_protm_exit_wait(ptdev, timeout_ms);
 }
 
+int panthor_fw_protm_init(struct drm_file *file,
+			  struct drm_panthor_protm_init *args)
+{
+	struct panthor_file *pfile = file->driver_priv;
+	struct panthor_device *ptdev = pfile->ptdev;
+	ssize_t vm_pgsz = panthor_vm_page_size(ptdev->fw->vm);
+	struct panthor_fw_section *protm_section;
+	struct panthor_kernel_bo *mem;
+	struct drm_gem_object *obj;
+	u32 vm_map_flags;
+	int cookie, ret = 0;
+
+	if (!capable(CAP_SYS_MODULE))
+		return -EPERM;
+
+	if (args->pad)
+		return -EINVAL;
+
+	mutex_lock(&ptdev->fw->protm.init_lock);
+
+	protm_section = ptdev->fw->protm.section;
+
+	if (!protm_section || !protm_section->size) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (ptdev->fw->protm.inited)
+		goto out_unlock;
+
+	if (!drm_dev_enter(&ptdev->base, &cookie)) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	obj = drm_gem_object_lookup(file,
+				    args->fw_protected_sections_bo_handle);
+	if (!obj) {
+		ret = -ENOENT;
+		goto out_dev_exit;
+	}
+
+	if (obj->size < ALIGN(ptdev->fw->protm.section->size, vm_pgsz)) {
+		ret = -EINVAL;
+		goto out_gem_put;
+	}
+
+	vm_map_flags = section_vm_map_flags(protm_section);
+
+	mem = panthor_kernel_bo_create_from_gem(
+		ptdev, panthor_fw_vm(ptdev), to_panthor_bo(obj), vm_map_flags,
+		protm_section->va, protm_section->size);
+	if (IS_ERR(mem)) {
+		ret = PTR_ERR(mem);
+		goto out_gem_put;
+	}
+
+	protm_section->mem = mem;
+
+	ptdev->fw->protm.inited = true;
+
+out_gem_put:
+	drm_gem_object_put(obj);
+
+out_dev_exit:
+	drm_dev_exit(cookie);
+
+out_unlock:
+	mutex_unlock(&ptdev->fw->protm.init_lock);
+
+	return ret;
+}
+
+bool panthor_fw_protm_is_inited(struct panthor_device *ptdev)
+{
+	guard(mutex)(&ptdev->fw->protm.init_lock);
+	return ptdev->fw->protm.inited;
+}
+
+void panthor_fw_query_protm_info(struct drm_file *file,
+				 struct drm_panthor_protm_info *arg)
+{
+	struct panthor_file *pfile = file->driver_priv;
+	struct panthor_device *ptdev = pfile->ptdev;
+	ssize_t vm_pgsz = panthor_vm_page_size(ptdev->fw->vm);
+
+	guard(mutex)(&ptdev->fw->protm.init_lock);
+
+	memset(arg, 0, sizeof(*arg));
+	arg->state = ptdev->fw->protm.inited ? DRM_PANTHOR_PROTM_INITIALIZED : 0;
+	arg->group_protected_suspend_buf_size = ptdev->fw->protm_suspend_size;
+	arg->fw_protected_sections_size =  ALIGN(ptdev->fw->protm.section->size,
+						 vm_pgsz);
+}
+
 /**
  * panthor_fw_init() - Initialize FW related data.
  * @ptdev: Device.
@@ -1631,6 +1757,10 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	INIT_LIST_HEAD(&fw->sections);
 	INIT_DELAYED_WORK(&fw->watchdog.ping_work, panthor_fw_ping_work);
 
+	ret = drmm_mutex_init(&ptdev->base, &fw->protm.init_lock);
+	if (ret)
+		return ret;
+
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "job");
 	if (irq <= 0)
 		return -ENODEV;
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index b3bf00191a96b..84edd25989aa4 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -532,6 +532,11 @@ static inline int panthor_fw_resume(struct panthor_device *ptdev)
 int panthor_fw_init(struct panthor_device *ptdev);
 void panthor_fw_unplug(struct panthor_device *ptdev);
 
+int panthor_fw_protm_init(struct drm_file *file,
+			  struct drm_panthor_protm_init *args);
+bool panthor_fw_protm_is_inited(struct panthor_device *ptdev);
+void panthor_fw_query_protm_info(struct drm_file *file,
+				 struct drm_panthor_protm_info *arg);
 int panthor_fw_protm_enter(struct panthor_device *ptdev);
 int panthor_fw_protm_exit(struct panthor_device *ptdev, u32 timeout_ms);
 int panthor_fw_protm_exit_wait(struct panthor_device *ptdev, u32 timeout_ms);
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index a2ff0f4ec6915..d2d21e3e6bb39 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -154,6 +154,11 @@ enum drm_panthor_ioctl_id {
 	 * This is useful for imported BOs.
 	 */
 	DRM_PANTHOR_BO_QUERY_INFO,
+
+	/**
+	 * @DRM_PANTHOR_PROTM_INIT: Device-wide initialize of protected mode.
+	 */
+	DRM_PANTHOR_PROTM_INIT,
 };
 
 /**
@@ -256,6 +261,11 @@ enum drm_panthor_dev_query_type {
 
 	/** @DRM_PANTHOR_DEV_QUERY_MMU_INFO: Query MMU information. */
 	DRM_PANTHOR_DEV_QUERY_MMU_INFO,
+
+	/**
+	 * @DRM_PANTHOR_DEV_QUERY_PROTM_INFO: Query supported protected rendering information.
+	 */
+	DRM_PANTHOR_DEV_QUERY_PROTM_INFO,
 };
 
 /**
@@ -517,6 +527,51 @@ struct drm_panthor_group_priorities_info {
 	__u8 pad[3];
 };
 
+/**
+ * enum drm_panthor_protm_state_flags - Describes the state of the protected mode feature.
+ *
+ * List of GPU states which can be used by the GPU to access protected memory.
+ */
+enum drm_panthor_protm_state_flags {
+	/**
+	 * @DRM_PANTHOR_PROTM_INITIALIZED: Device-wide initialization of the
+	 * protected mode feature is done.
+	 */
+	DRM_PANTHOR_PROTM_INITIALIZED = 1 << 0,
+};
+
+/**
+ * struct drm_panthor_protm_info - Protected mode info.
+ *
+ * Structure grouping all queryable information relating to protected mode.
+ */
+struct drm_panthor_protm_info {
+	/**
+	 * @state: Combination of enum drm_panthor_protm_state_flags flags.
+	 */
+	__u32 state;
+
+	/**
+	 * @fw_protected_sections_size: Size of all the protected FW sections.
+	 *
+	 * Size of the protected buffer to pass through
+	 * DRM_IOCTL_PANTHOR_PROTM_INIT.
+	 */
+	__u32 fw_protected_sections_size;
+
+	/**
+	 * @group_protected_suspend_buf_size: Size of the group suspend buffer.
+	 *
+	 * This must be used to allocate a protected BO that's big enough to use
+	 * as a protected suspend buffer when a group supports protected
+	 * rendering.
+	 */
+	__u32 group_protected_suspend_buf_size;
+
+	/** @pad: MBZ. */
+	__u32 pad;
+};
+
 /**
  * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
  */
@@ -1270,6 +1325,24 @@ struct drm_panthor_bo_query_info {
 	__u32 pad;
 };
 
+/**
+ * struct drm_panthor_protm_init - Protected mode initialization arguments.
+ */
+struct drm_panthor_protm_init {
+	/**
+	 * @fw_protected_sections_bo_handle: Handle of the BO to use for the FW protected
+	 * sections.
+	 *
+	 * This BO must have been allocated from a protected DMA-BUF heap and
+	 * imported in panthor. It's size must be at least
+	 * drm_panthor_protm_info::fw_protected_sections_size.
+	 */
+	__u32 fw_protected_sections_bo_handle;
+
+	/** @pad: MBZ. */
+	__u32 pad;
+};
+
 /**
  * DRM_IOCTL_PANTHOR() - Build a Panthor IOCTL number
  * @__access: Access type. Must be R, W or RW.
@@ -1320,6 +1393,8 @@ enum {
 		DRM_IOCTL_PANTHOR(WR, BO_SYNC, bo_sync),
 	DRM_IOCTL_PANTHOR_BO_QUERY_INFO =
 		DRM_IOCTL_PANTHOR(WR, BO_QUERY_INFO, bo_query_info),
+	DRM_IOCTL_PANTHOR_PROTM_INIT =
+		DRM_IOCTL_PANTHOR(WR, PROTM_INIT, protm_init),
 };
 
 #if defined(__cplusplus)
-- 
2.43.0

