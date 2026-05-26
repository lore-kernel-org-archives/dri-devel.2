Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1334FCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 19:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623D110E54A;
	Tue, 26 May 2026 19:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gVSNjFwi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E920410E1C9
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 19:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779823734; x=1811359734;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XQwcTUHdfQmbvyGlO2P1MTlKu+URis0tgY1z0nqk/Xo=;
 b=gVSNjFwi2PPwNRSKLMf6qwm+DKUQC7TiSadiL4DdL71ch8HPOrH/vtFo
 kKh3Zw904G7ZeGz+n8qW0wLDkvSwXAohzVf7NqkOhABMV71tjOLu0pPbW
 IGPv63snx4fyZcskSK/QQk9V+48heoByYJtFQITHDCv/nFEFGAFRIuYBk
 c+h22PAbBsnT96Y9gbyL1xp68X0W8Yl6stn/UUhs3F7eBb67IqSMUi3bX
 hZV8aBE022uvn7Y+7fjsojFlB0NvPajaD733BAGiIGGEYJTPZDj0d2+RQ
 FMpx3SQERWHynK/iiHYUf4qG03/r1tq3AecilDxx6jz3mxl9JKMgWHdhA Q==;
X-CSE-ConnectionGUID: PBxrKVGAR6+4q+cwI7JdCA==
X-CSE-MsgGUID: x/pA0OLiQw2ljJhllx37cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91219168"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="91219168"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 12:28:53 -0700
X-CSE-ConnectionGUID: qn0H6IvyRaOLA1rU3O6ytQ==
X-CSE-MsgGUID: 1mavTKkSSj22tIC8JHsQDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="241172577"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.158.5])
 by orviesa010.jf.intel.com with ESMTP; 26 May 2026 12:28:53 -0700
From: dongwon.kim@intel.com
To: dri-devel@lists.freedesktop.org, airlied@redhat.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com
Subject: [PATCH v9 1/3] drm/virtio: Freeze and restore hooks to support
 suspend and resume
Date: Tue, 26 May 2026 12:28:12 -0700
Message-Id: <20260526192814.179673-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526192814.179673-1-dongwon.kim@intel.com>
References: <20260526192814.179673-1-dongwon.kim@intel.com>
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

virtio device needs to delete before VM suspend happens
then reinitialize all virtqueues again upon resume

Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Nirmoy Das <nirmoyd@nvidia.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
v2: 10ms sleep was added in virtgpu_freeze to avoid the situation
    the driver is locked up during resumption.

v3: Plain 10ms delay was replaced with wait calls which wait until
    the virtio queue is empty.
    (Dmitry Osipenko)

v4: Change wait_event to wait_event_timeout to prevent permanent wait
    (Nirmoy Das)

v5: Move duplicate wait_event_timeout blocks into a single
    virtio_gpu_wait_queue helper function.
    (Dmitry Osipenko)

    Handle timeouts gracefully by returning -ETIMEDOUT to abort
    the freeze operation if the host hangs.
    (Dmitry Osipenko)
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 68 +++++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h |  2 +
 drivers/gpu/drm/virtio/virtgpu_kms.c | 23 +++++++---
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 17 +++++++
 4 files changed, 103 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 812ee3f5e4aa..fd3fbc7474dd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -165,6 +165,68 @@ static unsigned int features[] = {
 	VIRTIO_GPU_F_CONTEXT_INIT,
 	VIRTIO_GPU_F_BLOB_ALIGNMENT,
 };
