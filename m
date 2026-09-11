Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44924C88E4A
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA5310F540;
	Fri, 11 Sep 2026 11:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RTCBhqvM";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 068EE10F540
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:40:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC9271655;
 Fri, 11 Sep 2026 04:40:44 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65A453F59E;
 Fri, 11 Sep 2026 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789126848; bh=pIY+WqEDy4/+Hp5LAAO3D5YEFvq2syVutRRW3FgFVSA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RTCBhqvMgW0QIKN6eARLpM8uEzT50dU8WWfyyipMzKLxY4hHo7iNiC6Ipjn3/oeWk
 aXuielZF6HlMiKBj+wYw2Cn+51LiKBzj3GLN2uTJwu2XQRYMI2xL/80fDzt146Y0WP
 h2NT55cE80y9qRrRkT8CoCloU1ZLXCaYt2HMSVx8=
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
Subject: [PATCH v3 6/6] drm/panthor: Expose protected rendering features
Date: Fri, 11 Sep 2026 13:40:14 +0200
Message-ID: <20260911114014.79139-7-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911114014.79139-1-ketil.johnsen@arm.com>
References: <20260911114014.79139-1-ketil.johnsen@arm.com>
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

Extensions to Panthor uAPI:
- New IOCTL for user space to provide protected FW memory.
- New query for checking protected rendering availability/status
  and requirements.
- Extends group creation to allow user space to provide a protected
  suspend buffer.

The Mali GPU FW needs some protected memory when executing in protected
mode. This FW memory section is assigned a VA during device init.
A user space process with the needed privileges (CAP_SYS_MODULE) must
provide a suitable memory buffer before the Mali GPU is capable of
executing in protected mode.

Processes who want to execute in protected mode must also ensure they
pass a protected suspend buffer during group creation.

Added panthor_kernel_bo_import() to allow user provided buffers.
Refactor panthor_kernel_bo_create() to allow shared code with the
new import variant.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

---

v3:
- Formating
- Rebase changed
  - Keep local section_size var, needed for early out.
  - Access fatal_queues and protm_pending_queues as atomics.

v2:
- First version of this change in this patch set.
---
 drivers/gpu/drm/panthor/panthor_device.h |   3 +
 drivers/gpu/drm/panthor/panthor_drv.c    |  23 +++-
 drivers/gpu/drm/panthor/panthor_fw.c     | 159 +++++++++++++++++++----
 drivers/gpu/drm/panthor/panthor_fw.h     |   2 +
 drivers/gpu/drm/panthor/panthor_gem.c    | 106 ++++++++++-----
 drivers/gpu/drm/panthor/panthor_gem.h    |   7 +-
 drivers/gpu/drm/panthor/panthor_sched.c  |  45 ++++++-
 include/uapi/drm/panthor_drm.h           |  85 +++++++++++-
 8 files changed, 356 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index f1b7f51f5ae1e..241550964b04c 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -366,6 +366,9 @@ struct panthor_device {
 
 		/** @protm_exit_count: Number of times exited protm. */
 		atomic64_t protm_exit_count;
+
+		/** @info: Protected mode info. */
+		struct drm_panthor_protm_info info;
 	} protm;
 };
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 51eb77633602f..875c5ef3e2748 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -178,11 +178,13 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
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
@@ -959,6 +961,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(ptdev->mmu_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_PROTM_INFO:
+			args->size = sizeof(ptdev->protm.info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -992,6 +998,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
 
+	case DRM_PANTHOR_DEV_QUERY_PROTM_INFO:
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->protm.info);
+
 	default:
 		return -EINVAL;
 	}
