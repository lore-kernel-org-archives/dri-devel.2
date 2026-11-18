Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8A606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WtYen5Dm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8469410E6B3;
	Wed, 18 Nov 2026 02:07:43 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E07410E68A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 02:07:37 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-3719e3cb82bso65498eec.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 18:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794967656; x=1795572456; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I3dICNFdr3DWOw64MCFV6kwJXPRZS9N3sYYYv1odNCg=;
 b=WtYen5Dm0xKb2C1YMwac8GUY07+jr9/yjXRJ4rimBBXUQpb8fk0ZQyU1t13xMzRXl/
 tLS+6S49ilDvXY/t5TpF4SymNU3M9F/tlr92prMxV9sxLvAxaGlE2BkOWlONp/nwYb+V
 EFj2p0q784Cb6+cT9x/0PDN2En/vOYYBty8gm8t3Zm71nmwEh8OZcUIkFd9xdNmoWx35
 6ZmEMj7N9dBOuOObbwnp9SUPKGzqnStBZaR5SykCMVEJ5aDLfpTGadewsx5dtlVppMqT
 wZa3prVYp/7g/alrEMGmNUDZTH4a03PnuhlWxi7VId2QSVDuZutA8HFTcXICAY1ZJQc1
 R2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794967656; x=1795572456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I3dICNFdr3DWOw64MCFV6kwJXPRZS9N3sYYYv1odNCg=;
 b=O0PqHowhmhegzqkBZ7mf+eUvL05pkUvx54P+UOTsw/7z9FtfFugOWgj5iyNxS108jP
 x+TWaH32OUq5ivdC5nk2DGmCQEqqsj7BXPPl8qBEqcddBnxJlB5GPLH5mwCb24behS0Z
 iEcY8cUuW3wwR0zyfKkswvPXzrOst1BoK6DDl8xnmsuU8J7OxGpp8uNuRW4rP667bZ21
 fEI9UgXlY9c4xMPsqgpvEox1Fn7c4YN7Ilyok9QTFrxGVUBe0yiFyOnMCSZ+MlzZfdwG
 yMxTtqNTD7mlkLO0dioe01mNoNHPsW0WC1rZR0h4e3VG3iOYR7ltJLt0ELJtQZvEP7gF
 VbQg==
X-Forwarded-Encrypted: i=1;
 AL+hErEGKAMH7O1Y5QuNDDR3upJJvbto5URhN9vah2AzkP49NE/nfve3yroiiQ8o5YMxFWkgT8PnsF1svQY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9GZnhWhuJtjXDvjQZvHT6F19fk1tC5jeq+ccCUJfsQtapCuQN0
 HAcuMrvzqHgZZyqvqBrq15yW80XLP5LH4C2xJBvPHhYHDSurQ3vYmSaS
X-Gm-Gg: AYBFou2Dmuwd33juvpaZfoHyTVq6BYZKEhDHu1Vyue4dqsqc5sSeM+d+4Xz1g7ykQD+
 /oEwxxWeoWmoOfT1CLlZyJjpyxuTy0HyiRgydWIvb5Oyc0PzDe0Fs1yvs3lfOUm8Vc+ebJYwwsK
 yh3ut3mlhJpx/dRS5eZ/xrpE6P0QsnMFc8U3ubcaypRrIHwc6y+rlyGwSNoKt2xAwfdpjpb86+5
 9sGZLegZWQvMZYUHRiTjtnz4z59d3hTmqKxhjXsqH0Q+i8V+Mw9+behKMtldv5HFoMlAbOgmmJS
 vNYvP7Gv1XpY8FoHktFUjWSPG7szKLuPnjaPnBRc8dQrZVzL03yU4ct0gs1V8aKtkoF/s9Hk7EO
 FY3UkAiVEf/swJNkh4rR0e5BXmiEuMcijllhuiYR4UZGU7fEtHtaYIQ69Pd+5x+bZ7C29ehDFq0
 cAn7rJ/nTj9K8iD0Oyfcsde7YBC96P57/qyhdGhYzC9weYwJ7o+jF7IvTAeXRWZr6k5HnDOiM4Y
 kR4sznPPy+/ZhHAPCeQSJt4MZHDmD48kkk5AohrLii3JqIWpNoNrPmMiSidtsLSpY9jurZ6hP4o
 ETwIy2ro+bXYP/VBNWFi3aDy9HMBDSJdiZE0VtyHmtZhNv0S49pNqIFnLSjcKq7FOdQb569oK9D
 mRgaQSTM=
