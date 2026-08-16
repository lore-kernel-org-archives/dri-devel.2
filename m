Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DF1C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B06910E350;
	Sun, 16 Aug 2026 19:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lCRK7fdm";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F307A10E34A
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 19:43:27 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so2948761a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786909407; x=1787514207; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qw9lm5WHODTA8mgreGjGqN+F7jtyssQd06aikBSp6SQ=;
 b=lCRK7fdmQxcHF2+jxRHqmdNV7PR1Q2sm8bgOyPdlP04sffgj42BymztFbYSnmp9gZD
 wXxY3WvpheVc+kAuzZX7fFTvf5Io4S9iJG+4BQPUCOgWG3gs+cTOwCh3gfblNM+2MiVV
 YK4JrVhSt6SUJ8mW8wdkoh0VN86yuQQGovI1A/aOM16PQ+khqLLM6HuzFIstpTR1GdDy
 I/rkLyWZpirg+mSl1MDjeiY3Hp6vDQjmpz7CFBVgs820QezI5QeZmGzTiISSLELxuf2A
 BGjwqUdvZhuXC8WRFN/y5g2Y/bMOQpNEhd9UvqsQr9vfhbRgAwd0vBpUDbHFl59a5ChR
 2Jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786909407; x=1787514207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qw9lm5WHODTA8mgreGjGqN+F7jtyssQd06aikBSp6SQ=;
 b=BHMKcb+sEFFjeMRAuy2nOYxArwUapgeYPPHgx3uQCn+r1JSM9G80iv/vm10g+3fc1T
 gbgYt3K8omcnfRGRbMnehuf435X6sAfNG+Tsi238baKBUjaYIJ4DbaMQTMCG+wpmjVk+
 C5wt67fhlUUTT7vDnXVt5Adcke0iZ4I6ulsWXIvGgznGZ9hETfNEfkuiVHNSBa/ouPp5
 jk6T+LAN8BRQs5YRHHi8v7cySe4MSkwqDh/BOS9MK9jg8uBkEhwSIrPfgzQ6pv7dIbHb
 46uoW9g6gWnzRgoSBxTWoM/gAFxmITBD7poHkkrAfrs7sEiaeB8kh+lZnWMraKncBunG
 VVyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiB9nhj+4pvz1/EATUuzp0GVj2QkRhwGnbKzxbLgMA00mR+uCkXWb9vO0sPF7LzeL/kuCNci9ke9w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8yywnFnh31L0+1OiuBsIzl5mQDfeUsPCjbCod16TBnI+7kv5+
 329hzyV6Yvua3gxTbGtVtV25t0EXLPOzGyU8Weq3NtQFabUuiuGfwj6o
X-Gm-Gg: AR+sD10PnL8rNUiW/MOdDDL9EYaARvZ4mfFYL9vILYN6VmomoLAFZ23gRJ7hdbzRk0R
 1zMjEf80vTMW8PEsIngOGoONQzFLUHVyQL+fn6sDX7VME3xLq2j1dvbvZxjhqvq+QaDp8X/Dutx
 tBaQdjtBmkCkDdsBKKWVqWmF7nRNNKM9144TNptwsLz325MmnU87QyPkORqJftJpTkCBbyHwXKL
 9W/Hu+aNDoPl6YbXCO9N5r0kvhInQrPk7tcJsjrzjzxDpOaGZfshPz22KICFW3+HvtskYOCR8SC
 whQ0AKigAZJXRxuc+j4x3Ziy1J7E9A7vwa1oWWpWp1Ejp/I3gmygi6C+Q36yv2XYqFEZZ2fKcX2
 MIvwb8+u/i3k8d3zIpQOMrtkMf+guBroQt+R5ufzT6bd0HSdOVeREKZBms+f9X2awENGQ2yjD/l
 ZRjZsDpl2Sg5JV6vQ8W3USPvjOa8me3nGSYX1bvbwSH6zC1NWu8SmlbX1Fb78CaqtCLw==
X-Received: by 2002:a17:90b:590d:b0:38f:23d6:b4a9 with SMTP id
 98e67ed59e1d1-3933ed66651mr24307375a91.21.1786909407219; 
 Sun, 16 Aug 2026 12:43:27 -0700 (PDT)
Received: from [127.0.1.1] ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395320229f4sm2141310a91.15.2026.08.16.12.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 12:43:26 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Mon, 17 Aug 2026 04:42:10 +0900
Subject: [PATCH 3/4] drm/imagination: Add async VM_BIND ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-pvr-vm-bind-v1-3-0a0f21be7d38@gmail.com>
References: <20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com>
In-Reply-To: <20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matt Coster <opensource@mtcoster.net>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