@@ -1589,6 +1598,12 @@ static int panthor_ioctl_bo_query_info(struct drm_device *ddev, void *data,
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
@@ -1665,6 +1680,7 @@ static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
 	PANTHOR_IOCTL(SET_USER_MMIO_OFFSET, set_user_mmio_offset, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(BO_SYNC, bo_sync, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(BO_QUERY_INFO, bo_query_info, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PROTM_INIT, protm_init, DRM_RENDER_ALLOW),
 };
 
 static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
@@ -1785,6 +1801,9 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
  *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
+ * - 1.10 - adds DRM_IOCTL_PANTHOR_PROTM_INIT ioctl
+ *        - adds DRM_PANTHOR_DEV_QUERY_PROTM_INFO query
+ *        - adds drm_panthor_group_create::protected_suspend_bo_handle
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1798,7 +1817,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 9,
+	.minor = 10,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
 	.gem_prime_import = panthor_gem_prime_import,
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 96770ce34da84..4b44baf82a037 100644
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
 
@@ -198,6 +200,12 @@ struct panthor_fw_section {
 		/** @size: Size of @buf in bytes. */
 		size_t size;
 	} data;
+
+	/** @size: Section size. */
+	size_t size;
+
+	/** @va: Section VA. */
+	u32 va;
 };
 
 #define CSF_MCU_SHARED_REGION_START		0x04000000ULL
@@ -246,6 +254,9 @@ struct panthor_fw {
 	/** @shared_section: The section containing the FW interfaces. */
 	struct panthor_fw_section *shared_section;
 
+	/** @protm_section: The protected mode section. */
+	struct panthor_fw_section *protm_section;
+
 	/** @iface: FW interfaces. */
 	struct panthor_fw_iface iface;
 
@@ -255,6 +266,9 @@ struct panthor_fw {
 		struct delayed_work ping_work;
 	} watchdog;
 
+	/** @protm_init_lock: Used to serialize protm initialization. */
+	struct mutex protm_init_lock;
+
 	/**
 	 * @req_waitqueue: FW request waitqueue.
 	 *
@@ -543,6 +557,31 @@ panthor_fw_alloc_suspend_buf_mem(struct panthor_device *ptdev, size_t size)
 					"FW suspend buffer");
 }
 
+static u32 section_vm_map_flags(const struct panthor_fw_section *section)
+{
+	u32 cache_mode = section->flags &
+			 CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_MASK;
+	u32 vm_map_flags = 0;
+
+	if (!(section->flags & CSF_FW_BINARY_IFACE_ENTRY_WR))
+		vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_READONLY;
+
+	if (!(section->flags & CSF_FW_BINARY_IFACE_ENTRY_EX))
+		vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC;
+
+	/* TODO: CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_*_COHERENT are mapped to
+	 * non-cacheable for now. We might want to introduce a new
+	 * IOMMU_xxx flag (or abuse IOMMU_MMIO, which maps to device
+	 * memory and is currently not used by our driver) for
+	 * AS_MEMATTR_AARCH64_SHARED memory, so we can take benefit
+	 * of IO-coherent systems.
+	 */
+	if (cache_mode != CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_CACHED)
+		vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED;
+
+	return vm_map_flags;
+}
+
 static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 					 const struct firmware *fw,
 					 struct panthor_fw_binary_iter *iter,
@@ -590,12 +629,6 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
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
@@ -644,35 +677,36 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 		section->name = name;
 	}
 
-	if (section_size) {
-		u32 cache_mode = hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_MASK;
-		u32 vm_map_flags = 0;
-		u64 va = hdr.va.start;
+	section->size = section_size;
+	section->va = hdr.va.start;
 
-		if (!(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_WR))
-			vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_READONLY;
+	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
+		if (ptdev->fw->protm_section) {
+			drm_err(&ptdev->base,
+				"Only one protected section supported\n");
+			return -EINVAL;
+		}
 
-		if (!(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_EX))
-			vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC;
+		ptdev->protm.info.fw_protected_sections_size =
+			ALIGN(section->size, vm_pgsz);
+		ptdev->fw->protm_section = section;
+	}
 
