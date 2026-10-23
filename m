Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F399606A322
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gEzeRm6H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F138E112970;
	Fri, 23 Oct 2026 06:40:12 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9863F10E592
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:40:01 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so334418f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737600; x=1793342400; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JjhEm+Zzj8+ZQICx4K5pWitdAhWNMVvCik8KE2MS864=;
 b=gEzeRm6Hvg9T5n0H0A3/xKMaRHacLCrDZ/jqAhYCBlarlvzZo35x4EBUM8U1a2ExF8
 IT0Hvzz3hQdyZnUDbWOJUFeOuy8387fTbRHOQZW3oB6rse2Si+wX3xMknyfD5g8au22a
 qs8GaLFeg/xX4dCsRJmL59Wr7f0+xwm5eZo5vvFIvxjjJWePs1DlY9syyDPEyXNSC/Sg
 XgngtFfkquePbKqQBhaKm37B/yBDJeYheOUCT/1py4jghoMHKgrn+fT7/fwSQZLQrwSm
 TEXt+EE7M2Og77cw8jxo39IH5+CWVLdfM1impB41/B9tVZ8ZbqplMRXUPyOTn8zabPzr
 Qnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737600; x=1793342400;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjhEm+Zzj8+ZQICx4K5pWitdAhWNMVvCik8KE2MS864=;
 b=ADgKgwlsmtK1t+hR45RsJBWSp3/W6KFLQcr9hS+GMwy+M+DSaTxceLKRjLsFd2iLUD
 DQp3BUucnBSSz04iDmMag7WzIZMBgfgDqBF2hMzm55uy62tyXark2ugEYceZuTgWLKUy
 5Cy8T/mFxJ1CVRb/HkqS08AbkNL2wGuW8C2WpgN3ZoRS4vD/IiTYrylPvqQWL8l4VUbe
 97Zmj4RZAk8JQbMUPeAwmxSUN+7X2EoE4y7fTZMJXd/Tg+mW/lnazfkyA6VdRTlUsZl1
 b6PoWFgCvmLsPPIFbCCu0NGpI0v7kYlLGygRYo0MBLj7hcqvbVlQf5LHl5Q3jXLIjnBQ
 P4Zw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZDV2JzhhGWGabfElvzBWVtGaUzxaWpF67XXRF9hmM1o7xTlE4xuhZPqn3SyuOCsuTeh5QHTNb9Qo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIp60eBLD8kMTQK/yPuT+nT4oVAXXNRQwPiOs2umH3zoJmRiyOb
 KqGgcznxthfzB8cjYC8zFoYINDg3SXBYC7DTQXU+Z4g8LKXMIQ7Jy8yX
X-Gm-Gg: AYBFou0qTPKnmJB6/3gHxGPxsnqoD9xJVOo6oP0WmvTqbKOmuTnz8yMzTiXnh8fi+dT
 J2C7t+dVZ7n6wXaH2Auqpsohl8NjSr4NsLSIZ0oIiUADV1hjIt7VpgpZ8Hwk5Ylq2TYLHXJYRSw
 cqEFnu2dXqOMESXdws6+WX5yybi8qlY+pNuItaGzjmRD7csLVnlh8n9pJ050TwLW1W0bjPIJ5qX
 F9+Mhu8WFjRkoR8sc5HhRaNVETO82iyYHZhsLxs/U20E3t4pzhY/PC4yTcGiG7omakUeA3uVPLL
 E5eHpgkgRpWd9MD6vw/qpLETcQJ6mcOkfVN0cc/bKnomytT0ZlNtUKiPbM9cWtQg2PLBPB2HJMo
 bdeM7rXAQo4/HjHgB1NpAeUgOj0o0fdD6FluRq81eEDhuHNIR4/6XEESQnvm5t4FKpNvKS0HqkE
 6LVlVinLlLFZzkb0VjSz32YmiYGKC8suc3JhPtqyQIvoIdb4H1TxDpJL8ZDl4awo5jtj4hSFt56
 wGCp46eClraDroEb2omXhtq/5/ZxeYuauGsQPjoQURZRf/B84oSNKgtdmbKEaQBp+SESBGmAkgn
 nmeETTEQXVg1UhUoCoQS8wj80DdKUIRNOzw2VdORDMsNDfdj5tUnYM3FrxYB+Iww6EAjLfifAha
 09/k=
X-Received: by 2002:a05:6000:186b:b0:48e:1b11:7ee6 with SMTP id
 ffacd0b85a97d-48e3854e373mr1738767f8f.2.1792737599792; 
 Thu, 22 Oct 2026 23:39:59 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:39:58 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:32 +0200
Subject: [PATCH v3 07/16] accel/thames: Add IOCTLs for BO creation and mapping
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-7-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Creation returns a handle and maps nothing. The client maps a buffer
with DRM_IOCTL_THAMES_BO_BIND at a DSP address of its choice, as a
Vulkan driver would; the kernel enters the mapping in the page table
of every core, because we cannot know upfront which core will run a
given job.

We use the SHMEM helpers for non-contiguous memory. Contiguous memory
comes from the driver's own allocator, which aligns a buffer of 2 MiB or
more to 2 MiB so it can be mapped as blocks; only the GEM DMA object
and its mmap and vmap helpers are used for it.