DRM_IOCTL_PVR_VM_MAP and DRM_IOCTL_PVR_VM_UNMAP fall short of what Vulkan
sparse binding needs in two ways:

1. Each carries a single operation, while vkQueueBindSparse hands over an
   array, so one request turns into hundreds of ioctls.

2. Neither takes sync operations. A bind can neither wait on a fence nor
   signal one, so ordering it against GPU work means blocking the CPU.

Add DRM_IOCTL_PVR_VM_BIND, which extends them with an array of bind
operations and an array of sync operations. With DRM_PVR_VM_BIND_ASYNC
a request runs asynchronously, as a drm_sched job.

The interface follows panthor throughout. Routing VM_MAP and VM_UNMAP
through VM_BIND is left to a follow-up.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c   |  88 ++++++
 drivers/gpu/drm/imagination/pvr_drv.h   |   4 +-
 drivers/gpu/drm/imagination/pvr_job.c   |   6 +
 drivers/gpu/drm/imagination/pvr_queue.c |   3 +
 drivers/gpu/drm/imagination/pvr_vm.c    | 504 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_vm.h    |  27 ++
 include/uapi/drm/pvr_drm.h              | 115 ++++++++
 7 files changed, 746 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 5c965ef0274..ec6ed610e29 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1130,6 +1130,93 @@ pvr_ioctl_vm_unmap(struct drm_device *drm_dev, void *raw_args,
 	return err;
 }
 
+/**
+ * pvr_ioctl_vm_bind() - IOCTL to apply a batch of VM bind operations.
+ * @drm_dev: [IN] DRM device.
+ * @raw_args: [IN] Arguments passed to this IOCTL. This must be of type
+ *                 &struct drm_pvr_ioctl_vm_bind_args.
+ * @file: [IN] DRM file private data.
+ *
+ * Called from userspace with %DRM_IOCTL_PVR_VM_BIND.
+ *
+ * Return:
+ *  * 0 on success,
+ *  * -%EINVAL if arguments are invalid, or
+ *  * Any error returned by pvr_vm_bind().
+ */
+static int
+pvr_ioctl_vm_bind(struct drm_device *drm_dev, void *raw_args,
+		  struct drm_file *file)
+{
+	struct drm_pvr_ioctl_vm_bind_args *args = raw_args;
+	struct pvr_file *pvr_file = to_pvr_file(file);
+	struct drm_pvr_vm_bind_op *uapi_ops = NULL;
+	struct drm_pvr_sync_op *sync_ops = NULL;
+	struct pvr_vm_context *vm_ctx;
+	struct pvr_vm_bind_req req;
+	int idx;
+	int err;
+
+	if (!drm_dev_enter(drm_dev, &idx))
+		return -EIO;
+
+	if (args->flags & ~DRM_PVR_VM_BIND_FLAGS_MASK) {
+		err = -EINVAL;
+		goto err_drm_dev_exit;
+	}
+
+	if (!(args->flags & DRM_PVR_VM_BIND_ASYNC) && args->sync_ops.count) {
+		err = -EINVAL;
+		goto err_drm_dev_exit;
+	}
+
+	if (!args->ops.count && !args->sync_ops.count) {
+		err = 0;
+		goto err_drm_dev_exit;
+	}
+
+	vm_ctx = pvr_vm_context_lookup(pvr_file, args->vm_context_handle);
+	if (!vm_ctx) {
+		err = -EINVAL;
+		goto err_drm_dev_exit;
+	}
+
+	if (args->ops.count) {
+		err = PVR_UOBJ_GET_ARRAY(uapi_ops, &args->ops);
+		if (err)
+			goto err_put_vm_context;
+	}
+
+	if (args->sync_ops.count) {
+		err = PVR_UOBJ_GET_ARRAY(sync_ops, &args->sync_ops);
+		if (err)
+			goto err_free_uapi_ops;
+	}
+
+	req = (struct pvr_vm_bind_req){
+		.ops = uapi_ops,
+		.op_count = args->ops.count,
+		.sync_ops = sync_ops,
+		.sync_op_count = args->sync_ops.count,
+		.async = args->flags & DRM_PVR_VM_BIND_ASYNC,
+	};
+
+	err = pvr_vm_bind(vm_ctx, pvr_file, &req);
+
+	kvfree(sync_ops);
+
+err_free_uapi_ops:
+	kvfree(uapi_ops);
+
+err_put_vm_context:
+	pvr_vm_context_put(vm_ctx);
+
+err_drm_dev_exit:
+	drm_dev_exit(idx);
+
+	return err;
+}
+
 /*
  * pvr_ioctl_submit_job() - IOCTL to submit a job to the GPU
  * @drm_dev: [IN] DRM device.
@@ -1290,6 +1377,7 @@ static const struct drm_ioctl_desc pvr_drm_driver_ioctls[] = {
 	DRM_PVR_IOCTL(CREATE_HWRT_DATASET, create_hwrt_dataset, DRM_RENDER_ALLOW),
 	DRM_PVR_IOCTL(DESTROY_HWRT_DATASET, destroy_hwrt_dataset, DRM_RENDER_ALLOW),
 	DRM_PVR_IOCTL(SUBMIT_JOBS, submit_jobs, DRM_RENDER_ALLOW),
+	DRM_PVR_IOCTL(VM_BIND, vm_bind, DRM_RENDER_ALLOW),
 };
 
 /* clang-format on */