-		/* TODO: CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_*_COHERENT are mapped to
-		 * non-cacheable for now. We might want to introduce a new
-		 * IOMMU_xxx flag (or abuse IOMMU_MMIO, which maps to device
-		 * memory and is currently not used by our driver) for
-		 * AS_MEMATTR_AARCH64_SHARED memory, so we can take benefit
-		 * of IO-coherent systems.
-		 */
-		if (cache_mode != CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_CACHED)
-			vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED;
+	/* Defer the section->mem creation if this is a protected entry.
+	 * This will be populated when DRM_IOCTL_PANTHOR_PROTM_INIT is called.
+	 */
+	if (section->size && !(hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT)) {
+		u32 vm_map_flags = section_vm_map_flags(section);
 
-		section->mem = panthor_kernel_bo_create(ptdev, panthor_fw_vm(ptdev),
-							section_size,
-							DRM_PANTHOR_BO_NO_MMAP,
-							vm_map_flags, va, "FW section");
+		section->mem = panthor_kernel_bo_create(
+			ptdev, panthor_fw_vm(ptdev), section->size,
+			DRM_PANTHOR_BO_NO_MMAP, vm_map_flags, section->va,
+			"FW section");
 		if (IS_ERR(section->mem))
 			return PTR_ERR(section->mem);
 
-		if (drm_WARN_ON(&ptdev->base, section->mem->va_node.start != hdr.va.start))
+		if (drm_WARN_ON(&ptdev->base,
+				section->mem->va_node.start != section->va))
 			return -EINVAL;
 
 		if (section->flags & CSF_FW_BINARY_IFACE_ENTRY_SHARED) {
@@ -968,6 +1002,11 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
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
@@ -1566,6 +1605,66 @@ int panthor_fw_protm_exit(struct panthor_device *ptdev, u32 timeout_ms)
 	return ret;
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
+	if (ptdev->protm.info.state & DRM_PANTHOR_PROTM_INITIALIZED)
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
+	protm_section->mem = panthor_kernel_bo_import(
+		ptdev, panthor_fw_vm(ptdev), to_panthor_bo(obj), vm_map_flags,
+		protm_section->va, protm_section->size);
+	if (IS_ERR(protm_section->mem)) {
+		ret = PTR_ERR(protm_section->mem);
+		protm_section->mem = NULL;
+		goto out_gem_put;
+	}
+
+	ptdev->protm.info.state |= DRM_PANTHOR_PROTM_INITIALIZED;
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
@@ -1587,6 +1686,10 @@ int panthor_fw_init(struct panthor_device *ptdev)
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
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index c07a44057e426..9f9f68582ccf1 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -74,14 +74,16 @@ static void panthor_gem_debugfs_bo_rm(struct panthor_gem_object *bo)
 	mutex_unlock(&ptdev->gems.lock);
 }
 
-static void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, u32 usage_flags)
+static void panthor_gem_debugfs_add_usage_flags(struct panthor_gem_object *bo,
+						u32 usage_flags)
 {
-	bo->debugfs.flags = usage_flags;
-	panthor_gem_debugfs_bo_add(bo);
+	atomic_or(usage_flags, &bo->debugfs.flags);
 }
 #else
+static void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo) {}
 static void panthor_gem_debugfs_bo_rm(struct panthor_gem_object *bo) {}
-static void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, u32 usage_flags) {}
+static void panthor_gem_debugfs_add_usage_flags(struct panthor_gem_object *bo,
+						u32 usage_flags) {}
 static void panthor_gem_debugfs_bo_init(struct panthor_gem_object *bo) {}
 #endif
 
@@ -1031,7 +1033,7 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
 		bo->base.resv = bo->exclusive_vm_root_gem->resv;
 	}
 
-	panthor_gem_debugfs_set_usage_flags(bo, usage_flags);
+	panthor_gem_debugfs_bo_add(bo);
 	return bo;
 
 err_put:
@@ -1257,7 +1259,9 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
 	panthor_kernel_bo_vunmap(bo);
 
 	drm_WARN_ON(bo->obj->dev,
-		    to_panthor_bo(bo->obj)->exclusive_vm_root_gem != panthor_vm_root_gem(vm));
+		    to_panthor_bo(bo->obj)->exclusive_vm_root_gem &&
+			    (to_panthor_bo(bo->obj)->exclusive_vm_root_gem !=
+			     panthor_vm_root_gem(vm)));
 	panthor_vm_unmap_range(vm, bo->va_node.start, bo->va_node.size);
 	panthor_vm_free_va(vm, &bo->va_node);
 	if (vm == panthor_fw_vm(ptdev))
@@ -1268,46 +1272,32 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
 }
 
 /**
- * panthor_kernel_bo_create() - Create and map a GEM object to a VM
+ * panthor_kernel_bo_import() - Create a kernel BO from an existing GEM object
  * @ptdev: Device.
  * @vm: VM to map the GEM to.
- * @size: Size of the buffer object.
- * @bo_flags: Combination of drm_panthor_bo_flags flags.
+ * @bo: BO to use for our kernel BO.
  * @vm_map_flags: Combination of drm_panthor_vm_bind_op_flags (only those
  * that are related to map operations).
  * @gpu_va: GPU address assigned when mapping to the VM.
  * If gpu_va == PANTHOR_VM_KERNEL_AUTO_VA, the virtual address will be
  * automatically allocated.
- * @name: Descriptive label of the BO's contents
+ * @vm_map_size: Size of the BO to map to the VM.
  *
  * Return: A valid pointer in case of success, an ERR_PTR() otherwise.
  */
 struct panthor_kernel_bo *
-panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
-			 size_t size, u32 bo_flags, u32 vm_map_flags,
-			 u64 gpu_va, const char *name)
+panthor_kernel_bo_import(struct panthor_device *ptdev, struct panthor_vm *vm,
+			 struct panthor_gem_object *bo, u32 vm_map_flags,
+			 u64 gpu_va, u32 vm_map_size)
 {
 	struct panthor_kernel_bo *kbo;
-	struct panthor_gem_object *bo;
-	u32 debug_flags = PANTHOR_DEBUGFS_GEM_USAGE_FLAG_KERNEL;
 	int ret;
 
-	if (drm_WARN_ON(&ptdev->base, !vm))
-		return ERR_PTR(-EINVAL);
-
 	kbo = kzalloc_obj(*kbo);
 	if (!kbo)
 		return ERR_PTR(-ENOMEM);
 
-	if (vm == panthor_fw_vm(ptdev))
-		debug_flags |= PANTHOR_DEBUGFS_GEM_USAGE_FLAG_FW_MAPPED;
-
-	bo = panthor_gem_create(&ptdev->base, size, bo_flags, vm, debug_flags);
-	if (IS_ERR(bo)) {
-		ret = PTR_ERR(bo);
-		goto err_free_kbo;
-	}
-
+	drm_gem_object_get(&bo->base);
 	kbo->obj = &bo->base;
 
 	if (vm == panthor_fw_vm(ptdev)) {
@@ -1316,24 +1306,27 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 			goto err_put_obj;
 	}
 
-	panthor_gem_kernel_bo_set_label(kbo, name);
-
 	/* The system and GPU MMU page size might differ, which becomes a
 	 * problem for FW sections that need to be mapped at explicit address
 	 * since our PAGE_SIZE alignment might cover a VA range that's
 	 * expected to be used for another section.
 	 * Make sure we never map more than we need.
 	 */
-	size = ALIGN(size, panthor_vm_page_size(vm));
-	ret = panthor_vm_alloc_va(vm, gpu_va, size, &kbo->va_node);
+	vm_map_size = ALIGN(vm_map_size, panthor_vm_page_size(vm));
+	ret = panthor_vm_alloc_va(vm, gpu_va, vm_map_size, &kbo->va_node);
 	if (ret)
 		goto err_unpin;
 
-	ret = panthor_vm_map_bo_range(vm, bo, 0, size, kbo->va_node.start, vm_map_flags);
+	ret = panthor_vm_map_bo_range(vm, bo, 0, vm_map_size,
+				      kbo->va_node.start, vm_map_flags);
 	if (ret)
 		goto err_free_va;
 
 	kbo->vm = panthor_vm_get(vm);
+	if (vm == panthor_fw_vm(ptdev))
+		panthor_gem_debugfs_add_usage_flags(
+			bo, PANTHOR_DEBUGFS_GEM_USAGE_FLAG_FW_MAPPED);
+
 	return kbo;
 
 err_free_va:
@@ -1345,12 +1338,55 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 
 err_put_obj:
 	drm_gem_object_put(&bo->base);
-
-err_free_kbo:
 	kfree(kbo);
 	return ERR_PTR(ret);
 }
 
+/**
+ * panthor_kernel_bo_create() - Create and map a GEM object to a VM
+ * @ptdev: Device.
+ * @vm: VM to map the GEM to.
+ * @size: Size of the buffer object.
+ * @bo_flags: Combination of drm_panthor_bo_flags flags.
+ * @vm_map_flags: Combination of drm_panthor_vm_bind_op_flags (only those
+ * that are related to map operations).
+ * @gpu_va: GPU address assigned when mapping to the VM.
+ * If gpu_va == PANTHOR_VM_KERNEL_AUTO_VA, the virtual address will be
+ * automatically allocated.
+ * @name: Descriptive label of the BO's contents
+ *
+ * Return: A valid pointer in case of success, an ERR_PTR() otherwise.
+ */
+struct panthor_kernel_bo *
+panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
+			 size_t size, u32 bo_flags, u32 vm_map_flags,
+			 u64 gpu_va, const char *name)
+{
+	struct panthor_kernel_bo *kbo;
+	struct panthor_gem_object *bo;
+
+	if (drm_WARN_ON(&ptdev->base, !vm))
+		return ERR_PTR(-EINVAL);
+
+	bo = panthor_gem_create(&ptdev->base, size, bo_flags, vm, 0);
+	if (IS_ERR(bo))
+		return ERR_CAST(bo);
+
+	kbo = panthor_kernel_bo_import(ptdev, vm, bo, vm_map_flags, gpu_va,
+				       size);
+	if (!IS_ERR(kbo)) {
+		panthor_gem_debugfs_add_usage_flags(
+			bo, PANTHOR_DEBUGFS_GEM_USAGE_FLAG_KERNEL);
+		panthor_gem_kernel_bo_set_label(kbo, name);
+	}
+
+	/* panthor_kernel_bo_import() acquires a GEM ref if the import succeeds, so
+	 * we can release it unconditionally here.
+	 */
+	drm_gem_object_put(&bo->base);
+	return kbo;
+}
+
 /**
  * panthor_dummy_bo_create() - Create a Panthor BO meant to back sparse bindings.
  * @ptdev: Device.
@@ -1644,9 +1680,9 @@ static void panthor_gem_debugfs_bo_print(struct panthor_gem_object *bo,
 	enum panthor_gem_reclaim_state reclaim_state = bo->reclaim_state;
 	unsigned int refcount = kref_read(&bo->base.refcount);
 	int reclaimed_count = atomic_read(&bo->reclaimed_count);
+	u32 gem_usage_flags = atomic_read(&bo->debugfs.flags);
 	char creator_info[32] = {};
 	size_t resident_size;
-	u32 gem_usage_flags = bo->debugfs.flags;
 	u32 gem_state_flags = 0;
 
 	/* Skip BOs being destroyed. */
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 5ae37d0d3646f..7e88f5dcbff54 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -62,7 +62,7 @@ struct panthor_gem_debugfs {
 	} creator;
 
 	/** @flags: Combination of panthor_debugfs_gem_usage_flags flags */