Contiguous memory is needed for buffers that are going to be read from
or written into by the DRU, as it doesn't resolve addresses via the MMU.

Binding at an address the client chooses lets a program be compiled,
with its addresses fixed, on a machine without the hardware, and is what
a Vulkan driver needs.

A buffer is bound anywhere from 4 GiB up to the user region at 1 TiB; a
buffer shared through a dma-buf may be bound in several Contexts, so
the bindings are kept under one device-wide lock. The IOCTLs take their
arrays as versioned objects whose stride is the size userspace was
built against, so a structure can grow under a minor bump.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

---

v3:
- Added read-only, executable and contiguous flags.
- Added BO_BIND IOCTL.
- Copy the IOCTLs' arrays with vmemdup_array_user(), through one helper
  for versioned arrays (Tvrtko Ursulin).

v2:
- Add thames_accel.h UAPI header (Robert Nelson).
---
 drivers/accel/thames/Kconfig         |   2 +
 drivers/accel/thames/thames_device.h |   6 +
 drivers/accel/thames/thames_drv.c    |  47 +++++
 drivers/accel/thames/thames_drv.h    |   5 +
 drivers/accel/thames/thames_gem.c    | 398 +++++++++++++++++++++++++++++++++++
 drivers/accel/thames/thames_gem.h    |  21 ++
 include/uapi/drm/thames_accel.h      | 183 +++++++++++++++-
 7 files changed, 661 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/thames/Kconfig b/drivers/accel/thames/Kconfig
index 9362b9274075..47a2986fcabd 100644
--- a/drivers/accel/thames/Kconfig
+++ b/drivers/accel/thames/Kconfig
@@ -6,6 +6,8 @@ config DRM_ACCEL_THAMES
 	depends on TI_K3_DSP_REMOTEPROC
 	depends on REMOTEPROC
 	depends on MAILBOX
+	select DRM_GEM_DMA_HELPER
+	select DRM_GEM_SHMEM_HELPER
 	select IOMMU_IO_PGTABLE_LPAE
 	help
 	  Choose this option if you have a Texas Instruments J722S and want to
diff --git a/drivers/accel/thames/thames_device.h b/drivers/accel/thames/thames_device.h
index e89e0dfd89b8..a1a54d974359 100644
--- a/drivers/accel/thames/thames_device.h
+++ b/drivers/accel/thames/thames_device.h
@@ -58,6 +58,12 @@ struct thames_device {
 	struct list_head contexts;
 	struct mutex contexts_lock;
 
+	/*
+	 * One lock for the device: a dma-buf shared buffer is bound from
+	 * several files.
+	 */
+	struct mutex bindings_lock;
+
 };
 
 #define to_thames_device(drm_dev) \
diff --git a/drivers/accel/thames/thames_drv.c b/drivers/accel/thames/thames_drv.c
index cb0287430d25..a17e7a90f7c1 100644
--- a/drivers/accel/thames/thames_drv.c
+++ b/drivers/accel/thames/thames_drv.c
@@ -93,6 +93,41 @@ static void thames_postclose(struct drm_device *dev, struct drm_file *file)
 	thames_file_priv_put(thames_priv);
 }
 
+void *thames_get_uobj_array(const struct drm_thames_obj_array *in, u32 min_stride, u32 obj_size)
+{
+	void __user *in_ptr = u64_to_user_ptr(in->array);
+	void *out, *out_ptr;
+	int ret;
+	u32 i;
+
+	if (!in->count)
+		return NULL;
+
+	if (in->stride < min_stride)
+		return ERR_PTR(-EINVAL);
+
+	if (in->stride == obj_size)
+		return vmemdup_array_user(in_ptr, in->count, obj_size);
+
+	out = kvmalloc_array(in->count, obj_size, GFP_KERNEL);
+	if (!out)
+		return ERR_PTR(-ENOMEM);
+
+	out_ptr = out;
+	for (i = 0; i < in->count; i++) {
+		ret = copy_struct_from_user(out_ptr, obj_size, in_ptr, in->stride);
+		if (ret) {
+			kvfree(out);
+			return ERR_PTR(ret);
+		}
+
+		out_ptr += obj_size;
+		in_ptr += in->stride;
+	}
+
+	return out;
+}
+
 #define THAMES_DRIVER_MAJOR 1
 #define THAMES_DRIVER_MINOR 0
 
@@ -121,6 +156,8 @@ static int thames_query_caps(struct drm_device *dev, struct drm_thames_dev_query
 		.l2_aux.dsp_va = thames_window_va(tdev, THAMES_WINDOW_L2AUX),
 		.l2_aux.size = reported->window_sizes[THAMES_WINDOW_L2AUX],
 		.dru_realtime_dsp_va = thames_window_va(tdev, THAMES_WINDOW_DRU),
+		.dsp_va_range.dsp_va = THAMES_BIND_VA_START,
+		.dsp_va_range.size = THAMES_BIND_VA_END - THAMES_BIND_VA_START,
 		.user_region.dsp_va = THAMES_USER_REGION_BASE,
 		.user_region.size = THAMES_USER_REGION_SIZE,
 		.hardware_id = reported->hardware_id,
@@ -165,11 +202,17 @@ static int thames_ioctl_##func##_entered(struct drm_device *dev, void *data,	\
 	return ret;								\
 }
 
