Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87325606A31F
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AK29E5tQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDCEC10E739;
	Sun,  8 Nov 2026 05:17:11 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525F410EB88
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:17:05 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-36e795af1d4so158250eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 21:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794115024; x=1794719824; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KEj12dtkAG3GtLVKFyb77WvSAyKGQSNJ5fAS9RqTe8A=;
 b=AK29E5tQvaZp4yCZlvH4W5+avzO1e0DiITM1/ijnIaNxzFABlmOYiLeN1rObRZxM3z
 ZOPGWSmESg/5yfZKu3rS0fdVGTK7GvtebeDgnR42gpNty/qq7IRT9UxqruvTkJwk3+E6
 HbJPDe6BdkVf4CtLmLIZz9flLCpfSJ5eZ668U0CNxcaxZuVl3z+L5QkPOml7FZLor+aP
 S0hySMnq8g8GyWsuzurnkDGDgLcc3vJx5b+F30/LmWwqbq4bTEebrRyhAIWEx5Dcd4Bg
 zQT8FESnjAeLl0JrolLaROu8Z95lflRKgL8igNBYfQGVj2fNSu1ubvk7vYo9WQk/nIlb
 TI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794115024; x=1794719824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KEj12dtkAG3GtLVKFyb77WvSAyKGQSNJ5fAS9RqTe8A=;
 b=IP0W6VDgbaGayS3NunrUEhevcY9tJihDX0EoCMDhP0tZ1POAEzplf2KOJx8TAhoD77
 VRHSA26ylrqQd1ACCFi32VwE2a/Q7LuNw91ODU7pS5xBeZSTn9BrgD9LS9cPdQvL0ne8
 kU8ywMP7O/TIYGagBY1XTQs4oOIFmV3mWt8ymcpJbz8gXgOtG2SZcb4RU27H4t48ah+E
 CJBIXc7dwzuGwyIh/ssRR61i0kAgFxeM4k5E8U6mfnp8eenckx24tt+L//jDFJZluYW3
 GXQoPk4r15h3AJbPn/8u8UCH6dYRRvaC0YciCuKTtNa+ZXG8og9uiflYfkb1c6l+nfun
 s6sA==
X-Forwarded-Encrypted: i=1;
 AL+hErFvO3GBbYOPC+8uOCXSLa7u806f9UbS4/B8BETt+upiIdWATTiRmZN+t0tI4G5OfYI5ggAqXUfnP54=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+a6jeFX9fur+DeGGUsv5t3yO6j39xmRGNDc/j5GaBW7uYUrwk0
 DMrtM1ie64+9YM1qvagb4wGZthaFnOVOy41Q/3M11Y8TFe1JV0Uj6iQ0
X-Gm-Gg: AYBFou2rnstJyWqDeiipq5pcVwrS68w2L+LX5+car3WfYLx6IdN9krq9CL3FaT/YV4y
 qiMV3fySZV2sPvyYQJ6Q+wSIYERUO/ZUt80T5LJgT9VR1Mc/RABE7fy+ZV/wXFMUrkDzqYhOIm/
 q7QFfeQoIycOb7xOpMG8jrHSq1AjrXA0rvFWbXfOPofslgMtdkd4YmhVKq1Gcqi7ZTD6C0ONtKf
 o5DwkFbxWQVdQpceOEtqdg2qK+fBPJaYBh0V6330Rf8ZDv/+K4qbBl4AIBku08Ev5NcmF3MnQlJ
 oYLLvIVn3zSuVUiYUR69NMxFvB7pEbynD3egwGAuUuXevGBlS9uYxnRmsyrfY/Mlr9dAvl1GlKQ
 Y/7a+p3duneYYT1Y8iTJ5lLG1M3tIGpqC20Gr1QY4WWNKvX5CBh722GeZ9tjMD8dynd/7afJpZr
 0Hz9yPX33WFBgJv5FikpYDM6dIqDgLmNS6840MYcG7uuG5ac3LJ/27mEXrgNXjiwC0Ueji6LUWB
 sFfVp1QBGCvJFpfMjZwyr4oFDJ/EnfcmREF42KF6escZ7O0/SH7qwYThTjn4QDePkkIu4t9iauc
 UcFNeUM6xksugO6Eo5WjrdKVtw==
X-Received: by 2002:a05:7300:f643:b0:371:197b:5ade with SMTP id
 5a478bee46e88-371197b5cfcmr5417322eec.11.1794115023710; 
 Sat, 07 Nov 2026 21:17:03 -0800 (PST)
Received: from [127.0.1.1] ([121.125.115.175])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372667d60absm2750989eec.26.2026.11.07.21.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 21:17:03 -0800 (PST)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 08 Nov 2026 14:16:27 +0900
Subject: [PATCH v2 5/6] drm/imagination: Add asynchronous VM_BIND
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-pvr-vm-bind-v2-5-730103d2cc9a@gmail.com>
References: <20261108-pvr-vm-bind-v2-0-730103d2cc9a@gmail.com>
In-Reply-To: <20261108-pvr-vm-bind-v2-0-730103d2cc9a@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>, 
 Matt Coster <opensource@mtcoster.net>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
 Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

Add DRM_PVR_VM_BIND_ASYNC, which runs a VM_BIND request asynchronously.
sync_ops can only be used with this flag.

Each VM context has one drm_sched queue for bind requests. A request
with the flag set is queued there as a job and runs in submission order.
The job runs on the CPU, so it waits for completion fences rather than
scheduled ones, and syncs the page tables itself.
pvr_mmu_op_context_sync() is made public for this.

A request that fails part way through makes its VM context unusable:
further binds and job submissions on it fail with -ECANCELED.

