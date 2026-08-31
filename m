Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B56C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAB410E368;
	Mon, 31 Aug 2026 12:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZB1SietX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF0710E368
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 12:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788178917; x=1819714917;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SCWbzX3nrl3zKFnV0y29R00pQxYqLpbUaFXPRluhel8=;
 b=ZB1SietXXuu/JieyBSqz9BAhJd+R+bnIhXxY/BfR6RtUBMkw/fEr/I6x
 yPNPPadhGIL1oQffis1RO7a4Cybz786og7lCEpDtQxZy+hRSCpcT4GXMG
 zmBuiTBP0GNHcGpLvX9Jgnkc5U5rYevKvPx+bDYPllS3VJnhlUCskjjpv
 9xw1GA55ymOItTRh0SyHiNXVoZteA0Uri5Aj9lgSTeUW1+ZStyvkd8W4k
 fqrymG8lREV30DVsVWtS718io0zkM2fnztPDCVhQpIqkqzT4wtM3uvVgs
 vJlkpkxhddseau+A0/AnySctYJU2Mj5ZmHmEdzb3nfwi9Q2uF+4+aPbWa Q==;
X-CSE-ConnectionGUID: uv1rlBY0TbCWcJYq4fndDg==
X-CSE-MsgGUID: MR7uQGcXSbeoxw1Cfc4tiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="98921697"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="98921697"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 05:21:56 -0700
X-CSE-ConnectionGUID: 9W4GG0VaTgKHLl5e4vfGfg==
X-CSE-MsgGUID: 6j/ne4O5Q3CpxFPyrJ7mZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="269376259"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 05:21:55 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com
Subject: [PATCH] accel/ivpu: Add support for getting and setting command queue
 priority
Date: Mon, 31 Aug 2026 14:16:17 +0200
Message-ID: <20260831121617.395523-1-andrzej.kacprowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

Add a new DRM_IVPU_PARAM_CMDQ_PRIORITY parameter to query and update
the scheduling priority of an existing command queue, identified by
its ID via drm_ivpu_param.index.

The priority can be changed on a queue that already has pending jobs;
if the queue's doorbell is registered, the new priority is propagated
to the firmware immediately, otherwise it is applied when the queue is
next registered. The firmware picks up the change at the first
opportunity.

The feature requires HW scheduling mode and is advertised through the
new DRM_IVPU_CAP_CMDQ_SET_PRIORITY capability. Legacy command queues
are not supported.

Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 13 ++++++
 drivers/accel/ivpu/ivpu_job.c | 85 +++++++++++++++++++++++++++++++++++
 drivers/accel/ivpu/ivpu_job.h |  5 ++-
 include/uapi/drm/ivpu_accel.h | 17 ++++++-
 4 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 95120957f42a..0f215392d42d 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -205,6 +205,7 @@ bool ivpu_is_capable(struct ivpu_device *vdev, u32 capability)
 	case DRM_IVPU_CAP_BO_CREATE_FROM_USERPTR:
 		return true;
 	case DRM_IVPU_CAP_MANAGE_CMDQ:
+	case DRM_IVPU_CAP_CMDQ_SET_PRIORITY:
 		return vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW;
 	default:
 		return false;
@@ -273,6 +274,9 @@ static int ivpu_get_param_ioctl(struct drm_device *dev, void *data, struct drm_f
 	case DRM_IVPU_PARAM_PREEMPT_BUFFER_SIZE:
 		args->value = ivpu_fw_preempt_buf_size(vdev);
 		break;
+	case DRM_IVPU_PARAM_CMDQ_PRIORITY:
+		ret = ivpu_cmdq_get_priority(file_priv, args->index, &args->value);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -284,14 +288,23 @@ static int ivpu_get_param_ioctl(struct drm_device *dev, void *data, struct drm_f
 
 static int ivpu_set_param_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 {
+	struct ivpu_file_priv *file_priv = file->driver_priv;
 	struct drm_ivpu_param *args = data;
 	int ret = 0;
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return -ENODEV;
 
 	switch (args->param) {
+	case DRM_IVPU_PARAM_CMDQ_PRIORITY:
+		ret = ivpu_cmdq_set_priority(file_priv, args->index, args->value);
+		break;
 	default:
 		ret = -EINVAL;
 	}
 
+	drm_dev_exit(idx);
 	return ret;
 }
 
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index ebb2c865b09a..b3de5dd29d1e 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -323,6 +323,11 @@ static inline u8 ivpu_job_to_jsm_priority(u8 priority)
 	return priority - 1;
 }
 
+static inline u8 ivpu_jsm_to_job_priority(u8 priority)
+{
+	return priority + 1;
+}
+
 static void ivpu_cmdq_destroy(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cmdq)
 {
 	lockdep_assert_held(&file_priv->lock);
@@ -1127,6 +1132,86 @@ int ivpu_cmdq_destroy_ioctl(struct drm_device *dev, void *data, struct drm_file
 	return ret;
 }
 
+static int ivpu_cmdq_priority_args_check(struct ivpu_device *vdev, u32 cmdq_id, u64 priority)
+{
+	if (!ivpu_is_capable(vdev, DRM_IVPU_CAP_CMDQ_SET_PRIORITY)) {
+		ivpu_dbg(vdev, IOCTL, "Command queue priority not supported\n");
+		return -ENODEV;
+	}
+
+	if (cmdq_id < IVPU_CMDQ_MIN_ID || cmdq_id > IVPU_CMDQ_MAX_ID) {
+		ivpu_dbg(vdev, IOCTL, "Invalid command queue ID %u\n", cmdq_id);
+		return -EINVAL;
+	}
+
+	if (priority > DRM_IVPU_JOB_PRIORITY_REALTIME)
+		return -EINVAL;
+
+	return 0;
+}
+
+int ivpu_cmdq_get_priority(struct ivpu_file_priv *file_priv, u32 cmdq_id, u64 *priority)
+{
+	struct ivpu_device *vdev = file_priv->vdev;
+	struct ivpu_cmdq *cmdq;
+	int ret;
+
+	ret = ivpu_cmdq_priority_args_check(vdev, cmdq_id, DRM_IVPU_JOB_PRIORITY_NORMAL);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&file_priv->lock);
+
+	cmdq = ivpu_cmdq_acquire(file_priv, cmdq_id);
+	if (!cmdq || cmdq->is_legacy)
+		return -EINVAL;
+
+	*priority = ivpu_jsm_to_job_priority(cmdq->priority);
+	return 0;
+}
+
+int ivpu_cmdq_set_priority(struct ivpu_file_priv *file_priv, u32 cmdq_id, u64 priority)
+{
+	struct ivpu_device *vdev = file_priv->vdev;
+	struct ivpu_cmdq *cmdq;
+	u8 jsm_priority;
+	int ret = 0;
+
+	ret = ivpu_cmdq_priority_args_check(vdev, cmdq_id, priority);
+	if (ret)
+		return ret;
+
+	ret = ivpu_rpm_get(vdev);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&file_priv->lock);
+
+	cmdq = ivpu_cmdq_acquire(file_priv, cmdq_id);
+	if (!cmdq || cmdq->is_legacy) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	jsm_priority = ivpu_job_to_jsm_priority(priority);
+	if (cmdq->priority == jsm_priority)
+		goto out;
+
+	if (cmdq->db_id) {
+		ret = ivpu_jsm_hws_set_context_sched_properties(vdev, file_priv->ctx.id, cmdq_id,
+								jsm_priority);
+		if (ret)
+			goto out;
+	}
+
+	cmdq->priority = jsm_priority;
+
+out:
+	mutex_unlock(&file_priv->lock);
+	ivpu_rpm_put(vdev);
+	return ret;
+}
+
 static void
 ivpu_job_done_callback(struct ivpu_device *vdev, struct ivpu_ipc_hdr *ipc_hdr,
 		       struct vpu_jsm_msg *jsm_msg)
