Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5A606A320
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdSWEwtt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5324810EB88;
	Sun,  8 Nov 2026 05:17:15 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B94C10EBF0
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:17:09 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-33fb4680717so532329eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 21:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794115028; x=1794719828; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hpFZi/vtl7LBX9oOLKqmOJOTPbReJ2rE1h+tVICvcYw=;
 b=xdSWEwttFGMMCAGV8bWQ/9Pp0MFmQKGjtO+pcDcoKMxH6zq5SHs7IJYs6R5TGNnpzv
 9uRzpv3jKJDOyn4Vc1Jk1G2dNsJyJcgWAzqsSdGJGsxfbFpJTzYFhCU10Qvkc/IyNgp0
 JGDDeY/ZgeEygz4nlq5aER9nuUENZhBkQvbKsrV+M/4fjwLQugnAB9pAMOBmAss5RmKA
 UDXKh9xmlwBoaOeLgOxejGsIWW23Zde04FK9rcVb5ndEUZTX2gRTny4Ib2Lw8+Qztg1p
 k8MVMqzH/Y9Bs20qH5xOJHaTkFWqvoeIkfOqMq3/SYfxkMW0pfUuxqB5uSAmbxEoVgrC
 RVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794115028; x=1794719828;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hpFZi/vtl7LBX9oOLKqmOJOTPbReJ2rE1h+tVICvcYw=;
 b=ECI72weqGJzzEc3+nvNQVbZ8vJkPIdLCEeJ+RJLLLleTfoPKi5S/JKQzhzPuQMlcju
 bm0uK5AO9hW99orQpnfDbYkQZGdx7JMGfEkWnQiKdqh1cMRMPL3K52Z3vwJ7lgDniJnp
 WAQLXwNv1YF09BZbQEj8luBalRdd1ZOpMAlq32dSJKT7e4mL0lXn/DR3UnEgV2AoneZk
 XWkSkj9m9YKAKMw3OXED4N51A2aQLRjl/jHrtAhYkrJZwq15AlYnlIs6sWFjub4AxCDA
 VjaXqhr/RcrOl4eyYMYbWGQYHT9NskZv+4IoCgEyp2oZoXv6WtboKII/J0Sb2NxmYBPB
 ifzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBylhxr0NwLaD71JXYuX9oOvXzh0bQMw1VHLFkFcox8gypmBHoyF7S3tKTZT+yXEfqXH7UPj/gbsF1E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9b6yjNgRTBcVh1T3Vb76bjR/3wtwoaCls/ygubl+b8Xj5Cqp7E
 t0XHDsZJ3f3wQG8sVtQuGUxEdFXpdcZ3RoXlLJ9OjAg/jIB441c/f6fa
X-Gm-Gg: AYBFou29JA2qsYkRifuUv454IHdohTiEXwPPCzIRjqWLaWNfWwi3LpWFVYbFhrjTjoQ
 imifmLqk+4Td8vJaYO/hOJrmAOq7HNTjfvhmz2/cni/YRmdVTPqCu23VsDYrfTXK/G5WM+6KsXt
 +oyDONKATOtuDg0wB5R4oaHbOVmhYNvWskXlD9F0yfQhtBLsbuwTCoqXl0CfCPEJYF88EogSi+I
 N5hKnrOpHVp66vpgrAhOlUwKha2ZlA4Ice9evqo7db687iWXQgfLYMSo83Ekq/QEzdQqSpw1dAr
 zKb898wUmR7ken0jI2pP6SGbUSB7ilkPfv/Neuh0jJj03z0k/zZUBcihRR5dCHokrZ1NKEaLShZ
 cDytsoShrHBHR2W8/iN6+/xYmLrRmQGJ39qUVpmwesXyn1MDDcSHum+wkIjZHG1U9d+Is1nx5SU
 caSGngXLNTV7WRmR/+H6OQtGWaPrBkQ15KAoDksd4p8tHcJlNNiHUTkX/eCjg0us+prOEvwl7xr
 PpRRKmWBYFhk6qAz0s0/kzm4dKC7Qtn7D+Msl4RH1+ylj2k0/YZlRAqV2xYBdWHQ972Z1fo3Xg3
 0hhzgl/c7FU/y3a4h4oSj/WKEg==
