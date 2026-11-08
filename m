Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB69606A326
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cuVl7QvH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66B810EB8E;
	Sun,  8 Nov 2026 05:17:05 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9B710EB88
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:17:00 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-33fb4680717so532216eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 21:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794115019; x=1794719819; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PV+G4eCp3NYoNJTF07kAfpF9Tt1DHEOnhaIb+G3LetM=;
 b=cuVl7QvHfpp7kmYhKg8Xkuv78hBqLtf//w3SQeo+Iru2q8DQoTiTX/7HCYGt1HgpFb
 w2n1ROhLAaI2JbAyTgY1o2W0Sv+hi4L9WYK+0XM6rm+a9vDzCj68FQUWvaa+5a8RJfUN
 n1ZU6oGPZ+HQTNzI3RzR67zX3bxx1ERZobMuYZSR5tUsG1kCxxUrs9513QTSacnoewEo
 CZ4D3qgIDh4LyqMx1C5hPP8Tvl7aHhnSCCFAXbyDMWa4bG3QiMl07nwmgH302XnogjEu
 a25fPxOf/IhFE8FNKsS1DTyody2jyFfBNa/mSn86x+vmeEtcPM/Fe0E8z3zEYDZlA3ka
 hGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794115019; x=1794719819;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PV+G4eCp3NYoNJTF07kAfpF9Tt1DHEOnhaIb+G3LetM=;
 b=EFK9TbzH5iAkmjwT7iUK43aFc/01ZIWcsD8q20CKR4sMWP9VtOhBaXj+NhJfNVWj+z
 IFCDEiFRv5BgcrhO6Vf7ztPndPIJN2lQmFU6+t3SChdzwsAwB9fyt5uv0pW2SCmOfCev
 lvsPk+HS6YAYVIP23zVzB84ZJgb8/enhEJUUEtj6zw5zZPPr+H5oOdSv/lMKgVDx9wYD
 52E4bERbHya6os3VAm+9d683jzIiUnp28o/nGVt8/oOStHFY5swNQKvPWgYP+SyGQH+G
 2ZeAJk/Lh7bYmfuP2K8qYjl/GSzxvxAL6s6wPehcLsSk3MJJS8romba2NsAW5TCgsJFu
 19/w==
X-Forwarded-Encrypted: i=1;
 AL+hErF1wEpMhTnQTkFs4G66siq4CfFVU8fO8eVZPAKlvcZTeeYNX7sG9+zJZK3N3XgjMcP8nGFNshQArx4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+MUDPpRZeddzuwmPTgIVW8yApfUpcOSXnh4sJ5QEFfkmAaKgko
 FIBQnB01oFm79SLNmr4xgcaioF/VpxsSh15sXMFyqaoeELrXkk0FDU3/
X-Gm-Gg: AYBFou28QyvXbiAqTsH52AWvbU0vkN2ziujUNhzXVOzoAGAjQRWMN9o5U4HB1rv7oaI
 8Bj8kSXnzcVDNksTrOARWoiLzQDcW7ERv298H5gco1Vj7VNl15lN/UH9KhrQlGAMtJwhEgkBZg2
 NwcDRltqtgCl0rmDkTlod57NvHQ/wL+fR9vciHXUHOOzECOo1cANY8gW3htKhr3ZQfb6JVmcdbx
 A+NQDwrw51noQaBNDWzGziUPQd5VBBA9Jkj43UvK9SBCmMj0644Gjd2V7GScPpLCPBQ0GjJJCT4
 CQA+Hr9pox/6V+J6h1B+fJwXqV+CluXRiKLhS6OUCSN1IUs67Kx51ph8W3xtypmVk2s/qxifiTi
 tGXpOhvoU082JeFIx7sPtPEmM0Ic+OtVY475SDh/EMlE65fiMM5oXQw68dZF3qH/V2m4Xr8VHzE
 E3gmTldzZu96uKgi60/nx9aoBN//x4mM6aPGFNHOUwMPyMJdEngk66pjzvm/BXltqlFwdfnWebH
 NUWWvGOSpTrDRvPNngvYpW75/1/1NV1AV7XjL0k7mG4KBd4fFDWK1IwdHXVEz365QXioMmaoGt2
 DYFWKO3umT59CE7hliQjtiQ0Ew==