diff --git a/drivers/accel/ivpu/ivpu_job.h b/drivers/accel/ivpu/ivpu_job.h
index d8dbce82447a..6e32fea1eb62 100644
--- a/drivers/accel/ivpu/ivpu_job.h
+++ b/drivers/accel/ivpu/ivpu_job.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2025 Intel Corporation
+ * Copyright (C) 2020-2026 Intel Corporation
  */
 
 #ifndef __IVPU_JOB_H__
@@ -81,6 +81,9 @@ int ivpu_cmdq_create_ioctl(struct drm_device *dev, void *data, struct drm_file *
 int ivpu_cmdq_destroy_ioctl(struct drm_device *dev, void *data, struct drm_file *file);
 int ivpu_cmdq_submit_ioctl(struct drm_device *dev, void *data, struct drm_file *file);
 
+int ivpu_cmdq_get_priority(struct ivpu_file_priv *file_priv, u32 cmdq_id, u64 *priority);
+int ivpu_cmdq_set_priority(struct ivpu_file_priv *file_priv, u32 cmdq_id, u64 priority);
+
 void ivpu_context_abort_locked(struct ivpu_file_priv *file_priv);
 
 void ivpu_cmdq_release_all_locked(struct ivpu_file_priv *file_priv);
diff --git a/include/uapi/drm/ivpu_accel.h b/include/uapi/drm/ivpu_accel.h
index 264505d54f93..9ce19d9c3131 100644
--- a/include/uapi/drm/ivpu_accel.h
+++ b/include/uapi/drm/ivpu_accel.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
- * Copyright (C) 2020-2025 Intel Corporation
+ * Copyright (C) 2020-2026 Intel Corporation
  */
 
 #ifndef __UAPI_IVPU_DRM_H__
@@ -96,6 +96,7 @@ extern "C" {
 #define DRM_IVPU_PARAM_SKU		    12
 #define DRM_IVPU_PARAM_CAPABILITIES	    13
 #define DRM_IVPU_PARAM_PREEMPT_BUFFER_SIZE  14
+#define DRM_IVPU_PARAM_CMDQ_PRIORITY	    15
 
 #define DRM_IVPU_PLATFORM_TYPE_SILICON	    0
 
@@ -140,6 +141,15 @@ extern "C" {
  */
 #define DRM_IVPU_CAP_BO_CREATE_FROM_USERPTR	4
 
+/**
+ * DRM_IVPU_CAP_CMDQ_SET_PRIORITY
+ *
+ * Driver supports DRM_IVPU_PARAM_CMDQ_PRIORITY parameter to get/set command
+ * queue priority.
+ * This allows changing command queue priority after creation.
+ */
+#define DRM_IVPU_CAP_CMDQ_SET_PRIORITY	5
+
 /**
  * struct drm_ivpu_param - Get/Set VPU parameters
  */
@@ -192,6 +202,11 @@ struct drm_ivpu_param {
 	 *
 	 * %DRM_IVPU_PARAM_PREEMPT_BUFFER_SIZE:
 	 * Size of the preemption buffer (read-only)
+	 *
+	 * %DRM_IVPU_PARAM_CMDQ_PRIORITY:
+	 * Get/Set command queue priority (see DRM_IVPU_JOB_PRIORITY_*).
+	 * DRM_IVPU_JOB_PRIORITY_DEFAULT is treated as DRM_IVPU_JOB_PRIORITY_NORMAL.
+	 * Command queue ID is given via drm_ivpu_param.index.
 	 */
 	__u32 param;
 
-- 
2.43.0