X-Received: by 2002:a05:7301:7305:b0:369:d779:bcb8 with SMTP id
 5a478bee46e88-3724fd69ac0mr1729876eec.0.1794115028233; 
 Sat, 07 Nov 2026 21:17:08 -0800 (PST)
Received: from [127.0.1.1] ([121.125.115.175])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372667d60absm2750989eec.26.2026.11.07.21.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 21:17:07 -0800 (PST)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 08 Nov 2026 14:16:28 +0900
Subject: [PATCH v2 6/6] drm/imagination: Add MAP_SPARSE to VM_BIND
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-pvr-vm-bind-v2-6-730103d2cc9a@gmail.com>
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

Vulkan sparse residency requires that an access to an unbound part of a
sparse resource does not fault, so a range has to be mappable without
naming any buffer object.

Add DRM_PVR_VM_BIND_OP_MAP_SPARSE, which maps one dummy object over and
over across the range.

To save memory, one dummy is shared by all sparse mappings, but per file
rather than per device: writes to a sparse range land in the dummy, so
per file keeps clients isolated from each other.

The dummy is 2MiB, so pvr_mmu_map() runs once per 2MiB, but the mapping
itself is still done per page.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_device.h | 10 ++++
 drivers/gpu/drm/imagination/pvr_drv.c    | 63 +++++++++++++++++++++++--
 drivers/gpu/drm/imagination/pvr_vm.c     | 81 +++++++++++++++++++++++++++++---
 drivers/gpu/drm/imagination/pvr_vm.h     |  8 ++++
 include/uapi/drm/pvr_drm.h               | 21 +++++++--
 5 files changed, 169 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index c246122b4ca..c8a7a949fdc 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -380,6 +380,16 @@ struct pvr_file {
 	 */
 	struct xarray hwrt_handles;
 
+	/**
+	 * @sparse_dummy_bo: Object the file's sparse mappings repeat. Pins its
+	 * pages, so it is created on first use, under @sparse_dummy_lock. Per
+	 * file, so that sparse writes stay out of other clients' view.
+	 */
+	struct pvr_gem_object *sparse_dummy_bo;
+
+	/** @sparse_dummy_lock: Serialises the creation of @sparse_dummy_bo. */
+	struct mutex sparse_dummy_lock;
+
 	/**
 	 * @vm_ctx_handles: Array of VM contexts belonging to this file. Array
 	 * members are of type "struct pvr_vm_context *".
diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index c35d437aef7..377fa8d936a 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1137,6 +1137,37 @@ pvr_ioctl_vm_unmap(struct drm_device *drm_dev, void *raw_args,
 	return err;
 }
 
+/**
+ * pvr_file_get_sparse_dummy() - Get a file's sparse dummy object.
+ * @pvr_file: Target PowerVR file.
+ *
+ * Return: The object, with a reference for the caller, or an ERR_PTR on
+ * failure.
+ */
+static struct pvr_gem_object *
+pvr_file_get_sparse_dummy(struct pvr_file *pvr_file)
+{
+	struct pvr_gem_object *dummy;
+
+	mutex_lock(&pvr_file->sparse_dummy_lock);
+
+	dummy = pvr_file->sparse_dummy_bo;
+	if (!dummy) {
+		dummy = pvr_vm_sparse_dummy_create(pvr_file->pvr_dev);
+		if (IS_ERR(dummy))
+			goto err_unlock;
+
+		pvr_file->sparse_dummy_bo = dummy;
+	}
+
+	pvr_gem_object_get(dummy);
+
+err_unlock:
+	mutex_unlock(&pvr_file->sparse_dummy_lock);
+
+	return dummy;
+}
+
 /**
  * pvr_vm_bind_desc_from_uapi() - Translate a userspace bind operation.
  * @desc: Description to fill in.
@@ -1150,6 +1181,8 @@ pvr_vm_bind_desc_from_uapi(struct pvr_vm_bind_desc *desc,
 			   struct pvr_file *pvr_file,
 			   const struct drm_pvr_vm_bind_op *uapi_op)
 {
+	const bool sparse = uapi_op->flags & DRM_PVR_VM_BIND_OP_MAP_SPARSE;
+
 	if (uapi_op->flags & ~DRM_PVR_VM_BIND_OP_FLAGS_MASK)
 		return -EINVAL;
 
@@ -1157,19 +1190,35 @@ pvr_vm_bind_desc_from_uapi(struct pvr_vm_bind_desc *desc,
 		.offset = uapi_op->offset,
 		.device_addr = uapi_op->device_addr,
 		.size = uapi_op->size,
+		.sparse = sparse,
 	};
 
 	switch (uapi_op->flags & DRM_PVR_VM_BIND_OP_TYPE_MASK) {
 	case DRM_PVR_VM_BIND_OP_TYPE_MAP:
 		desc->type = PVR_VM_BIND_TYPE_MAP;
-		desc->obj = pvr_gem_object_from_handle(pvr_file, uapi_op->handle);
-		if (!desc->obj)
-			return -ENOENT;
+
+		if (sparse) {
+			struct pvr_gem_object *dummy;
+
+			if (uapi_op->handle || uapi_op->offset)
+				return -EINVAL;
+
+			dummy = pvr_file_get_sparse_dummy(pvr_file);
+			if (IS_ERR(dummy))
+				return PTR_ERR(dummy);
+
+			desc->obj = dummy;
+		} else {
+			desc->obj = pvr_gem_object_from_handle(pvr_file,
+							       uapi_op->handle);
+			if (!desc->obj)
+				return -ENOENT;
+		}
 
 		return 0;
 
 	case DRM_PVR_VM_BIND_OP_TYPE_UNMAP:
-		if (uapi_op->handle || uapi_op->offset)
+		if (uapi_op->handle || uapi_op->offset || sparse)
 			return -EINVAL;
 
 		desc->type = PVR_VM_BIND_TYPE_UNMAP;
@@ -1615,6 +1664,8 @@ pvr_drm_driver_open(struct drm_device *drm_dev, struct drm_file *file)
 
 	INIT_LIST_HEAD(&pvr_file->contexts);
 
+	mutex_init(&pvr_file->sparse_dummy_lock);
+
 	xa_init_flags(&pvr_file->ctx_handles, XA_FLAGS_ALLOC1);
 	xa_init_flags(&pvr_file->free_list_handles, XA_FLAGS_ALLOC1);
 	xa_init_flags(&pvr_file->hwrt_handles, XA_FLAGS_ALLOC1);
@@ -1653,6 +1704,10 @@ pvr_drm_driver_postclose(__always_unused struct drm_device *drm_dev,
 	pvr_destroy_hwrt_datasets_for_file(pvr_file);
 	pvr_destroy_vm_contexts_for_file(pvr_file);
 
+	if (pvr_file->sparse_dummy_bo)
+		pvr_gem_object_put(pvr_file->sparse_dummy_bo);
+	mutex_destroy(&pvr_file->sparse_dummy_lock);
+
 	kfree(pvr_file);
 	file->driver_priv = NULL;
 }
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 4e58ea8c50c..0c22c63e498 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -22,8 +22,10 @@
 #include <linux/errno.h>
 #include <linux/gfp_types.h>
 #include <linux/kref.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/workqueue.h>
@@ -188,6 +190,9 @@ struct pvr_vm_bind_op {
 	 */
 	struct pvr_vm_gpuva *next_va;
 
+	/** @sparse: See &pvr_vm_bind_desc.sparse. */
+	bool sparse;
+
 	/** @offset: Offset into @pvr_obj to begin mapping from. */
 	u64 offset;
 
@@ -280,11 +285,19 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_op,
 
 	if (!pvr_device_addr_and_size_are_valid(vm_ctx, desc->device_addr,
 						desc->size) ||
-	    desc->offset & ~PAGE_MASK || desc->size & ~PAGE_MASK ||
-	    desc->offset >= pvr_obj_size || offset_plus_size > pvr_obj_size)
+	    desc->offset & ~PAGE_MASK || desc->size & ~PAGE_MASK)
+		return -EINVAL;
+
+	/*
+	 * A sparse mapping repeats @obj over a range wider than it, so only
+	 * ordinary mappings must fit within @obj.
+	 */
+	if (!desc->sparse &&
+	    (desc->offset >= pvr_obj_size || offset_plus_size > pvr_obj_size))
 		return -EINVAL;
 
 	bind_op->type = PVR_VM_BIND_TYPE_MAP;