diff --git a/drivers/gpu/drm/imagination/pvr_drv.h b/drivers/gpu/drm/imagination/pvr_drv.h
index 7fa147312dd..9ca8f8780a3 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.h
+++ b/drivers/gpu/drm/imagination/pvr_drv.h
@@ -13,9 +13,10 @@
 /*
  * Driver interface version:
  *  - 1.0: Initial interface
+ *  - 1.1: adds DRM_IOCTL_PVR_VM_BIND
  */
 #define PVR_DRIVER_MAJOR 1
-#define PVR_DRIVER_MINOR 0
+#define PVR_DRIVER_MINOR 1
 #define PVR_DRIVER_PATCHLEVEL 0
 
 int pvr_get_uobj(u64 usr_ptr, u32 usr_size, u32 min_size, u32 obj_size, void *out);
@@ -60,6 +61,7 @@ int pvr_set_uobj_array(const struct drm_pvr_obj_array *out, u32 min_stride, u32
 #define PVR_UOBJ_MIN_SIZE(_obj_name) _Generic(_obj_name \
 	PVR_UOBJ_DECL(struct drm_pvr_job, hwrt) \
 	PVR_UOBJ_DECL(struct drm_pvr_sync_op, value) \
+	PVR_UOBJ_DECL(struct drm_pvr_vm_bind_op, size) \
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_gpu_info, num_phantoms) \
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_runtime_info, cdm_max_local_mem_size_regs) \
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_quirks, _padding_c) \
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
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 09993e858df..6b83734604d 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -761,6 +761,9 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 		return dma_fence_get(job->done_fence);
 	}
 
+	if (pvr_vm_context_is_unusable(job->ctx->vm_ctx))
+		return ERR_PTR(-ECANCELED);
+
 	/* The only kind of jobs that can be paired are geometry and fragment, and
 	 * we bail out early if we see a fragment job that's paired with a geometry job.
 	 * Paired jobs must also target the same context and point to the same HWRT.
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 45df76e61f7..f92bfeacd7a 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -9,20 +9,27 @@
 #include "pvr_mmu.h"
 #include "pvr_rogue_fwif.h"
 #include "pvr_rogue_heap_config.h"
+#include "pvr_sync.h"
 
 #include <drm/drm_exec.h>
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
 #include <linux/kref.h>
 #include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
 #include <linux/stddef.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
 
 /**
  * DOC: Memory context
@@ -50,6 +57,32 @@ struct pvr_vm_context {
 	/** @lock: Global lock on this VM. */
 	struct mutex lock;
 