X-Received: by 2002:a05:701b:2706:b0:183:d275:cf76 with SMTP id
 a92af1059eb24-1b543b93021mr2097351c88.2.1794967656267; 
 Tue, 17 Nov 2026 18:07:36 -0800 (PST)
Received: from DESKTOP-CJ1L666.dankook.ac.kr ([220.149.255.57])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b544784008sm2862327c88.5.2026.11.17.18.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 18:07:35 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Julius Bairaktaris <julius@bairaktaris.de>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v4 2/5] drm/msm: Mark the VM unusable on out-of-order VM_BIND
 unmaps
Date: Wed, 18 Nov 2026 11:07:13 +0900
Message-ID: <20261118020716.1698-3-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020716.1698-1-arpe1618@gmail.com>
References: <20261118020716.1698-1-arpe1618@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

msm_ioctl_vm_bind() updates the VMAs of the VM right away, and queues
the matching pgtable updates on the job, but the VM_BIND jobs of
different queues are not ordered against each other. A job can thus
unmap a VMA before the job of another queue that maps it has run. The
unmap then finds nothing mapped, and drops the reference that its op
holds on the object. When the map runs after it, the pages it maps are
neither tracked by a VMA nor kept alive by a reference once that job is
done.

Userspace is expected to order VM_BIND jobs that touch the same range,
but the kernel must not end up with freed pages mapped when it does
not. Treat an unmap that finds part of its range not mapped like a
failed map: skip the remaining maps of the job and mark the VM
unusable, after which SUBMIT and VM_BIND fail with -EPIPE. VM_BIND
pgtables only use single-page granules, so such an unmap error only
means that part of the range was not mapped.

That alone does not catch an unmap that runs while the range still
holds the pages of an older mapping, whose own unmap is still queued on
a third queue. So also have the VMAs that a job maps, and the unmap ops
that undo them, refer to a small refcounted object that tells whether
the job has applied its updates, and handle an unmap that comes before
the map it undoes the same way. In msm_vma_job_run(), read
vm->unusable, and set it on such an error, under mmu_lock, which also
protects the done state, so that the result does not depend on the
jobs of a VM being run one at a time.

A job that fails in msm_ioctl_vm_bind() after it queued pgtable updates
is freed without applying them, so the VM no longer matches its
pgtables, and a later unmap of one of its VMAs would be taken for an
out-of-order one. Mark the VM unusable in that case too.

The patch and its changelog were drafted with an AI coding assistant.
The issue has not been reproduced, and the change has only been
compile-tested.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-214650@kernel.org
Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
Link: https://lore.kernel.org/r/CACSVV00ZppfBKwsHJ+NBYBB7a2f3g1O=6J4Gt1m_A74fudZQoQ@mail.gmail.com
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
VMAs that the shrinker unmapped are no longer marked mapped, so no unmap
is queued for them, and a VMA whose map has been applied is fully
mapped, as VM_BIND pgtables only use single-page granules. So the new
errors should not trigger for userspace that orders its VM_BIND jobs.

Not addressed here: a queued unmap only holds a reference on its
object, which does not keep the shrinker from purging or evicting the
pages before the unmap is applied. Julius Bairaktaris' "drm/msm: Keep
objects of queued VM_BIND unmaps busy" addresses that:
https://lore.kernel.org/r/20261111080619.244138-1-julius@bairaktaris.de

 drivers/gpu/drm/msm/msm_gem.h     |   7 ++
 drivers/gpu/drm/msm/msm_gem_vma.c | 126 ++++++++++++++++++++++++++++--
 2 files changed, 127 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index d8ec696d89d7..3174460def2e 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -164,6 +164,7 @@ void msm_gem_vm_close(struct drm_gpuvm *gpuvm);
 void msm_gem_vm_unusable(struct drm_gpuvm *gpuvm);
 
 struct msm_fence_context;
