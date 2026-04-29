Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2284FF8873
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74DBC10F17E;
	Wed, 29 Apr 2026 20:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jKgQHkhe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290A810F177
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 20:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777495967; x=1809031967;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=71SxCoLGtvH3BYSrLv3t00fBEW6KmQtvGRdUcbP4ZRo=;
 b=jKgQHkheAJWC8usmpzCa+wuRDE/NCx4kPGonb/aLQc/evj+xjGEc8Zfr
 cm2YTutOUHQUdN1T6S8lNFcpCaIcruJujXLNKtXBDEwwSsC9dUGr3MHED
 9mx5gVaQ8be/Rh38WrZ2SssCH7SHuZOW8wwLrEoEyluMTEbaE5NQdUAZg
 kCmPjF27ep6SauZjYl6lfC4Dh3mh/SHpwJSmO7e/bEM4bCZKDmb+eOzUk
 RsygCz0AFesz94saXoIddZXaZuz6OvdLkPFGcTE43f9vY66gDcqA0P7Kh
 W1K1gf3Jc1oWdG2GfbFwq7jPvVzQTKl7w9NhFdJiFQvuP10vm2YankHiW A==;
X-CSE-ConnectionGUID: 0p/P60mhTYafQU4tqJbdEw==
X-CSE-MsgGUID: UjHnpGbHT4+J1B2h5u9iZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78490697"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="78490697"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 13:52:47 -0700
X-CSE-ConnectionGUID: ATb1cgVOSr2DAKih/YZshw==
X-CSE-MsgGUID: tbgjY2CbSQS1C3gKrTSXNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="272499914"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.158.5])
 by orviesa001.jf.intel.com with ESMTP; 29 Apr 2026 13:52:46 -0700
From: dongwon.kim@intel.com
To: dri-devel@lists.freedesktop.org, airlied@redhat.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com
Subject: [PATCH v8 3/3] drm/virtio: Add PM notifier to restore objects after
 hibernation
Date: Wed, 29 Apr 2026 13:47:29 -0700
Message-Id: <20260429204729.993669-4-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429204729.993669-1-dongwon.kim@intel.com>
References: <20260429204729.993669-1-dongwon.kim@intel.com>
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

From: Dongwon Kim <dongwon.kim@intel.com>

Register a PM notifier in virtio-gpu to handle suspend/hibernate
events. On PM_POST_HIBERNATION, restore all GPU objects so that the
driver can properly recover after resume.

v2: Remove unused header - drm_atomic_helper.h
    (Dmitry Osipenko)

v3: Objects for virgl usecase can't be recovered after resume so
    blocking S4 when virgl is enabled
    (Dmitry Osipenko)

v4: Restoring objects in the PM notifier is too late, as virtio-gpu
    message communication begins in virtgpu_restore once virtqueues
    are re-established. To address this, a 'hibernation' flag is set
    during the PM_HIBERNATION_PREPARE phase in the notifier. This flag
    is then used in virtgpu_restore to detect if the system is resuming
    from S4, allowing objects to be recovered immediately after virtqueues
    are reconfigured.

v5: Unreference all objects before hibernation so they can be removed
    on the host side, since they will be fully restored anyway. This
    prevents the situation where host-side hibernation fails (leaving
    all associated resources still alive) while the virtio-gpu driver
    still attempts to restore those objects.
    (Dmitry Osipenko)

Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c    | 12 +++++++++++
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  8 ++++++-
 drivers/gpu/drm/virtio/virtgpu_kms.c    | 28 +++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_object.c | 18 +++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_prime.c  |  2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 13 +++++++++---
 drivers/gpu/drm/virtio/virtgpu_vram.c   |  2 +-
 7 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 397f3d4f5906..bc3c0cc69eae 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -178,6 +178,9 @@ static int virtgpu_freeze(struct virtio_device *vdev)
 		return error;
 	}
 
+	if (vgdev->hibernation)
+		virtio_gpu_object_unref_all(vgdev);
+
 	flush_work(&vgdev->obj_free_work);
 	flush_work(&vgdev->ctrlq.dequeue_work);
 	flush_work(&vgdev->cursorq.dequeue_work);