-	u32 flags;
+	atomic_t flags;
 };
 
 /**
@@ -318,6 +318,11 @@ panthor_kernel_bo_vunmap(struct panthor_kernel_bo *bo)
 	}
 }
 
+struct panthor_kernel_bo *
+panthor_kernel_bo_import(struct panthor_device *ptdev, struct panthor_vm *vm,
+			 struct panthor_gem_object *bo,
+			 u32 vm_map_flags, u64 gpu_va, u32 vm_map_size);
+
 struct panthor_kernel_bo *
 panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 			 size_t size, u32 bo_flags, u32 vm_map_flags,
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 1fe77e5c41995..d73fc2f6633a6 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1429,10 +1429,15 @@ cs_slot_process_protm_pending_event_locked(struct panthor_device *ptdev,
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
+	if (!(ptdev->protm.info.state & DRM_PANTHOR_PROTM_INITIALIZED))
+		atomic_or(BIT(cs_id), &group->fatal_queues);
+	else
+		atomic_or(BIT(cs_id), &group->protm_pending_queues);
 
 	sched_queue_delayed_work(sched, tick, 0);
 }
@@ -3963,6 +3968,7 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
 }
 
 #define MAX_GROUPS_PER_POOL		128
+#define GROUP_CREATE_FLAGS DRM_PANTHOR_GROUP_CREATE_PROTECTED
 
 int panthor_group_create(struct drm_file *file,
 			 const struct drm_panthor_group_create *group_args,
@@ -3977,9 +3983,6 @@ int panthor_group_create(struct drm_file *file,
 	u32 gid, i, suspend_size;
 	int ret;
 
-	if (group_args->pad)
-		return -EINVAL;
-
 	if (group_args->priority >= PANTHOR_CSG_PRIORITY_COUNT)
 		return -EINVAL;
 
@@ -4030,6 +4033,36 @@ int panthor_group_create(struct drm_file *file,
 		goto err_put_group;
 	}
 
+	if (group_args->protected_suspend_bo_handle) {
+		struct drm_gem_object *obj;
+
+		obj = drm_gem_object_lookup(file, group_args->protected_suspend_bo_handle);
+		if (!obj) {
+			ret = -ENOENT;
+			goto err_put_group;
+		}
+
+		if (obj->size < ptdev->protm.info.group_protected_suspend_buf_size) {
+			drm_gem_object_put(obj);
+			ret = -EINVAL;
+			goto err_put_group;
+		}
+
+		suspend_size = csg_iface->control->protm_suspend_size;
+		group->protm_suspend_buf =
+			panthor_kernel_bo_import(ptdev, panthor_fw_vm(ptdev),
+						 to_panthor_bo(obj),
+						 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
+						 PANTHOR_VM_KERNEL_AUTO_VA,
+						 suspend_size);
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
index a2ff0f4ec6915..a0ed16041e178 100644
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
@@ -901,8 +956,14 @@ struct drm_panthor_group_create {
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
@@ -1270,6 +1331,24 @@ struct drm_panthor_bo_query_info {
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
@@ -1320,6 +1399,8 @@ enum {
 		DRM_IOCTL_PANTHOR(WR, BO_SYNC, bo_sync),
 	DRM_IOCTL_PANTHOR_BO_QUERY_INFO =
 		DRM_IOCTL_PANTHOR(WR, BO_QUERY_INFO, bo_query_info),
+	DRM_IOCTL_PANTHOR_PROTM_INIT =
+		DRM_IOCTL_PANTHOR(WR, PROTM_INIT, protm_init),
 };
 
 #if defined(__cplusplus)
-- 
2.43.0