+struct msm_vm_bind_done;
 
 #define MSM_VMA_DUMP (DRM_GPUVA_USERBITS << 0)
 
@@ -185,6 +186,12 @@ struct msm_gem_vma {
 
 	/** @mapped: Is this VMA mapped? */
 	bool mapped;
+
+	/**
+	 * @map_done: For a VMA created by a VM_BIND job, tells whether that
+	 * job has applied its pgtable updates.
+	 */
+	struct msm_vm_bind_done *map_done;
 };
 #define to_msm_vma(x) container_of(x, struct msm_gem_vma, base)
 
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 2f0698df1a9a..228c16a3d9e4 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -63,6 +63,12 @@ struct msm_vm_unmap_op {
 	 * a submitqueue (ie. process cleanup)
 	 */
 	int queue_id;
+
+	/**
+	 * @map_done: For an unmap queued by a VM_BIND job, tells whether the
+	 * map that it undoes has been applied.
+	 */
+	struct msm_vm_bind_done *map_done;
 };
 
 /**
@@ -97,6 +103,20 @@ struct msm_vm_op {
 	struct drm_gem_object *obj;
 };
 
+/**
+ * struct msm_vm_bind_done - Whether a VM_BIND job has applied its updates
+ *
+ * The VMAs that a VM_BIND job maps, and the unmap ops that undo them later,
+ * hold a reference to it, so that such an unmap can tell whether the map it
+ * undoes has been applied to the pgtables yet.
+ */
+struct msm_vm_bind_done {
+	/** @ref: reference count */
+	struct kref ref;
+	/** @done: the job has applied its updates, protected by vm->mmu_lock */
+	bool done;
+};
+
 /**
  * struct msm_vm_bind_job - Tracking for a VM_BIND ioctl
  *
@@ -119,6 +139,8 @@ struct msm_vm_bind_job {
 	struct msm_mmu_prealloc prealloc;
 	/** @vm_ops: a list of struct msm_vm_op */
 	struct list_head vm_ops;
+	/** @bind_done: whether the job has applied its updates to the pgtables */
+	struct msm_vm_bind_done *bind_done;
 	/** @bos_pinned: are the GEM objects being bound pinned? */
 	bool bos_pinned;
 	/** @nr_ops: the number of userspace requested ops */
@@ -156,6 +178,27 @@ static inline struct msm_vm_bind_job *to_msm_vm_bind_job(struct drm_sched_job *j
 	return container_of(job, struct msm_vm_bind_job, base);
 }
 
+static struct msm_vm_bind_done *
+vm_bind_done_get(struct msm_vm_bind_done *done)
+{
+	if (done)
+		kref_get(&done->ref);
+	return done;
+}
+
+static void
+vm_bind_done_release(struct kref *ref)
+{
+	kfree(container_of(ref, struct msm_vm_bind_done, ref));
+}
+
+static void
+vm_bind_done_put(struct msm_vm_bind_done *done)
+{
+	if (done)
+		kref_put(&done->ref, vm_bind_done_release);
+}
+
 static void
 msm_gem_vm_free(struct drm_gpuvm *gpuvm)
 {
@@ -243,7 +286,7 @@ vm_log(struct msm_gem_vm *vm, const char *op, uint64_t iova, uint64_t range, int
 	vm->log_idx = (vm->log_idx + 1) & ((1 << vm->log_shift) - 1);
 }
 
-static void
+static int
 vm_unmap_op(struct msm_gem_vm *vm, const struct msm_vm_unmap_op *op)
 {
 	const char *reason = op->reason;
@@ -253,7 +296,7 @@ vm_unmap_op(struct msm_gem_vm *vm, const struct msm_vm_unmap_op *op)
 
 	vm_log(vm, reason, op->iova, op->range, op->queue_id);
 
-	vm->mmu->funcs->unmap(vm->mmu, op->iova, op->range);
+	return vm->mmu->funcs->unmap(vm->mmu, op->iova, op->range);
 }
 
 static int
@@ -361,6 +404,7 @@ void msm_gem_vma_close(struct drm_gpuva *vma)
 	drm_gpuva_remove(vma);
 	drm_gpuva_unlink(vma);
 
+	vm_bind_done_put(msm_vma->map_done);
 	kfree(vma);
 }
 