@@ -210,6 +213,15 @@ static int virtgpu_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	if (vgdev->hibernation) {
+		vgdev->hibernation = false;
+		error = virtio_gpu_object_restore_all(vgdev);
+		if (error) {
+			DRM_ERROR("Failed to recover virtio-gpu objects\n");
+			return error;
+		}
+	}
+
 	error = drm_mode_config_helper_resume(dev);
 	if (error) {
 		DRM_ERROR("resume error %d\n", error);
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f91f31b861b8..c75db6ad51fc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -261,6 +261,7 @@ struct virtio_gpu_device {
 	bool has_resource_blob;
 	bool has_host_visible;
 	bool has_context_init;
+	bool hibernation;
 	struct virtio_shm_region host_visible_region;
 	struct drm_mm host_visible_mm;
 
@@ -277,6 +278,8 @@ struct virtio_gpu_device {
 	uint64_t capset_id_mask;
 	struct list_head cap_cache;
 
+	struct notifier_block pm_nb;
+
 	/* protects uuid state when exporting */
 	spinlock_t resource_export_lock;
 	/* protects map state and host_visible_mm */
@@ -341,7 +344,8 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object_array *objs,
 				    struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
-				   struct virtio_gpu_object *bo);
+				   struct virtio_gpu_object *bo,
+				   int no_cb);
 int virtio_gpu_panic_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					     uint64_t offset,
 					     uint32_t width, uint32_t height,
@@ -492,6 +496,8 @@ void virtio_gpu_add_object_to_restore_list(struct virtio_gpu_device *vgdev,
 
 int virtio_gpu_object_restore_all(struct virtio_gpu_device *vgdev);
 
+void virtio_gpu_object_unref_all(struct virtio_gpu_device *vgdev);
+
 /* virtgpu_prime.c */
 int virtio_gpu_resource_assign_uuid(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo);
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index ad12ea7165c4..5688e8f39dd6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -26,6 +26,8 @@
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
+#include <linux/suspend.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drm_file.h>
 #include <drm/drm_managed.h>
@@ -134,6 +136,25 @@ int virtio_gpu_find_vqs(struct virtio_gpu_device *vgdev)
 	return 0;
 }
 
+static int virtio_gpu_pm_notifier(struct notifier_block *nb, unsigned long mode,
+				  void *data)
+{
+	struct virtio_gpu_device *vgdev = container_of(nb,
+						struct virtio_gpu_device,
+						pm_nb);
+
+	if (mode == PM_HIBERNATION_PREPARE) {
+		if (vgdev->has_virgl_3d) {
+			DRM_ERROR("S4 not allowed when VIRGL is enabled\n");
+			return notifier_from_errno(-EPERM);
+		}
+
+		vgdev->hibernation = true;
+	}
+
+	return NOTIFY_DONE;
+}
+
 int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 {
 	struct virtio_gpu_device *vgdev;
@@ -270,6 +291,12 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
 				   5 * HZ);
 	}
+
+	vgdev->pm_nb.notifier_call = virtio_gpu_pm_notifier;
+	ret = register_pm_notifier(&vgdev->pm_nb);
+	if (ret)
+		goto err_scanouts;
+
 	return 0;
 
 err_scanouts:
@@ -302,6 +329,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
 	virtio_reset_device(vgdev->vdev);
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
 	mutex_destroy(&vgdev->obj_restore_lock);
+	unregister_pm_notifier(&vgdev->pm_nb);
 }
 
 void virtio_gpu_release(struct drm_device *dev)
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index a1ea65f7b1de..e4275274c2fa 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -104,7 +104,7 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
 
 	if (bo->created) {
 		virtio_gpu_remove_from_restore_list(bo);
-		virtio_gpu_cmd_unref_resource(vgdev, bo);
+		virtio_gpu_cmd_unref_resource(vgdev, bo, false);
 		virtio_gpu_notify(vgdev);
 		/* completion handler calls virtio_gpu_cleanup_object() */
 		return;
@@ -341,3 +341,19 @@ int virtio_gpu_object_restore_all(struct virtio_gpu_device *vgdev)
 
 	return ret;
 }
+
+void virtio_gpu_object_unref_all(struct virtio_gpu_device *vgdev)
+{
+	struct virtio_gpu_object *bo, *tmp;
+
+	mutex_lock(&vgdev->obj_restore_lock);
+	list_for_each_entry_safe(bo, tmp, &vgdev->obj_restore_list,
+				 restore_node)
+		if (bo->created) {
+			virtio_gpu_cmd_unref_resource(vgdev, bo, true);
+			virtio_gpu_notify(vgdev);
+		}
+
+	mutex_unlock(&vgdev->obj_restore_lock);
+}
+
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 27eaab9f5cfa..56686c453763 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -218,7 +218,7 @@ static void virtgpu_dma_buf_free_obj(struct drm_gem_object *obj)
 
 	if (bo->created) {
 		virtio_gpu_remove_from_restore_list(bo);
-		virtio_gpu_cmd_unref_resource(vgdev, bo);
+		virtio_gpu_cmd_unref_resource(vgdev, bo, false);
 		virtio_gpu_notify(vgdev);
 		return;
 	}
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 67865810a2e7..f454ba8553b0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -626,14 +626,21 @@ static void virtio_gpu_cmd_unref_cb(struct virtio_gpu_device *vgdev,
 }
 
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
-				   struct virtio_gpu_object *bo)
+				   struct virtio_gpu_object *bo,
+				   int no_cb)
 {
 	struct virtio_gpu_resource_unref *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
 	int ret;
 
-	cmd_p = virtio_gpu_alloc_cmd_cb(vgdev, &vbuf, sizeof(*cmd_p),
-					virtio_gpu_cmd_unref_cb);
+	if (no_cb) {
+		cmd_p = virtio_gpu_alloc_cmd_cb(vgdev, &vbuf, sizeof(*cmd_p),
+						NULL);
+	} else {
+		cmd_p = virtio_gpu_alloc_cmd_cb(vgdev, &vbuf, sizeof(*cmd_p),
+						virtio_gpu_cmd_unref_cb);
+	}
+
 	memset(cmd_p, 0, sizeof(*cmd_p));
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_UNREF);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
index 35f3f592ab19..db64d89539c6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -19,7 +19,7 @@ static void virtio_gpu_vram_free(struct drm_gem_object *obj)
 			virtio_gpu_cmd_unmap(vgdev, bo);
 
 		virtio_gpu_remove_from_restore_list(bo);
-		virtio_gpu_cmd_unref_resource(vgdev, bo);
+		virtio_gpu_cmd_unref_resource(vgdev, bo, false);
 		virtio_gpu_notify(vgdev);
 		return;
 	}
-- 
2.34.1

