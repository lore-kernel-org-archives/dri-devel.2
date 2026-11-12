Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB2606D58C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D305E1123D4;
	Thu, 12 Nov 2026 22:59:28 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84DDA11239D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:59:21 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8b336de3d38so3297557b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524360; x=1795129160;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2S+1oVmF7ABvevxRP1h0vhmyM1Y1t2gXt3/NcgVPU8s=;
 b=UFRH7/rXNcHosDStwTZsm1ysETZhZCjhVm5Ul438OybPv7dAf+3+pMd3otsjuUvoUQ
 CYO835d/FKcYeHZGH54ksQ/GNtDuhm27Z9d5y8+q7EVEWYcWJ4l12gsGGsUC2rpMFAck
 fDcBcM7StKcVUOk5k4fZgVh1nLJ2UBUjhnc45UaUf44d3Iaw95alEW2iwG+601tnW43k
 jRw3FEIhE/e0wzJhTMHgNq27mA01QK+ciVx7kChWZjujRYDtsqy/NshCb3K6G0IsJKiu
 dltmlmdaLFWWJqoxYbMrLLKoTbZv/ef5H7GHOP8wxmE6rNyPUu7A+cMBdhgDqsptpS40
 KJxQ==
X-Gm-Message-State: APuU4Z9NPwo19bAGpEke6PYCRMwRBrWbJ1J+dQ5Z64V6RdTnvxMEw5Xp
 Zi8lIa7jjom4nhNGFh7snZ2J6ALHRPX1IHd5kupEb6sViNDn0+Il8ubd
X-Gm-Gg: AYBFou2CbNFZ33e4wMcXDkKAHJGOqOOdAMEODqgNGC9uxmukGXuG7QL9J6XjPqOtPJx
 +3YYanbT2JAi154M9ypmCzlyVmUmLxJNbuIkaxoRyt7AWXh7jwYgHvTfIN2UV28KOr0d241BUEp
 KpW9YqUeKJXq6AEz2C/fAQMvqG55WyLeryd9ajAoGDoYHy+a7pZqF8nbbXlwmHKVjlc0A+envNN
 El6IN814wMLTQpgV9qdtW9h+h9y9WTurKROpDqomCnh+pfpGiK81iKLfetC9pRc7LCiHwS4blyo
 JRNGlEXD2k1gRtZXzFWpI0H8PzcYyqzkKv2bORRX4yuhpY9Qwx2aLTmLEb3rQ9alRThj4GuyC4F
 GIzTz2s8DtTolYDpweRUcdmWzVXT+ByXVFAfKTKu8ZOvorZBP6NAr5v8JF+63l4zdovUnjjc4xT
 2SZahVUAPKLcoHapONGFrg5vDMnbBWWa5FYRpQ0+B/dSbuvBwos6A+AZ6/qgQuoWqaYmXqP/gJU
 L2ycHJe8fF/b0PD/2J23QbkfUFsk5FmQjRSZ7DMmeyo+X/0hOG/qwLLbm/n5Bv7UPwBo701QuUO
 d6hk9QE15NuARx9y4RiGx0j2hdesOe+S5OBlxz19ScEFZdF4O8rVV+8wwcAV+31H5d5zLtAdWvE
 daietRSwTCKxVIZVhGUx66F2WY+UlelRYVOzLKKKrSPMJeIMsx0EUxi4ijTBNOa0MKNqOP+Kp9v
 0Tjqa0CDDJPEY6XRHdxCtDEWEMI2g=
