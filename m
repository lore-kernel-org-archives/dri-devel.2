Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E211C79F8E
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89AE010F5E8;
	Thu,  3 Sep 2026 13:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ctuN9rlY";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0BB10F5D9
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:44:21 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48431648f33so712705f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788443059; x=1789047859; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6klaXJvfXq947sYWFvExSHm1VkoJDuNrl0THSIIZjfw=;
 b=ctuN9rlYD2MKZz9+0KDh1QRo/Cu6+mYWxiR7omi9LNdi3g8/oLFd06o7lqxBoV37YY
 3HUxzXBQDbibipvgDrpP8z6OrhFcdxsPqLD8gkYklxlVjZ2v4v/EXUYeESK7NKAkcymD
 dC9x0PNffCAJfvAHI4baz0v6Au5d0hJMijCKombpLaKqhvYOO12DR0tiM47Y0BOuhahJ
 2I1Gszuf8rl2eo8EkX7fytLzG6GZJmtTEabkfp2KSE0dgYt2LGNa/dvINOO2wVGOKSkm
 RuJZayRHWMvdRaNED5jrh3/y/HQrhxWg2n6hBqQOm/8A9rz/oDntd0Uq78jMsrsUMYrf
 lDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443059; x=1789047859;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6klaXJvfXq947sYWFvExSHm1VkoJDuNrl0THSIIZjfw=;
 b=lViPkie7v4zs5V6udIZiULmazr6XAs7d8QWRu7m1kM5hbLhD6tTRqkbgte7UkzXAfr
 5Xg9cMR4eANDurNeidCWai4qcnR1Q9CCzhHPqQ0mNL7JYmUETWkeMX6tvKwV6AySzstm
 3GN8J6sbZH1ooBJCupOktXp6BFdqiH0609RrH6XQdySbdTxwZOKX964CRRelqcbSgNsi
 FnUp29ejbyPhOMOQ0y+9ng9MWnvu/5tVYq/dLHYGE0pfviK6WpkmKCKF4ehbNmSINUjK
 Q3STIAdEHdCqo9Ltb5Xyogp0uf0lfRkHMqV7vL0SjHkz+FDTRPULh56LjPasNCO/rY0q
 FTlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBsQrgPUD3c1p2cOjR2JzGkhlGbqpIV9Ua2OuG2L/gSuUgGESBq5JJUkGmlQtkeocNwfMfU7ZT7Gw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++njR9rgi/laKX5ArDwKaKcYbkDSEYIc+ZNNr1XmVtQszF32AHle
 nJ9jS8386LKL6POBKg+2LUloEGOfZmEhJzc5rKf1AN7ovRX4lOhCwBas
X-Gm-Gg: AYBFou2hzI7ZDX9LwAHyqqdWW1E7Dsr0U+0o1hE22z7PSPXTor8N551SOkqf5URE8Ff
 ek+Qg23rN1z/OUvcmla4voSL4WlcxiXxup1uLbKo7kVEAH81GbwxPTBWxWncDKcPtTQnEMzaJlv
 Mc3gfpn7q6k6VyUyn6HDAPSe2UtxVFi/6uImKugk5Bt4RYNxbt0PuOBZGc3+0mH2jiceynKncUw
 HM0xlmKbtuQ4F7pUgzSaenhuTqQssBWVhdj1h6ejIz9CBT561ByR1kqVZiGxQBWAuQnjEqRfbdj
 3n+RrYAnPhDyopvCSrdJS63S0pvSZBxENNaorI/xRow/tX5+Y+27KPoOHV/gXytyFIRXYF1vJqb
 PTENBMFtpcMEXWgqp944IzQW4pT0bMAsuDyw8W8iL5xG4uNm9ufwOlKcgdE/i34rjkUPK1VQPm2
 BWYWHlC3wisrcqwKzpJxxWf4/MULAU+LMt4C+FKN0+X6XXy6SLSYTAC/+QU17cI7rxmbb8ZZzrb
 Q==
X-Received: by 2002:a7b:c044:0:b0:49c:f501:e428 with SMTP id
 5b1f17b1804b1-49cf501e471mr14994485e9.8.1788443059191; 
 Thu, 03 Sep 2026 06:44:19 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm13597080f8f.5.2026.09.03.06.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:18 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/11] drm/i915/gt: Use dma_resv_alloc for VM reservation
 objects v2
Date: Thu,  3 Sep 2026 15:28:03 +0200
Message-ID: <20260903134408.105317-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903134408.105317-1-christian.koenig@amd.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
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
- i915_dpt_create(): now returns ERR_PTR on failure
- mock_ppgtt(): now returns NULL on failure
- mock_init_ggtt(): changed to return int and propagate errors
- Add proper cleanup on allocation failures