+	bind_op->sparse = desc->sparse;
 
 	bind_op->gpuvm_bo = drm_gpuvm_bo_create(&vm_ctx->gpuvm_mgr, obj);
 	if (!bind_op->gpuvm_bo)
@@ -373,6 +386,58 @@ pvr_vm_bind_op_unmap_init(struct pvr_vm_bind_op *bind_op,
 	return err;
 }
 
+/**
+ * pvr_vm_sparse_dummy_create() - Create the object sparse mappings repeat.
+ * @pvr_dev: Target PowerVR device.
+ *
+ * It covers a whole level 0 page table, so that each chunk mapped by
+ * pvr_vm_mmu_map_sparse() fills one.
+ *
+ * Return: The new object, or an ERR_PTR on failure.
+ */
+struct pvr_gem_object *pvr_vm_sparse_dummy_create(struct pvr_device *pvr_dev)
+{
+	return pvr_gem_object_create(pvr_dev, SZ_2M,
+				     DRM_PVR_BO_BYPASS_DEVICE_CACHE);
+}
+
+/**
+ * pvr_vm_mmu_map_sparse() - Map a dummy object over and over across a range.
+ * @mmu_op_ctx: Target MMU op context, created for @dummy.
+ * @dummy: Object to repeat.
+ * @device_addr: Virtual device address at the start of the range.
+ * @size: Size of the range.
+ *
+ * Maps @dummy repeatedly, in chunks aligned to its size, which must be a power
+ * of two.
+ *
+ * Return: 0 on success, or a negative error code with nothing left mapped.
+ */
+static int
+pvr_vm_mmu_map_sparse(struct pvr_mmu_op_context *mmu_op_ctx,
+		      struct pvr_gem_object *dummy, u64 device_addr, u64 size)
+{
+	const u64 dummy_size = pvr_gem_object_size(dummy);
+	u64 mapped = 0;
+	int err;
+
+	while (mapped < size) {
+		const u64 addr = device_addr + mapped;
+		const u64 chunk = min(size - mapped,
+				      dummy_size - (addr & (dummy_size - 1)));
+
+		err = pvr_mmu_map(mmu_op_ctx, chunk, dummy->flags, addr);
+		if (err) {
+			pvr_mmu_unmap(mmu_op_ctx, device_addr, mapped);
+			return err;
+		}
+
+		mapped += chunk;
+	}
+
+	return 0;
+}
+
 /**
  * pvr_vm_gpuva_map() - Insert a mapping into a memory context.
  * @op: gpuva op containing the remap details.
@@ -383,7 +448,7 @@ pvr_vm_bind_op_unmap_init(struct pvr_vm_bind_op *bind_op,
  *
  * Return:
  *  * 0 on success, or
- *  * Any error returned by pvr_mmu_map().
+ *  * Any error returned by pvr_mmu_map() or pvr_vm_mmu_map_sparse().
  */
 static int
 pvr_vm_gpuva_map(struct drm_gpuva_op *op, void *op_ctx)