Converting a wait operation into a fence is split out into
pvr_sync_wait_op_get_fence() and shared with pvr_sync_add_deps_to_job(),
which behaves as before.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 Documentation/gpu/imagination/uapi.rst  |   3 +
 drivers/gpu/drm/imagination/pvr_drv.c   | 127 ++++++++++-
 drivers/gpu/drm/imagination/pvr_job.c   |   6 +
 drivers/gpu/drm/imagination/pvr_mmu.c   |   2 +-
 drivers/gpu/drm/imagination/pvr_mmu.h   |   1 +
 drivers/gpu/drm/imagination/pvr_queue.c |   3 +
 drivers/gpu/drm/imagination/pvr_sync.c  | 146 +++++++++++--
 drivers/gpu/drm/imagination/pvr_sync.h  |  13 ++
 drivers/gpu/drm/imagination/pvr_vm.c    | 359 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/imagination/pvr_vm.h    |   9 +
 include/uapi/drm/pvr_drm.h              |  34 ++-
 11 files changed, 673 insertions(+), 30 deletions(-)

diff --git a/Documentation/gpu/imagination/uapi.rst b/Documentation/gpu/imagination/uapi.rst
index 781d54ec01e..8c96b6bc7a7 100644
--- a/Documentation/gpu/imagination/uapi.rst
+++ b/Documentation/gpu/imagination/uapi.rst
@@ -95,6 +95,9 @@ VM_BIND
 .. kernel-doc:: include/uapi/drm/pvr_drm.h
    :doc: Flags for VM_BIND operations.
 
+.. kernel-doc:: include/uapi/drm/pvr_drm.h
+   :doc: Flags for the VM_BIND ioctl.
+
 .. kernel-doc:: include/uapi/drm/pvr_drm.h
    :identifiers: drm_pvr_vm_bind_op
                  drm_pvr_ioctl_vm_bind_args
diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 8203d5f081d..c35d437aef7 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -15,6 +15,7 @@
 #include "pvr_rogue_defs.h"
 #include "pvr_rogue_fwif_client.h"
 #include "pvr_rogue_fwif_shared.h"
+#include "pvr_sync.h"
 #include "pvr_trace.h"
 #include "pvr_vm.h"
 
@@ -26,6 +27,7 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
 
+#include <linux/dma-fence.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/fs.h>
@@ -1227,6 +1229,84 @@ pvr_vm_bind_descs_from_uapi(struct pvr_file *pvr_file,
 	return descs;
 }
 
+/**
+ * struct pvr_vm_bind_syncs - Translated sync operations of a VM_BIND request.
+ */
+struct pvr_vm_bind_syncs {
+	/** @waits: Fences to wait for before applying the request. */
+	struct dma_fence **waits;
+
+	/** @wait_count: Number of entries in @waits. */
+	u32 wait_count;
+
+	/** @signals: Syncobjs to signal once the request has been applied. */
+	struct xarray signals;
+};
+
+/**
+ * pvr_vm_bind_syncs_release() - Release translated sync operations.
+ * @syncs: Sync operations to release.
+ */
+static void pvr_vm_bind_syncs_release(struct pvr_vm_bind_syncs *syncs)
+{
+	pvr_sync_signal_array_cleanup(&syncs->signals);
+	pvr_sync_put_fences(syncs->waits, syncs->wait_count);
+}
+
+/**
+ * pvr_vm_bind_syncs_from_uapi() - Translate VM_BIND sync operations.
+ * @syncs: Sync operations to fill in, to be released with
+ *         pvr_vm_bind_syncs_release() on success.
+ * @file: DRM file the request was issued on.
+ * @uapi_sync_ops: Userspace sync operations.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int
+pvr_vm_bind_syncs_from_uapi(struct pvr_vm_bind_syncs *syncs,
+			    struct drm_file *file,
+			    const struct drm_pvr_obj_array *uapi_sync_ops)
+{
+	struct drm_pvr_sync_op *ops;
+	struct dma_fence **waits;
+	int err;
+
+	syncs->waits = NULL;
+	syncs->wait_count = 0;
+	xa_init_flags(&syncs->signals, XA_FLAGS_ALLOC);
+
+	if (!uapi_sync_ops->count)
+		return 0;
+
+	err = PVR_UOBJ_GET_ARRAY(ops, uapi_sync_ops);
+	if (err)
+		return err;
+
+	err = pvr_sync_signal_array_collect_ops(&syncs->signals, file,
+						uapi_sync_ops->count, ops);
+	if (err)
+		goto err_syncs_release;
+
+	waits = pvr_sync_get_wait_fences(file, uapi_sync_ops->count, ops,
+					 &syncs->wait_count);
+	if (IS_ERR(waits)) {
+		err = PTR_ERR(waits);
+		goto err_syncs_release;
+	}
+
+	syncs->waits = waits;
+
+	kvfree(ops);
+
+	return 0;
+
+err_syncs_release:
+	pvr_vm_bind_syncs_release(syncs);
+	kvfree(ops);
+
+	return err;
+}
+
 /**
  * pvr_ioctl_vm_bind() - IOCTL to apply a batch of VM bind operations.
  * @drm_dev: [IN] DRM device.
@@ -1248,8 +1328,9 @@ pvr_ioctl_vm_bind(struct drm_device *drm_dev, void *raw_args,
 {
 	struct drm_pvr_ioctl_vm_bind_args *args = raw_args;
 	struct pvr_file *pvr_file = to_pvr_file(file);
-	struct drm_pvr_vm_bind_op *uapi_ops;
+	struct drm_pvr_vm_bind_op *uapi_ops = NULL;
 	struct pvr_vm_bind_desc *descs;
+	struct pvr_vm_bind_syncs syncs;
 	struct pvr_vm_context *vm_ctx;
 	int idx;
 	int err;
@@ -1257,12 +1338,17 @@ pvr_ioctl_vm_bind(struct drm_device *drm_dev, void *raw_args,
 	if (!drm_dev_enter(drm_dev, &idx))
 		return -EIO;
 
-	if (args->flags || args->sync_ops.count) {
+	if (args->flags & ~DRM_PVR_VM_BIND_FLAGS_MASK) {
+		err = -EINVAL;
+		goto err_drm_dev_exit;
+	}
+
+	if (!(args->flags & DRM_PVR_VM_BIND_ASYNC) && args->sync_ops.count) {
 		err = -EINVAL;
 		goto err_drm_dev_exit;
 	}
 
-	if (!args->ops.count) {
+	if (!args->ops.count && !args->sync_ops.count) {
 		err = 0;
 		goto err_drm_dev_exit;
 	}
@@ -1273,9 +1359,11 @@ pvr_ioctl_vm_bind(struct drm_device *drm_dev, void *raw_args,
 		goto err_drm_dev_exit;
 	}
 
-	err = PVR_UOBJ_GET_ARRAY(uapi_ops, &args->ops);
-	if (err)
-		goto err_put_vm_context;
+	if (args->ops.count) {
+		err = PVR_UOBJ_GET_ARRAY(uapi_ops, &args->ops);
+		if (err)
+			goto err_put_vm_context;
+	}
 
 	descs = pvr_vm_bind_descs_from_uapi(pvr_file, uapi_ops, args->ops.count);
 	kvfree(uapi_ops);
@@ -1284,8 +1372,33 @@ pvr_ioctl_vm_bind(struct drm_device *drm_dev, void *raw_args,
 		goto err_put_vm_context;
 	}
 
-	err = pvr_vm_bind(vm_ctx, descs, args->ops.count);
+	/* Empty in synchronous mode, rejected above otherwise. */
+	err = pvr_vm_bind_syncs_from_uapi(&syncs, file, &args->sync_ops);
+	if (err)
+		goto err_descs_release;
+
+	if (args->flags & DRM_PVR_VM_BIND_ASYNC) {
+		struct dma_fence *fence;
+
+		fence = pvr_vm_bind_async(vm_ctx, descs, args->ops.count,
+					  syncs.waits, syncs.wait_count,
+					  file->client_id);
+		if (IS_ERR(fence)) {
+			err = PTR_ERR(fence);
+			goto err_syncs_release;
+		}
+
+		pvr_sync_signal_array_set_fence(&syncs.signals, fence);
+		pvr_sync_signal_array_push_fences(&syncs.signals);
+		dma_fence_put(fence);
+	} else {
+		err = pvr_vm_bind(vm_ctx, descs, args->ops.count);
+	}
+
+err_syncs_release:
+	pvr_vm_bind_syncs_release(&syncs);
 
