Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0443CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F7C10F0D0;
	Mon, 12 Oct 2026 13:00:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 725B310F0BB
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:00:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFF921A00;
 Mon, 12 Oct 2026 06:00:18 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E95D23F66F;
 Mon, 12 Oct 2026 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791810022; bh=5dl3upRv2JVuocjW37MBOplNc6LnnavS968KHhVlsvU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nL64fe6o2SbHvd4OoRET4KjAHFgMuZJMqfYbZ/5gNC/ezts5xfy4dhGTnVOQ4yeOp
 othYf9FBzchaAuhH6UCugjDCfGEQlOGheLoasesBd7iIPwWB3Dr7Stb6fQfC8UTz43
 dEaaRue6YIHeYYdqUt6A3/zHpdlPaidiRCKWUPXA=
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
Subject: [PATCH v4 10/12] drm/panthor: Support FW init of protm
Date: Mon, 12 Oct 2026 14:59:38 +0200
Message-ID: <20261012125940.3291951-11-ketil.johnsen@arm.com>
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

v4:
- First version of this change as a separate commit
---
 drivers/gpu/drm/panthor/panthor_device.h |   3 +
 drivers/gpu/drm/panthor/panthor_drv.c    |  18 +++-
 drivers/gpu/drm/panthor/panthor_fw.c     | 107 +++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_fw.h     |   2 +
 include/uapi/drm/panthor_drm.h           |  75 ++++++++++++++++
 5 files changed, 197 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4362c55bcd7e4..99e5174cf0e50 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -343,6 +343,9 @@ struct panthor_device {
 
 		/** @protm_exit_count: Number of times we exited protm. */
 		atomic64_t protm_exit_count;
+
+		/** @info: Protected mode info. */
+		struct drm_panthor_protm_info info;
 	} protm;
 };
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 51a2e5358cd51..cc1c050ea3806 100644
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
@@ -958,6 +960,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(ptdev->mmu_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_PROTM_INFO:
+			args->size = sizeof(ptdev->protm.info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -991,6 +997,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
 
+	case DRM_PANTHOR_DEV_QUERY_PROTM_INFO:
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->protm.info);
+
 	default:
 		return -EINVAL;
 	}