+THAMES_IOCTL_ENTERED(bo_create)
+THAMES_IOCTL_ENTERED(bo_mmap_offset)
 THAMES_IOCTL_ENTERED(dev_query)
+THAMES_IOCTL_ENTERED(bo_bind)
 
 static const struct drm_ioctl_desc thames_drm_driver_ioctls[] = {
 #define THAMES_IOCTL(n, func) DRM_IOCTL_DEF_DRV(THAMES_##n, thames_ioctl_##func, 0)
+	THAMES_IOCTL(BO_CREATE, bo_create_entered),
+	THAMES_IOCTL(BO_MMAP_OFFSET, bo_mmap_offset_entered),
 	THAMES_IOCTL(DEV_QUERY, dev_query_entered),
+	THAMES_IOCTL(BO_BIND, bo_bind_entered),
 };
 
 DEFINE_DRM_ACCEL_FOPS(thames_accel_driver_fops);
@@ -234,6 +277,10 @@ static struct thames_device *thames_device_init(struct platform_device *pdev,
 	if (err)
 		return ERR_PTR(err);
 
+	err = drmm_mutex_init(&tdev->ddev, &tdev->bindings_lock);
+	if (err)
+		return ERR_PTR(err);
+
 	INIT_LIST_HEAD(&tdev->contexts);
 
 	tdev->asid_next = 1;
diff --git a/drivers/accel/thames/thames_drv.h b/drivers/accel/thames/thames_drv.h
index f4536078e02f..7f9031b63780 100644
--- a/drivers/accel/thames/thames_drv.h
+++ b/drivers/accel/thames/thames_drv.h
@@ -15,6 +15,7 @@
 #include "thames_device.h"
 
 struct drm_gem_dma_object;
+struct drm_thames_obj_array;
 
 struct thames_file_priv {
 	struct thames_device *tdev;
@@ -37,6 +38,8 @@ struct thames_file_priv {
 	struct drm_mm_node user_region;
 	struct drm_mm_node window_nodes[THAMES_NUM_WINDOWS];
 
+	struct list_head bindings;
+
 	u32 context_id;
 
 	u64 context_serial;
@@ -47,4 +50,6 @@ struct thames_file_priv {
 
 void thames_file_priv_put(struct thames_file_priv *priv);
 
+void *thames_get_uobj_array(const struct drm_thames_obj_array *in, u32 min_stride, u32 obj_size);
+
 #endif
diff --git a/drivers/accel/thames/thames_gem.c b/drivers/accel/thames/thames_gem.c
index b98e0fe203b0..c9fd08c7aaf4 100644
--- a/drivers/accel/thames/thames_gem.c
+++ b/drivers/accel/thames/thames_gem.c
@@ -14,6 +14,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_timeout.h>
 #include <drm/thames_accel.h>
@@ -23,6 +24,30 @@
 #include "thames_drv.h"
 #include "thames_gem.h"
 
+/*
+ * References neither the buffer nor the Context: whichever goes first removes
+ * it.
+ */
+struct thames_binding {
+	struct thames_gem_object *bo;
+	struct thames_file_priv *priv;
+	struct drm_mm_node mm;
+	struct list_head bo_link;
+	struct list_head context_link;
+};
+
+static int thames_bo_flags_to_prot(u32 flags)
+{
+	int prot = IOMMU_READ | IOMMU_CACHE;
+
+	if (!(flags & DRM_THAMES_BO_EXECUTABLE))
+		prot |= IOMMU_NOEXEC;
+	if (!(flags & (DRM_THAMES_BO_READ_ONLY | DRM_THAMES_BO_EXECUTABLE)))
+		prot |= IOMMU_WRITE;
+
+	return prot;
+}
+
 static size_t thames_pgsize(u64 addr, size_t size, size_t *count)
 {
 	size_t blk_offset = -addr % SZ_2M;
@@ -95,6 +120,72 @@ static int thames_context_map(struct thames_file_priv *priv, u64 dsp_va, int pro
 	return 0;
 }
 
+static void thames_context_unmap(struct thames_file_priv *priv, u64 dsp_va, u64 size)
+{
+	unsigned int c;
+
+	for (c = 0; c < priv->tdev->num_cores; c++)
+		thames_pgtable_unmap(priv->pgtbl_ops[c], dsp_va, size);
+}
+
+struct thames_gem_object *thames_context_find_bo(struct thames_file_priv *priv, u64 start,
+						 u64 end, u64 *offset)
+{
+	struct thames_binding *binding;
+	struct thames_gem_object *bo;
+	struct drm_mm_node *node;
+	unsigned int i;
+
+	guard(mutex)(&priv->mm_lock);
+
+	node = __drm_mm_interval_first(&priv->mm, start, start);
+	if (node == &priv->mm.head_node || node == &priv->first_page ||
+	    node == &priv->user_region)
+		return NULL;
+
+	for (i = 0; i < THAMES_NUM_WINDOWS; i++) {
+		if (node == &priv->window_nodes[i])
+			return NULL;
+	}
+
+	binding = container_of(node, struct thames_binding, mm);
+	bo = binding->bo;
+	if (end > node->start + bo->base.base.size)
+		return NULL;
+
+	if (!kref_get_unless_zero(&bo->base.base.refcount))
+		return NULL;
+
+	*offset = start - node->start;
+
+	return bo;
+}
+
+static struct thames_binding *thames_bo_find_binding(struct thames_gem_object *bo,
+						     struct thames_file_priv *priv)
+{
+	struct thames_binding *binding;
+
+	lockdep_assert_held(&priv->tdev->bindings_lock);
+
+	list_for_each_entry(binding, &bo->bindings, bo_link) {
+		if (binding->priv == priv)
+			return binding;
+	}
+
+	return NULL;
+}
+
+u64 thames_bo_dsp_va(struct thames_gem_object *bo, struct thames_file_priv *priv)
+{
+	struct thames_binding *binding;
+
+	guard(mutex)(&priv->tdev->bindings_lock);
+	binding = thames_bo_find_binding(bo, priv);
+
+	return binding ? binding->mm.start : 0;
+}
+
 /* Cyclic, so a freed ASID is not handed out again at once. */
 static int thames_asid_alloc(struct thames_device *tdev)
 {
@@ -215,6 +306,7 @@ static int thames_context_map_core_regions(struct thames_file_priv *priv)
 }
 
 static const struct drm_gem_object_funcs thames_gem_funcs;
+static const struct drm_gem_object_funcs thames_gem_shmem_funcs;
 
 /*
  * The allocator zeroes through the cache: clean it before the DSP can reach the
@@ -234,6 +326,7 @@ static struct drm_gem_dma_object *thames_gem_create(struct drm_device *ddev, siz
 	if (!bo)
 		return ERR_PTR(-ENOMEM);
 
+	INIT_LIST_HEAD(&bo->bindings);
 	obj = &bo->base.base;
 	obj->funcs = &thames_gem_funcs;
 	bo->base.map_noncoherent = true;
@@ -271,6 +364,38 @@ static struct drm_gem_dma_object *thames_gem_create(struct drm_device *ddev, siz
 	return ERR_PTR(ret);
 }
 
+/*
+ * The DSP reaches these pages only through the page tables, never by a DRU
+ * transfer.
+ */
+static struct thames_gem_object *thames_gem_create_shmem(struct drm_device *ddev, size_t size)
+{
+	struct thames_gem_object *bo;
+	struct sg_table *sgt;
+	int ret;
+
+	bo = kzalloc_obj(*bo, GFP_KERNEL);
+	if (!bo)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&bo->bindings);
+	bo->shmem.base.funcs = &thames_gem_shmem_funcs;
+
+	ret = drm_gem_shmem_init(ddev, &bo->shmem, PAGE_ALIGN(size));
+	if (ret) {
+		kfree(bo);
+		return ERR_PTR(ret);
+	}
+
+	sgt = drm_gem_shmem_get_pages_sgt(&bo->shmem);
+	if (IS_ERR(sgt)) {
+		drm_gem_object_put(&bo->shmem.base);
+		return ERR_CAST(sgt);
+	}
+
+	return bo;
+}
+
 static struct drm_gem_dma_object *thames_context_alloc_user_pages(struct thames_file_priv *priv,
 								  u64 dsp_va, size_t size)
 {
@@ -459,6 +584,7 @@ int thames_context_create(struct thames_file_priv *priv)
 
 	priv->context_id = ret;
 	priv->context_serial = atomic64_inc_return(&tdev->last_context_serial);
+	INIT_LIST_HEAD(&priv->bindings);
 
 	ret = thames_context_va_init(priv);
 	if (ret)
@@ -500,14 +626,37 @@ int thames_context_create(struct thames_file_priv *priv)
 	return ret;
 }
 
+static void thames_binding_remove(struct thames_binding *binding)
+{
+	struct thames_file_priv *priv = binding->priv;
+
+	lockdep_assert_held(&priv->tdev->bindings_lock);
+
+	thames_context_unmap(priv, binding->mm.start, binding->mm.size);
+	thames_context_bump_generation(priv);
+
+	scoped_guard(mutex, &priv->mm_lock)
+		drm_mm_remove_node(&binding->mm);
+
+	list_del(&binding->bo_link);
+	list_del(&binding->context_link);
+	kfree(binding);
+}
+
 void thames_context_destroy(struct thames_file_priv *priv)
 {
 	struct thames_device *tdev = priv->tdev;
+	struct thames_binding *binding, *tmp;
 
 	/*
 	 * The Context goes after its last pushed Job completed, so no Job runs
 	 * on mappings removed here.
 	 */
+	scoped_guard(mutex, &tdev->bindings_lock) {
+		list_for_each_entry_safe(binding, tmp, &priv->bindings, context_link)
+			thames_binding_remove(binding);
+	}
+
 	scoped_guard(mutex, &tdev->contexts_lock)
 		list_del(&priv->context_node);
 
@@ -522,10 +671,124 @@ void thames_context_destroy(struct thames_file_priv *priv)
 		priv->context_id, priv->asid);
 }
 
+static int thames_context_map_sgt(struct thames_file_priv *priv, u64 dsp_va, int prot,
+				  struct sg_table *sgt)
+{
+	struct scatterlist *sg;
+	u64 offset = 0;
+	unsigned int i;
+	int ret;
+
+	for_each_sgtable_dma_sg(sgt, sg, i) {
+		ret = thames_context_map(priv, dsp_va + offset, prot, sg_dma_address(sg),
+					 sg_dma_len(sg));
+		if (ret) {
+			thames_context_unmap(priv, dsp_va, offset);
+			return ret;
+		}
+
+		offset += sg_dma_len(sg);
+	}
+
+	return 0;
+}
+
+static int thames_bo_bind(struct thames_file_priv *priv, struct thames_gem_object *bo,
+			  u64 dsp_va)
+{
+	size_t size = bo->base.base.size;
+	int prot = thames_bo_flags_to_prot(bo->flags);
+	struct thames_binding *binding;
+	int ret;
+
+	if (!IS_ALIGNED(dsp_va, PAGE_SIZE))
+		return -EINVAL;
+
+	if (dsp_va < THAMES_BIND_VA_START || dsp_va > THAMES_BIND_VA_END ||
+	    size > THAMES_BIND_VA_END - dsp_va)
+		return -EINVAL;
+
+	binding = kzalloc_obj(*binding);
+	if (!binding)
+		return -ENOMEM;
+
+	binding->bo = bo;
+	binding->priv = priv;
+	binding->mm.start = dsp_va;
+	binding->mm.size = size;
+
+	ret = mutex_lock_interruptible(&priv->tdev->bindings_lock);
+	if (ret)
+		goto err_free;
+
+	if (thames_bo_find_binding(bo, priv)) {
+		ret = -EBUSY;
+		goto err_unlock;
+	}
+
+	scoped_guard(mutex, &priv->mm_lock)
+		ret = drm_mm_reserve_node(&priv->mm, &binding->mm);
+	if (ret)
+		goto err_unlock;
+
+	if (bo->flags & DRM_THAMES_BO_CONTIGUOUS)
+		ret = thames_context_map(priv, dsp_va, prot, bo->base.dma_addr, size);
+	else
+		ret = thames_context_map_sgt(priv, dsp_va, prot, bo->shmem.sgt);
+	if (ret) {
+		scoped_guard(mutex, &priv->mm_lock)
+			drm_mm_remove_node(&binding->mm);
+		goto err_unlock;
+	}
+
+	list_add_tail(&binding->bo_link, &bo->bindings);
+	list_add_tail(&binding->context_link, &priv->bindings);
+	mutex_unlock(&priv->tdev->bindings_lock);
+
+	return 0;
+
+err_unlock:
+	mutex_unlock(&priv->tdev->bindings_lock);
+err_free:
+	kfree(binding);
+	return ret;
+}
+
+static int thames_bo_unbind(struct thames_file_priv *priv, struct thames_gem_object *bo)
+{
+	struct thames_binding *binding;
+	int ret;
+
+	ret = mutex_lock_interruptible(&priv->tdev->bindings_lock);
+	if (ret)
+		return ret;
+
+	binding = thames_bo_find_binding(bo, priv);
+	if (binding)
+		thames_binding_remove(binding);
+	else
+		ret = -EINVAL;
+
+	mutex_unlock(&priv->tdev->bindings_lock);
+	return ret;
+}
+
+static void thames_bo_unmap_from_device(struct thames_gem_object *bo)
+{
+	struct thames_device *tdev = to_thames_device(bo->base.base.dev);
+	struct thames_binding *binding, *tmp;
+
+	guard(mutex)(&tdev->bindings_lock);
+	list_for_each_entry_safe(binding, tmp, &bo->bindings, bo_link)
+		thames_binding_remove(binding);
+}
+
 static void thames_gem_bo_free(struct drm_gem_object *obj)
 {
 	struct thames_gem_object *bo = to_thames_bo(obj);
 
+	thames_bo_unmap_from_device(bo);
+
 	if (bo->alloc_vaddr)
 		dma_free_noncoherent(drm_dev_dma_dev(obj->dev), bo->alloc_size, bo->alloc_vaddr,
 				     bo->alloc_dma, DMA_TO_DEVICE);
@@ -535,6 +798,16 @@ static void thames_gem_bo_free(struct drm_gem_object *obj)
 	kfree(bo);
 }
 
+static void thames_gem_shmem_bo_free(struct drm_gem_object *obj)
+{
+	struct thames_gem_object *bo = to_thames_bo(obj);
+
+	thames_bo_unmap_from_device(bo);
+
+	drm_gem_free_mmap_offset(obj);
+	drm_gem_shmem_free(&bo->shmem);
+}
+
 static const struct drm_gem_object_funcs thames_gem_funcs = {
 	.free = thames_gem_bo_free,
 	.print_info = drm_gem_dma_object_print_info,
@@ -544,3 +817,128 @@ static const struct drm_gem_object_funcs thames_gem_funcs = {
 	.vm_ops = &drm_gem_dma_vm_ops,
 };
 
+static const struct drm_gem_object_funcs thames_gem_shmem_funcs = {
+	.free = thames_gem_shmem_bo_free,
+	.print_info = drm_gem_shmem_object_print_info,
+	.pin = drm_gem_shmem_object_pin,
+	.unpin = drm_gem_shmem_object_unpin,
+	.get_sg_table = drm_gem_shmem_object_get_sg_table,
+	.vmap = drm_gem_shmem_object_vmap,
+	.vunmap = drm_gem_shmem_object_vunmap,
+	.mmap = drm_gem_shmem_object_mmap,
+	.vm_ops = &drm_gem_shmem_vm_ops,
+};
+
+int thames_ioctl_bo_create(struct drm_device *ddev, void *data, struct drm_file *file)
+{
+	struct drm_thames_bo_create *args = data;
+	struct thames_gem_object *bo;
+	struct drm_gem_dma_object *mem;
+	int ret;
+
+	if (args->handle)
+		return -EINVAL;
+
+	if (!args->size)
+		return -EINVAL;
+
+	if (args->flags & ~(DRM_THAMES_BO_READ_ONLY | DRM_THAMES_BO_EXECUTABLE |
+			    DRM_THAMES_BO_CONTIGUOUS))
+		return -EINVAL;
+
+	if (args->flags & DRM_THAMES_BO_CONTIGUOUS) {
+		mem = thames_gem_create(ddev, args->size);
+		if (IS_ERR(mem))
+			return PTR_ERR(mem);
+		bo = to_thames_bo(&mem->base);
+	} else {
+		bo = thames_gem_create_shmem(ddev, args->size);
+		if (IS_ERR(bo))
+			return PTR_ERR(bo);
+	}
+
+	bo->flags = args->flags;
+
+	ret = drm_gem_handle_create(file, &bo->base.base, &args->handle);
+	drm_gem_object_put(&bo->base.base);
+	if (ret) {
+		dev_err(ddev->dev, "Failed to create gem handle: %d", ret);
+		return ret;
+	}
+
+	args->size = bo->base.base.size;
+
+	return 0;
+}
+
+static int thames_bind_exec_op(struct drm_file *file, const struct drm_thames_bind_op *op)
+{
+	struct thames_file_priv *priv = file->driver_priv;
+	struct drm_gem_object *obj;
+	int ret;
+
+	if (op->flags & ~DRM_THAMES_BIND_OP_UNBIND)
+		return -EINVAL;
+
+	if ((op->flags & DRM_THAMES_BIND_OP_UNBIND) && op->dsp_va)
+		return -EINVAL;
+
+	obj = drm_gem_object_lookup(file, op->handle);
+	if (!obj)
+		return -ENOENT;
+
+	if (op->flags & DRM_THAMES_BIND_OP_UNBIND)
+		ret = thames_bo_unbind(priv, to_thames_bo(obj));
+	else
+		ret = thames_bo_bind(priv, to_thames_bo(obj), op->dsp_va);
+
+	drm_gem_object_put(obj);
+
+	return ret;
+}
+
+int thames_ioctl_bo_bind(struct drm_device *ddev, void *data, struct drm_file *file)
+{
+	struct drm_thames_bo_bind *args = data;
+	struct drm_thames_bind_op *ops;
+	int ret = 0;
+	u32 i;
+
+	if (args->flags || args->pad)
+		return -EINVAL;
+
+	ops = thames_get_uobj_array(&args->ops, sizeof(*ops), sizeof(*ops));
+	if (IS_ERR(ops))
+		return PTR_ERR(ops);
+
+	for (i = 0; i < args->ops.count; i++) {
+		ret = thames_bind_exec_op(file, &ops[i]);
+		if (ret) {
+			args->ops.count = i;
+			break;
+		}
+	}
+
+	kvfree(ops);
+
+	return ret;
+}
+
+int thames_ioctl_bo_mmap_offset(struct drm_device *ddev, void *data, struct drm_file *file)
+{
+	struct drm_thames_bo_mmap_offset *args = data;
+	struct drm_gem_object *obj;
+
+	if (args->pad)
+		return -EINVAL;
+
+	obj = drm_gem_object_lookup(file, args->handle);
+	if (!obj)
+		return -ENOENT;
+
+	args->offset = drm_vma_node_offset_addr(&obj->vma_node);
+	drm_gem_object_put(obj);
+
+	return 0;
+}
+
diff --git a/drivers/accel/thames/thames_gem.h b/drivers/accel/thames/thames_gem.h
index 09ac1b50d21a..c9d0e170dad3 100644
--- a/drivers/accel/thames/thames_gem.h
+++ b/drivers/accel/thames/thames_gem.h
@@ -12,6 +12,13 @@
 
 #include "thames_abi.h"
 
+/*
+ * The windows sit below 4 GiB because Kernels load their addresses with 32-bit
+ * moves.
+ */
+#define THAMES_BIND_VA_START	SZ_4G
+#define THAMES_BIND_VA_END	THAMES_USER_REGION_BASE
+
 struct thames_core;
 struct thames_device;
 struct thames_file_priv;
@@ -34,9 +41,18 @@ struct thames_gem_object {
 	dma_addr_t alloc_dma;
 	size_t alloc_size;
 
+	struct list_head bindings;
+
+	u32 flags;
 };
 
 
+int thames_ioctl_bo_create(struct drm_device *ddev, void *data, struct drm_file *file);
+
+int thames_ioctl_bo_mmap_offset(struct drm_device *ddev, void *data, struct drm_file *file);
+
+int thames_ioctl_bo_bind(struct drm_device *ddev, void *data, struct drm_file *file);
+
 int thames_context_create(struct thames_file_priv *priv);
 
 void thames_context_destroy(struct thames_file_priv *priv);
@@ -44,6 +60,11 @@ void thames_context_rewrite_entries(struct thames_core *core);
 
 void thames_context_va_fini(struct thames_file_priv *priv);
 
+struct thames_gem_object *thames_context_find_bo(struct thames_file_priv *priv, u64 start,
+						 u64 end, u64 *offset);
+
+u64 thames_bo_dsp_va(struct thames_gem_object *bo, struct thames_file_priv *priv);
+
 static inline struct thames_gem_object *to_thames_bo(struct drm_gem_object *obj)
 {
 	return container_of(obj, struct thames_gem_object, base.base);
diff --git a/include/uapi/drm/thames_accel.h b/include/uapi/drm/thames_accel.h
index af427a29b585..ea556b48f1d7 100644
--- a/include/uapi/drm/thames_accel.h
+++ b/include/uapi/drm/thames_accel.h
@@ -45,15 +45,116 @@ extern "C" {
  * definitions instead.
  */
 enum drm_thames_ioctl_id {
+	/** @DRM_THAMES_BO_CREATE: Create a buffer object. */
+	DRM_THAMES_BO_CREATE,
+
+	/**
+	 * @DRM_THAMES_BO_MMAP_OFFSET: Get the file offset to pass to
+	 * mmap to map a GEM object.
+	 */
+	DRM_THAMES_BO_MMAP_OFFSET,
+
 	/** @DRM_THAMES_DEV_QUERY: Query the device's capabilities. */
 	DRM_THAMES_DEV_QUERY,
 
+	/**
+	 * @DRM_THAMES_BO_BIND: Bind buffers into the file's Context at the
+	 * addresses the client chooses, or unbind them.
+	 */
+	DRM_THAMES_BO_BIND,
 };
 
 /**
  * DOC: IOCTL arguments
  */
 
+/**
+ * enum drm_thames_bo_flags - Buffer object flags, passed at creation time.
+ *
+ * A buffer with neither permission flag is user read-write and execute-never;
+ * DRM_THAMES_BO_CONTIGUOUS chooses the backing, not the permissions.
+ */
+enum drm_thames_bo_flags {
+	/**
+	 * @DRM_THAMES_BO_READ_ONLY: Mapped user read-only in the Context.  For
+	 * the params, the coefficients and the constants, so that a Kernel
+	 * cannot alter the inputs of a Job's next run.
+	 */
+	DRM_THAMES_BO_READ_ONLY = 1 << 0,
+
+	/**
+	 * @DRM_THAMES_BO_EXECUTABLE: Mapped user read-execute and not
+	 * writable.  Required of a Job's program.
+	 */
+	DRM_THAMES_BO_EXECUTABLE = 1 << 1,
+
+	/**
+	 * @DRM_THAMES_BO_CONTIGUOUS: Backed by one physically contiguous
+	 * allocation, so that a transfer of a Job can name it.  For the buffers
+	 * a DRU transfer reads or writes; any other buffer is backed page by
+	 * page.
+	 */
+	DRM_THAMES_BO_CONTIGUOUS = 1 << 2,
+};
+
+/**
+ * struct drm_thames_bo_create - Arguments passed to DRM_IOCTL_THAMES_BO_CREATE.
+ *
+ * Returns a handle and no address; the buffer is bound in no Context until
+ * DRM_IOCTL_THAMES_BO_BIND.
+ */
+struct drm_thames_bo_create {
+	/**
+	 * @size: Requested size for the object
+	 *
+	 * The (page-aligned) allocated size for the object will be returned.
+	 */
+	__u64 size;
+
+	/**
+	 * @handle: MBZ on input; returns the object's handle, which is nonzero.
+	 */
+	__u32 handle;
+
+	/** @flags: Combination of &enum drm_thames_bo_flags. */
+	__u32 flags;
+};
+
+/**
+ * struct drm_thames_bo_mmap_offset - Arguments passed to DRM_IOCTL_THAMES_BO_MMAP_OFFSET.
+ */
+struct drm_thames_bo_mmap_offset {
+	/** @handle: Handle of the object we want an mmap offset for. */
+	__u32 handle;
+
+	/** @pad: MBZ. */
+	__u32 pad;
+
+	/** @offset: The fake offset to use for subsequent mmap calls. */
+	__u64 offset;
+};
+
+/**
+ * struct drm_thames_obj_array - An array of versioned objects passed by pointer.
+ *
+ * The stride is the size of the object userspace was built against, so a
+ * structure can grow at its end under a minor bump.
+ * The kernel reads each element with copy_struct_from_user(): a stride smaller
+ * than its own size has the rest read as zero, down to the size the structure
+ * had when it entered the uAPI and no smaller; a larger stride is accepted only
+ * if the bytes the kernel does not know are zero.
+ */
+struct drm_thames_obj_array {
+	/** @stride: Size of one element in bytes. */
+	__u32 stride;
+
+	/** @count: Number of elements. */
+	__u32 count;
+
+	/** @array: User pointer to the first element. */
+	__u64 array;
+};
+
 /**
  * struct drm_thames_range - A range of the Context's address space.
  */
@@ -65,6 +166,73 @@ struct drm_thames_range {
 	__u64 size;
 };
 
+/**
+ * DOC: Bind operation flags
+ *
+ * - %DRM_THAMES_BIND_OP_UNBIND: Unbind the buffer from the Context instead
+ *   of binding it; &drm_thames_bind_op.dsp_va must be 0.
+ */
+#define DRM_THAMES_BIND_OP_UNBIND	(1 << 0)
+
+/**
+ * struct drm_thames_bind_op - One operation of DRM_IOCTL_THAMES_BO_BIND
+ *
+ * A bind maps the whole buffer at @dsp_va in every page table of the file's
+ * Context, with the permissions of its creation flags; an unbind removes the
+ * mapping.  A buffer is bound at most once in a Context, at one address, over
+ * no range another buffer is bound in.  A buffer shared through a dma-buf may
+ * be bound in each importing file's Context, each at its own address.  The
+ * kernel maps 2 MiB blocks where both the address and the buffer's pages are
+ * 2 MiB aligned, so a client aligns a buffer of 2 MiB or more to 2 MiB.
+ *
+ * Unbinding a buffer a submitted Job still reaches through the MMU is the
+ * client's error: the mapping goes at once, and the Job faults in the client's
+ * own Context as on any other fault.  A Job's transfers keep the buffers they
+ * reach, whether bound or not, until the Job is destroyed.  Freeing a bound
+ * buffer unbinds it.
+ */
+struct drm_thames_bind_op {
+	/** @handle: The buffer. */
+	__u32 handle;
+
+	/**
+	 * @flags: 0 to bind the buffer at @dsp_va,
+	 * %DRM_THAMES_BIND_OP_UNBIND to unbind it.
+	 */
+	__u32 flags;
+
+	/**
+	 * @dsp_va: Where the buffer is bound in the DSP's address space,
+	 * page-aligned, the buffer wholly inside
+	 * &drm_thames_caps.dsp_va_range; 0 for an unbind.
+	 *
+	 * The address the core's MMU translates through the Context's page
+	 * table, the same on every core.  It is the number userspace embeds
+	 * in params and Kernel code.  It is neither the bus address the page
+	 * table entries hold nor the CPU address mmap returns.
+	 */
+	__u64 dsp_va;
+};
+
+/**
+ * struct drm_thames_bo_bind - Arguments passed to DRM_IOCTL_THAMES_BO_BIND
+ *
+ * The operations are applied in order and each is done when the call
+ * returns.  The call stops at the first operation that fails and returns its
+ * error; the operations before it hold, and @ops.count is set to their
+ * number.
+ */
+struct drm_thames_bo_bind {
+	/** @flags: MBZ. */
+	__u32 flags;
+
+	/** @pad: MBZ. */
+	__u32 pad;
+
+	/** @ops: Array of &struct drm_thames_bind_op, applied in order. */
+	struct drm_thames_obj_array ops;
+};
+
 /**
  * enum drm_thames_dev_query_type - Query type
  *
@@ -126,9 +294,16 @@ struct drm_thames_caps {
 	 */
 	__u64 dru_realtime_dsp_va;
 
+	/**
+	 * @dsp_va_range: The span of the Context's address space the client
+	 * binds its buffers in with DRM_IOCTL_THAMES_BO_BIND.  The windows
+	 * above sit below it and @user_region above it.
+	 */
+	struct drm_thames_range dsp_va_range;
+
 	/**
 	 * @user_region: Where the kernel driver maps the Context's user stack
-	 * and save page.
+	 * and save page, outside @dsp_va_range.
 	 */
 	struct drm_thames_range user_region;
 
@@ -189,8 +364,14 @@ struct drm_thames_dev_query {
 			   struct drm_thames_ ## __type)
 
 enum {
+	DRM_IOCTL_THAMES_BO_CREATE =
+		DRM_IOCTL_THAMES(WR, BO_CREATE, bo_create),
+	DRM_IOCTL_THAMES_BO_MMAP_OFFSET =
+		DRM_IOCTL_THAMES(WR, BO_MMAP_OFFSET, bo_mmap_offset),
 	DRM_IOCTL_THAMES_DEV_QUERY =
 		DRM_IOCTL_THAMES(WR, DEV_QUERY, dev_query),
+	DRM_IOCTL_THAMES_BO_BIND =
+		DRM_IOCTL_THAMES(WR, BO_BIND, bo_bind),
 };
 
 #if defined(__cplusplus)

-- 
2.54.0