@@ -484,6 +528,9 @@ vm_op_enqueue(struct op_arg *arg, struct msm_vm_op _op)
 	if (op->obj)
 		drm_gem_object_get(op->obj);
 
+	if (op->op == MSM_VM_OP_UNMAP)
+		vm_bind_done_get(op->unmap.map_done);
+
 	return 0;
 }
 
@@ -541,6 +588,7 @@ msm_gem_vm_sm_step_map(struct drm_gpuva_op *op, void *_arg)
 
 	vma->flags = ((struct op_arg *)arg)->flags;
 	to_msm_vma(vma)->mapped = true;
+	to_msm_vma(vma)->map_done = vm_bind_done_get(job->bind_done);
 
 	return 0;
 }
@@ -554,6 +602,7 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 	struct drm_gpuva *prev_vma = NULL, *next_vma = NULL;
 	struct drm_gpuvm_bo *vm_bo = orig_vma->vm_bo;
 	bool mapped = to_msm_vma(orig_vma)->mapped;
+	struct msm_vm_bind_done *map_done;
 	unsigned flags;
 	int ret;
 
@@ -571,6 +620,7 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 				.iova = unmap_start,
 				.range = unmap_range,
 				.queue_id = job->queue->id,
+				.map_done = to_msm_vma(orig_vma)->map_done,
 			},
 			.obj = orig_vma->gem.obj,
 		});
@@ -601,25 +651,34 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 	 */
 	flags = orig_vma->flags;
 
+	/* The pages of prev_vma and next_vma were mapped with orig_vma: */
+	map_done = vm_bind_done_get(to_msm_vma(orig_vma)->map_done);
+
 	msm_gem_vma_close(orig_vma);
 
 	if (op->remap.prev) {
 		prev_vma = vma_from_op(arg, op->remap.prev);
-		if (WARN_ON(IS_ERR(prev_vma)))
+		if (WARN_ON(IS_ERR(prev_vma))) {
+			vm_bind_done_put(map_done);
 			return PTR_ERR(prev_vma);
+		}
 
 		vm_dbg("prev_vma: %p:%p: %016llx %016llx", vm, prev_vma, prev_vma->va.addr, prev_vma->va.range);
 		to_msm_vma(prev_vma)->mapped = mapped;
+		to_msm_vma(prev_vma)->map_done = vm_bind_done_get(map_done);
 		prev_vma->flags = flags;
 	}
 
 	if (op->remap.next) {
 		next_vma = vma_from_op(arg, op->remap.next);
-		if (WARN_ON(IS_ERR(next_vma)))
+		if (WARN_ON(IS_ERR(next_vma))) {
+			vm_bind_done_put(map_done);
 			return PTR_ERR(next_vma);
+		}
 
 		vm_dbg("next_vma: %p:%p: %016llx %016llx", vm, next_vma, next_vma->va.addr, next_vma->va.range);
 		to_msm_vma(next_vma)->mapped = mapped;
+		to_msm_vma(next_vma)->map_done = vm_bind_done_get(map_done);
 		next_vma->flags = flags;
 	}
 
@@ -628,6 +687,7 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 
 	/* Drop the previous ref: */
 	drm_gpuvm_bo_put(vm_bo);
+	vm_bind_done_put(map_done);
 
 	return 0;
 }
@@ -678,6 +738,7 @@ msm_gem_vm_sm_step_unmap(struct drm_gpuva_op *op, void *_arg)
 			.iova = vma->va.addr,
 			.range = vma->va.range,
 			.queue_id = job->queue->id,
+			.map_done = msm_vma->map_done,
 		},
 		.obj = vma->gem.obj,
 	});
@@ -701,6 +762,16 @@ static const struct drm_gpuvm_ops msm_gpuvm_ops = {
 	.sm_step_unmap = msm_gem_vm_sm_step_unmap,
 };
 