X-Received: by 2002:a05:693c:8809:10b0:368:c6b9:d3c0 with SMTP id
 5a478bee46e88-37256df1f7dmr1712151eec.28.1794115019264; 
 Sat, 07 Nov 2026 21:16:59 -0800 (PST)
Received: from [127.0.1.1] ([121.125.115.175])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372667d60absm2750989eec.26.2026.11.07.21.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 21:16:58 -0800 (PST)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 08 Nov 2026 14:16:26 +0900
Subject: [PATCH v2 4/6] drm/imagination: Add VM_BIND ioctl
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-pvr-vm-bind-v2-4-730103d2cc9a@gmail.com>
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

Add DRM_IOCTL_PVR_VM_BIND, a batched version of VM_MAP and VM_UNMAP.

Problem with VM_MAP and VM_UNMAP:

  vkQueueBindSparse hands over operations in bulk, which VM_MAP and
  VM_UNMAP turn into hundreds of ioctls.

Difference from VM_UNMAP:

  VM_UNMAP only removes a mapping that exactly matches the range.
  VM_BIND's UNMAP removes everything in the range, splitting mappings
  that cross its boundaries, as Vulkan sparse unbinding takes an
  arbitrary range rather than a previous binding.

The flags and sync_ops fields are reserved for asynchronous requests and
must be zero and empty until then, which fixes the layout.

Bump the driver interface minor version to 2.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 Documentation/gpu/imagination/uapi.rst |  12 +++
 drivers/gpu/drm/imagination/pvr_drv.c  | 163 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_drv.h  |   4 +-
 include/uapi/drm/pvr_drm.h             |  90 ++++++++++++++++++
 4 files changed, 268 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/imagination/uapi.rst b/Documentation/gpu/imagination/uapi.rst
index 7502413d0a9..781d54ec01e 100644
--- a/Documentation/gpu/imagination/uapi.rst
+++ b/Documentation/gpu/imagination/uapi.rst
@@ -87,6 +87,18 @@ VM_MAP and VM_UNMAP
    :identifiers: drm_pvr_ioctl_vm_map_args
                  drm_pvr_ioctl_vm_unmap_args
 
+VM_BIND
+-------
+.. kernel-doc:: include/uapi/drm/pvr_drm.h
+   :doc: PowerVR IOCTL VM_BIND interface
+
+.. kernel-doc:: include/uapi/drm/pvr_drm.h
+   :doc: Flags for VM_BIND operations.
+
+.. kernel-doc:: include/uapi/drm/pvr_drm.h
+   :identifiers: drm_pvr_vm_bind_op
+                 drm_pvr_ioctl_vm_bind_args
+
 CREATE_CONTEXT and DESTROY_CONTEXT
 ----------------------------------
 .. kernel-doc:: include/uapi/drm/pvr_drm.h
diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 2d522a8e46a..8203d5f081d 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1135,6 +1135,168 @@ pvr_ioctl_vm_unmap(struct drm_device *drm_dev, void *raw_args,
 	return err;
 }
 
