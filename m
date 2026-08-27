Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B16FC61DC7
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9901310F030;
	Thu, 27 Aug 2026 12:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SZkSsdFM";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C5010F01C
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 12:49:23 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-495590dde14so19227105e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787834962; x=1788439762; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PdtcQXS1rWUi6eamqDxtKl/B421piV9fpujYC0gePHo=;
 b=SZkSsdFMMyyNRdldgAQRu3XqaMTHb+tOw7HYz5/kKTMlxpjlnajhfn5t8JJERWoo9b
 xYt3ReFssBssA5hM7n/hlzr5YsZDhlHLzI2CFBC3APAInP+FlCiiVurl7/l9vN6qhiSX
 NONcFMquYEsyNuyQoGhBc91mmZEPRxvf0WJXTXufxnSYEqJP3VpHZPjnabvScmEo0pvi
 EPk8Nm90vUYH1KuQdkytXu4ULRhCpKaqWGjACFl5sdtwAvzjtiDwgXC1jOnwZY21bT9G
 bhIFbDSNWcCdqf/TXevcXhgSd1uBYUr76qcJHotPaPdS8qx62q6kLASoFHTD4TE+70xb
 Bn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834962; x=1788439762;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PdtcQXS1rWUi6eamqDxtKl/B421piV9fpujYC0gePHo=;
 b=YJKVxPSY+p/XipwJWNOlVlbX83U59x14jlOJnsvejiUg95SghkpN1+/XE4aeAEgeg0
 NdYwnvTb3Zm6+oUlHpXLLQwvKh9bfOdo1V3wkMpAl3yeHlMg0yYTDOroDK/T49phYG/H
 2pm1u144OIZfz8cV3QUizr9rsOYEwzGrzhPwX/nKtgoPW4fufvYdJkqy9VTujA7UgUAA
 cTZ+ct927BlL7WXSOTWm49us7AQNiJLk1FqyyG3N2a2USqxVXXD+hpY6UWzJoPcARihY
 GT+0leV12qK7Qm6ddKeFtUpCAU7VOccaI1GvxlFFfnshnpPIv7uEfFkJEzjOjRNiZOgA
 LPZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9v4x9MiF297na/DQu4fb5ZRCN1BEycwhfYDt8hzctCWIfVK3JU9jGmibeGYcIBvyv5r0Bc7ALxvQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++krK83KpQ+oHymVwj6WwB/yQbOgG9KEexi7+2DuwkN23BC1WsjK
 2Quq6vxwMGMjvgycbwrsZAgFiBCA0UBxEtY7yxT6B8UqRHpymF1doWrw
X-Gm-Gg: AR+sD13616X2iel5tHVcAutcejM/9aHZbkwMa+6omUveOJ++YgbcGc+3aEg5iegZjrd
 8+fvIaRcWt5QqsD8fRWHSJXi6STIgTiYMvTHgREpV46UWLwGuRysUp1P4Rfi+JVJdKqAI3pgcd3
 5RVMehyMO76iU95PxoKaAFBVRsY/DmcMuDRiL70t4ckVQUlttAV1xwG0Lrjf88o5SMqu8oUDCdX
 bUaGKjI5Ykx5ZAghLMBKcAJUJ3KlUxVuOWZXSlltA7KiJArkPYMzgqFEhnjSQ0CIBK2RTlyNbqN
 P8QjzJpFDY2+ixCvSwt+VYyGX+nF0qgngZ+HbGGnx/j3FL9Mem7S7dOqGDdchev+LUr/aDsF0AQ
 aGghjcC8QAos1mVY28Shoa1Oqfo+VygTroDs9CELIwfJRd/wPhfDEQZMN4nenf3WUGgy1/wo2Ik
 hCzAzKV2vRFaF/lPIzosPEt9nfWNz911+dp7rfiH2XTZaoBYS1IbSZKFf5gAeSSEmnpfCUz/T1o
 w==