All initialization functions now check the allocation and return
-ENOMEM if it fails, with appropriate cleanup of already-allocated
resources.

v2: Remove unnecessary dma_resv allocations from ggtt_probe_hw() and
    ppgtt_init(). i915_address_space_init() already handles _resv
    allocation at the correct point in the initialization sequence.
    Add some missing error handling.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c             |  7 ++++++-
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c             |  7 ++++++-
 drivers/gpu/drm/i915/gt/intel_ggtt.c             | 12 ++++++------
 drivers/gpu/drm/i915/gt/intel_gtt.c              | 13 +++++++++----
 drivers/gpu/drm/i915/gt/intel_gtt.h              |  8 ++++----
 drivers/gpu/drm/i915/gt/intel_ppgtt.c            | 12 ++++++++----
 drivers/gpu/drm/i915/i915_dpt.c                  |  7 ++++++-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c    |  4 +++-
 drivers/gpu/drm/i915/selftests/i915_vma.c        |  4 +++-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c |  5 ++++-
 drivers/gpu/drm/i915/selftests/mock_gtt.c        |  9 ++++++---
 drivers/gpu/drm/i915/selftests/mock_gtt.h        |  2 +-
 12 files changed, 62 insertions(+), 28 deletions(-)

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
index 3cc8df7b8fad..b7f64aaeb768 100644
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
@@ -1514,7 +1517,6 @@ static int ggtt_probe_hw(struct i915_ggtt *ggtt, struct intel_gt *gt)
 	ggtt->vm.gt = gt;
 	ggtt->vm.i915 = i915;
 	ggtt->vm.dma = i915->drm.dev;
-	dma_resv_init(&ggtt->vm._resv);
 
 	if (GRAPHICS_VER(i915) >= 8)
 		ret = gen8_gmch_probe(ggtt);
@@ -1523,10 +1525,8 @@ static int ggtt_probe_hw(struct i915_ggtt *ggtt, struct intel_gt *gt)
 	else
 		ret = intel_ggtt_gmch_probe(ggtt);
 