+	/**
+	 * @sched: Scheduler used to serialise asynchronous VM_BIND requests.
+	 *
+	 * Only initialised for userspace VM contexts; see @sched_initialised.
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
+	 * @unusable: An asynchronous bind failed part way through, leaving the
+	 * address space in a state nobody can reason about.
+	 *
+	 * Only the asynchronous path sets this; a synchronous failure reaches
+	 * its caller directly, who then owns the recovery. Set once and never
+	 * cleared: further operations are rejected with -%ECANCELED and the
+	 * context has to be destroyed and recreated.
+	 *
+	 * Written under @lock, read without it.
+	 */
+	bool unusable;
+
 	/**
 	 * @fw_mem_ctx_obj: Firmware object representing firmware memory
 	 * context.
@@ -72,6 +105,9 @@ struct pvr_vm_context *to_pvr_vm_context(struct drm_gpuvm *gpuvm)
 	return container_of(gpuvm, struct pvr_vm_context, gpuvm_mgr);
 }
 
+static int pvr_vm_bind_sched_init(struct pvr_vm_context *vm_ctx);
+static void pvr_vm_bind_sched_fini(struct pvr_vm_context *vm_ctx);
+
 struct pvr_vm_context *pvr_vm_context_get(struct pvr_vm_context *vm_ctx)
 {
 	if (vm_ctx)
@@ -606,8 +642,26 @@ pvr_vm_create_context(struct pvr_device *pvr_dev, bool is_userspace_context)
 	mutex_init(&vm_ctx->lock);
 	kref_init(&vm_ctx->ref_count);
 
+	if (is_userspace_context) {
+		err = pvr_vm_bind_sched_init(vm_ctx);
+		if (err)
+			goto err_gpuvm_put;
+	}
+
 	return vm_ctx;
 
+err_gpuvm_put:
+	if (vm_ctx->fw_mem_ctx_obj)
+		pvr_fw_object_destroy(vm_ctx->fw_mem_ctx_obj);
+
+	pvr_mmu_context_destroy(vm_ctx->mmu_ctx);
+	drm_gem_private_object_fini(&vm_ctx->dummy_gem);
+	mutex_destroy(&vm_ctx->lock);
+
+	drm_gpuvm_put(&vm_ctx->gpuvm_mgr);
+
+	return ERR_PTR(err);
+
 err_page_table_destroy:
 	pvr_mmu_context_destroy(vm_ctx->mmu_ctx);
 
@@ -630,6 +684,8 @@ pvr_vm_context_release(struct kref *ref_count)
 	struct pvr_vm_context *vm_ctx =
 		container_of(ref_count, struct pvr_vm_context, ref_count);
 
+	pvr_vm_bind_sched_fini(vm_ctx);
+
 	if (vm_ctx->fw_mem_ctx_obj)
 		pvr_fw_object_destroy(vm_ctx->fw_mem_ctx_obj);
 
@@ -853,6 +909,18 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
 	return err;
 }
 
+/**
+ * pvr_vm_context_is_unusable() - Test whether a VM context has been left in an
+ * undefined state by a failed operation.
+ * @vm_ctx: Target VM context.
+ *
+ * Return: %true if the context rejects further operations.
+ */
+bool pvr_vm_context_is_unusable(struct pvr_vm_context *vm_ctx)
+{
+	return READ_ONCE(vm_ctx->unusable);
+}
+
 /**
  * pvr_vm_unmap_all() - Unmap all mappings associated with a VM context.
  * @vm_ctx: Target VM context.
@@ -1174,3 +1242,439 @@ pvr_vm_get_fw_mem_context(struct pvr_vm_context *vm_ctx)
 {
 	return vm_ctx->fw_mem_ctx_obj;
 }
+
+/**
+ * DOC: Asynchronous VM_BIND
+ *
+ * %DRM_IOCTL_PVR_VM_BIND can queue a batch of bind operations instead of
+ * applying them inline. Each request becomes a &pvr_vm_bind_job pushed to a
+ * per-VM-context &drm_gpu_scheduler, which guarantees that requests targeting
+ * the same VM context are applied in submission order.
+ *
+ * Everything that can fail or allocate - argument validation, page table
+ * pre-allocation, page pinning - happens while building the job, because
+ * &drm_sched_backend_ops.run_job executes inside the dma-fence signalling
+ * critical path. For the same reason the GPUVM is initialised with
+ * %DRM_GPUVM_IMMEDIATE_MODE, so that mappings are tracked under the GEM's
+ * gpuva.lock rather than its dma_resv.
+ */
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
+	/** @op_count: Number of entries in @ops. */
+	u32 op_count;
+
+	/** @ops: Prepared bind operations, applied in array order. */
+	struct pvr_vm_bind_op *ops;
+
+	/**
+	 * @cleanup_work: Releases @ops and the reference on @vm_ctx.
+	 *
+	 * free_job() cannot do this itself: dropping what may be the last VM
+	 * context reference there would call drm_sched_fini(), which flushes
+	 * the very worker free_job() runs on.
+	 */
+	struct work_struct cleanup_work;
+};
+
+#define to_pvr_vm_bind_job(sched_job) \
+	container_of((sched_job), struct pvr_vm_bind_job, base)
+
+/**
+ * pvr_vm_bind_ops_free() - Release an array of prepared bind operations.
+ * @ops: Array to release. May be %NULL.
+ * @count: Number of prepared entries in @ops.
+ */
+static void pvr_vm_bind_ops_free(struct pvr_vm_bind_op *ops, u32 count)
+{
+	if (!ops)
+		return;
+
+	for (u32 i = 0; i < count; i++)
+		pvr_vm_bind_op_fini(&ops[i]);
+
+	kvfree(ops);
+}
+
+static void pvr_vm_bind_job_free(struct pvr_vm_bind_job *job)
+{
+	if (!job)
+		return;
+
+	pvr_vm_bind_ops_free(job->ops, job->op_count);
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
+	pvr_vm_bind_job_free(job);
+}
+
+static struct dma_fence *
+pvr_vm_bind_run_job(struct drm_sched_job *sched_job)
+{
+	struct pvr_vm_bind_job *job = to_pvr_vm_bind_job(sched_job);
+	struct pvr_vm_context *vm_ctx = job->vm_ctx;
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
+	for (u32 i = 0; i < job->op_count; i++) {
+		err = pvr_vm_bind_op_exec(&job->ops[i]);
+		if (err)
+			break;
+	}
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
+	/* Flushed before the device goes away, so it cannot outlive it. */
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
+ * pvr_vm_bind_sched_init() - Set up the VM_BIND scheduler of a VM context.
+ * @vm_ctx: Target VM context.
+ *
+ * Return:
+ *  * 0 on success, or
+ *  * Any error returned by drm_sched_init() or drm_sched_entity_init().
+ */
+static int pvr_vm_bind_sched_init(struct pvr_vm_context *vm_ctx)
+{
+	struct pvr_device *pvr_dev = vm_ctx->pvr_dev;
+	struct drm_gpu_scheduler *sched = &vm_ctx->sched;
+	const struct drm_sched_init_args sched_args = {
+		.ops = &pvr_vm_bind_sched_ops,
+		.submit_wq = pvr_dev->sched_wq,
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
+	err = drm_sched_entity_init(&vm_ctx->entity, DRM_SCHED_PRIORITY_NORMAL,
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
+ * pvr_vm_bind_sched_fini() - Tear down the VM_BIND scheduler of a VM context.
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
+ * pvr_vm_bind_op_init_from_uapi() - Prepare a single bind op from its
+ *                                   userspace description.
+ * @bind_op: Bind op to initialise.
+ * @vm_ctx: Target VM context.
+ * @pvr_file: PowerVR file used to resolve buffer object handles.
+ * @uapi_op: Userspace description of the operation.
+ *
+ * On success @bind_op owns every resource it needs to be executed later,
+ * and must be released with pvr_vm_bind_op_fini().
+ *
+ * Return:
+ *  * 0 on success,
+ *  * -%EINVAL if @uapi_op is malformed, or
+ *  * -%ENOENT if @uapi_op refers to an unknown buffer object.
+ */
+static int
+pvr_vm_bind_op_init_from_uapi(struct pvr_vm_bind_op *bind_op,
+			      struct pvr_vm_context *vm_ctx,
+			      struct pvr_file *pvr_file,
+			      const struct drm_pvr_vm_bind_op *uapi_op)
+{
+	struct pvr_gem_object *pvr_obj;
+	int err;
+
+	if (uapi_op->flags & ~DRM_PVR_VM_BIND_OP_FLAGS_MASK)
+		return -EINVAL;
+
+	if (!uapi_op->size)
+		return -EINVAL;
+
+	switch (uapi_op->flags & DRM_PVR_VM_BIND_OP_TYPE_MASK) {
+	case DRM_PVR_VM_BIND_OP_TYPE_MAP:
+		pvr_obj = pvr_gem_object_from_handle(pvr_file, uapi_op->handle);
+		if (!pvr_obj)
+			return -ENOENT;
+
+		err = pvr_vm_bind_op_map_init(bind_op, vm_ctx, pvr_obj,
+					      uapi_op->offset,
+					      uapi_op->device_addr,
+					      uapi_op->size);
+		if (err) {
+			pvr_gem_object_put(pvr_obj);
+			return err;
+		}
+
+		return 0;
+
+	case DRM_PVR_VM_BIND_OP_TYPE_UNMAP:
+		if (uapi_op->handle || uapi_op->offset)
+			return -EINVAL;
+
+		return pvr_vm_bind_op_unmap_init(bind_op, vm_ctx, NULL,
+						 uapi_op->device_addr,
+						 uapi_op->size);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * pvr_vm_bind_ops_create_from_uapi() - Prepare bind operations from their
+ *                                      userspace description.
+ * @vm_ctx: Target VM context.
+ * @pvr_file: PowerVR file used to resolve buffer object handles.
+ * @uapi_ops: Array of userspace operation descriptions.
+ * @op_count: Number of entries in @uapi_ops.
+ *
+ * Every allocation needed to apply the operations is performed here, so that
+ * applying them later - possibly from inside the dma-fence signalling critical
+ * path - cannot fail for want of memory.
+ *
+ * Return: The new array on success, or an ERR_PTR on failure.
+ */
+static struct pvr_vm_bind_op *
+pvr_vm_bind_ops_create_from_uapi(struct pvr_vm_context *vm_ctx,
+				 struct pvr_file *pvr_file,
+				 const struct drm_pvr_vm_bind_op *uapi_ops,
+				 u32 op_count)
+{
+	struct pvr_vm_bind_op *ops;
+	int err;
+
+	ops = kvzalloc_objs(*ops, op_count, GFP_KERNEL);
+	if (!ops)
+		return ERR_PTR(-ENOMEM);
+
+	for (u32 prepared = 0; prepared < op_count; prepared++) {
+		err = pvr_vm_bind_op_init_from_uapi(&ops[prepared], vm_ctx,
+						    pvr_file,
+						    &uapi_ops[prepared]);
+		if (err) {
+			pvr_vm_bind_ops_free(ops, prepared);
+			return ERR_PTR(err);
+		}
+	}
+
+	return ops;
+}
+
+/**
+ * pvr_vm_bind_exec_async() - Queue a batch of bind operations.
+ * @vm_ctx: Target VM context.
+ * @ops: Prepared bind operations. Consumed by this function.
+ * @op_count: Number of entries in @ops.
+ * @pvr_file: PowerVR file the request was issued on.
+ * @sync_ops: Sync operations to apply to the request.
+ * @sync_op_count: Number of entries in @sync_ops.
+ *
+ * Wraps @ops in a &pvr_vm_bind_job and hands it to the VM context scheduler.
+ * The synchronous path needs no job at all; it applies @ops inline.
+ *
+ * Return:
+ *  * 0 on success, or
+ *  * Any error returned while resolving @sync_ops or arming the job.
+ */
+static int pvr_vm_bind_exec_async(struct pvr_vm_context *vm_ctx,
+				  struct pvr_vm_bind_op *ops, u32 op_count,
+				  struct pvr_file *pvr_file,
+				  const struct drm_pvr_sync_op *sync_ops,
+				  u32 sync_op_count)
+{
+	struct dma_fence *finished_fence;
+	struct pvr_vm_bind_job *job;
+	struct xarray signal_array;
+	int err;
+
+	job = kzalloc_obj(*job);
+	if (!job) {
+		pvr_vm_bind_ops_free(ops, op_count);
+		return -ENOMEM;
+	}
+
+	job->vm_ctx = pvr_vm_context_get(vm_ctx);
+	job->ops = ops;
+	job->op_count = op_count;
+	INIT_WORK(&job->cleanup_work, pvr_vm_bind_job_cleanup_work);
+
+	xa_init_flags(&signal_array, XA_FLAGS_ALLOC);
+
+	err = drm_sched_job_init(&job->base, &vm_ctx->entity, 1, pvr_file,
+				 from_pvr_file(pvr_file)->client_id);
+	if (err)
+		goto err_cleanup_signal_array;
+
+	err = pvr_sync_signal_array_collect_ops(&signal_array,
+						from_pvr_file(pvr_file),
+						sync_op_count, sync_ops);
+	if (err)
+		goto err_cleanup_job;
+
+	err = pvr_sync_add_deps_to_job(pvr_file, &job->base, sync_op_count,
+				       sync_ops, &signal_array);
+	if (err)
+		goto err_cleanup_job;
+
+	drm_sched_job_arm(&job->base);
+	finished_fence = &job->base.s_fence->finished;
+
+	/*
+	 * Arming is the point of no return: the job has to be pushed now. The
+	 * update below only touches entries the collect above created, so it
+	 * cannot fail, and a driver bug that made it fail has already warned.
+	 */
+	pvr_sync_signal_array_update_fences(&signal_array, sync_op_count,
+					    sync_ops, finished_fence);
+
+	drm_sched_entity_push_job(&job->base);
+	pvr_sync_signal_array_push_fences(&signal_array);
+
+	pvr_sync_signal_array_cleanup(&signal_array);
+
+	return 0;
+
+err_cleanup_job:
+	drm_sched_job_cleanup(&job->base);
+
+err_cleanup_signal_array:
+	pvr_sync_signal_array_cleanup(&signal_array);
+	pvr_vm_bind_job_free(job);
+
+	return err;
+}
+
+/**
+ * pvr_vm_bind() - Apply a batch of bind operations to a VM context.
+ * @vm_ctx: Target VM context.
+ * @pvr_file: PowerVR file the request was issued on.
+ * @req: The request to apply.
+ *
+ * This is the single entry point for every userspace-initiated mapping change:
+ * %DRM_IOCTL_PVR_VM_BIND passes its whole operation array, while the legacy
+ * %DRM_IOCTL_PVR_VM_MAP and %DRM_IOCTL_PVR_VM_UNMAP build a one-element array.
+ *
+ * Return:
+ *  * 0 on success, or
+ *  * A negative error code on failure.
+ */
+int pvr_vm_bind(struct pvr_vm_context *vm_ctx, struct pvr_file *pvr_file,
+		const struct pvr_vm_bind_req *req)
+{
+	struct pvr_vm_bind_op *ops;
+	int err = 0;
+
+	if (pvr_vm_context_is_unusable(vm_ctx))
+		return -ECANCELED;
+
+	if (req->async && !vm_ctx->sched_initialised)
+		return -EINVAL;
+
+	ops = pvr_vm_bind_ops_create_from_uapi(vm_ctx, pvr_file, req->ops,
+					       req->op_count);
+	if (IS_ERR(ops))
+		return PTR_ERR(ops);
+
+	if (req->async)
+		return pvr_vm_bind_exec_async(vm_ctx, ops, req->op_count,
+					      pvr_file, req->sync_ops,
+					      req->sync_op_count);
+
+	mutex_lock(&vm_ctx->lock);
+
+	if (pvr_vm_context_is_unusable(vm_ctx))
+		err = -ECANCELED;
+
+	for (u32 i = 0; !err && i < req->op_count; i++)
+		err = pvr_vm_bind_op_exec(&ops[i]);
+
+	mutex_unlock(&vm_ctx->lock);
+
+	pvr_vm_bind_ops_free(ops, req->op_count);
+	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
+
+	return err;
+}
diff --git a/drivers/gpu/drm/imagination/pvr_vm.h b/drivers/gpu/drm/imagination/pvr_vm.h
index b0528dffa7f..76762133c64 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.h
+++ b/drivers/gpu/drm/imagination/pvr_vm.h
@@ -22,6 +22,8 @@ struct pvr_vm_context;
 
 /* Forward declaration from <uapi/drm/pvr_drm.h> */
 struct drm_pvr_ioctl_get_heap_info_args;
+struct drm_pvr_sync_op;
+struct drm_pvr_vm_bind_op;
 
 /* Forward declaration from <drm/drm_exec.h> */
 struct drm_exec;
@@ -44,6 +46,31 @@ int pvr_vm_unmap_obj(struct pvr_vm_context *vm_ctx,
 int pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size);
 void pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx);
 
+bool pvr_vm_context_is_unusable(struct pvr_vm_context *vm_ctx);
+
+/**
+ * struct pvr_vm_bind_req - A VM bind request, as passed to pvr_vm_bind().
+ */
+struct pvr_vm_bind_req {
+	/** @ops: Array of userspace operation descriptions. */
+	const struct drm_pvr_vm_bind_op *ops;
+
+	/** @op_count: Number of entries in @ops. */
+	u32 op_count;
+
+	/** @sync_ops: Array of sync operations, or %NULL if there are none. */
+	const struct drm_pvr_sync_op *sync_ops;
+
+	/** @sync_op_count: Number of entries in @sync_ops. */
+	u32 sync_op_count;
+
+	/** @async: Queue the request instead of applying it inline. */
+	bool async;
+};
+
+int pvr_vm_bind(struct pvr_vm_context *vm_ctx, struct pvr_file *pvr_file,
+		const struct pvr_vm_bind_req *req);
+
 dma_addr_t pvr_vm_get_page_table_root_addr(struct pvr_vm_context *vm_ctx);
 struct dma_resv *pvr_vm_get_dma_resv(struct pvr_vm_context *vm_ctx);
 
diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
index ccf6c211246..eb1535cd513 100644
--- a/include/uapi/drm/pvr_drm.h
+++ b/include/uapi/drm/pvr_drm.h
@@ -108,6 +108,7 @@ struct drm_pvr_obj_array {
 #define DRM_IOCTL_PVR_CREATE_HWRT_DATASET PVR_IOCTL(0x0b, DRM_IOWR, create_hwrt_dataset)
 #define DRM_IOCTL_PVR_DESTROY_HWRT_DATASET PVR_IOCTL(0x0c, DRM_IOW, destroy_hwrt_dataset)
 #define DRM_IOCTL_PVR_SUBMIT_JOBS PVR_IOCTL(0x0d, DRM_IOW, submit_jobs)
+#define DRM_IOCTL_PVR_VM_BIND PVR_IOCTL(0x0e, DRM_IOW, vm_bind)
 
 /**
  * DOC: PowerVR IOCTL DEV_QUERY interface
@@ -1288,6 +1289,120 @@ struct drm_pvr_ioctl_submit_jobs_args {
 	struct drm_pvr_obj_array jobs;
 };
 
+/**
+ * DOC: PowerVR IOCTL VM_BIND interface
+ *
+ * %DRM_IOCTL_PVR_VM_BIND applies a batch of map and/or unmap operations to a
+ * single VM context, either before the IOCTL returns or, with
+ * %DRM_PVR_VM_BIND_ASYNC, from a queue.
+ *
+ * Operations within a request are applied in array order, and queued requests
+ * targeting one VM context in submission order. A synchronous request does not
+ * wait for the queued ones; a caller mixing the two on one VM context has to
+ * order them itself.
+ *
+ * A request that fails part way through may leave the address space in an
+ * undefined state; how much of it was applied is not reported.
+ */
+
+/**
+ * DOC: Flags for VM_BIND operations.
+ *
+ * The type of a VM bind operation is stored in the top four bits of
+ * &drm_pvr_vm_bind_op.flags.
+ *
+ * .. c:macro:: DRM_PVR_VM_BIND_OP_TYPE_MAP
+ *
+ *    Create a new mapping. &drm_pvr_vm_bind_op.handle must be a valid buffer
+ *    object handle.
+ *
+ * .. c:macro:: DRM_PVR_VM_BIND_OP_TYPE_UNMAP
+ *
+ *    Remove existing mappings. &drm_pvr_vm_bind_op.handle and
+ *    &drm_pvr_vm_bind_op.offset must both be zero.
+ *
+ * .. c:macro:: DRM_PVR_VM_BIND_OP_TYPE_MASK
+ *
+ *    Mask used to extract the operation type.
+ */
+#define DRM_PVR_VM_BIND_OP_TYPE_MAP (0u << 28)
+#define DRM_PVR_VM_BIND_OP_TYPE_UNMAP (1u << 28)
+#define DRM_PVR_VM_BIND_OP_TYPE_MASK (0xfu << 28)
+
+#define DRM_PVR_VM_BIND_OP_FLAGS_MASK DRM_PVR_VM_BIND_OP_TYPE_MASK
+
+/**
+ * struct drm_pvr_vm_bind_op - A single VM bind operation.
+ */
+struct drm_pvr_vm_bind_op {
+	/** @flags: [IN] Combination of ``DRM_PVR_VM_BIND_OP_`` flags. */
+	__u32 flags;
+
+	/**
+	 * @handle: [IN] Handle of the target buffer object.
+	 *
+	 * Must be a valid handle returned by %DRM_IOCTL_PVR_CREATE_BO for map
+	 * operations. MBZ for unmap operations.
+	 */
+	__u32 handle;
+
+	/**
+	 * @offset: [IN] Offset into the target buffer object from which to
+	 * begin the mapping. MBZ for unmap operations.
+	 */
+	__u64 offset;
+
+	/**
+	 * @device_addr: [IN] Device-virtual address at the start of the target
+	 * range. This must be non-zero and must obey the same alignment and
+	 * heap containment rules as %DRM_IOCTL_PVR_VM_MAP.
+	 */
+	__u64 device_addr;
+
+	/** @size: [IN] Size in bytes of the target range. Must be non-zero. */
+	__u64 size;
+};
+
+/**
+ * DOC: Flags for the VM_BIND ioctl.
+ *
+ * .. c:macro:: DRM_PVR_VM_BIND_ASYNC
+ *
+ *    Queue the request instead of applying it synchronously. Completion is
+ *    reported through &drm_pvr_ioctl_vm_bind_args.sync_ops.
+ */
+#define DRM_PVR_VM_BIND_ASYNC _BITUL(0)
+
+#define DRM_PVR_VM_BIND_FLAGS_MASK DRM_PVR_VM_BIND_ASYNC
+
+/**
+ * struct drm_pvr_ioctl_vm_bind_args - Arguments for %DRM_IOCTL_PVR_VM_BIND.
+ */
+struct drm_pvr_ioctl_vm_bind_args {
+	/**
+	 * @vm_context_handle: [IN] Handle for the VM context these operations
+	 * apply to.
+	 */
+	__u32 vm_context_handle;
+
+	/** @flags: [IN] Combination of ``DRM_PVR_VM_BIND_`` flags. */
+	__u32 flags;
+
+	/** @ops: [IN] Array of &struct drm_pvr_vm_bind_op to apply. */
+	struct drm_pvr_obj_array ops;
+
+	/**
+	 * @sync_ops: [IN] Sync operations applied to the request as a whole.
+	 * Waits are honoured before any of @ops is applied, signals fire once
+	 * all of them have been. Must be empty unless %DRM_PVR_VM_BIND_ASYNC is
+	 * set in @flags.
+	 *
+	 * A request with no operations but a non-empty @sync_ops is valid, and
+	 * places a bare synchronisation point on the VM bind queue.
+	 */
+	struct drm_pvr_obj_array sync_ops;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.43.0