@@ -1588,6 +1597,12 @@ static int panthor_ioctl_bo_query_info(struct drm_device *ddev, void *data,
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
@@ -1664,6 +1679,7 @@ static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
 	PANTHOR_IOCTL(SET_USER_MMIO_OFFSET, set_user_mmio_offset, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(BO_SYNC, bo_sync, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(BO_QUERY_INFO, bo_query_info, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PROTM_INIT, protm_init, DRM_RENDER_ALLOW),
 };
 
 static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index fc07796fc9ef7..0af6addfd55a5 100644
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
 
@@ -252,6 +254,9 @@ struct panthor_fw {
 	/** @shared_section: The section containing the FW interfaces. */
 	struct panthor_fw_section *shared_section;
 
+	/** @protm_section: The protected mode section. */
+	struct panthor_fw_section *protm_section;
+
 	/** @iface: FW interfaces. */
 	struct panthor_fw_iface iface;
 
@@ -261,6 +266,9 @@ struct panthor_fw {
 		struct delayed_work ping_work;
 	} watchdog;
 
+	/** @protm_init_lock: Used to serialize protm initialization. */
+	struct mutex protm_init_lock;
+
 	/**
 	 * @req_waitqueue: FW request waitqueue.
 	 *
@@ -462,6 +470,9 @@ static void panthor_fw_init_section_mem(struct panthor_device *ptdev,
 	    !(section->flags & CSF_FW_BINARY_IFACE_ENTRY_ZERO))
 		return;
 
+	if (!section->mem)
+		return;
+
 	ret = panthor_kernel_bo_vmap(section->mem);
 	if (drm_WARN_ON(&ptdev->base, ret))
 		return;
@@ -621,12 +632,6 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
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
@@ -678,7 +683,22 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 	section->size = section_size;
 	section->va = hdr.va.start;
 
-	if (section_size) {
+	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
+		if (ptdev->fw->protm_section) {
+			drm_err(&ptdev->base,
+				"Only one protected section supported\n");
+			return -EINVAL;
+		}
+
+		ptdev->protm.info.fw_protected_sections_size =
+			ALIGN(section->size, vm_pgsz);
+		ptdev->fw->protm_section = section;
+	}
+
+	/* Defer the section->mem creation if this is a protected entry.
+	 * This will be populated when DRM_IOCTL_PANTHOR_PROTM_INIT is called.
+	 */
+	if (section->size && !(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT)) {
 		u32 vm_map_flags = section_vm_map_flags(section);
 
 		section->mem = panthor_kernel_bo_create(
@@ -985,6 +1005,11 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 		return -EINVAL;
 	}
 
+	if (!csg_idx) {
+		ptdev->protm.info.group_protected_suspend_buf_size =
+			csg_iface->control->protm_suspend_size;
+	}
+
 	if (csg_idx > 0) {
 		struct panthor_fw_csg_iface *first_csg_iface =
 			panthor_fw_get_csg_iface(ptdev, 0);
@@ -1585,6 +1610,70 @@ int panthor_fw_protm_exit(struct panthor_device *ptdev, u32 timeout_ms)
 	return panthor_fw_protm_exit_wait(ptdev, timeout_ms);
 }
 
+int panthor_fw_protm_init(struct drm_file *file,
+			  struct drm_panthor_protm_init *args)
+{
+	struct panthor_file *pfile = file->driver_priv;
+	struct panthor_device *ptdev = pfile->ptdev;
+	struct panthor_fw_section *protm_section = ptdev->fw->protm_section;
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
+	if (!protm_section || !protm_section->size)
+		return -EINVAL;
+
+	guard(mutex)(&ptdev->fw->protm_init_lock);
+
+	/* Thread safe access so other readers do not need protm_init_lock */
+	if (smp_load_acquire(&ptdev->protm.info.state) &
+	    DRM_PANTHOR_PROTM_INITIALIZED)
+		return 0;
+
+	if (!drm_dev_enter(&ptdev->base, &cookie))
+		return -ENODEV;
+
+	obj = drm_gem_object_lookup(file,
+				    args->fw_protected_sections_bo_handle);
+	if (!obj) {
+		ret = -ENOENT;
+		goto out_dev_exit;
+	}
+
+	if (obj->size < ptdev->protm.info.fw_protected_sections_size) {
+		ret = -EINVAL;
+		goto out_gem_put;
+	}
+
+	vm_map_flags = section_vm_map_flags(protm_section);
+
+	protm_section->mem = panthor_kernel_bo_create_from_gem(
+		ptdev, panthor_fw_vm(ptdev), to_panthor_bo(obj), vm_map_flags,
+		protm_section->va, protm_section->size);
+	if (IS_ERR(protm_section->mem)) {
+		ret = PTR_ERR(protm_section->mem);
+		protm_section->mem = NULL;
+		goto out_gem_put;
+	}
+
+	/* Make sure all above is completed before we update state */
+	smp_store_release(&ptdev->protm.info.state,
+			  DRM_PANTHOR_PROTM_INITIALIZED);
+
+out_gem_put:
+	drm_gem_object_put(obj);
+
+out_dev_exit:
+	drm_dev_exit(cookie);
+	return ret;
+}
+
 /**
  * panthor_fw_init() - Initialize FW related data.
  * @ptdev: Device.
@@ -1606,6 +1695,10 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	INIT_LIST_HEAD(&fw->sections);
 	INIT_DELAYED_WORK(&fw->watchdog.ping_work, panthor_fw_ping_work);
 
+	ret = drmm_mutex_init(&ptdev->base, &fw->protm_init_lock);
+	if (ret)
+		return ret;
+
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "job");
 	if (irq <= 0)
 		return -ENODEV;
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index 4eda8f8e714c1..34bc9dc82314c 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -529,6 +529,8 @@ static inline int panthor_fw_resume(struct panthor_device *ptdev)
 int panthor_fw_init(struct panthor_device *ptdev);
 void panthor_fw_unplug(struct panthor_device *ptdev);
 
+int panthor_fw_protm_init(struct drm_file *file,
+			  struct drm_panthor_protm_init *args);
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