X-Received: by 2002:a05:690c:c510:b0:8b4:aa69:a749 with SMTP id
 00721157ae682-8b4aa69be0amr5479297b3.1.1794524359991; 
 Thu, 12 Nov 2026 14:59:19 -0800 (PST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([71.68.170.161]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8f354asm7261077b3.14.2026.11.12.14.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:59:19 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 12 Nov 2026 17:58:57 -0500
Subject: [PATCH RFC 07/13] drm/powervr_sgx: Add GEM objects, VMs and
 dma-buf sharing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-powervr-sgx-v1-7-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
In-Reply-To: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
To: dri-devel@lists.freedesktop.org, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: imagination@lists.freedesktop.org, Frank Binns <frank.binns@imgtec.com>, 
 Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

- GEM shmem objects below 4 GiB, mapped write-combined. A code object
  has no CPU mapping; its contents come through UPLOAD_CODE.
- VM contexts on drm_gpuvm, one GPU page directory each, with VM_BIND
  mapping and unmapping inside the fixed heaps. An unmap invalidates the
  GPU's directory and table caches and waits for the VM's jobs before
  the pages go.
- dma-buf export and import (import on x86 only for now). The SGX
  doesn't snoop the CPU's caches, so an import is written back once when
  it is imported, through the exporter's vmap, and the byte ranges a job
  lists are flushed before it runs and, where it writes, again before
  its fence signals.
- Firmware objects a client releases wait until the GPU can no longer
  use them; a VM's mappings go when its handle and its last context are
  gone.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/gpu/drm/powervr_sgx/pvrsgx_gem.c   | 120 +++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_gem.h   |  46 ++
 drivers/gpu/drm/powervr_sgx/pvrsgx_kobj.c  | 285 ++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_kobj.h  |  82 +++
 drivers/gpu/drm/powervr_sgx/pvrsgx_prime.c | 203 ++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_prime.h |  26 +
 drivers/gpu/drm/powervr_sgx/pvrsgx_vm.c    | 799 +++++++++++++++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_vm.h    |  69 +++
 8 files changed, 1630 insertions(+)

diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_gem.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_gem.c
new file mode 100644
index 000000000..b22b819b0
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_gem.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+#include <drm/drm_gem.h>
+#include <drm/drm_prime.h>
+#include <drm/drm_vma_manager.h>
+
+#include <linux/dma-buf.h>
+#include <linux/pagemap.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+
+#include <uapi/drm/powervr_sgx_drm.h>
+
+#include "pvrsgx_drv.h"
+#include "pvrsgx_gem.h"
+
+/* The GPU has 32-bit physical addresses and a 4 GiB address space. */
+#define PVRSGX_BO_MAX_SIZE	SZ_1G
+
+/* A code object's contents are validated: no other way to reach them. */
+static struct dma_buf *pvrsgx_gem_export(struct drm_gem_object *obj, int flags)
+{
+	if (to_pvrsgx_bo(obj)->flags & DRM_POWERVR_SGX_BO_CODE)
+		return ERR_PTR(-EPERM);
+	return drm_gem_prime_export(obj, flags);
+}
+
+/* Every CPU mapping, the dma-buf's included, needs ALLOW_CPU_ACCESS. */
+static int pvrsgx_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
+{
+	if (!drm_gem_is_imported(obj) &&
+	    !(to_pvrsgx_bo(obj)->flags & DRM_POWERVR_SGX_BO_ALLOW_CPU_ACCESS))
+		return -EINVAL;
+	return drm_gem_shmem_object_mmap(obj, vma);
+}
+
+static void pvrsgx_gem_free(struct drm_gem_object *obj)
+{
+	struct pvrsgx_bo *bo = to_pvrsgx_bo(obj);
+
+	if (drm_gem_is_imported(obj) && !iosys_map_is_null(&bo->import_map))
+		dma_buf_vunmap_unlocked(obj->import_attach->dmabuf, &bo->import_map);
+	drm_gem_shmem_object_free(obj);
+}
+
+static const struct drm_gem_object_funcs pvrsgx_gem_funcs = {
+	.free = pvrsgx_gem_free,
+	.export = pvrsgx_gem_export,
+	.print_info = drm_gem_shmem_object_print_info,
+	.pin = drm_gem_shmem_object_pin,
+	.unpin = drm_gem_shmem_object_unpin,
+	.get_sg_table = drm_gem_shmem_object_get_sg_table,
+	.vmap = drm_gem_shmem_object_vmap,
+	.vunmap = drm_gem_shmem_object_vunmap,
+	.mmap = pvrsgx_gem_mmap,
+	.vm_ops = &drm_gem_shmem_vm_ops,
+};
+
+struct drm_gem_object *pvrsgx_gem_create_object(struct drm_device *drm, size_t size)
+{
+	struct pvrsgx_bo *bo = kzalloc_obj(*bo);
+
+	if (!bo)
+		return ERR_PTR(-ENOMEM);
+	bo->base.base.funcs = &pvrsgx_gem_funcs;
+	/* The GPU doesn't snoop the CPU caches. */
+	bo->base.map_wc = true;
+	return &bo->base.base;
+}
+
+int pvrsgx_ioctl_create_bo(struct drm_device *drm, void *data, struct drm_file *file)
+{
+	struct drm_powervr_sgx_ioctl_create_bo_args *args = data;
+	struct drm_gem_shmem_object *shmem;
+	int err;
+
+	if (args->_padding_c || (args->flags & ~PVRSGX_BO_FLAGS_MASK) ||
+	    !args->size || !PAGE_ALIGNED(args->size) || args->size > PVRSGX_BO_MAX_SIZE)
+		return -EINVAL;
+	if ((args->flags & DRM_POWERVR_SGX_BO_CODE) &&
+	    (args->flags & DRM_POWERVR_SGX_BO_ALLOW_CPU_ACCESS))
+		return -EINVAL;
+
+	shmem = drm_gem_shmem_create(drm, args->size);
+	if (IS_ERR(shmem))
+		return PTR_ERR(shmem);
+	to_pvrsgx_bo(&shmem->base)->flags = args->flags;
+	/* Pages the GPU can address. */
+	mapping_set_gfp_mask(shmem->base.filp->f_mapping,
+			     (GFP_HIGHUSER & ~__GFP_HIGHMEM) | __GFP_DMA32);
+
+	err = drm_gem_handle_create(file, &shmem->base, &args->handle);
+	drm_gem_object_put(&shmem->base);
+	return err;
+}
+
+int pvrsgx_ioctl_get_bo_mmap_offset(struct drm_device *drm, void *data, struct drm_file *file)
+{
+	struct drm_powervr_sgx_ioctl_get_bo_mmap_offset_args *args = data;
+	struct drm_gem_object *obj;
+	int err;
+
+	if (args->_padding_4)
+		return -EINVAL;
+
+	obj = drm_gem_object_lookup(file, args->handle);
+	if (!obj)
+		return -ENOENT;
+	if (!(to_pvrsgx_bo(obj)->flags & DRM_POWERVR_SGX_BO_ALLOW_CPU_ACCESS)) {
+		err = -EINVAL;
+		goto out;
+	}
+	err = drm_gem_create_mmap_offset(obj);
+	if (!err)
+		args->offset = drm_vma_node_offset_addr(&obj->vma_node);
+out:
+	drm_gem_object_put(obj);
+	return err;
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_gem.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_gem.h
new file mode 100644
index 000000000..5f8c4ab94
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_gem.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_GEM_H
+#define PVRSGX_GEM_H
+
+#include <drm/drm_gem_shmem_helper.h>
+
+#include <linux/atomic.h>
+#include <linux/iosys-map.h>
+#include <linux/types.h>
+
+struct drm_device;
+struct drm_file;
+
+struct pvrsgx_bo {
+	struct drm_gem_shmem_object base;
+	u64 flags;
+	/** @code_end: A code object's end of the furthest upload (under the resv lock). */
+	u64 code_end;
+	/**
+	 * @code_abs: The code has absolute targets, checked for the object's start
+	 * at @code_place instructions from its USSE heap's base (resv lock).
+	 */
+	bool code_abs;
+	s64 code_place;
+	/**
+	 * @code_unmapping: A code object's mappings that are unmapped but that the
+	 * GPU may still fetch from: the jobs before the unmap or the BIF invalidate
+	 * after it are not done. UPLOAD_CODE treats them as live mappings.
+	 */
+	atomic_t code_unmapping;
+	/** @import_map: An import's CPU mapping, from its exporter, for the cache flushes. */
+	struct iosys_map import_map;
+};
+
+static inline struct pvrsgx_bo *to_pvrsgx_bo(struct drm_gem_object *obj)
+{
+	return container_of(to_drm_gem_shmem_obj(obj), struct pvrsgx_bo, base);
+}
+
+struct drm_gem_object *pvrsgx_gem_create_object(struct drm_device *drm, size_t size);
+int pvrsgx_ioctl_create_bo(struct drm_device *drm, void *data, struct drm_file *file);
+int pvrsgx_ioctl_get_bo_mmap_offset(struct drm_device *drm, void *data, struct drm_file *file);
+
+#endif /* PVRSGX_GEM_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_kobj.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_kobj.c
new file mode 100644
index 000000000..8b21315e9
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_kobj.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * Kernel-owned objects at device-wide addresses: render contexts' and RT
+ * datasets' firmware structures, parameter buffers, free lists, region headers.
+ * The 3D parameters range (PB, free list, scratch, background block) is per VM
+ * instead: the DPM numbers PB pages from the heap base, so a second context's PB
+ * at a higher device-wide address hangs the GPU.
+ *
+ * Releasing one does not free it at once: a render already handed to the
+ * microkernel may still read it. Released objects are freed once every render
+ * submitted before the release has completed. A PB descriptor waits for the
+ * next restart instead: the microkernel remembers the last PB's address to
+ * skip reloading its free list, so a new PB at a freed one's address must not
+ * appear while it runs.
+ *
+ * Unmapping is not the end either: the BIF may hold a translation of the
+ * object's pages until it is invalidated, and the microkernel invalidates only
+ * for the cache control word of a command it takes, before it moves the read
+ * offset on. So a reaped object is unmapped, the invalidate is queued for the
+ * next command, and its pages and address are freed once the kernel CCB has
+ * consumed that command. A hardware unit's late write then faults instead of
+ * landing in a page the kernel has handed out again.
+ */
+
+#include <linux/mm.h>
+#include <linux/seq_buf.h>
+#include <linux/slab.h>
+
+#include "pvrsgx_ccb.h"
+#include "pvrsgx_kobj.h"
+#include "pvrsgx_fw.h"
+#include "pvrsgx_mmu.h"
+#include "pvrsgx_vm.h"
+
+struct krange {
+	u32 start, end, pte;
+};
+
+/* Each range in the core's layout (pvrsgx_core.c). */
+static struct krange krange(const struct pvrsgx_device *sdev, enum pvrsgx_krange r)
+{
+	const struct pvrsgx_heap_layout *h = pvrsgx_heaps(sdev);
+
+	switch (r) {
+	case PVRSGX_KRANGE_KDATA:	/* past the firmware's own arenas (pvrsgx_fw.c) */
+		return (struct krange){ h->kernel_data.base + 0x10000, h->kernel_data.end,
+					SGX_MMU_PTE_CACHECONSISTENT | SGX_MMU_PTE_EDMPROTECT };
+	case PVRSGX_KRANGE_KCODE:
+		return (struct krange){ h->kernel_code.base + 0x10000, h->kernel_code.end,
+					SGX_MMU_PTE_CACHECONSISTENT };
+	case PVRSGX_KRANGE_SYNC:
+		return (struct krange){ h->sync.base, h->sync.end, SGX_MMU_PTE_CACHECONSISTENT };
+	case PVRSGX_KRANGE_3DPARAMS:
+		return (struct krange){ h->params_3d.base, h->params_3d.end, 0 };
+	case PVRSGX_KRANGE_TADATA:
+	default:
+		return (struct krange){ h->ta_data.base, h->ta_data.end, 0 };
+	}
+}
+
+int pvrsgx_kobj_init(struct pvrsgx_device *sdev)
+{
+	mutex_init(&sdev->kobj_lock);
+	INIT_LIST_HEAD(&sdev->graveyard);
+	INIT_LIST_HEAD(&sdev->kobj_unmapped);
+	for (int r = 0; r < PVRSGX_KRANGE_COUNT; r++) {
+		struct krange kr = krange(sdev, r);
+
+		drm_mm_init(&sdev->krange[r], kr.start, kr.end - kr.start);
+	}
+	return 0;
+}
+
+struct pvrsgx_kobj *pvrsgx_kobj_create(struct pvrsgx_device *sdev, enum pvrsgx_krange range,
+				       u32 size, u32 min_addr, struct pvrsgx_vm *vm)
+{
+	struct pvrsgx_kobj *o;
+	struct krange kr = krange(sdev, range);
+	u32 start = max(min_addr, kr.start);
+	/* A 3D-params object without a VM is the device's: the PB (pvrsgx_render.c). */
+	bool per_vm = range == PVRSGX_KRANGE_3DPARAMS && vm;
+	int err;
+
+	/* Clients' ioctls create these: charge them to the caller. */
+	o = kzalloc_obj(*o, GFP_KERNEL_ACCOUNT);
+	if (!o)
+		return ERR_PTR(-ENOMEM);
+	o->range = range;
+	o->mm = per_vm ? &vm->params : &sdev->krange[range];
+	mutex_lock(&sdev->kobj_lock);
+	err = drm_mm_insert_node_in_range(o->mm, &o->node, PAGE_ALIGN(size), PAGE_SIZE,
+					  0, start, kr.end, DRM_MM_INSERT_LOW);
+	mutex_unlock(&sdev->kobj_lock);
+	if (err)
+		goto err_free;
+
+	if (per_vm)
+		o->km.mmu = vm->mmu;
+	err = pvrsgx_kmem_alloc(sdev, &o->km, o->node.start, size, kr.pte,
+				__GFP_ACCOUNT);
+	if (err)
+		goto err_node;
+	memset(o->km.cpu, 0, o->km.size);
+
+	if (per_vm) {
+		o->vm = pvrsgx_vm_get(vm);
+	} else if (vm) {
+		err = pvrsgx_mmu_map_pages(vm->mmu, o->node.start, o->km.pages, o->km.npages, 0);
+		if (err)
+			goto err_kmem;
+		o->vm = pvrsgx_vm_get(vm);
+	}
+	mutex_lock(&sdev->ccb_lock);
+	sdev->fw.cache_control |= PVRSGX_CC_INVAL_BIF_PT | PVRSGX_CC_INVAL_BIF_PD;
+	mutex_unlock(&sdev->ccb_lock);
+	return o;
+
+err_kmem:
+	pvrsgx_kmem_free(sdev, &o->km);
+err_node:
+	mutex_lock(&sdev->kobj_lock);
+	drm_mm_remove_node(&o->node);
+	mutex_unlock(&sdev->kobj_lock);
+err_free:
+	kfree(o);
+	return ERR_PTR(err);
+}
+
+static void kobj_unmap(struct pvrsgx_kobj *o)
+{
+	struct pvrsgx_vm *vm = o->vm;
+
+	if (vm && o->km.mmu != vm->mmu)
+		pvrsgx_mmu_unmap(vm->mmu, kobj_va(o), o->km.size);
+	pvrsgx_mmu_unmap(o->km.mmu, o->km.dev_addr, o->km.size);
+}
+
+/* An unmapped object, after the invalidate: nothing can reach it now. */
+static void kobj_free(struct pvrsgx_device *sdev, struct pvrsgx_kobj *o)
+{
+	struct pvrsgx_vm *vm = o->vm;
+
+	pvrsgx_kmem_release(&o->km);
+	mutex_lock(&sdev->kobj_lock);
+	drm_mm_remove_node(&o->node);
+	mutex_unlock(&sdev->kobj_lock);
+	kfree(o);
+	/* Last: the node may belong to the VM's own allocator. */
+	pvrsgx_vm_put(vm);
+}
+
+void pvrsgx_kobj_release(struct pvrsgx_device *sdev, struct pvrsgx_kobj *o)
+{
+	if (IS_ERR_OR_NULL(o))
+		return;
+	mutex_lock(&sdev->kobj_lock);
+	o->grave_seq = sdev->renders_submitted;
+	o->grave_restarts = READ_ONCE(sdev->restarts);
+	list_add_tail(&o->grave, &sdev->graveyard);
+	mutex_unlock(&sdev->kobj_lock);
+}
+
+/*
+ * Unmap what was released before a render that has now finished, and free
+ * what was unmapped before a command the microkernel has since taken.
+ * renders_done U64_MAX (unbind, the GPU stopped) frees everything at once.
+ */
+void pvrsgx_kobj_reap(struct pvrsgx_device *sdev, u64 renders_done)
+{
+	struct pvrsgx_kobj *o, *tmp;
+	bool all = renders_done == U64_MAX;
+	u32 restarts = READ_ONCE(sdev->restarts);
+	u64 seq = 0, consumed;
+	LIST_HEAD(dead);
+
+	mutex_lock(&sdev->kobj_lock);
+	list_for_each_entry_safe(o, tmp, &sdev->graveyard, grave) {
+		/* A restart forgets everything the old run pointed at. */
+		if (all || o->grave_restarts != restarts ||
+		    (o->grave_seq < renders_done && !o->until_restart))
+			list_move_tail(&o->grave, &dead);
+	}
+	mutex_unlock(&sdev->kobj_lock);
+
+	if (!list_empty(&dead)) {
+		list_for_each_entry(o, &dead, grave)
+			kobj_unmap(o);
+		/* The next command carries the invalidate. */
+		mutex_lock(&sdev->ccb_lock);
+		sdev->fw.cache_control |= PVRSGX_CC_INVAL_BIF_PT | PVRSGX_CC_INVAL_BIF_PD;
+		seq = sdev->ccb_issued + 1;
+		mutex_unlock(&sdev->ccb_lock);
+	}
+
+	mutex_lock(&sdev->kobj_lock);
+	list_for_each_entry(o, &dead, grave)
+		o->flush_seq = seq;
+	list_splice_tail_init(&dead, &sdev->kobj_unmapped);
+	/*
+	 * After a restart the ring starts over empty, so everything sent before it
+	 * counts as consumed: the GPU was reset, and the first command after the
+	 * microkernel's start carries an invalidate of its own.
+	 */
+	consumed = all ? U64_MAX : pvrsgx_ccb_consumed(sdev);
+	list_for_each_entry_safe(o, tmp, &sdev->kobj_unmapped, grave) {
+		if (o->flush_seq <= consumed)
+			list_move_tail(&o->grave, &dead);
+	}
+	mutex_unlock(&sdev->kobj_lock);
+	list_for_each_entry_safe(o, tmp, &dead, grave)
+		kobj_free(sdev, o);
+}
+
+void pvrsgx_kobj_fini(struct pvrsgx_device *sdev)
+{
+	/*
+	 * Freeing can release more: a VM's last object frees the VM, which
+	 * drops its PB reference, and the PB's objects join the graveyard.
+	 */
+	for (;;) {
+		bool empty;
+
+		mutex_lock(&sdev->kobj_lock);
+		empty = list_empty(&sdev->graveyard) && list_empty(&sdev->kobj_unmapped);
+		mutex_unlock(&sdev->kobj_lock);
+		if (empty)
+			break;
+		pvrsgx_kobj_reap(sdev, U64_MAX);
+	}
+	for (int r = 0; r < PVRSGX_KRANGE_COUNT; r++)
+		drm_mm_takedown(&sdev->krange[r]);
+	mutex_destroy(&sdev->kobj_lock);
+}
+
+/* For status dumps: what waits to be freed. Never sleeps: false if busy. */
+bool pvrsgx_kobj_pending(struct pvrsgx_device *sdev, struct pvrsgx_kobj_counts *c)
+{
+	struct pvrsgx_kobj *o;
+
+	if (!mutex_trylock(&sdev->kobj_lock))
+		return false;
+	memset(c, 0, sizeof(*c));
+	list_for_each_entry(o, &sdev->graveyard, grave) {
+		c->graveyard++;
+		c->graveyard_pages += o->km.npages;
+	}
+	list_for_each_entry(o, &sdev->kobj_unmapped, grave) {
+		c->unmapped++;
+		c->unmapped_pages += o->km.npages;
+	}
+	mutex_unlock(&sdev->kobj_lock);
+	return true;
+}
+
+void pvrsgx_kobj_drop(struct pvrsgx_device *sdev, struct pvrsgx_kobj **o)
+{
+	pvrsgx_kobj_release(sdev, *o);
+	*o = NULL;
+}
+
+/* A kernel object into *dst, which stays NULL on failure. */
+int pvrsgx_kobj_new(struct pvrsgx_device *sdev, struct pvrsgx_kobj **dst,
+		    enum pvrsgx_krange range, u32 size, u32 min, struct pvrsgx_vm *vm)
+{
+	struct pvrsgx_kobj *o = pvrsgx_kobj_create(sdev, range, size, min, vm);
+
+	if (IS_ERR(o))
+		return PTR_ERR(o);
+	*dst = o;
+	return 0;
+}
+
+void pvrsgx_kobj_dump(struct seq_buf *sb, const char *name, struct pvrsgx_kobj *o, u32 off,
+		      u32 bytes)
+{
+	const u32 *w = (const u32 *)((const u8 *)kobj_cpu(o) + off);
+
+	seq_buf_printf(sb, "%s @ 0x%08x:", name, kobj_va(o) + off);
+	for (u32 i = 0; i < bytes / 4; i++)
+		seq_buf_printf(sb, "%s%08x", i % 8 ? " " : "\n  ", READ_ONCE(w[i]));
+	seq_buf_puts(sb, "\n");
+}
+
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_kobj.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_kobj.h
new file mode 100644
index 000000000..8af216e66
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_kobj.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_KOBJ_H
+#define PVRSGX_KOBJ_H
+
+#include <drm/drm_mm.h>
+
+#include <linux/list.h>
+#include <linux/types.h>
+
+#include "pvrsgx_device.h"
+
+struct pvrsgx_vm;
+
+/**
+ * struct pvrsgx_kobj - A kernel-owned object the firmware or the TA/3D reads
+ *
+ * Its address is unique across the device and the firmware's directory maps it,
+ * and a VM also maps the ones the TA and 3D use under its directory. The 3D
+ * parameters range is the exception: per VM, from the heap base, mapped only in
+ * that VM's directory. A client can never map anything in these ranges
+ * itself.
+ */
+struct pvrsgx_kobj {
+	/** @km: Its memory. */
+	struct pvrsgx_kmem km;
+	/** @node: Its place in @mm. */
+	struct drm_mm_node node;
+	/** @mm: The range allocator @node came from. */
+	struct drm_mm *mm;
+	/** @range: The range it was allocated in. */
+	enum pvrsgx_krange range;
+	/** @vm: Also mapped in this VM's directory, or NULL. */
+	struct pvrsgx_vm *vm;
+	/** @until_restart: Once released, kept until the next microkernel start. */
+	bool until_restart;
+	/** @grave: In pvrsgx_device.graveyard once released. */
+	struct list_head grave;
+	/** @grave_seq: pvrsgx_device.renders_submitted when it was released. */
+	u64 grave_seq;
+	/** @flush_seq: Once unmapped, the kernel CCB command whose cache control frees it. */
+	u64 flush_seq;
+	/** @grave_restarts: pvrsgx_device.restarts when it was released. */
+	u32 grave_restarts;
+};
+
+static inline u32 *kobj_cpu(struct pvrsgx_kobj *o)
+{
+	return o->km.cpu;
+}
+
+static inline u32 kobj_va(struct pvrsgx_kobj *o)
+{
+	return o->km.dev_addr;
+}
+
+int pvrsgx_kobj_init(struct pvrsgx_device *sdev);
+void pvrsgx_kobj_fini(struct pvrsgx_device *sdev);
+struct pvrsgx_kobj *pvrsgx_kobj_create(struct pvrsgx_device *sdev, enum pvrsgx_krange range,
+				       u32 size, u32 min_addr, struct pvrsgx_vm *vm);
+void pvrsgx_kobj_release(struct pvrsgx_device *sdev, struct pvrsgx_kobj *o);
+void pvrsgx_kobj_reap(struct pvrsgx_device *sdev, u64 renders_done);
+
+/* Objects and pages waiting in the graveyard, and unmapped ones waiting for the invalidate. */
+struct pvrsgx_kobj_counts {
+	u32 graveyard, unmapped;
+	u64 graveyard_pages, unmapped_pages;
+};
+
+bool pvrsgx_kobj_pending(struct pvrsgx_device *sdev, struct pvrsgx_kobj_counts *c);
+
+struct seq_buf;
+struct pvrsgx_vm;
+
+int pvrsgx_kobj_new(struct pvrsgx_device *sdev, struct pvrsgx_kobj **dst,
+		    enum pvrsgx_krange range, u32 size, u32 min, struct pvrsgx_vm *vm);
+void pvrsgx_kobj_drop(struct pvrsgx_device *sdev, struct pvrsgx_kobj **o);
+void pvrsgx_kobj_dump(struct seq_buf *sb, const char *name, struct pvrsgx_kobj *o, u32 off,
+		      u32 bytes);
+
+#endif /* PVRSGX_KOBJ_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.c
new file mode 100644
index 000000000..e6aca1145
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * Buffers imported from other devices. The GPU doesn't snoop the CPU caches
+ * and can only reach the low 4 GiB, so an import needs a reachability check
+ * when it is mapped, and cache flushes of the bytes each job lists
+ * (&drm_powervr_sgx_job.cache_ranges) around it.
+ */
+
+#include <drm/drm_cache.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem_shmem_helper.h>
+
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/ktime.h>
+#include <linux/overflow.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+
+#include <uapi/drm/powervr_sgx_drm.h>
+
+#include "pvrsgx_drv.h"
+#include "pvrsgx_gem.h"
+#include "pvrsgx_job.h"
+#include "pvrsgx_prime.h"
+#include "pvrsgx_trace.h"
+
+/*
+ * The GPU's MMU takes 32-bit addresses. An import was mapped for our device,
+ * whose DMA mask is 32 bits, so the DMA API already keeps every address below
+ * 4 GiB (bouncing if it must, synced through the dma-buf's CPU access calls);
+ * check the addresses only, never the exporter's pages.
+ */
+bool pvrsgx_prime_reachable(struct sg_table *sgt)
+{
+	struct scatterlist *sg;
+	unsigned int i;
+
+	for_each_sgtable_dma_sg(sgt, sg, i) {
+		if (upper_32_bits(sg_dma_address(sg) + sg_dma_len(sg) - 1))
+			return false;
+	}
+	return true;
+}
+
+#define PVRSGX_MAX_CACHE_RANGES	64
+
+#define CACHE_RANGE_FLAGS	(DRM_POWERVR_SGX_CACHE_RANGE_FLAG_READ | \
+				 DRM_POWERVR_SGX_CACHE_RANGE_FLAG_WRITE)
+
+/* A range's flags, and its rows inside an object of obj_size bytes. */
+static int cache_range_check(const struct drm_powervr_sgx_cache_range *r, u64 obj_size)
+{
+	u32 rows = max(r->rows, 1u);
+	u64 span, end;
+
+	if (!r->flags || (r->flags & ~CACHE_RANGE_FLAGS) || !r->size)
+		return -EINVAL;
+	if (rows > 1 && r->stride < r->size)
+		return -EINVAL;
+	if (check_mul_overflow((u64)(rows - 1), (u64)r->stride, &span) ||
+	    check_add_overflow(span, r->size, &span) ||
+	    check_add_overflow(r->offset, span, &end) || end > obj_size)
+		return -EINVAL;
+	return 0;
+}
+
+/* The job's cache ranges, checked, each holding a reference on its object. */
+int pvrsgx_prime_ranges(struct drm_file *file, const struct drm_powervr_sgx_obj_array *arr,
+			struct pvrsgx_job *job)
+{
+	struct drm_powervr_sgx_cache_range *in;
+	int err = 0;
+
+	in = pvrsgx_obj_array_get(arr, sizeof(*in), PVRSGX_MAX_CACHE_RANGES);
+	if (IS_ERR_OR_NULL(in))
+		return PTR_ERR_OR_ZERO(in);
+	job->ranges = kvcalloc(arr->count, sizeof(*job->ranges), GFP_KERNEL);
+	if (!job->ranges) {
+		err = -ENOMEM;
+		goto out;
+	}
+	for (u32 i = 0; i < arr->count; i++) {
+		struct pvrsgx_cache_range *r = &job->ranges[i];
+
+		r->obj = drm_gem_object_lookup(file, in[i].handle);
+		if (!r->obj) {
+			err = -ENOENT;
+			break;
+		}
+		job->nranges++;
+		err = cache_range_check(&in[i], r->obj->size);
+		if (err)
+			break;
+		/*
+		 * Our own objects are write-combined: nothing to flush. A re-imported
+		 * dma-buf of ours comes back as such an object, so it isn't refused.
+		 */
+		r->import = drm_gem_is_imported(r->obj);
+		r->offset = in[i].offset;
+		r->size = in[i].size;
+		r->stride = in[i].stride;
+		r->rows = max(in[i].rows, 1u);
+		r->write = in[i].flags & DRM_POWERVR_SGX_CACHE_RANGE_FLAG_WRITE;
+	}
+out:
+	kvfree(in);
+	return err;
+}
+
+/*
+ * The GPU's accesses don't snoop the CPU caches, not even through
+ * cache-consistent PTEs. Our own objects are write-combined on the CPU; an
+ * import may be cached. Before a job every range it lists is written back and
+ * dropped (the GPU reads what the CPU wrote, no dirty line lands on its output
+ * later), and after it the ranges it wrote are dropped again (no stale line
+ * hides its output). An importer may not touch the attachment's pages, so the
+ * flushes go through the exporter's own CPU mapping, taken at import.
+ */
+static u64 range_flush(const struct pvrsgx_cache_range *r)
+{
+	const struct iosys_map *map = &to_pvrsgx_bo(r->obj)->import_map;
+
+	/* I/O memory isn't cached. */
+	if (!r->import || map->is_iomem)
+		return 0;
+	if (r->rows == 1 || r->stride == r->size) {
+		drm_clflush_virt_range(map->vaddr + r->offset, r->size * r->rows);
+	} else {
+		for (u32 y = 0; y < r->rows; y++)
+			drm_clflush_virt_range(map->vaddr + r->offset + (u64)y * r->stride,
+					       r->size);
+	}
+	return r->size * r->rows;
+}
+
+/* The whole of an import, at import. */
+static void import_flush(struct drm_gem_object *obj)
+{
+	const struct iosys_map *map = &to_pvrsgx_bo(obj)->import_map;
+
+	if (!map->is_iomem)
+		drm_clflush_virt_range(map->vaddr, obj->size);
+}
+
+void pvrsgx_prime_flush(struct pvrsgx_job *job, bool after)
+{
+	u64 t0 = trace_pvrsgx_flush_imports_enabled() ? ktime_get_ns() : 0, bytes = 0;
+
+	for (u32 i = 0; i < job->nranges; i++) {
+		if (!after || job->ranges[i].write)
+			bytes += range_flush(&job->ranges[i]);
+	}
+	if (job->nranges)
+		trace_pvrsgx_flush_imports(job->hw_fence ? job->hw_fence->seqno : 0,
+					   job->nranges, bytes,
+					   t0 ? ktime_get_ns() - t0 : 0, after);
+}
+
+struct drm_gem_object *pvrsgx_prime_import_sg_table(struct drm_device *drm,
+						    struct dma_buf_attachment *attach,
+						    struct sg_table *sgt)
+{
+	struct drm_gem_object *obj;
+	struct iosys_map map;
+	int err;
+
+	/* An import's flushes are CPU cache flushes of its vmap, which only x86 has here. */
+	if (!IS_ENABLED(CONFIG_X86))
+		return ERR_PTR(-EOPNOTSUPP);
+	/*
+	 * The exporter's mapping is taken once here and kept for the import's
+	 * life. A job's cache ranges are flushed through it in run_job and at
+	 * completion, inside the fence-signaling path, where a vmap can't be
+	 * taken: it may sleep and allocate. The importer never touches the
+	 * attachment's pages.
+	 */
+	err = dma_buf_vmap_unlocked(attach->dmabuf, &map);
+	if (err)
+		return ERR_PTR(err);
+	obj = drm_gem_shmem_prime_import_sg_table(drm, attach, sgt);
+	if (IS_ERR(obj)) {
+		dma_buf_vunmap_unlocked(attach->dmabuf, &map);
+		return obj;
+	}
+	to_pvrsgx_bo(obj)->import_map = map;
+	/*
+	 * Only the bytes a job lists are flushed around it: what the CPU still
+	 * holds of the rest (its zeroing, say) reaches memory now, or the GPU
+	 * could see the pages' earlier contents.
+	 */
+	import_flush(obj);
+	return obj;
+}
+
+void pvrsgx_prime_put(struct pvrsgx_job *job)
+{
+	for (u32 i = 0; i < job->nranges; i++)
+		drm_gem_object_put(job->ranges[i].obj);
+	kvfree(job->ranges);
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.h
new file mode 100644
index 000000000..dd0332f34
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_PRIME_H
+#define PVRSGX_PRIME_H
+
+#include <linux/types.h>
+
+struct dma_buf_attachment;
+struct drm_device;
+struct drm_file;
+struct drm_gem_object;
+struct drm_powervr_sgx_obj_array;
+struct pvrsgx_job;
+struct sg_table;
+
+bool pvrsgx_prime_reachable(struct sg_table *sgt);
+struct drm_gem_object *pvrsgx_prime_import_sg_table(struct drm_device *drm,
+						    struct dma_buf_attachment *attach,
+						    struct sg_table *sgt);
+int pvrsgx_prime_ranges(struct drm_file *file, const struct drm_powervr_sgx_obj_array *arr,
+			struct pvrsgx_job *job);
+void pvrsgx_prime_flush(struct pvrsgx_job *job, bool after);
+void pvrsgx_prime_put(struct pvrsgx_job *job);
+
+#endif /* PVRSGX_PRIME_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_vm.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_vm.c
new file mode 100644
index 000000000..b12d39062
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_vm.c
@@ -0,0 +1,799 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * VM contexts on drm_gpuvm. The client picks every address inside the heaps
+ * DEV_QUERY reports. VM_BIND maps and unmaps through drm_gpuvm's split and
+ * merge steps; an unmap takes the page tables down at once and lets go of the
+ * objects once every job submitted before it is done, from a fence callback.
+ */
+
+#include <drm/drm_drv.h>
+#include <drm/drm_exec.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_print.h>
+#include <drm/drm_syncobj.h>
+
+#include <linux/device.h>
+#include <linux/dma-resv.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <uapi/drm/powervr_sgx_drm.h>
+
+#include "pvrsgx_ccb.h"
+#include "pvrsgx_device.h"
+#include "pvrsgx_drv.h"
+#include "pvrsgx_fw.h"
+#include "pvrsgx_gem.h"
+#include "pvrsgx_job.h"
+#include "pvrsgx_mmu.h"
+#include "pvrsgx_render.h"
+#include "pvrsgx_validate.h"
+#include "pvrsgx_prime.h"
+#include "pvrsgx_vm.h"
+
+/* The client heaps, the same in every VM, from the core's layout. */
+static void client_heaps(const struct pvrsgx_device *sdev,
+			 struct drm_powervr_sgx_heap heaps[DRM_POWERVR_SGX_HEAP_COUNT])
+{
+	const struct pvrsgx_heap_layout *h = pvrsgx_heaps(sdev);
+	const struct {
+		const struct pvrsgx_va_range *r;
+		u32 usse_base_index;
+	} from[DRM_POWERVR_SGX_HEAP_COUNT] = {
+		[DRM_POWERVR_SGX_HEAP_GENERAL] = { &h->general },
+		[DRM_POWERVR_SGX_HEAP_PDS_PIXEL] = { &h->pds_pixel },
+		[DRM_POWERVR_SGX_HEAP_PDS_VERTEX] = { &h->pds_vertex },
+		[DRM_POWERVR_SGX_HEAP_USSE_PIXEL] = { &h->usse_pixel,
+						      PVRSGX_USSE_PIXEL_BASE_INDEX },
+		[DRM_POWERVR_SGX_HEAP_USSE_VERTEX] = { &h->usse_vertex,
+						       PVRSGX_USSE_VERTEX_BASE_INDEX },
+		[DRM_POWERVR_SGX_HEAP_TEXTURE] = { &h->texture },
+	};
+
+	for (int i = 0; i < DRM_POWERVR_SGX_HEAP_COUNT; i++) {
+		bool usse = i == DRM_POWERVR_SGX_HEAP_USSE_PIXEL ||
+			    i == DRM_POWERVR_SGX_HEAP_USSE_VERTEX;
+
+		heaps[i] = (struct drm_powervr_sgx_heap){
+			.base = from[i].r->base,
+			.size = from[i].r->end - from[i].r->base,
+			.page_size_log2 = SGX_MMU_PAGE_SHIFT,
+			.usse_base_index = from[i].usse_base_index,
+			.usse_window_log2 = usse ? PVRSGX_USSE_WINDOW_LOG2 : 0,
+		};
+	}
+}
+
+/* The heap holding all of [addr, addr + size), or -1. */
+int pvrsgx_heap_find(const struct pvrsgx_device *sdev, u64 addr, u64 size)
+{
+	struct drm_powervr_sgx_heap heaps[DRM_POWERVR_SGX_HEAP_COUNT];
+	u64 end;
+
+	if (check_add_overflow(addr, size, &end))
+		return -1;
+	client_heaps(sdev, heaps);
+	for (int i = 0; i < ARRAY_SIZE(heaps); i++) {
+		if (addr >= heaps[i].base && end <= heaps[i].base + heaps[i].size)
+			return i;
+	}
+	return -1;
+}
+
+int pvrsgx_query_heap_info(struct pvrsgx_device *sdev, void __user *ptr, u32 *size)
+{
+	struct drm_powervr_sgx_heap heaps[DRM_POWERVR_SGX_HEAP_COUNT];
+	struct drm_powervr_sgx_dev_query_heap_info info = {};
+	int err;
+
+	if (!ptr) {
+		*size = sizeof(info);
+		return 0;
+	}
+	err = copy_struct_from_user(&info, sizeof(info), ptr, *size);
+	if (err)
+		return err;
+
+	client_heaps(sdev, heaps);
+	if (info.heaps.array) {
+		err = pvrsgx_obj_array_put(&info.heaps, heaps, sizeof(heaps[0]), ARRAY_SIZE(heaps));
+		if (err)
+			return err;
+	}
+	info.heaps.stride = sizeof(heaps[0]);
+	info.heaps.count = ARRAY_SIZE(heaps);
+
+	*size = min_t(u32, *size, sizeof(info));
+	return copy_to_user(ptr, &info, *size) ? -EFAULT : 0;
+}
+
+struct pvrsgx_vm *pvrsgx_vm_get(struct pvrsgx_vm *vm)
+{
+	kref_get(&vm->ref);
+	return vm;
+}
+
+struct dma_resv *pvrsgx_vm_resv(struct pvrsgx_vm *vm)
+{
+	return drm_gpuvm_resv(&vm->gpuvm);
+}
+
+static const struct drm_gpuvm_ops pvrsgx_gpuvm_ops;
+
+/* A mapping. Once unmapped, it keeps its object until the jobs before the unmap are done. */
+struct pvrsgx_va {
+	struct drm_gpuva base;
+	struct drm_gem_object *obj;
+	struct list_head free_link;
+};
+
+static struct pvrsgx_va *to_pvrsgx_va(struct drm_gpuva *va)
+{
+	return container_of(va, struct pvrsgx_va, base);
+}
+
+/*
+ * What an unmap or a teardown lets go of once every job on the VM so far is
+ * done. A teardown also takes the mappings down then.
+ */
+struct pvrsgx_vm_free {
+	struct dma_fence_cb cb;
+	struct work_struct work;
+	struct pvrsgx_inval_wait inval;
+	struct drm_device *drm;
+	struct dma_fence *fence;
+	struct list_head vas;
+	struct pvrsgx_vm *vm;
+	bool teardown;
+};
+
+/* The BIF may hold walks of what changed: the next command drops them. */
+static void vm_invalidate(struct pvrsgx_device *sdev, bool data)
+{
+	mutex_lock(&sdev->ccb_lock);
+	sdev->fw.cache_control |= PVRSGX_CC_INVAL_BIF_PT | PVRSGX_CC_INVAL_BIF_PD |
+				  (data ? PVRSGX_CC_INVAL_DATA : 0);
+	mutex_unlock(&sdev->ccb_lock);
+}
+
+/* A code object counts its unmapped mappings until vas_free() (pvrsgx_bo.code_unmapping). */
+static bool va_obj_is_code(struct pvrsgx_va *v)
+{
+	return to_pvrsgx_bo(v->obj)->flags & DRM_POWERVR_SGX_BO_CODE;
+}
+
+/* Unlink a removed mapping from its object, keeping a reference on freed. */
+static void va_unlink_locked(struct drm_gpuva *va, struct list_head *freed)
+{
+	struct pvrsgx_va *v = to_pvrsgx_va(va);
+
+	v->obj = va->gem.obj;
+	drm_gem_object_get(v->obj);
+	if (va_obj_is_code(v))
+		atomic_inc(&to_pvrsgx_bo(v->obj)->code_unmapping);
+	drm_gpuva_unlink(va);
+	list_add_tail(&v->free_link, freed);
+}
+
+static void vas_free(struct list_head *list)
+{
+	struct pvrsgx_va *v, *tmp;
+
+	list_for_each_entry_safe(v, tmp, list, free_link) {
+		list_del(&v->free_link);
+		if (va_obj_is_code(v))
+			atomic_dec(&to_pvrsgx_bo(v->obj)->code_unmapping);
+		drm_gem_object_put(v->obj);
+		kfree(v);
+	}
+}
+
+/* Every mapping down, onto freed. Nothing may submit to the VM any more. */
+static void vm_unmap_all(struct pvrsgx_vm *vm, struct list_head *freed)
+{
+	struct drm_gpuva *va, *next;
+
+	drm_gpuvm_for_each_va_safe(va, next, &vm->gpuvm) {
+		struct drm_gem_object *obj = va->gem.obj;
+
+		pvrsgx_mmu_unmap(vm->mmu, va->va.addr, va->va.range);
+		drm_gpuva_remove(va);
+		dma_resv_lock(obj->resv, NULL);
+		va_unlink_locked(va, freed);
+		dma_resv_unlock(obj->resv);
+	}
+}
+
+/* The invalidate has run: nothing can reach the unmapped pages any more. */
+static void vm_free_done(struct pvrsgx_inval_wait *w)
+{
+	struct pvrsgx_vm_free *f = container_of(w, struct pvrsgx_vm_free, inval);
+
+	vas_free(&f->vas);
+	pvrsgx_vm_put(f->vm);
+	dma_fence_put(f->fence);
+	drm_dev_put(f->drm);
+	kfree(f);
+}
+
+static void vm_free_work(struct work_struct *work)
+{
+	struct pvrsgx_vm_free *f = container_of(work, struct pvrsgx_vm_free, work);
+	struct pvrsgx_device *sdev = to_pvrsgx_device(f->drm);
+
+	f->inval.done = vm_free_done;
+	if (f->teardown) {
+		mutex_lock(&f->vm->lock);
+		vm_unmap_all(f->vm, &f->vas);
+		mutex_unlock(&f->vm->lock);
+	}
+	/*
+	 * The BIF caches walks only of a directory a job ran on, and a restart or
+	 * power-off drops them: then there is nothing to wait for.
+	 */
+	if (!READ_ONCE(sdev->powered) ||
+	    READ_ONCE(f->vm->ran_gen) != READ_ONCE(sdev->fw_gen) + 1) {
+		vm_free_done(&f->inval);
+		return;
+	}
+	pvrsgx_ccb_after_invalidate(sdev, &f->inval, PVRSGX_CC_INVAL_BIF_PT |
+				    PVRSGX_CC_INVAL_BIF_PD | PVRSGX_CC_INVAL_DATA);
+}
+
+static void vm_free_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
+{
+	struct pvrsgx_vm_free *f = container_of(cb, struct pvrsgx_vm_free, cb);
+
+	queue_work(system_dfl_wq, &f->work);
+}
+
+/*
+ * Run f once every job submitted to vm so far is done, without waiting for
+ * them. With none left, at once if now is set (the caller holds no VM lock).
+ */
+static void vm_free_after_jobs(struct pvrsgx_vm *vm, struct pvrsgx_vm_free *f, bool now)
+{
+	struct dma_fence *fence = NULL;
+
+	f->drm = &vm->sdev->base;
+	drm_dev_get(f->drm);
+	f->vm = pvrsgx_vm_get(vm);
+	INIT_WORK(&f->work, vm_free_work);
+	if (dma_resv_get_singleton(pvrsgx_vm_resv(vm), DMA_RESV_USAGE_BOOKKEEP, &fence)) {
+		/* No memory for a fence array: wait here instead. */
+		dma_resv_wait_timeout(pvrsgx_vm_resv(vm), DMA_RESV_USAGE_BOOKKEEP, false,
+				      MAX_SCHEDULE_TIMEOUT);
+		fence = NULL;
+	}
+	f->fence = fence;
+	if (fence && !dma_fence_add_callback(fence, &f->cb, vm_free_cb))
+		return;
+	if (now)
+		vm_free_work(&f->work);
+	else
+		queue_work(system_dfl_wq, &f->work);
+}
+
+static struct pvrsgx_vm_free *vm_free_alloc(void)
+{
+	struct pvrsgx_vm_free *f = kzalloc_obj(*f);
+
+	if (f)
+		INIT_LIST_HEAD(&f->vas);
+	return f;
+}
+
+/*
+ * On a single-context core the microkernel puts list 0 back on the firmware's
+ * directory when it raises its interrupt, which can come after a job's
+ * completion shows. Before a VM's directory is freed, list 0 must not hold it.
+ * A suspended core holds nothing: the next start's reset sets list 0.
+ */
+static void vm_pd_unload(struct pvrsgx_device *sdev, struct pvrsgx_mmu *mmu)
+{
+	struct device *dev = sdev->base.dev;
+	u32 pd = pvrsgx_mmu_pd_addr(mmu);
+
+	if (!pvrsgx_core_single_context(sdev->family))
+		return;
+	if (IS_ENABLED(CONFIG_PM) && pm_runtime_get_if_active(dev) <= 0)
+		return;
+	if (READ_ONCE(sdev->powered) && sgx_rd(sdev, SGX_CR_BIF_DIR_LIST_BASE0) == pd) {
+		drm_dbg_driver(&sdev->base, "list 0 still on a released VM's directory\n");
+		sgx_wr(sdev, SGX_CR_BIF_DIR_LIST_BASE0, pvrsgx_mmu_pd_addr(sdev->kernel_mmu));
+	}
+	if (IS_ENABLED(CONFIG_PM))
+		pm_runtime_put(dev);
+}
+
+static void vm_release(struct kref *ref)
+{
+	struct pvrsgx_vm *vm = container_of(ref, struct pvrsgx_vm, ref);
+	LIST_HEAD(freed);
+
+	/* No job holds this VM any more, so nothing on the GPU uses it. */
+	vm_unmap_all(vm, &freed);
+	vas_free(&freed);
+	if (vm->pb)
+		pvrsgx_pb_unmap(vm);
+	drm_mm_takedown(&vm->params);
+	if (vm->pd_slot)
+		pvrsgx_fw_pd_slot_put(vm->sdev, vm->pd_slot);
+	vm_pd_unload(vm->sdev, vm->mmu);
+	pvrsgx_mmu_destroy(vm->mmu);
+	/* The directory and its pages may come back as another VM's. */
+	mutex_lock(&vm->sdev->ccb_lock);
+	vm->sdev->fw.cache_control |= PVRSGX_CC_INVAL_BIF_PT | PVRSGX_CC_INVAL_BIF_PD |
+				      PVRSGX_CC_INVAL_DATA;
+	mutex_unlock(&vm->sdev->ccb_lock);
+	mutex_destroy(&vm->lock);
+	drm_gpuvm_put(&vm->gpuvm);
+}
+
+void pvrsgx_vm_put(struct pvrsgx_vm *vm)
+{
+	if (vm)
+		kref_put(&vm->ref, vm_release);
+}
+
+void pvrsgx_vm_user_get(struct pvrsgx_vm *vm)
+{
+	atomic_inc(&vm->users);
+}
+
+/*
+ * The handle or a context is gone. With neither left, nothing can submit to
+ * the VM again: once its jobs are done, unmap and release every object. The
+ * VM itself can live on much longer, held by its contexts' kernel objects
+ * until a later render (pvrsgx_kobj.c), but the client's memory goes then.
+ */
+void pvrsgx_vm_user_put(struct pvrsgx_vm *vm)
+{
+	struct pvrsgx_vm_free *f;
+	LIST_HEAD(freed);
+
+	if (!atomic_dec_and_test(&vm->users))
+		return;
+
+	f = vm_free_alloc();
+	if (f) {
+		f->teardown = true;
+		vm_free_after_jobs(vm, f, false);
+		return;
+	}
+	/*
+	 * No memory to defer it: wait for the jobs here. The pages then go before
+	 * the invalidate has run; nothing of this VM can run again, and the next
+	 * scene's directory switch invalidates before any translation.
+	 */
+	dma_resv_wait_timeout(pvrsgx_vm_resv(vm), DMA_RESV_USAGE_BOOKKEEP, false,
+			      MAX_SCHEDULE_TIMEOUT);
+	mutex_lock(&vm->lock);
+	vm_unmap_all(vm, &freed);
+	mutex_unlock(&vm->lock);
+	vm_invalidate(vm->sdev, true);
+	vas_free(&freed);
+}
+
+struct pvrsgx_vm *pvrsgx_vm_create(struct pvrsgx_device *sdev)
+{
+	struct drm_gem_object *r_obj;
+	struct pvrsgx_vm *vm;
+
+	vm = kzalloc_obj(*vm);
+	if (!vm)
+		return ERR_PTR(-ENOMEM);
+	vm->mmu = pvrsgx_mmu_create(sdev);
+	if (IS_ERR(vm->mmu)) {
+		struct pvrsgx_mmu *mmu = vm->mmu;
+
+		kfree(vm);
+		return ERR_CAST(mmu);
+	}
+	r_obj = drm_gpuvm_resv_object_alloc(&sdev->base);
+	if (!r_obj) {
+		pvrsgx_mmu_destroy(vm->mmu);
+		kfree(vm);
+		return ERR_PTR(-ENOMEM);
+	}
+	if (pvrsgx_core_single_context(sdev->family)) {
+		pvrsgx_share_fw_heaps(sdev, vm->mmu);
+		vm->pd_slot = pvrsgx_fw_pd_slot_get(sdev, pvrsgx_mmu_pd_addr(vm->mmu));
+		if (vm->pd_slot < 0) {
+			int err = vm->pd_slot;
+
+			drm_gem_object_put(r_obj);
+			pvrsgx_mmu_destroy(vm->mmu);
+			kfree(vm);
+			return ERR_PTR(err);
+		}
+	}
+	drm_gpuvm_init(&vm->gpuvm, "powervr_sgx", 0, &sdev->base, r_obj,
+		       0, BIT_ULL(sdev->family->va_bits), 0, 0, &pvrsgx_gpuvm_ops);
+	drm_gem_object_put(r_obj);
+	vm->sdev = sdev;
+	drm_mm_init(&vm->params, pvrsgx_heaps(sdev)->params_3d.base,
+		    pvrsgx_heaps(sdev)->params_3d.end - pvrsgx_heaps(sdev)->params_3d.base);
+	mutex_init(&vm->lock);
+	kref_init(&vm->ref);
+	atomic_set(&vm->users, 1);
+	return vm;
+}
+
+/*
+ * What a HW context's directory word holds: the directory's address, or on a
+ * single-context core its slot in the microkernel's PD table.
+ */
+u32 pvrsgx_vm_pd_word(const struct pvrsgx_vm *vm)
+{
+	return vm->pd_slot ?: pvrsgx_mmu_pd_addr(vm->mmu);
+}
+
+struct pvrsgx_vm *pvrsgx_vm_lookup(struct pvrsgx_file *sfile, u32 handle)
+{
+	struct pvrsgx_vm *vm;
+
+	xa_lock(&sfile->vms);
+	vm = xa_load(&sfile->vms, handle);
+	if (vm)
+		pvrsgx_vm_get(vm);
+	xa_unlock(&sfile->vms);
+	return vm;
+}
+
+void pvrsgx_vm_destroy_all(struct pvrsgx_file *sfile)
+{
+	struct pvrsgx_vm *vm;
+	unsigned long handle;
+
+	xa_for_each(&sfile->vms, handle, vm) {
+		xa_erase(&sfile->vms, handle);
+		pvrsgx_vm_user_put(vm);
+		pvrsgx_vm_put(vm);
+	}
+}
+
+int pvrsgx_ioctl_create_vm_context(struct drm_device *drm, void *data, struct drm_file *file)
+{
+	struct drm_powervr_sgx_ioctl_create_vm_context_args *args = data;
+	struct pvrsgx_file *sfile = to_pvrsgx_file(file);
+	struct pvrsgx_vm *vm;
+	int err;
+
+	if (args->_padding_4)
+		return -EINVAL;
+
+	vm = pvrsgx_vm_create(to_pvrsgx_device(drm));
+	if (IS_ERR(vm))
+		return PTR_ERR(vm);
+	err = xa_alloc(&sfile->vms, &args->handle, vm, xa_limit_32b, GFP_KERNEL);
+	if (err)
+		pvrsgx_vm_put(vm);
+	return err;
+}
+
+int pvrsgx_ioctl_destroy_vm_context(struct drm_device *drm, void *data, struct drm_file *file)
+{
+	struct drm_powervr_sgx_ioctl_destroy_vm_context_args *args = data;
+	struct pvrsgx_vm *vm;
+
+	if (args->_padding_4)
+		return -EINVAL;
+
+	vm = xa_erase(&to_pvrsgx_file(file)->vms, args->handle);
+	if (!vm)
+		return -ENOENT;
+	/* Contexts and jobs that use it keep it until they are done. */
+	pvrsgx_vm_user_put(vm);
+	pvrsgx_vm_put(vm);
+	return 0;
+}
+
+#define PVRSGX_MAX_BIND_OPS	256
+
+/* One op of a VM_BIND and what it needs, all gathered before anything changes. */
+struct bind_op {
+	struct drm_powervr_sgx_vm_bind_op in;
+	/* MAP: the object, its pages, its link to the VM, the new mapping. */
+	struct drm_gem_object *obj;
+	struct sg_table *sgt;
+	struct drm_gpuvm_bo *vm_bo;
+	/* MAP: [0]. UNMAP: the pieces a split may leave at either end. */
+	struct pvrsgx_va *va[2];
+};
+
+struct bind_ctx {
+	struct pvrsgx_vm *vm;
+	struct bind_op *op;
+	int next_va;
+	struct list_head *freed;
+};
+
+static struct pvrsgx_va *bind_take_va(struct bind_ctx *b)
+{
+	struct pvrsgx_va *v = b->op->va[b->next_va];
+
+	b->op->va[b->next_va++] = NULL;
+	return v;
+}
+
+/* The steps below can't fail: bind_prepare() checked and allocated everything. */
+static int bind_step_map(struct drm_gpuva_op *op, void *priv)
+{
+	struct bind_ctx *b = priv;
+	struct bind_op *o = b->op;
+	struct pvrsgx_va *v = bind_take_va(b);
+
+	WARN_ON(pvrsgx_mmu_map_sgt(b->vm->mmu, op->map.va.addr, o->sgt, op->map.gem.offset,
+				   op->map.va.range,
+				   pvrsgx_validate_pte_flags(to_pvrsgx_bo(o->obj))));
+	drm_gpuva_map(&b->vm->gpuvm, &v->base, &op->map);
+	drm_gpuva_link(&v->base, o->vm_bo);
+	return 0;
+}
+
+static int bind_step_remap(struct drm_gpuva_op *op, void *priv)
+{
+	struct bind_ctx *b = priv;
+	struct drm_gpuva *va = op->remap.unmap->va;
+	struct pvrsgx_va *prev = NULL, *next = NULL;
+	u64 addr, range;
+
+	drm_gpuva_op_remap_to_unmap_range(&op->remap, &addr, &range);
+	pvrsgx_mmu_unmap(b->vm->mmu, addr, range);
+	if (op->remap.prev)
+		prev = bind_take_va(b);
+	if (op->remap.next)
+		next = bind_take_va(b);
+	drm_gpuva_remap(prev ? &prev->base : NULL, next ? &next->base : NULL, &op->remap);
+	if (prev)
+		drm_gpuva_link(&prev->base, va->vm_bo);
+	if (next)
+		drm_gpuva_link(&next->base, va->vm_bo);
+	va_unlink_locked(va, b->freed);
+	return 0;
+}
+
+static int bind_step_unmap(struct drm_gpuva_op *op, void *priv)
+{
+	struct bind_ctx *b = priv;
+	struct drm_gpuva *va = op->unmap.va;
+
+	pvrsgx_mmu_unmap(b->vm->mmu, va->va.addr, va->va.range);
+	drm_gpuva_unmap(&op->unmap);
+	va_unlink_locked(va, b->freed);
+	return 0;
+}
+
+static void pvrsgx_gpuvm_free(struct drm_gpuvm *gpuvm)
+{
+	kfree(container_of(gpuvm, struct pvrsgx_vm, gpuvm));
+}
+
+static const struct drm_gpuvm_ops pvrsgx_gpuvm_ops = {
+	.vm_free = pvrsgx_gpuvm_free,
+	.sm_step_map = bind_step_map,
+	.sm_step_remap = bind_step_remap,
+	.sm_step_unmap = bind_step_unmap,
+};
+
+static bool ranges_overlap(u64 a, u64 as, u64 b, u64 bs)
+{
+	return a < b + bs && b < a + as;
+}
+
+/* The op's own arguments, and its object for a map. */
+static int bind_op_check(struct drm_file *file, struct pvrsgx_vm *vm, struct bind_op *o)
+{
+	const struct drm_powervr_sgx_vm_bind_op *in = &o->in;
+	u64 end;
+	int heap, err;
+
+	if (in->flags || in->_padding_24 || !in->size || !PAGE_ALIGNED(in->size) ||
+	    !PAGE_ALIGNED(in->device_addr) || check_add_overflow(in->device_addr, in->size, &end) ||
+	    end > BIT_ULL(vm->sdev->family->va_bits))
+		return -EINVAL;
+	if (in->op == DRM_POWERVR_SGX_VM_BIND_OP_UNMAP)
+		return in->handle || in->bo_offset ? -EINVAL : 0;
+	if (in->op != DRM_POWERVR_SGX_VM_BIND_OP_MAP || !PAGE_ALIGNED(in->bo_offset))
+		return -EINVAL;
+	heap = pvrsgx_heap_find(vm->sdev, in->device_addr, in->size);
+	if (heap < 0)
+		return -EINVAL;
+
+	o->obj = drm_gem_object_lookup(file, in->handle);
+	if (!o->obj)
+		return -ENOENT;
+	if (check_add_overflow(in->bo_offset, in->size, &end) || end > o->obj->size)
+		return -EINVAL;
+	err = pvrsgx_validate_vm_map(vm->sdev, vm, heap, to_pvrsgx_bo(o->obj), in->bo_offset,
+				     in->size);
+	if (err)
+		return err;
+	o->sgt = drm_gem_shmem_get_pages_sgt(to_drm_gem_shmem_obj(o->obj));
+	if (IS_ERR(o->sgt)) {
+		err = PTR_ERR(o->sgt);
+		o->sgt = NULL;
+		return err;
+	}
+	if (drm_gem_is_imported(o->obj) && !pvrsgx_prime_reachable(o->sgt))
+		return -EFAULT;
+	return 0;
+}
+
+/*
+ * With vm->lock and every object involved locked: check each op against the
+ * VM as it is (the ops don't overlap, so none depends on another) and allocate
+ * what applying it takes.
+ */
+static int bind_prepare(struct pvrsgx_vm *vm, struct bind_op *ops, u32 n)
+{
+	for (u32 i = 0; i < n; i++) {
+		struct bind_op *o = &ops[i];
+		u64 addr = o->in.device_addr, size = o->in.size;
+		int nva = o->in.op == DRM_POWERVR_SGX_VM_BIND_OP_MAP ? 1 : 2;
+		int err;
+
+		if (o->in.op == DRM_POWERVR_SGX_VM_BIND_OP_MAP) {
+			if (drm_gpuva_find_first(&vm->gpuvm, addr, size))
+				return -EEXIST;
+			err = pvrsgx_validate_vm_link(to_pvrsgx_bo(o->obj), addr, o->in.bo_offset);
+			if (err)
+				return err;
+			err = pvrsgx_mmu_reserve(vm->mmu, addr, size);
+			if (err)
+				return err;
+			if (!o->vm_bo) {
+				o->vm_bo = drm_gpuvm_bo_obtain_locked(&vm->gpuvm, o->obj);
+				if (IS_ERR(o->vm_bo)) {
+					err = PTR_ERR(o->vm_bo);
+					o->vm_bo = NULL;
+					return err;
+				}
+			}
+		}
+		for (int k = 0; k < nva; k++) {
+			if (!o->va[k])
+				o->va[k] = kzalloc_obj(*o->va[k]);
+			if (!o->va[k])
+				return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+static void bind_apply(struct pvrsgx_vm *vm, struct bind_op *ops, u32 n, struct list_head *freed)
+{
+	struct bind_ctx b = { .vm = vm, .freed = freed };
+
+	for (u32 i = 0; i < n; i++) {
+		struct bind_op *o = &ops[i];
+
+		b.op = o;
+		b.next_va = 0;
+		if (o->in.op == DRM_POWERVR_SGX_VM_BIND_OP_MAP) {
+			struct drm_gpuvm_map_req req = {
+				.map.va.addr = o->in.device_addr,
+				.map.va.range = o->in.size,
+				.map.gem.obj = o->obj,
+				.map.gem.offset = o->in.bo_offset,
+			};
+
+			WARN_ON(drm_gpuvm_sm_map(&vm->gpuvm, &b, &req));
+		} else {
+			WARN_ON(drm_gpuvm_sm_unmap(&vm->gpuvm, &b, o->in.device_addr, o->in.size));
+		}
+	}
+}
+
+/* Wait, interruptibly, for every wait op; find every signal op's syncobj. */
+int pvrsgx_ioctl_vm_bind(struct drm_device *drm, void *data, struct drm_file *file)
+{
+	struct drm_powervr_sgx_ioctl_vm_bind_args *args = data;
+	struct pvrsgx_vm_free *f = NULL;
+	struct bind_op *ops = NULL;
+	struct drm_powervr_sgx_vm_bind_op *in;
+	struct pvrsgx_vm *vm;
+	struct drm_exec exec;
+	u32 n = args->ops.count;
+	int err;
+
+	/* A synchronous bind takes no fences (drm-vm-bind-async.rst). */
+	if (args->flags != DRM_POWERVR_SGX_VM_BIND_FLAG_SYNC || !n || args->sync_ops.count)
+		return -EINVAL;
+
+	vm = pvrsgx_vm_lookup(to_pvrsgx_file(file), args->vm_context_handle);
+	if (!vm)
+		return -ENOENT;
+	in = pvrsgx_obj_array_get(&args->ops, sizeof(*in), PVRSGX_MAX_BIND_OPS);
+	if (IS_ERR(in)) {
+		err = PTR_ERR(in);
+		goto out_vm;
+	}
+	ops = kvcalloc(n, sizeof(*ops), GFP_KERNEL);
+	f = vm_free_alloc();
+	if (!ops || !f) {
+		err = -ENOMEM;
+		goto out;
+	}
+	for (u32 i = 0; i < n; i++) {
+		ops[i].in = in[i];
+		err = bind_op_check(file, vm, &ops[i]);
+		if (err)
+			goto out;
+		for (u32 k = 0; k < i; k++) {
+			if (ranges_overlap(in[i].device_addr, in[i].size, in[k].device_addr,
+					   in[k].size)) {
+				err = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
+	mutex_lock(&vm->lock);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT | DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&exec) {
+		err = 0;
+		for (u32 i = 0; i < n && !err; i++) {
+			struct drm_gpuva *va;
+
+			if (ops[i].obj) {
+				err = drm_exec_lock_obj(&exec, ops[i].obj);
+				drm_exec_retry_on_contention(&exec);
+				continue;
+			}
+			drm_gpuvm_for_each_va_range(va, &vm->gpuvm, in[i].device_addr,
+						    in[i].device_addr + in[i].size) {
+				err = drm_exec_lock_obj(&exec, va->gem.obj);
+				drm_exec_retry_on_contention(&exec);
+				if (err)
+					break;
+			}
+		}
+	}
+	err = err ?: bind_prepare(vm, ops, n);
+	if (!err)
+		bind_apply(vm, ops, n, &f->vas);
+	drm_exec_fini(&exec);
+	mutex_unlock(&vm->lock);
+	if (err)
+		goto out;
+
+	vm_invalidate(vm->sdev, false);
+	/*
+	 * The objects unmapped stay until every job submitted before now is done
+	 * and, if the VM ran one since the GPU started, the BIF invalidate has run.
+	 */
+	if (!list_empty(&f->vas)) {
+		vm_free_after_jobs(vm, f, true);
+		f = NULL;
+	}
+
+out:
+	if (ops) {
+		for (u32 i = 0; i < n; i++) {
+			kfree(ops[i].va[0]);
+			kfree(ops[i].va[1]);
+			if (ops[i].vm_bo) {
+				dma_resv_lock(ops[i].obj->resv, NULL);
+				drm_gpuvm_bo_put(ops[i].vm_bo);
+				dma_resv_unlock(ops[i].obj->resv);
+			}
+			if (ops[i].obj)
+				drm_gem_object_put(ops[i].obj);
+		}
+		kvfree(ops);
+	}
+	kfree(f);
+	kvfree(in);
+out_vm:
+	pvrsgx_vm_put(vm);
+	return err;
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_vm.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_vm.h
new file mode 100644
index 000000000..9a9a95262
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_vm.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_VM_H
+#define PVRSGX_VM_H
+
+#include <drm/drm_gpuvm.h>
+#include <drm/drm_mm.h>
+
+#include <linux/kref.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+struct drm_device;
+struct drm_file;
+struct pvrsgx_device;
+struct pvrsgx_file;
+struct pvrsgx_pb;
+
+/**
+ * struct pvrsgx_vm - A VM context: one page directory
+ *
+ * Maps only the client heaps, plus (later) the kernel-owned structures the TA
+ * and 3D read under it. Never the kernel code or data heaps: that is what keeps
+ * a client's tasks away from the firmware's memory. A single-context core is
+ * the exception: there every VM shares the firmware heaps' page tables.
+ */
+struct pvrsgx_vm {
+	/** @gpuvm: The GPU VA manager. */
+	struct drm_gpuvm gpuvm;
+	/** @sdev: The device. */
+	struct pvrsgx_device *sdev;
+	/** @mmu: Its page directory and tables. */
+	struct pvrsgx_mmu *mmu;
+	/** @params: 3D parameters addresses of this VM's kernel objects (pvrsgx_kobj.c). */
+	struct drm_mm params;
+	/** @pb: The device's parameter buffer, mapped here by the first render context. */
+	struct pvrsgx_pb *pb;
+	/** @pb_nodes: @pb's PB and free list in @params. */
+	struct drm_mm_node pb_nodes[2];
+	/** @lock: Serializes binds, the teardown and @pb's mapping. */
+	struct mutex lock;
+	/** @ref: Held by the handle, its contexts and their jobs. */
+	struct kref ref;
+	/** @users: The handle and the live contexts; at zero its mappings go. */
+	atomic_t users;
+	/** @ran_gen: &pvrsgx_device.fw_gen + 1 at its last job sent; 0 before any. */
+	u32 ran_gen;
+	/** @pd_slot: Its slot in the microkernel's PD table (single-context cores), or 0. */
+	int pd_slot;
+};
+
+struct pvrsgx_vm *pvrsgx_vm_create(struct pvrsgx_device *sdev);
+u32 pvrsgx_vm_pd_word(const struct pvrsgx_vm *vm);
+struct pvrsgx_vm *pvrsgx_vm_get(struct pvrsgx_vm *vm);
+void pvrsgx_vm_put(struct pvrsgx_vm *vm);
+void pvrsgx_vm_user_get(struct pvrsgx_vm *vm);
+void pvrsgx_vm_user_put(struct pvrsgx_vm *vm);
+struct dma_resv *pvrsgx_vm_resv(struct pvrsgx_vm *vm);
+struct pvrsgx_vm *pvrsgx_vm_lookup(struct pvrsgx_file *sfile, u32 handle);
+void pvrsgx_vm_destroy_all(struct pvrsgx_file *sfile);
+int pvrsgx_heap_find(const struct pvrsgx_device *sdev, u64 addr, u64 size);
+
+int pvrsgx_ioctl_create_vm_context(struct drm_device *drm, void *data, struct drm_file *file);
+int pvrsgx_ioctl_destroy_vm_context(struct drm_device *drm, void *data, struct drm_file *file);
+int pvrsgx_ioctl_vm_bind(struct drm_device *drm, void *data, struct drm_file *file);
+int pvrsgx_query_heap_info(struct pvrsgx_device *sdev, void __user *ptr, u32 *size);
+
+#endif /* PVRSGX_VM_H */

-- 
2.50.1