+
+#ifdef CONFIG_PM_SLEEP
+static int virtgpu_freeze(struct virtio_device *vdev)
+{
+	struct drm_device *dev = vdev->priv;
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+	int error;
+
+	error = drm_mode_config_helper_suspend(dev);
+	if (error) {
+		DRM_ERROR("suspend error %d\n", error);
+		return error;
+	}
+
+	flush_work(&vgdev->obj_free_work);
+	flush_work(&vgdev->ctrlq.dequeue_work);
+	flush_work(&vgdev->cursorq.dequeue_work);
+	flush_work(&vgdev->config_changed_work);
+
+	error = virtio_gpu_wait_queue(&vgdev->ctrlq, vgdev->ctrlq.vq->num_max);
+
+	if (error) {
+		DRM_ERROR("suspend error %d\n", error);
+		return error;
+	}
+
+	error = virtio_gpu_wait_queue(&vgdev->cursorq, vgdev->cursorq.vq->num_max);
+
+	if (error) {
+		DRM_ERROR("suspend error %d\n", error);
+		return error;
+	}
+
+	vdev->config->del_vqs(vdev);
+
+	return 0;
+}
+
+static int virtgpu_restore(struct virtio_device *vdev)
+{
+	struct drm_device *dev = vdev->priv;
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+	int error;
+
+	error = virtio_gpu_find_vqs(vgdev);
+	if (error) {
+		DRM_ERROR("failed to find virt queues\n");
+		return error;
+	}
+
+	virtio_device_ready(vdev);
+
+	error = drm_mode_config_helper_resume(dev);
+	if (error) {
+		DRM_ERROR("resume error %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+#endif
+
 static struct virtio_driver virtio_gpu_driver = {
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
@@ -173,7 +235,11 @@ static struct virtio_driver virtio_gpu_driver = {
 	.probe = virtio_gpu_probe,
 	.remove = virtio_gpu_remove,
 	.shutdown = virtio_gpu_shutdown,
-	.config_changed = virtio_gpu_config_changed
+	.config_changed = virtio_gpu_config_changed,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtgpu_freeze,
+	.restore = virtgpu_restore,
+#endif
 };
 
 static int __init virtio_gpu_driver_init(void)
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 7449907754a4..c630c75e308b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -303,6 +303,7 @@ void virtio_gpu_deinit(struct drm_device *dev);
 void virtio_gpu_release(struct drm_device *dev);
 int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file);
 void virtio_gpu_driver_postclose(struct drm_device *dev, struct drm_file *file);
+int virtio_gpu_find_vqs(struct virtio_gpu_device *vgdev);
 
 /* virtgpu_gem.c */
 int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
@@ -424,6 +425,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work);
 void virtio_gpu_dequeue_cursor_func(struct work_struct *work);
 void virtio_gpu_panic_notify(struct virtio_gpu_device *vgdev);
 void virtio_gpu_notify(struct virtio_gpu_device *vgdev);
+int virtio_gpu_wait_queue(struct virtio_gpu_queue *vgvq, int num_elem);
 
 int
 virtio_gpu_cmd_resource_assign_uuid(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index cfde9f573df6..82baf1b3717e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -115,15 +115,28 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
 	vgdev->num_capsets = num_capsets;
 }
 
-int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
+int virtio_gpu_find_vqs(struct virtio_gpu_device *vgdev)
 {
 	struct virtqueue_info vqs_info[] = {
 		{ "control", virtio_gpu_ctrl_ack },
 		{ "cursor", virtio_gpu_cursor_ack },
 	};
-	struct virtio_gpu_device *vgdev;
-	/* this will expand later */
 	struct virtqueue *vqs[2];
+	int ret;
+
+	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, vqs_info, NULL);
+	if (ret)
+		return ret;
+
+	vgdev->ctrlq.vq = vqs[0];
+	vgdev->cursorq.vq = vqs[1];
+
+	return 0;
+}
+
+int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
+{
+	struct virtio_gpu_device *vgdev;
 	u32 num_scanouts, num_capsets, blob_alignment;
 	int ret = 0;
 
@@ -215,13 +228,11 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		 vgdev->has_context_init ? '+' : '-',
 		 vgdev->has_blob_alignment ? '+' : '-');
 
-	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, vqs_info, NULL);
+	ret = virtio_gpu_find_vqs(vgdev);
 	if (ret) {
 		DRM_ERROR("failed to find virt queues\n");
 		goto err_vqs;
 	}
-	vgdev->ctrlq.vq = vqs[0];
-	vgdev->cursorq.vq = vqs[1];
 	ret = virtio_gpu_alloc_vbufs(vgdev);
 	if (ret) {
 		DRM_ERROR("failed to alloc vbufs\n");
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 67865810a2e7..22bf11497f16 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -369,6 +369,23 @@ static int virtio_gpu_panic_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	return 0;
 }
 
+int virtio_gpu_wait_queue(struct virtio_gpu_queue *vgvq, int num_elem)
+{
+	int ret;
+
+	/* Cap num_elem at the queue's maximum capacity */
+	num_elem = min(num_elem, (int)vgvq->vq->num_max);
+
+	/* Wait up to 5 seconds for enough free slots to become available */
+	ret = wait_event_timeout(vgvq->ack_queue,
+				 vgvq->vq->num_free >= num_elem,
+				 5 * HZ);
+	if (ret == 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 				     struct virtio_gpu_vbuffer *vbuf,
 				     struct virtio_gpu_fence *fence,
-- 
2.34.1