+/*
+ * Whether the map that an unmap op of @job undoes has been applied.  The ops
+ * of @job itself are applied in order, so its own maps come first.
+ */
+static bool
+vm_bind_map_done(struct msm_vm_bind_job *job, struct msm_vm_bind_done *map_done)
+{
+	return !map_done || map_done == job->bind_done || map_done->done;
+}
+
 static struct dma_fence *
 msm_vma_job_run(struct drm_sched_job *_job)
 {
@@ -708,13 +779,16 @@ msm_vma_job_run(struct drm_sched_job *_job)
 	struct drm_device *dev = job->vm->drm;
 	struct msm_gem_vm *vm = to_msm_vm(job->vm);
 	struct drm_gem_object *obj;
-	int ret = vm->unusable ? -EINVAL : 0;
+	int ret;
 
 	vm_dbg("");
 
 	mutex_lock(&vm->mmu_lock);
 	vm->mmu->prealloc = &job->prealloc;
 
+	/* vm->unusable is checked and set under mmu_lock, see below: */
+	ret = vm->unusable ? -EINVAL : 0;
+
 	while (!list_empty(&job->vm_ops)) {
 		struct msm_vm_op *op =
 			list_first_entry(&job->vm_ops, struct msm_vm_op, node);
@@ -730,7 +804,17 @@ msm_vma_job_run(struct drm_sched_job *_job)
 				ret = vm_map_op(vm, &op->map);
 			break;
 		case MSM_VM_OP_UNMAP:
-			vm_unmap_op(vm, &op->unmap);
+			/*
+			 * An unmap that finds part of its range not mapped, or
+			 * that comes before the map it undoes, means that the
+			 * jobs that touch this range were not ordered.  If the
+			 * map was applied after the unmap, nothing would track
+			 * its pages, so handle this like a failed map.
+			 */
+			if (vm_unmap_op(vm, &op->unmap) ||
+			    !vm_bind_map_done(job, op->unmap.map_done))
+				ret = ret ?: -EINVAL;
+			vm_bind_done_put(op->unmap.map_done);
 			break;
 		}
 		drm_gem_object_put(op->obj);
@@ -738,6 +822,15 @@ msm_vma_job_run(struct drm_sched_job *_job)
 		kfree(op);
 	}
 
+	/*
+	 * Mark the VM unusable before dropping mmu_lock, so that the maps of
+	 * a job that applies its updates after an out of order unmap are
+	 * skipped.
+	 */
+	if (ret)
+		vm->unusable = true;
+	job->bind_done->done = true;
+
 	vm->mmu->prealloc = NULL;
 	mutex_unlock(&vm->mmu_lock);
 
@@ -783,10 +876,14 @@ msm_vma_job_free(struct drm_sched_job *_job)
 	while (!list_empty(&job->vm_ops)) {
 		struct msm_vm_op *op =
 			list_first_entry(&job->vm_ops, struct msm_vm_op, node);
+		if (op->op == MSM_VM_OP_UNMAP)
+			vm_bind_done_put(op->unmap.map_done);
 		list_del(&op->node);
 		kfree(op);
 	}
 
+	vm_bind_done_put(job->bind_done);
+
 	wake_up(&vm->prealloc_throttle.wait);
 
 	kfree(job);
@@ -968,9 +1065,17 @@ vm_bind_job_create(struct drm_device *dev, struct drm_file *file, struct drm_gpu
 	if (!job)
 		return ERR_PTR(-ENOMEM);
 
+	job->bind_done = kzalloc_obj(*job->bind_done);
+	if (!job->bind_done) {
+		kfree(job);
+		return ERR_PTR(-ENOMEM);
+	}
+	kref_init(&job->bind_done->ref);
+
 	ret = drm_sched_job_init(&job->base, queue->entity, 1, queue,
 				 file->client_id);
 	if (ret) {
+		kfree(job->bind_done);
 		kfree(job);
 		return ERR_PTR(ret);
 	}
@@ -1604,6 +1709,15 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	if (ret)
 		vm_bind_job_unpin_objects(job);
 
+	/*
+	 * A job that fails after it queued pgtable updates is freed without
+	 * applying them, so the VM no longer matches its pgtables, and a
+	 * later unmap of one of its VMAs would be taken for an out of order
+	 * one.
+	 */
+	if (ret && !list_empty(&job->vm_ops))
+		msm_gem_vm_unusable(job->vm);
+
 	drm_exec_fini(&exec);
 out_unlock:
 	mutex_unlock(&queue->lock);
-- 
2.43.0