-	if (ret) {
-		dma_resv_put(&ggtt->vm._resv);
+	if (ret)
 		return ret;
-	}
 
 	if ((ggtt->vm.total - 1) >> 32) {
 		drm_err(&i915->drm,
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
index 161e4b73b3df..7db6b6929677 100644
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
index 72d8473a448b..b944f4f10749 100644
--- a/drivers/gpu/drm/i915/gt/intel_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
@@ -304,10 +304,11 @@ void i915_vm_free_pt_stash(struct i915_address_space *vm,
 	}
 }
 
-void ppgtt_init(struct i915_ppgtt *ppgtt, struct intel_gt *gt,
-		unsigned long lmem_pt_obj_flags)
+int ppgtt_init(struct i915_ppgtt *ppgtt, struct intel_gt *gt,
+	       unsigned long lmem_pt_obj_flags)
 {
 	struct drm_i915_private *i915 = gt->i915;
+	int err;
 
 	ppgtt->vm.gt = gt;
 	ppgtt->vm.i915 = i915;
@@ -315,9 +316,12 @@ void ppgtt_init(struct i915_ppgtt *ppgtt, struct intel_gt *gt,
 	ppgtt->vm.total = BIT_ULL(RUNTIME_INFO(i915)->ppgtt_size);
 	ppgtt->vm.lmem_pt_obj_flags = lmem_pt_obj_flags;
 
-	dma_resv_init(&ppgtt->vm._resv);
-	i915_address_space_init(&ppgtt->vm, VM_CLASS_PPGTT);
+	err = i915_address_space_init(&ppgtt->vm, VM_CLASS_PPGTT);
+	if (err)
+		return err;
 
 	ppgtt->vm.vma_ops.bind_vma    = ppgtt_bind_vma;
 	ppgtt->vm.vma_ops.unbind_vma  = ppgtt_unbind_vma;
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/i915/i915_dpt.c b/drivers/gpu/drm/i915/i915_dpt.c
index fcd7cced771d..0c6e5ef72749 100644
--- a/drivers/gpu/drm/i915/i915_dpt.c
+++ b/drivers/gpu/drm/i915/i915_dpt.c
@@ -229,7 +229,12 @@ static struct intel_dpt *i915_dpt_create(struct drm_gem_object *obj, size_t size
 	vm->total = (size / sizeof(gen8_pte_t)) * I915_GTT_PAGE_SIZE;
 	vm->is_dpt = true;
 
-	i915_address_space_init(vm, VM_CLASS_DPT);
+	ret = i915_address_space_init(vm, VM_CLASS_DPT);
+	if (ret) {
+		kfree(dpt);
+		i915_gem_object_put(dpt_obj);
+		return ERR_PTR(ret);
+	}
 
 	vm->insert_page = dpt_insert_page;
 	vm->clear_range = dpt_clear_range;
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index 7eb254a0be57..1d1c41ca6fbb 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -1947,7 +1947,9 @@ int i915_gem_gtt_mock_selftests(void)
 
 	gt = to_gt(i915);
 
-	mock_init_ggtt(gt);
+	err = mock_init_ggtt(gt);
+	if (err)
+		goto out_put;
 
 	err = i915_subtests(tests, gt->ggtt);
 
diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
index 7c4111e60f2e..bf9c5e7df281 100644
--- a/drivers/gpu/drm/i915/selftests/i915_vma.c
+++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
@@ -942,7 +942,9 @@ int i915_vma_mock_selftests(void)
 
 	gt = to_gt(i915);
 
-	mock_init_ggtt(gt);
+	err = mock_init_ggtt(gt);
+	if (err)
+		goto out_put;
 
 	err = i915_subtests(tests, gt->ggtt);
 
diff --git a/drivers/gpu/drm/i915/selftests/mock_gem_device.c b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
index 796c9b070e41..7c409514653b 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gem_device.c
+++ b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
@@ -234,7 +234,10 @@ struct drm_i915_private *mock_gem_device(void)
 	if (ret)
 		goto err_unlock;
 
-	mock_init_ggtt(to_gt(i915));
+	ret = mock_init_ggtt(to_gt(i915));
+	if (ret)
+		goto err_unlock;
+
 	to_gt(i915)->vm = i915_vm_get(&to_gt(i915)->ggtt->vm);
 
 	to_gt(i915)->info.engine_mask = BIT(0);
diff --git a/drivers/gpu/drm/i915/selftests/mock_gtt.c b/drivers/gpu/drm/i915/selftests/mock_gtt.c
index 933990a8dc52..990c827137b2 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/mock_gtt.c
@@ -75,7 +75,10 @@ struct i915_ppgtt *mock_ppgtt(struct drm_i915_private *i915, const char *name)
 	ppgtt->vm.total = round_down(U64_MAX, PAGE_SIZE);
 	ppgtt->vm.dma = i915->drm.dev;
 
-	i915_address_space_init(&ppgtt->vm, VM_CLASS_PPGTT);
+	if (i915_address_space_init(&ppgtt->vm, VM_CLASS_PPGTT)) {
+		kfree(ppgtt);
+		return NULL;
+	}
 
 	ppgtt->vm.alloc_pt_dma = alloc_pt_dma;
 	ppgtt->vm.alloc_scratch_dma = alloc_pt_dma;
@@ -104,7 +107,7 @@ static void mock_unbind_ggtt(struct i915_address_space *vm,
 {
 }
 
-void mock_init_ggtt(struct intel_gt *gt)
+int mock_init_ggtt(struct intel_gt *gt)
 {
 	struct i915_ggtt *ggtt = gt->ggtt;
 
@@ -127,7 +130,7 @@ void mock_init_ggtt(struct intel_gt *gt)
 	ggtt->vm.vma_ops.bind_vma    = mock_bind_ggtt;
 	ggtt->vm.vma_ops.unbind_vma  = mock_unbind_ggtt;
 
-	i915_address_space_init(&ggtt->vm, VM_CLASS_GGTT);
+	return i915_address_space_init(&ggtt->vm, VM_CLASS_GGTT);
 }
 
 void mock_fini_ggtt(struct i915_ggtt *ggtt)
diff --git a/drivers/gpu/drm/i915/selftests/mock_gtt.h b/drivers/gpu/drm/i915/selftests/mock_gtt.h
index d6eb90bd7f3f..904b86253c99 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gtt.h
+++ b/drivers/gpu/drm/i915/selftests/mock_gtt.h
@@ -29,7 +29,7 @@ struct drm_i915_private;
 struct i915_ggtt;
 struct intel_gt;
 
-void mock_init_ggtt(struct intel_gt *gt);
+int mock_init_ggtt(struct intel_gt *gt);
 void mock_fini_ggtt(struct i915_ggtt *ggtt);
 
 struct i915_ppgtt *mock_ppgtt(struct drm_i915_private *i915, const char *name);
-- 
2.43.0