@@ -395,8 +460,12 @@ pvr_vm_gpuva_map(struct drm_gpuva_op *op, void *op_ctx)
 	if ((op->map.gem.offset | op->map.va.range) & ~PVR_DEVICE_PAGE_MASK)
 		return -EINVAL;
 
-	err = pvr_mmu_map(ctx->mmu_op_ctx, op->map.va.range, pvr_gem->flags,
-			  op->map.va.addr);
+	if (ctx->sparse)
+		err = pvr_vm_mmu_map_sparse(ctx->mmu_op_ctx, pvr_gem,
+					    op->map.va.addr, op->map.va.range);
+	else
+		err = pvr_mmu_map(ctx->mmu_op_ctx, op->map.va.range,
+				  pvr_gem->flags, op->map.va.addr);
 	if (err)
 		return err;
 
@@ -741,7 +810,7 @@ pvr_vm_bind_op_init(struct pvr_vm_bind_op *bind_op,
 		return pvr_vm_bind_op_map_init(bind_op, vm_ctx, desc);
 
 	case PVR_VM_BIND_TYPE_UNMAP:
-		if (WARN_ON(desc->obj))
+		if (WARN_ON(desc->obj || desc->sparse))
 			return -EINVAL;
 
 		return pvr_vm_bind_op_unmap_init(bind_op, vm_ctx, desc);
diff --git a/drivers/gpu/drm/imagination/pvr_vm.h b/drivers/gpu/drm/imagination/pvr_vm.h
index df74b405960..68d5ffa5e88 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.h
+++ b/drivers/gpu/drm/imagination/pvr_vm.h
@@ -80,6 +80,12 @@ struct pvr_vm_bind_desc {
 
 	/** @size: Size of the range. */
 	u64 size;
+
+	/**
+	 * @sparse: Repeat @obj over the range rather than covering it once.
+	 * Map only.
+	 */
+	bool sparse;
 };
 
 int pvr_vm_bind(struct pvr_vm_context *vm_ctx,
@@ -93,6 +99,8 @@ void pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx);
 
 bool pvr_vm_context_is_unusable(struct pvr_vm_context *vm_ctx);
 
+struct pvr_gem_object *pvr_vm_sparse_dummy_create(struct pvr_device *pvr_dev);
+
 dma_addr_t pvr_vm_get_page_table_root_addr(struct pvr_vm_context *vm_ctx);
 struct dma_resv *pvr_vm_get_dma_resv(struct pvr_vm_context *vm_ctx);
 
diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
index 57c22f5f215..a7c2801cc70 100644
--- a/include/uapi/drm/pvr_drm.h
+++ b/include/uapi/drm/pvr_drm.h
@@ -1333,7 +1333,17 @@ struct drm_pvr_ioctl_submit_jobs_args {
 /**
  * DOC: Flags for VM_BIND operations.
  *
- * Set exactly one operation type in &drm_pvr_vm_bind_op.flags.
+ * Set exactly one operation type in &drm_pvr_vm_bind_op.flags, optionally
+ * ORed with modifiers.
+ *
+ * .. c:macro:: DRM_PVR_VM_BIND_OP_MAP_SPARSE
+ *
+ *    Sparsely map a range without naming a buffer object. Only valid with
+ *    %DRM_PVR_VM_BIND_OP_TYPE_MAP.
+ *
+ *    GPU accesses to the range do not fault. Nothing else is guaranteed:
+ *    reads return undefined values, and writes may become visible through
+ *    other sparse mappings.
  *
  * .. c:macro:: DRM_PVR_VM_BIND_OP_TYPE_MAP
  *
@@ -1349,11 +1359,14 @@ struct drm_pvr_ioctl_submit_jobs_args {
  *
  *    Mask used to extract the operation type.
  */
+#define DRM_PVR_VM_BIND_OP_MAP_SPARSE _BITUL(0)
+
 #define DRM_PVR_VM_BIND_OP_TYPE_MAP (0u << 28)
 #define DRM_PVR_VM_BIND_OP_TYPE_UNMAP (1u << 28)
 #define DRM_PVR_VM_BIND_OP_TYPE_MASK (0xfu << 28)
 
-#define DRM_PVR_VM_BIND_OP_FLAGS_MASK DRM_PVR_VM_BIND_OP_TYPE_MASK
+#define DRM_PVR_VM_BIND_OP_FLAGS_MASK \
+	(DRM_PVR_VM_BIND_OP_MAP_SPARSE | DRM_PVR_VM_BIND_OP_TYPE_MASK)
 
 /**
  * struct drm_pvr_vm_bind_op - A single VM bind operation.
@@ -1366,13 +1379,13 @@ struct drm_pvr_vm_bind_op {
 	 * @handle: [IN] Handle of the target buffer object.
 	 *
 	 * Must be a valid handle returned by %DRM_IOCTL_PVR_CREATE_BO for map
-	 * operations. MBZ for unmap operations.
+	 * operations. MBZ for unmap and sparse map operations.
 	 */
 	__u32 handle;
 
 	/**
 	 * @offset: [IN] Offset into the target buffer object from which to
-	 * begin the mapping. MBZ for unmap operations.
+	 * begin the mapping. MBZ for unmap and sparse map operations.
 	 */
 	__u64 offset;
 

-- 
2.43.0