+/**
+ * pvr_vm_bind_desc_from_uapi() - Translate a userspace bind operation.
+ * @desc: Description to fill in.
+ * @pvr_file: PowerVR file used to resolve buffer object handles.
+ * @uapi_op: Userspace description of the operation.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int
+pvr_vm_bind_desc_from_uapi(struct pvr_vm_bind_desc *desc,
+			   struct pvr_file *pvr_file,
+			   const struct drm_pvr_vm_bind_op *uapi_op)
+{
+	if (uapi_op->flags & ~DRM_PVR_VM_BIND_OP_FLAGS_MASK)
+		return -EINVAL;
+
+	*desc = (struct pvr_vm_bind_desc){
+		.offset = uapi_op->offset,
+		.device_addr = uapi_op->device_addr,
+		.size = uapi_op->size,
+	};
+
+	switch (uapi_op->flags & DRM_PVR_VM_BIND_OP_TYPE_MASK) {
+	case DRM_PVR_VM_BIND_OP_TYPE_MAP:
+		desc->type = PVR_VM_BIND_TYPE_MAP;
+		desc->obj = pvr_gem_object_from_handle(pvr_file, uapi_op->handle);
+		if (!desc->obj)
+			return -ENOENT;
+
+		return 0;
+
+	case DRM_PVR_VM_BIND_OP_TYPE_UNMAP:
+		if (uapi_op->handle || uapi_op->offset)
+			return -EINVAL;
+
+		desc->type = PVR_VM_BIND_TYPE_UNMAP;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * pvr_vm_bind_descs_release() - Release translated bind operations.
+ * @descs: Array to release.
+ * @count: Number of entries in @descs.
+ */
+static void pvr_vm_bind_descs_release(struct pvr_vm_bind_desc *descs,
+				      u32 count)
+{
+	for (u32 i = 0; i < count; i++) {
+		if (descs[i].obj)
+			pvr_gem_object_put(descs[i].obj);
+	}
+
+	kvfree(descs);
+}
+
+/**
+ * pvr_vm_bind_descs_from_uapi() - Translate userspace VM_BIND operations.
+ * @pvr_file: PowerVR file the request was issued on.
+ * @uapi_ops: Userspace bind operations.
+ * @count: Number of entries in @uapi_ops.
+ *
+ * Return: The new array, to be released with pvr_vm_bind_descs_release(), or
+ * an ERR_PTR on failure.
+ */
+static struct pvr_vm_bind_desc *
+pvr_vm_bind_descs_from_uapi(struct pvr_file *pvr_file,
+			    const struct drm_pvr_vm_bind_op *uapi_ops,
+			    u32 count)
+{
+	struct pvr_vm_bind_desc *descs;
+	int err;
+
+	descs = kvzalloc_objs(*descs, count, GFP_KERNEL_ACCOUNT);
+	if (!descs)
+		return ERR_PTR(-ENOMEM);
+
+	for (u32 i = 0; i < count; i++) {
+		err = pvr_vm_bind_desc_from_uapi(&descs[i], pvr_file,
+						 &uapi_ops[i]);
+		if (err) {
+			pvr_vm_bind_descs_release(descs, i);
+			return ERR_PTR(err);
+		}
+	}
+
+	return descs;
+}
+
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
+ *  * -%EINVAL if arguments are invalid,
+ *  * -%ENOENT if an operation refers to an unknown buffer object, or
+ *  * Any other negative error code on failure.
+ */
+static int
+pvr_ioctl_vm_bind(struct drm_device *drm_dev, void *raw_args,
+		  struct drm_file *file)
+{
+	struct drm_pvr_ioctl_vm_bind_args *args = raw_args;
+	struct pvr_file *pvr_file = to_pvr_file(file);
+	struct drm_pvr_vm_bind_op *uapi_ops;
+	struct pvr_vm_bind_desc *descs;
+	struct pvr_vm_context *vm_ctx;
+	int idx;
+	int err;
+
+	if (!drm_dev_enter(drm_dev, &idx))
+		return -EIO;
+
+	if (args->flags || args->sync_ops.count) {
+		err = -EINVAL;
+		goto err_drm_dev_exit;
+	}
+
+	if (!args->ops.count) {
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
+	err = PVR_UOBJ_GET_ARRAY(uapi_ops, &args->ops);
+	if (err)
+		goto err_put_vm_context;
+
+	descs = pvr_vm_bind_descs_from_uapi(pvr_file, uapi_ops, args->ops.count);
+	kvfree(uapi_ops);
+	if (IS_ERR(descs)) {
+		err = PTR_ERR(descs);
+		goto err_put_vm_context;
+	}
+
+	err = pvr_vm_bind(vm_ctx, descs, args->ops.count);
+
+	pvr_vm_bind_descs_release(descs, args->ops.count);
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
@@ -1295,6 +1457,7 @@ static const struct drm_ioctl_desc pvr_drm_driver_ioctls[] = {
 	DRM_PVR_IOCTL(CREATE_HWRT_DATASET, create_hwrt_dataset, DRM_RENDER_ALLOW),
 	DRM_PVR_IOCTL(DESTROY_HWRT_DATASET, destroy_hwrt_dataset, DRM_RENDER_ALLOW),
 	DRM_PVR_IOCTL(SUBMIT_JOBS, submit_jobs, DRM_RENDER_ALLOW),
+	DRM_PVR_IOCTL(VM_BIND, vm_bind, DRM_RENDER_ALLOW),
 };
 
 /* clang-format on */
diff --git a/drivers/gpu/drm/imagination/pvr_drv.h b/drivers/gpu/drm/imagination/pvr_drv.h
index 4e058a6fdd5..67317bbf958 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.h
+++ b/drivers/gpu/drm/imagination/pvr_drv.h
@@ -14,9 +14,10 @@
  * Driver interface version:
  *  - 1.0: Initial interface
  *  - 1.1: Add DRM_PVR_DEV_QUERY_FW_INFO_GET query
+ *  - 1.2: Add DRM_IOCTL_PVR_VM_BIND
  */
 #define PVR_DRIVER_MAJOR 1
-#define PVR_DRIVER_MINOR 1
+#define PVR_DRIVER_MINOR 2
 #define PVR_DRIVER_PATCHLEVEL 0
 
 int pvr_get_uobj(u64 usr_ptr, u32 usr_size, u32 min_size, u32 obj_size, void *out);
@@ -61,6 +62,7 @@ int pvr_set_uobj_array(const struct drm_pvr_obj_array *out, u32 min_stride, u32
 #define PVR_UOBJ_MIN_SIZE(_obj_name) _Generic(_obj_name \
 	PVR_UOBJ_DECL(struct drm_pvr_job, hwrt) \
 	PVR_UOBJ_DECL(struct drm_pvr_sync_op, value) \
+	PVR_UOBJ_DECL(struct drm_pvr_vm_bind_op, size) \
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_gpu_info, num_phantoms) \
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_runtime_info, cdm_max_local_mem_size_regs) \
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_quirks, _padding_c) \
diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
index 1179c1e7d92..55656aa8304 100644
--- a/include/uapi/drm/pvr_drm.h
+++ b/include/uapi/drm/pvr_drm.h
@@ -108,6 +108,7 @@ struct drm_pvr_obj_array {
 #define DRM_IOCTL_PVR_CREATE_HWRT_DATASET PVR_IOCTL(0x0b, DRM_IOWR, create_hwrt_dataset)
 #define DRM_IOCTL_PVR_DESTROY_HWRT_DATASET PVR_IOCTL(0x0c, DRM_IOW, destroy_hwrt_dataset)
 #define DRM_IOCTL_PVR_SUBMIT_JOBS PVR_IOCTL(0x0d, DRM_IOW, submit_jobs)
+#define DRM_IOCTL_PVR_VM_BIND PVR_IOCTL(0x0e, DRM_IOW, vm_bind)
 
 /**
  * DOC: PowerVR IOCTL DEV_QUERY interface
@@ -1309,6 +1310,95 @@ struct drm_pvr_ioctl_submit_jobs_args {
 	struct drm_pvr_obj_array jobs;
 };
 
+/**
+ * DOC: PowerVR IOCTL VM_BIND interface
+ *
+ * %DRM_IOCTL_PVR_VM_BIND applies a batch of map and/or unmap operations to a
+ * single VM context before the IOCTL returns.
+ *
+ * Operations within a request are applied in array order.
+ *
+ * A request that fails part way through may leave the address space in an
+ * undefined state; how much of it was applied is not reported.
+ */
+
+/**
+ * DOC: Flags for VM_BIND operations.
+ *
+ * Set exactly one operation type in &drm_pvr_vm_bind_op.flags.
+ *
+ * .. c:macro:: DRM_PVR_VM_BIND_OP_TYPE_MAP
+ *
+ *    Create a new mapping.
+ *
+ * .. c:macro:: DRM_PVR_VM_BIND_OP_TYPE_UNMAP
+ *
+ *    Remove everything in the range, splitting mappings that cross its
+ *    ends. Unlike %DRM_IOCTL_PVR_VM_UNMAP, the range need not match a
+ *    mapping.
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
+	 * range, aligned to the device page size. For map operations, it must
+	 * also obey the same heap containment rules as %DRM_IOCTL_PVR_VM_MAP.
+	 */
+	__u64 device_addr;
+
+	/** @size: [IN] Size in bytes of the target range. Must be non-zero. */
+	__u64 size;
+};
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
+	/** @flags: [IN] Reserved. MBZ. */
+	__u32 flags;
+
+	/** @ops: [IN] Array of &struct drm_pvr_vm_bind_op to apply. */
+	struct drm_pvr_obj_array ops;
+
+	/** @sync_ops: [IN] Reserved. Must be empty. */
+	struct drm_pvr_obj_array sync_ops;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.43.0