X-Received: by 2002:a05:600d:6445:10b0:49a:5b88:f551 with SMTP id
 5b1f17b1804b1-49a5b890419mr109246385e9.6.1787834961801; 
 Thu, 27 Aug 2026 05:49:21 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1524:4300:a4b8:720e:f64f:4778])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b465226d8sm52089985e9.0.2026.08.27.05.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:49:21 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/10] drm/i915/gt: Use dma_resv_alloc for VM reservation
 objects
Date: Thu, 27 Aug 2026 14:38:56 +0200
Message-ID: <20260827124910.2245-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827124910.2245-1-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Replace the embedded dma_resv (_resv) in struct i915_address_space
with a dynamically allocated one using dma_resv_alloc(). This aligns
with the move away from embedded dma_resv structures and towards
reference-counted dynamic allocation throughout the DRM subsystem.

The i915 address space structures (GGTT, PPGTT) maintain their own
reservation locks for page directory objects and buffer pools. By
switching to dynamic allocation, we reduce the size of the VM structures
and gain proper error handling if allocation fails.

Changes include:
- Convert i915_address_space._resv from embedded struct to pointer
- Update i915_address_space_init() to return int for error handling
- Update ppgtt_init() to return int and handle allocation failures
- Update all callers in GGTT, PPGTT, gen6_ppgtt, and gen8_ppgtt code
- Update helper functions like i915_vm_resv_get() to use pointer
- Add proper cleanup on allocation failures

All initialization functions now check the allocation and return
-ENOMEM if it fails, with appropriate cleanup of already-allocated
resources.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c  |  7 ++++++-
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c  |  7 ++++++-
 drivers/gpu/drm/i915/gt/intel_ggtt.c  | 14 ++++++++++----
 drivers/gpu/drm/i915/gt/intel_gtt.c   | 13 +++++++++----
 drivers/gpu/drm/i915/gt/intel_gtt.h   |  8 ++++----
 drivers/gpu/drm/i915/gt/intel_ppgtt.c | 16 ++++++++++++----
 6 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
index 438cd4724ac4..f8586467aef6 100644
--- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
@@ -437,7 +437,12 @@ struct i915_ppgtt *gen6_ppgtt_create(struct intel_gt *gt)
 
 	mutex_init(&ppgtt->flush);
 
-	ppgtt_init(&ppgtt->base, gt, 0);
+	err = ppgtt_init(&ppgtt->base, gt, 0);
+	if (err) {
+		kfree(ppgtt);
+		return ERR_PTR(err);
+	}
+
 	ppgtt->base.vm.pd_shift = ilog2(SZ_4K * SZ_4K / sizeof(gen6_pte_t));
 	ppgtt->base.vm.top = 1;
 