+err_descs_release:
 	pvr_vm_bind_descs_release(descs, args->ops.count);
 
 err_put_vm_context:
diff --git a/drivers/gpu/drm/imagination/pvr_job.c b/drivers/gpu/drm/imagination/pvr_job.c
index b8a58d81700..04f920aaf12 100644
--- a/drivers/gpu/drm/imagination/pvr_job.c
+++ b/drivers/gpu/drm/imagination/pvr_job.c
@@ -15,6 +15,7 @@
 #include "pvr_stream_defs.h"
 #include "pvr_sync.h"
 #include "pvr_trace.h"
+#include "pvr_vm.h"
 
 #include <drm/drm_exec.h>
 #include <drm/drm_gem.h>
@@ -434,6 +435,11 @@ create_job(struct pvr_device *pvr_dev,
 		goto err_put_job;
 	}
 
+	if (pvr_vm_context_is_unusable(job->ctx->vm_ctx)) {
+		err = -ECANCELED;
+		goto err_put_job;
+	}
+
 	if (args->hwrt.set_handle) {
 		job->hwrt = pvr_hwrt_data_lookup(pvr_file, args->hwrt.set_handle,
 						 args->hwrt.data_index);
diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 8ffa80bee97..5e39fa25e58 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -2017,7 +2017,7 @@ pvr_mmu_op_context_sync_partial(struct pvr_mmu_op_context *op_ctx,
  * that subsequent calls to this function will be no-ops unless @op_ctx is
  * otherwise updated.
  */
-static void
+void
 pvr_mmu_op_context_sync(struct pvr_mmu_op_context *op_ctx)
 {
 	pvr_mmu_op_context_sync_manual(op_ctx, op_ctx->sync_level_required);
diff --git a/drivers/gpu/drm/imagination/pvr_mmu.h b/drivers/gpu/drm/imagination/pvr_mmu.h
index ddf175eb5f9..73475578515 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.h
+++ b/drivers/gpu/drm/imagination/pvr_mmu.h
@@ -97,6 +97,7 @@ void pvr_mmu_context_destroy(struct pvr_mmu_context *ctx);
 dma_addr_t pvr_mmu_get_root_table_dma_addr(struct pvr_mmu_context *ctx);
 
 void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx);
+void pvr_mmu_op_context_sync(struct pvr_mmu_op_context *op_ctx);
 struct pvr_mmu_op_context *
 pvr_mmu_op_context_create(struct pvr_mmu_context *ctx,
 			  struct sg_table *sgt, u64 device_addr, u64 sgt_offset, u64 size);
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 24a8645aa91..ac5862b1c52 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -759,6 +759,9 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 		return dma_fence_get(job->done_fence);
 	}
 
+	if (pvr_vm_context_is_unusable(job->ctx->vm_ctx))
+		return ERR_PTR(-ECANCELED);
+
 	/* The only kind of jobs that can be paired are geometry and fragment, and
 	 * we bail out early if we see a fragment job that's paired with a geometry job.
 	 * Paired jobs must also target the same context and point to the same HWRT.
diff --git a/drivers/gpu/drm/imagination/pvr_sync.c b/drivers/gpu/drm/imagination/pvr_sync.c
index 936f840a522..714b26e776f 100644
--- a/drivers/gpu/drm/imagination/pvr_sync.c
+++ b/drivers/gpu/drm/imagination/pvr_sync.c
@@ -185,6 +185,28 @@ pvr_sync_signal_array_update_fences(struct xarray *array,
 	return 0;
 }
 
+/**
+ * pvr_sync_signal_array_set_fence() - Set the fence of all entries.
+ * @array: Signal array, as filled by pvr_sync_signal_array_collect_ops().
+ * @fence: Fence to set. Must not be %NULL.
+ *
+ * Unlike pvr_sync_signal_array_update_fences(), entries are not filtered by
+ * sync operations. pvr_sync_signal_array_push_fences() installs the fences.
+ */
+void
+pvr_sync_signal_array_set_fence(struct xarray *array, struct dma_fence *fence)
+{
+	struct pvr_sync_signal *sig_sync;
+	unsigned long i;
+
+	xa_for_each(array, i, sig_sync) {
+		struct dma_fence *old_fence = sig_sync->fence;
+
+		sig_sync->fence = dma_fence_get(fence);
+		dma_fence_put(old_fence);
+	}
+}
+
 void
 pvr_sync_signal_array_push_fences(struct xarray *array)
 {
@@ -244,6 +266,40 @@ pvr_sync_add_dep_to_job(struct drm_sched_job *job, struct dma_fence *f)
 	return err;
 }
 
+/*
+ * Resolve a wait operation to the fence it waits on. A fence already set in
+ * @signal_array, if not NULL, takes precedence over the one currently in the
+ * syncobj.
+ */
+static int
+pvr_sync_wait_op_get_fence(struct drm_file *file,
+			   const struct drm_pvr_sync_op *sync_op,
+			   struct xarray *signal_array,
+			   struct dma_fence **fence)
+{
+	struct pvr_sync_signal *sig_sync = NULL;
+	int err;
+
+	err = pvr_check_sync_op(sync_op);
+	if (err)
+		return err;
+
+	if (signal_array)
+		sig_sync = pvr_sync_signal_array_search(signal_array,
+							sync_op->handle,
+							sync_op->value);
+	if (sig_sync) {
+		if (WARN_ON(!sig_sync->fence))
+			return -EINVAL;
+
+		*fence = dma_fence_get(sig_sync->fence);
+		return 0;
+	}
+
+	return drm_syncobj_find_fence(file, sync_op->handle, sync_op->value, 0,
+				      fence);
+}
+
 int
 pvr_sync_add_deps_to_job(struct pvr_file *pvr_file, struct drm_sched_job *job,
 			 u32 sync_op_count,
@@ -256,30 +312,17 @@ pvr_sync_add_deps_to_job(struct pvr_file *pvr_file, struct drm_sched_job *job,
 		return 0;
 
 	for (u32 i = 0; i < sync_op_count; i++) {
-		struct pvr_sync_signal *sig_sync;
 		struct dma_fence *fence;
 
 		if (sync_ops[i].flags & DRM_PVR_SYNC_OP_FLAG_SIGNAL)
 			continue;
 
-		err = pvr_check_sync_op(&sync_ops[i]);
+		err = pvr_sync_wait_op_get_fence(from_pvr_file(pvr_file),
+						 &sync_ops[i], signal_array,
+						 &fence);
 		if (err)
 			return err;
 
-		sig_sync = pvr_sync_signal_array_search(signal_array, sync_ops[i].handle,
-							sync_ops[i].value);
-		if (sig_sync) {
-			if (WARN_ON(!sig_sync->fence))
-				return -EINVAL;
-
-			fence = dma_fence_get(sig_sync->fence);
-		} else {
-			err = drm_syncobj_find_fence(from_pvr_file(pvr_file), sync_ops[i].handle,
-						     sync_ops[i].value, 0, &fence);
-			if (err)
-				return err;
-		}
-
 		err = pvr_sync_add_dep_to_job(job, fence);
 		if (err)
 			return err;
@@ -287,3 +330,74 @@ pvr_sync_add_deps_to_job(struct pvr_file *pvr_file, struct drm_sched_job *job,
 
 	return 0;
 }
+
+/**
+ * pvr_sync_put_fences() - Release an array of fences.
+ * @fences: Array to release. May be %NULL.
+ * @count: Number of entries in @fences.
+ */
+void
+pvr_sync_put_fences(struct dma_fence **fences, u32 count)
+{
+	if (!fences)
+		return;
+
+	for (u32 i = 0; i < count; i++)
+		dma_fence_put(fences[i]);
+
+	kvfree(fences);
+}
+
+/**
+ * pvr_sync_get_wait_fences() - Resolve the wait operations of a request.
+ * @file: DRM file the request was issued on.
+ * @sync_op_count: Number of entries in @sync_ops.
+ * @sync_ops: Sync operations of the request.
+ * @count: Location to store the number of fences returned. Left untouched on
+ *         failure.
+ *
+ * Unlike pvr_sync_add_deps_to_job(), native fences are not replaced by their
+ * scheduled fence: that relies on the FW waiting for completion, which a job
+ * run on the CPU does not get.
+ *
+ * Return: The fences to wait on, to be released with pvr_sync_put_fences(),
+ * %NULL if @sync_op_count is zero, or an ERR_PTR on failure.
+ */
+struct dma_fence **
+pvr_sync_get_wait_fences(struct drm_file *file, u32 sync_op_count,
+			 const struct drm_pvr_sync_op *sync_ops, u32 *count)
+{
+	struct dma_fence **fences;
+	u32 fence_count = 0;
+	int err;
+
+	if (!sync_op_count) {
+		*count = 0;
+		return NULL;
+	}
+
+	fences = kvzalloc_objs(*fences, sync_op_count, GFP_KERNEL_ACCOUNT);
+	if (!fences)
+		return ERR_PTR(-ENOMEM);
+
+	for (u32 i = 0; i < sync_op_count; i++) {
+		if (sync_ops[i].flags & DRM_PVR_SYNC_OP_FLAG_SIGNAL)
+			continue;
+
+		err = pvr_sync_wait_op_get_fence(file, &sync_ops[i], NULL,
+						 &fences[fence_count]);
+		if (err)
+			goto err_put_fences;
+
+		fence_count++;
+	}
+
+	*count = fence_count;
+
+	return fences;
+
+err_put_fences:
+	pvr_sync_put_fences(fences, fence_count);
+
+	return ERR_PTR(err);
+}
diff --git a/drivers/gpu/drm/imagination/pvr_sync.h b/drivers/gpu/drm/imagination/pvr_sync.h
index 48501ad2779..72e34bbfe20 100644
--- a/drivers/gpu/drm/imagination/pvr_sync.h
+++ b/drivers/gpu/drm/imagination/pvr_sync.h
@@ -9,6 +9,9 @@
 /* Forward declaration from <linux/xarray.h>. */
 struct xarray;
 
+/* Forward declaration from <linux/dma-fence.h>. */
+struct dma_fence;
+
 /* Forward declaration from <drm/drm_file.h>. */
 struct drm_file;
 
@@ -72,6 +75,9 @@ pvr_sync_signal_array_update_fences(struct xarray *array,
 				    const struct drm_pvr_sync_op *sync_ops,
 				    struct dma_fence *finished_fence);
 
+void
+pvr_sync_signal_array_set_fence(struct xarray *array, struct dma_fence *fence);
+
 void
 pvr_sync_signal_array_push_fences(struct xarray *array);
 
@@ -81,4 +87,11 @@ pvr_sync_add_deps_to_job(struct pvr_file *pvr_file, struct drm_sched_job *job,
 			 const struct drm_pvr_sync_op *sync_ops,
 			 struct xarray *signal_array);
 
+void
+pvr_sync_put_fences(struct dma_fence **fences, u32 count);
+
+struct dma_fence **
+pvr_sync_get_wait_fences(struct drm_file *file, u32 sync_op_count,
+			 const struct drm_pvr_sync_op *sync_ops, u32 *count);
+
 #endif /* PVR_SYNC_H */
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 2f959cd5e90..4e58ea8c50c 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -13,9 +13,11 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_gpuvm.h>
 #include <drm/drm_print.h>
+#include <drm/gpu_scheduler.h>
 
 #include <linux/bug.h>
 #include <linux/container_of.h>
+#include <linux/dma-fence.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gfp_types.h>
@@ -24,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
+#include <linux/workqueue.h>
 
 /**
  * DOC: Memory context
@@ -51,6 +54,25 @@ struct pvr_vm_context {
 	/** @lock: Global lock on this VM. */
 	struct mutex lock;
 
+	/**
+	 * @sched: Serialises asynchronous bind requests. Userspace contexts
+	 * only.
+	 */
+	struct drm_gpu_scheduler sched;
+
+	/** @entity: Scheduling entity feeding @sched. */
+	struct drm_sched_entity entity;
+
+	/** @sched_initialised: True if @sched and @entity need tearing down. */
+	bool sched_initialised;
+
+	/**
+	 * @unusable: Set, and never cleared, when an asynchronous bind fails
+	 * part way through. Further binds and jobs on this context then fail
+	 * with -%ECANCELED. Written under @lock, read without it.
+	 */
+	bool unusable;
+
 	/**
 	 * @fw_mem_ctx_obj: Firmware object representing firmware memory
 	 * context.
@@ -73,6 +95,9 @@ struct pvr_vm_context *to_pvr_vm_context(struct drm_gpuvm *gpuvm)
 	return container_of(gpuvm, struct pvr_vm_context, gpuvm_mgr);
 }
 
+static int pvr_vm_bind_sched_init(struct pvr_vm_context *vm_ctx);
+static void pvr_vm_bind_sched_fini(struct pvr_vm_context *vm_ctx);
+
 struct pvr_vm_context *pvr_vm_context_get(struct pvr_vm_context *vm_ctx)
 {
 	if (vm_ctx)
@@ -594,6 +619,15 @@ pvr_vm_create_context(struct pvr_device *pvr_dev, bool is_userspace_context)
 	mutex_init(&vm_ctx->lock);
 	kref_init(&vm_ctx->ref_count);
 
+	if (is_userspace_context) {
+		err = pvr_vm_bind_sched_init(vm_ctx);
+		if (err) {
+			/* Fully set up by now: tear down through release(). */
+			pvr_vm_context_put(vm_ctx);
+			return ERR_PTR(err);
+		}
+	}
+
 	return vm_ctx;
 
 err_page_table_destroy:
@@ -618,6 +652,8 @@ pvr_vm_context_release(struct kref *ref_count)
 	struct pvr_vm_context *vm_ctx =
 		container_of(ref_count, struct pvr_vm_context, ref_count);
 
+	pvr_vm_bind_sched_fini(vm_ctx);
+
 	if (vm_ctx->fw_mem_ctx_obj)
 		pvr_fw_object_destroy(vm_ctx->fw_mem_ctx_obj);
 
@@ -774,8 +810,9 @@ pvr_vm_bind_ops_create(struct pvr_vm_context *vm_ctx,
  * Not atomic: if an operation fails, the earlier ones stay applied.
  *
  * Return:
- *  * 0 on success, or
- *  * A negative error code on failure.
+ *  * 0 on success,
+ *  * -%ECANCELED if @vm_ctx has been left unusable by an earlier failure, or
+ *  * Any other negative error code on failure.
  */
 int pvr_vm_bind(struct pvr_vm_context *vm_ctx,
 		const struct pvr_vm_bind_desc *descs, u32 desc_count)
@@ -789,6 +826,9 @@ int pvr_vm_bind(struct pvr_vm_context *vm_ctx,
 
 	mutex_lock(&vm_ctx->lock);
 
+	if (pvr_vm_context_is_unusable(vm_ctx))
+		err = -ECANCELED;
+
 	for (u32 i = 0; !err && i < desc_count; i++)
 		err = pvr_vm_bind_op_exec(&bind_ops[i]);
 
@@ -853,6 +893,17 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
 	return pvr_vm_bind(vm_ctx, &desc, 1);
 }
 
+/**
+ * pvr_vm_context_is_unusable() - Test whether a VM context is unusable.
+ * @vm_ctx: Target VM context.
+ *
+ * Return: %true if @vm_ctx rejects further operations.
+ */
+bool pvr_vm_context_is_unusable(struct pvr_vm_context *vm_ctx)
+{
+	return READ_ONCE(vm_ctx->unusable);
+}
+
 /**
  * pvr_vm_unmap_all() - Unmap all mappings associated with a VM context.
  * @vm_ctx: Target VM context.
@@ -1168,3 +1219,307 @@ pvr_vm_get_fw_mem_context(struct pvr_vm_context *vm_ctx)
 {
 	return vm_ctx->fw_mem_ctx_obj;
 }
+
+/**
+ * struct pvr_vm_bind_job - A queued batch of VM bind operations.
+ */
+struct pvr_vm_bind_job {
+	/** @base: Inherited &drm_sched_job object. */
+	struct drm_sched_job base;
+
+	/** @vm_ctx: VM context targeted by this job. Holds a reference. */
+	struct pvr_vm_context *vm_ctx;
+
+	/** @bind_op_count: Number of entries in @bind_ops. */
+	u32 bind_op_count;
+
+	/** @bind_ops: Prepared bind operations, applied in array order. */
+	struct pvr_vm_bind_op *bind_ops;
+
+	/**
+	 * @cleanup_work: Releases @bind_ops and the reference on @vm_ctx. Not
+	 * done in free_job(): dropping the last VM context reference there
+	 * would call drm_sched_fini(), which flushes the worker it runs on.
+	 */
+	struct work_struct cleanup_work;
+};
+
+#define to_pvr_vm_bind_job(sched_job) \
+	container_of((sched_job), struct pvr_vm_bind_job, base)
+
+static void pvr_vm_bind_job_destroy(struct pvr_vm_bind_job *job)
+{
+	if (!job)
+		return;
+
+	pvr_vm_bind_ops_free(job->bind_ops, job->bind_op_count);
+
+	if (job->vm_ctx) {
+		drm_gpuvm_bo_deferred_cleanup(&job->vm_ctx->gpuvm_mgr);
+		pvr_vm_context_put(job->vm_ctx);
+	}
+
+	kfree(job);
+}
+
+static void pvr_vm_bind_job_cleanup_work(struct work_struct *work)
+{
+	struct pvr_vm_bind_job *job =
+		container_of(work, struct pvr_vm_bind_job, cleanup_work);
+
+	pvr_vm_bind_job_destroy(job);
+}
+
+/*
+ * Runs in the dma-fence signalling path: nothing here may allocate or take a
+ * dma_resv. pvr_vm_bind_job_create() prepares everything beforehand.
+ */
+static struct dma_fence *
+pvr_vm_bind_run_job(struct drm_sched_job *sched_job)
+{
+	struct pvr_vm_bind_job *job = to_pvr_vm_bind_job(sched_job);
+	struct pvr_vm_context *vm_ctx = job->vm_ctx;
+	bool wait = false;
+	int flush_err;
+	int err = 0;
+	bool cookie;
+
+	if (pvr_vm_context_is_unusable(vm_ctx))
+		return ERR_PTR(-ECANCELED);
+
+	cookie = dma_fence_begin_signalling();
+
+	mutex_lock(&vm_ctx->lock);
+
+	/*
+	 * Sync the page tables and flush the MMU before signalling, including
+	 * tables a failed operation has already changed.
+	 */
+	for (u32 i = 0; i < job->bind_op_count; i++) {
+		struct pvr_vm_bind_op *bind_op = &job->bind_ops[i];
+
+		err = pvr_vm_bind_op_exec(bind_op);
+
+		pvr_mmu_op_context_sync(bind_op->mmu_op_ctx);
+		if (bind_op->type == PVR_VM_BIND_TYPE_UNMAP)
+			wait = true;
+
+		if (err)
+			break;
+	}
+
+	flush_err = pvr_mmu_flush_exec(vm_ctx->pvr_dev, wait);
+	if (!err)
+		err = flush_err;
+
+	if (err)
+		WRITE_ONCE(vm_ctx->unusable, true);
+
+	mutex_unlock(&vm_ctx->lock);
+
+	dma_fence_end_signalling(cookie);
+
+	/* NULL completes the job: the page tables are already updated. */
+	return err ? ERR_PTR(err) : NULL;
+}
+
+static enum drm_gpu_sched_stat
+pvr_vm_bind_timedout_job(struct drm_sched_job *sched_job)
+{
+	WARN(1, "VM bind jobs run on a CPU worker and cannot hang\n");
+
+	return DRM_GPU_SCHED_STAT_RESET;
+}
+
+static void pvr_vm_bind_free_job(struct drm_sched_job *sched_job)
+{
+	struct pvr_vm_bind_job *job = to_pvr_vm_bind_job(sched_job);
+
+	drm_sched_job_cleanup(sched_job);
+
+	queue_work(job->vm_ctx->pvr_dev->sched_wq, &job->cleanup_work);
+}
+
+static const struct drm_sched_backend_ops pvr_vm_bind_sched_ops = {
+	.run_job = pvr_vm_bind_run_job,
+	.timedout_job = pvr_vm_bind_timedout_job,
+	.free_job = pvr_vm_bind_free_job,
+};
+
+/**
+ * pvr_vm_bind_sched_init() - Set up the bind scheduler of a VM context.
+ * @vm_ctx: Target VM context.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int pvr_vm_bind_sched_init(struct pvr_vm_context *vm_ctx)
+{
+	struct pvr_device *pvr_dev = vm_ctx->pvr_dev;
+	struct drm_gpu_scheduler *sched = &vm_ctx->sched;
+	const struct drm_sched_init_args sched_args = {
+		.ops = &pvr_vm_bind_sched_ops,
+		.submit_wq = pvr_dev->sched_wq,
+		.num_rqs = 1,
+		.credit_limit = 1,
+		.hang_limit = 0,
+		/* Bind jobs run on a CPU worker and cannot hang. */
+		.timeout = MAX_SCHEDULE_TIMEOUT,
+		.name = "pvr-vm-bind",
+		.dev = from_pvr_device(pvr_dev)->dev,
+	};
+	int err;
+
+	err = drm_sched_init(sched, &sched_args);
+	if (err)
+		return err;
+
+	err = drm_sched_entity_init(&vm_ctx->entity, DRM_SCHED_PRIORITY_KERNEL,
+				    &sched, 1, NULL);
+	if (err)
+		goto err_sched_fini;
+
+	vm_ctx->sched_initialised = true;
+
+	return 0;
+
+err_sched_fini:
+	drm_sched_fini(sched);
+
+	return err;
+}
+
+/**
+ * pvr_vm_bind_sched_fini() - Tear down the bind scheduler of a VM context.
+ * @vm_ctx: Target VM context.
+ *
+ * Waits for all queued bind jobs to be applied before returning.
+ */
+static void pvr_vm_bind_sched_fini(struct pvr_vm_context *vm_ctx)
+{
+	if (!vm_ctx->sched_initialised)
+		return;
+
+	drm_sched_entity_destroy(&vm_ctx->entity);
+	drm_sched_fini(&vm_ctx->sched);
+	vm_ctx->sched_initialised = false;
+}
+
+/**
+ * pvr_vm_bind_job_create() - Prepare a job applying a batch of bind operations.
+ * @vm_ctx: Target VM context.
+ * @descs: Operations to apply, in array order.
+ * @desc_count: Number of entries in @descs.
+ * @deps: Fences to wait for before applying @descs.
+ * @dep_count: Number of entries in @deps.
+ * @client_id: DRM client the job is accounted to.
+ *
+ * Return: The new job, to be queued with pvr_vm_bind_job_push(), or an
+ * ERR_PTR on failure.
+ */
+static struct pvr_vm_bind_job *
+pvr_vm_bind_job_create(struct pvr_vm_context *vm_ctx,
+		       const struct pvr_vm_bind_desc *descs, u32 desc_count,
+		       struct dma_fence **deps, u32 dep_count, u64 client_id)
+{
+	struct pvr_vm_bind_job *job;
+	struct pvr_vm_bind_op *bind_ops;
+	int err;
+
+	job = kzalloc_obj(*job);
+	if (!job)
+		return ERR_PTR(-ENOMEM);
+
+	job->vm_ctx = pvr_vm_context_get(vm_ctx);
+	INIT_WORK(&job->cleanup_work, pvr_vm_bind_job_cleanup_work);
+
+	bind_ops = pvr_vm_bind_ops_create(vm_ctx, descs, desc_count);
+	if (IS_ERR(bind_ops)) {
+		err = PTR_ERR(bind_ops);
+		goto err_destroy_job;
+	}
+	job->bind_ops = bind_ops;
+	job->bind_op_count = desc_count;
+
+	err = drm_sched_job_init(&job->base, &vm_ctx->entity, 1, vm_ctx,
+				 client_id);
+	if (err)
+		goto err_destroy_job;
+
+	for (u32 i = 0; i < dep_count; i++) {
+		err = drm_sched_job_add_dependency(&job->base,
+						   dma_fence_get(deps[i]));
+		if (err)
+			goto err_cleanup_job;
+	}
+
+	return job;
+
+err_cleanup_job:
+	drm_sched_job_cleanup(&job->base);
+
+err_destroy_job:
+	pvr_vm_bind_job_destroy(job);
+
+	return ERR_PTR(err);
+}
+
+/**
+ * pvr_vm_bind_job_push() - Queue a prepared bind job.
+ * @job: Job to queue. The scheduler owns it from now on.
+ *
+ * Return: The fence that signals once @job has been applied, to be released
+ * with dma_fence_put().
+ */
+static struct dma_fence *pvr_vm_bind_job_push(struct pvr_vm_bind_job *job)
+{
+	struct dma_fence *fence;
+
+	drm_sched_job_arm(&job->base);
+
+	/* Pushing may free @job, so take the fence first. */
+	fence = dma_fence_get(&job->base.s_fence->finished);
+
+	drm_sched_entity_push_job(&job->base);
+
+	return fence;
+}
+
+/**
+ * pvr_vm_bind_async() - Queue a batch of bind operations on a VM context.
+ * @vm_ctx: Target VM context.
+ * @descs: Operations to apply, in array order.
+ * @desc_count: Number of entries in @descs.
+ * @deps: Fences to wait for before applying @descs.
+ * @dep_count: Number of entries in @deps.
+ * @client_id: DRM client the request is accounted to.
+ *
+ * Like pvr_vm_bind(), but applied by the VM context scheduler once every
+ * fence in @deps has signalled. The caller keeps its references on @descs and
+ * @deps.
+ *
+ * Return: A fence signalled once the operations have been applied, to be
+ * released with dma_fence_put(), or an ERR_PTR with nothing queued:
+ *  * -%ECANCELED if @vm_ctx has been left unusable by an earlier failure,
+ *  * -%EINVAL if @vm_ctx is the kernel VM context, or
+ *  * Any other negative error code.
+ */
+struct dma_fence *
+pvr_vm_bind_async(struct pvr_vm_context *vm_ctx,
+		  const struct pvr_vm_bind_desc *descs, u32 desc_count,
+		  struct dma_fence **deps, u32 dep_count, u64 client_id)
+{
+	struct pvr_vm_bind_job *job;
+
+	if (pvr_vm_context_is_unusable(vm_ctx))
+		return ERR_PTR(-ECANCELED);
+
+	if (!vm_ctx->sched_initialised)
+		return ERR_PTR(-EINVAL);
+
+	job = pvr_vm_bind_job_create(vm_ctx, descs, desc_count, deps, dep_count,
+				     client_id);
+	if (IS_ERR(job))
+		return ERR_CAST(job);
+
+	return pvr_vm_bind_job_push(job);
+}
diff --git a/drivers/gpu/drm/imagination/pvr_vm.h b/drivers/gpu/drm/imagination/pvr_vm.h
index bf6d5e802d9..df74b405960 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.h
+++ b/drivers/gpu/drm/imagination/pvr_vm.h
@@ -23,6 +23,9 @@ struct pvr_vm_context;
 /* Forward declaration from <uapi/drm/pvr_drm.h> */
 struct drm_pvr_ioctl_get_heap_info_args;
 
+/* Forward declaration from <linux/dma-fence.h> */
+struct dma_fence;
+
 /* Forward declaration from <drm/drm_exec.h> */
 struct drm_exec;
 
@@ -81,9 +84,15 @@ struct pvr_vm_bind_desc {
 
 int pvr_vm_bind(struct pvr_vm_context *vm_ctx,
 		const struct pvr_vm_bind_desc *descs, u32 desc_count);
+struct dma_fence *
+pvr_vm_bind_async(struct pvr_vm_context *vm_ctx,
+		  const struct pvr_vm_bind_desc *descs, u32 desc_count,
+		  struct dma_fence **deps, u32 dep_count, u64 client_id);
 
 void pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx);
 
+bool pvr_vm_context_is_unusable(struct pvr_vm_context *vm_ctx);
+
 dma_addr_t pvr_vm_get_page_table_root_addr(struct pvr_vm_context *vm_ctx);
 struct dma_resv *pvr_vm_get_dma_resv(struct pvr_vm_context *vm_ctx);
 
diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
index 55656aa8304..57c22f5f215 100644
--- a/include/uapi/drm/pvr_drm.h
+++ b/include/uapi/drm/pvr_drm.h
@@ -1314,12 +1314,20 @@ struct drm_pvr_ioctl_submit_jobs_args {
  * DOC: PowerVR IOCTL VM_BIND interface
  *
  * %DRM_IOCTL_PVR_VM_BIND applies a batch of map and/or unmap operations to a
- * single VM context before the IOCTL returns.
+ * single VM context, synchronously or, with %DRM_PVR_VM_BIND_ASYNC, from a
+ * queue.
  *
- * Operations within a request are applied in array order.
+ * Operations within a request are applied in array order, and queued requests
+ * in submission order per VM context. A synchronous request does not wait for
+ * the queued ones.
  *
  * A request that fails part way through may leave the address space in an
  * undefined state; how much of it was applied is not reported.
+ *
+ * If a queued request fails, its VM context becomes permanently unusable:
+ * further %DRM_IOCTL_PVR_VM_BIND and %DRM_IOCTL_PVR_SUBMIT_JOBS calls on it
+ * fail with -%ECANCELED, and jobs already queued on it complete with an error.
+ * A new VM context has to be created.
  */
 
 /**
@@ -1379,6 +1387,17 @@ struct drm_pvr_vm_bind_op {
 	__u64 size;
 };
 
+/**
+ * DOC: Flags for the VM_BIND ioctl.
+ *
+ * .. c:macro:: DRM_PVR_VM_BIND_ASYNC
+ *
+ *    Queue the request instead of applying it synchronously.
+ */
+#define DRM_PVR_VM_BIND_ASYNC _BITUL(0)
+
+#define DRM_PVR_VM_BIND_FLAGS_MASK DRM_PVR_VM_BIND_ASYNC
+
 /**
  * struct drm_pvr_ioctl_vm_bind_args - Arguments for %DRM_IOCTL_PVR_VM_BIND.
  */
@@ -1389,13 +1408,20 @@ struct drm_pvr_ioctl_vm_bind_args {
 	 */
 	__u32 vm_context_handle;
 
-	/** @flags: [IN] Reserved. MBZ. */
+	/** @flags: [IN] Combination of ``DRM_PVR_VM_BIND_`` flags. */
 	__u32 flags;
 
 	/** @ops: [IN] Array of &struct drm_pvr_vm_bind_op to apply. */
 	struct drm_pvr_obj_array ops;
 
-	/** @sync_ops: [IN] Reserved. Must be empty. */
+	/**
+	 * @sync_ops: [IN] Sync operations applied once to the request as a
+	 * whole: waits before any of @ops, signals after all of them. Must be
+	 * empty unless %DRM_PVR_VM_BIND_ASYNC is set in @flags.
+	 *
+	 * @ops may be empty, in which case the request only places a
+	 * synchronisation point on the queue.
+	 */
 	struct drm_pvr_obj_array sync_ops;
 };
 

-- 
2.43.0