diff --git a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
index cfa09b250a1b..21cb9db10688 100644
--- a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
@@ -1010,7 +1010,12 @@ struct i915_ppgtt *gen8_ppgtt_create(struct intel_gt *gt,
 	if (!ppgtt)
 		return ERR_PTR(-ENOMEM);
 
-	ppgtt_init(ppgtt, gt, lmem_pt_obj_flags);
+	err = ppgtt_init(ppgtt, gt, lmem_pt_obj_flags);
+	if (err) {
+		kfree(ppgtt);
+		return ERR_PTR(err);
+	}
+
 	ppgtt->vm.top = i915_vm_is_4lvl(&ppgtt->vm) ? 3 : 2;
 	ppgtt->vm.pd_shift = ilog2(SZ_4K * SZ_4K / sizeof(gen8_pte_t));
 
diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 3cc8df7b8fad..735f53fa648f 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -56,8 +56,11 @@ static void i915_ggtt_color_adjust(const struct drm_mm_node *node,
 static int ggtt_init_hw(struct i915_ggtt *ggtt)
 {
 	struct drm_i915_private *i915 = ggtt->vm.i915;
+	int ret;
 
-	i915_address_space_init(&ggtt->vm, VM_CLASS_GGTT);
+	ret = i915_address_space_init(&ggtt->vm, VM_CLASS_GGTT);
+	if (ret)
+		return ret;
 
 	ggtt->vm.is_ggtt = true;
 
@@ -1140,7 +1143,7 @@ void i915_ggtt_driver_late_release(struct drm_i915_private *i915)
 	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
 
 	GEM_WARN_ON(kref_read(&ggtt->vm.resv_ref) != 1);
-	dma_resv_put(&ggtt->vm._resv);
+	dma_resv_put(ggtt->vm._resv);
 }
 
 static unsigned int gen6_get_total_gtt_size(u16 snb_gmch_ctl)
@@ -1514,7 +1517,10 @@ static int ggtt_probe_hw(struct i915_ggtt *ggtt, struct intel_gt *gt)
 	ggtt->vm.gt = gt;
 	ggtt->vm.i915 = i915;
 	ggtt->vm.dma = i915->drm.dev;
-	dma_resv_init(&ggtt->vm._resv);
+
+	ggtt->vm._resv = dma_resv_alloc();
+	if (!ggtt->vm._resv)
+		return -ENOMEM;
 
 	if (GRAPHICS_VER(i915) >= 8)
 		ret = gen8_gmch_probe(ggtt);
@@ -1524,7 +1530,7 @@ static int ggtt_probe_hw(struct i915_ggtt *ggtt, struct intel_gt *gt)
 		ret = intel_ggtt_gmch_probe(ggtt);
 
 	if (ret) {
-		dma_resv_put(&ggtt->vm._resv);
+		dma_resv_put(ggtt->vm._resv);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
index 7b1bdb121c88..670cbe0b8cc0 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
@@ -197,7 +197,7 @@ static void __i915_vm_close(struct i915_address_space *vm)
 int i915_vm_lock_objects(struct i915_address_space *vm,
 			 struct i915_gem_ww_ctx *ww)
 {
-	if (vm->scratch[0]->base.resv == &vm->_resv) {
+	if (vm->scratch[0]->base.resv == vm->_resv) {
 		return i915_gem_object_lock(vm->scratch[0], ww);
 	} else {
 		struct i915_ppgtt *ppgtt = i915_vm_to_ppgtt(vm);
@@ -225,7 +225,7 @@ void i915_vm_resv_release(struct kref *kref)
 	struct i915_address_space *vm =
 		container_of(kref, typeof(*vm), resv_ref);
 
-	dma_resv_put(&vm->_resv);
+	dma_resv_put(vm->_resv);
 	mutex_destroy(&vm->mutex);
 
 	kfree(vm);
@@ -258,7 +258,7 @@ void i915_vm_release(struct kref *kref)
 	queue_work(vm->i915->wq, &vm->release_work);
 }
 
-void i915_address_space_init(struct i915_address_space *vm, int subclass)
+int i915_address_space_init(struct i915_address_space *vm, int subclass)
 {
 	kref_init(&vm->ref);
 
@@ -295,7 +295,10 @@ void i915_address_space_init(struct i915_address_space *vm, int subclass)
 		might_alloc(GFP_KERNEL);
 		mutex_release(&vm->mutex.dep_map, _THIS_IP_);
 	}
-	dma_resv_init(&vm->_resv);
+
+	vm->_resv = dma_resv_alloc();
+	if (!vm->_resv)
+		return -ENOMEM;
 
 	GEM_BUG_ON(!vm->total);
 	drm_mm_init(&vm->mm, 0, vm->total);
@@ -312,6 +315,8 @@ void i915_address_space_init(struct i915_address_space *vm, int subclass)
 
 	INIT_LIST_HEAD(&vm->bound_list);
 	INIT_LIST_HEAD(&vm->unbound_list);
+
+	return 0;
 }
 
 void *__px_vaddr(struct drm_i915_gem_object *p)
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.h b/drivers/gpu/drm/i915/gt/intel_gtt.h
index b54ee4f25af1..3976c176110f 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.h
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.h
@@ -266,7 +266,7 @@ struct i915_address_space {
 	struct mutex mutex; /* protects vma and our lists */
 
 	struct kref resv_ref; /* kref to keep the reservation lock alive. */
-	struct dma_resv _resv; /* reservation lock for all pd objects, and buffer pool */
+	struct dma_resv *_resv; /* reservation lock for all pd objects, and buffer pool */
 #define VM_CLASS_GGTT 0
 #define VM_CLASS_PPGTT 1
 #define VM_CLASS_DPT 2
@@ -504,7 +504,7 @@ static inline void assert_vm_alive(struct i915_address_space *vm)
 static inline struct dma_resv *i915_vm_resv_get(struct i915_address_space *vm)
 {
 	kref_get(&vm->resv_ref);
-	return &vm->_resv;
+	return vm->_resv;
 }
 
 void i915_vm_release(struct kref *kref);
@@ -525,7 +525,7 @@ static inline void i915_vm_resv_put(struct i915_address_space *vm)
 	kref_put(&vm->resv_ref, i915_vm_resv_release);
 }
 
-void i915_address_space_init(struct i915_address_space *vm, int subclass);
+int i915_address_space_init(struct i915_address_space *vm, int subclass);
 void i915_address_space_fini(struct i915_address_space *vm);
 
 static inline u32 i915_pte_index(u64 address, unsigned int pde_shift)
@@ -583,7 +583,7 @@ i915_page_dir_dma_addr(const struct i915_ppgtt *ppgtt, const unsigned int n)
 	return __px_dma(pt ? px_base(pt) : ppgtt->vm.scratch[ppgtt->vm.top]);
 }
 
-void ppgtt_init(struct i915_ppgtt *ppgtt, struct intel_gt *gt,
+int ppgtt_init(struct i915_ppgtt *ppgtt, struct intel_gt *gt,
 		unsigned long lmem_pt_obj_flags);
 void intel_ggtt_bind_vma(struct i915_address_space *vm,
 			 struct i915_vm_pt_stash *stash,
diff --git a/drivers/gpu/drm/i915/gt/intel_ppgtt.c b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
index 72d8473a448b..9abd4faa2e55 100644
--- a/drivers/gpu/drm/i915/gt/intel_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
@@ -304,8 +304,8 @@ void i915_vm_free_pt_stash(struct i915_address_space *vm,
 	}
 }
 
-void ppgtt_init(struct i915_ppgtt *ppgtt, struct intel_gt *gt,
-		unsigned long lmem_pt_obj_flags)
+int ppgtt_init(struct i915_ppgtt *ppgtt, struct intel_gt *gt,
+	       unsigned long lmem_pt_obj_flags)
 {
 	struct drm_i915_private *i915 = gt->i915;
 
@@ -315,9 +315,17 @@ void ppgtt_init(struct i915_ppgtt *ppgtt, struct intel_gt *gt,
 	ppgtt->vm.total = BIT_ULL(RUNTIME_INFO(i915)->ppgtt_size);
 	ppgtt->vm.lmem_pt_obj_flags = lmem_pt_obj_flags;
 
-	dma_resv_init(&ppgtt->vm._resv);
-	i915_address_space_init(&ppgtt->vm, VM_CLASS_PPGTT);
+	ppgtt->vm._resv = dma_resv_alloc();
+	if (!ppgtt->vm._resv)
+		return -ENOMEM;
+
+	if (i915_address_space_init(&ppgtt->vm, VM_CLASS_PPGTT)) {
+		dma_resv_put(ppgtt->vm._resv);
+		return -ENOMEM;
+	}
 
 	ppgtt->vm.vma_ops.bind_vma    = ppgtt_bind_vma;
 	ppgtt->vm.vma_ops.unbind_vma  = ppgtt_unbind_vma;
+
+	return 0;
 }
-- 
2.43.0

