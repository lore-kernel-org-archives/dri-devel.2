Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5510606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nEhowwg0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AD610F042;
	Sat, 14 Nov 2026 16:25:20 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FD310E5B4
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:19:18 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-36ca32a0faeso191983eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 00:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794644358; x=1795249158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F88s34t6HgwaWc7KrjRKtNSJ/J1MLEeihPOI9axIS0Y=;
 b=nEhowwg079G7waQRc7yCFvyJWMGX3DgVdzCoo6lYVtCs1hZlYl30eueHAwuXhWAuvE
 nF3ZSnkq3vqx1TauDJvjr6ty2mh0Rm8gAAgLAiWRYR5+ZknidvbEykJwFHz/Cdcv9WhQ
 4Bq0gMhqoi14WBG1zxQV+n9obq4faVJonRLcVJsv2VpYZuKaauKP6gtajgJzDnEF0Tph
 LACBzVHcbeOdzBSD+kg5BuJF7cvgRjzbwFPqQvwBOpOyQi8zTsMJcVm156VaG6Jxbicz
 LXvsybIp+enmUIBIgd/0coYBmcFJOhORnVWZbkJA4ivTmHHLw+dAS7zBbmNAdHzCPqA1
 KK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794644358; x=1795249158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F88s34t6HgwaWc7KrjRKtNSJ/J1MLEeihPOI9axIS0Y=;
 b=FpFXAR3Zd6gSMGd8T4qtUAr5lyNaSfHkELb+M8Wc8cBAOH+hyCGCFBCckCn87GmowE
 NGoSk+BUUQf1UJPIaYLH3jEqN5BMFYzwSZ3Jxalncsxc8B1p1Qf5mjJtofdUqWpx1vAC
 uGmxXtECHr2yjruIf1ugLQrPkvUSWZ3Uj4GABwdkSZHLp7HsYyfVdjatGjFvUkpeDij4
 BY9fswklhmZeDWNqGEupEJqjWeT5jfmrQIDOJzOmK+B70iSNUFiaKs1lHfMLHRrYpxDL
 PyNkUiefNTLyucNjQWSYFtuZqhjAZCRV481kHPFmC+4JgGQA3dBlOKAHP4m3srsrg6HQ
 TD+A==
X-Forwarded-Encrypted: i=1;
 AL+hErG7a7PrYhMEsxLiCDtvM5+1qzkmIF631SoFYE4BGvJe57ft9uoP+yfnJg7/MBsXx+DJaWXBB5vp0Z8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Wc+6oPhlehpu7GNRr5640kZF+aR3A8PjFcMPm2l3hyyUKKub7
 QGIJpRuPVKwRKixU8sG0dMc3j/6I6eh/mV5yCew23hyTOu2keGt7vgik
X-Gm-Gg: AYBFou0S6DWGyFN7E/0+roD9LVzusXhsb7GJ803jQtCQCOHAZBOld52ak30HonLF1j3
 We0wvAKBF9bMR+MPld4aD7M05daqRMbE1WVRzCYSnZY6LeK7qkTcrL8NCgcHGVMhx/VgulCVz8j
 b13dL0lfz5zH9modSQugMn9yr8VPmWoPSWRlT6TaPh20g0gEh4nIVfWyRrCJauTIXLy8FH55JpY
 FKcdP9T/jz2AZRthXAw0EPy+5jI7JPBHYoGlHPXGCgdBJJ78YROVhKpGSOHNN+5EKdTDjsx/Ujf
 inPUClbl4dPY0930lQbDQw4dPAiOMs39k12G0tjs7QBMmZiHTivdMQ49+2B9b4Dw2vbxlSxdSEv
 U5871ofBViNh8ZpwdIvrknRWJ4bOGUi85cUTTXozUSmuOsRPX4AEHwBMnJIcM3Qb0WEQnXLTuTK
 AQR6D/kRSLoso3oltodVbmWCFRsqk76vNwYZ9OzqLYHsGanMWsL29kPfRfjuQFzDByXp6xYqfYL
 suoGAh2rfea16Px11tl2xNnq0pCNkV6YSU5BAskDUA4hPxYFYYTJ98bQISA6+d7hd2Jrh0GncxE
 oHmUv/C7MB9jwtIDQir9ZSzpwJh9ZmraVClh4hgfcLSA0uqVJ0fg8Hw5f2cfiFlK6w4POHdZ2Xn
 PTgA=
X-Received: by 2002:a05:7301:a0a:b0:36c:a1bc:6114 with SMTP id
 5a478bee46e88-3796038259fmr6915918eec.0.1794644357643; 
 Sat, 14 Nov 2026 00:19:17 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378d7e5sm14008333eec.3.2026.11.14.00.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 00:19:17 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v2 1/3] drm/msm: Release the pins and ops of a VM_BIND job
 that never ran
Date: Sat, 14 Nov 2026 17:19:00 +0900
Message-ID: <20261114081902.1669-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114081902.1669-1-arpe1618@gmail.com>
References: <20261114081902.1669-1-arpe1618@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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

msm_vma_job_run() applies the pgtable updates that vm_bind_job_prepare()
queued for a VM_BIND job, drops the GEM object references that
vm_op_enqueue() took for them, and unpins the BOs of the job. A job can
also be freed without having run: when its entity is killed, e.g. on
SIGKILL while the process exits, and when msm_ioctl_vm_bind() fails
part-way through vm_bind_job_prepare() or after it. msm_vma_job_free()
then frees the queued ops without applying them and without dropping
their references, and a killed job also keeps its BOs pinned. Besides
the leaks, the VM no longer matches its pgtables: for example, the
pages of a VMA that was unmapped from the VM are still mapped.

In msm_vma_job_free(), apply the queued updates the way
msm_vma_job_run() does on error: skip the maps, but apply the unmaps,
so that their references can be dropped without freeing pages that are
still mapped, and mark the VM unusable. Move that part of
msm_vma_job_run() into a helper for this. Also clear bos_pinned once
msm_vma_job_run() has unpinned the BOs, as msm_job_run() does for
submits, and unpin the BOs of a job that still has them pinned. The
job's fence does not keep them busy anymore at that point, so take the
object lock to unpin them.

This also marks the VM unusable when msm_ioctl_vm_bind() fails after
vm_bind_job_prepare() has queued updates, i.e. when the first op fails
part-way or when sync_file_create() fails. The VM is then left
partially updated, as when a later op fails.

The patch and its changelog were drafted with an AI coding assistant.
The issue has not been reproduced, and the change has only been
compile-tested.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-214234@kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
At commit 2e6a8a1fe2b2, msm_vma_job_run() still unpinned the BOs under
the object lock, and msm_gem_vm_unusable() did not exist yet, so older
stable trees need an adapted backport.

 drivers/gpu/drm/msm/msm_gem_vma.c | 65 +++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 8b702422030a..a6f106d0cdef 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -700,16 +700,16 @@ static const struct drm_gpuvm_ops msm_gpuvm_ops = {
 	.sm_step_unmap = msm_gem_vm_sm_step_unmap,
 };
 
-static struct dma_fence *
-msm_vma_job_run(struct drm_sched_job *_job)
+/*
+ * Apply the pgtable updates queued for a job, and drop the references that
+ * the ops hold.  If ret is an error, or one occurs, the remaining maps are
+ * skipped, but the unmaps are still applied, as the pages they unmap must
+ * not be freed while they are still mapped.
+ */
+static int
+vm_bind_job_apply_ops(struct msm_vm_bind_job *job, int ret)
 {
-	struct msm_vm_bind_job *job = to_msm_vm_bind_job(_job);
-	struct drm_device *dev = job->vm->drm;
 	struct msm_gem_vm *vm = to_msm_vm(job->vm);
-	struct drm_gem_object *obj;
-	int ret = vm->unusable ? -EINVAL : 0;
-
-	vm_dbg("");
 
 	mutex_lock(&vm->mmu_lock);
 	vm->mmu->prealloc = &job->prealloc;
@@ -740,6 +740,22 @@ msm_vma_job_run(struct drm_sched_job *_job)
 	vm->mmu->prealloc = NULL;
 	mutex_unlock(&vm->mmu_lock);
 
+	return ret;
+}
+
+static struct dma_fence *
+msm_vma_job_run(struct drm_sched_job *_job)
+{
+	struct msm_vm_bind_job *job = to_msm_vm_bind_job(_job);
+	struct drm_device *dev = job->vm->drm;
+	struct msm_gem_vm *vm = to_msm_vm(job->vm);
+	struct drm_gem_object *obj;
+	int ret;
+
+	vm_dbg("");
+
+	ret = vm_bind_job_apply_ops(job, vm->unusable ? -EINVAL : 0);
+
 	/*
 	 * We failed to perform at least _some_ of the pgtable updates, so
 	 * now the VM is in an undefined state.  Game over!
@@ -753,6 +769,8 @@ msm_vma_job_run(struct drm_sched_job *_job)
 		msm_gem_unpin_active(obj);
 	}
 
+	job->bos_pinned = false;
+
 	mutex_unlock(&dev->gem_lru_mutex);
 
 	/* VM_BIND ops are synchronous, so no fence to wait on: */
@@ -766,26 +784,41 @@ msm_vma_job_free(struct drm_sched_job *_job)
 	struct msm_gem_vm *vm = to_msm_vm(job->vm);
 	struct drm_gem_object *obj;
 
+	/*
+	 * In error paths, and if the job was killed before it ran, we could
+	 * have unexecuted ops.  Their changes were already made to the VM, so
+	 * apply the unmaps, and give up on the VM.
+	 */
+	if (!list_empty(&job->vm_ops)) {
+		vm_bind_job_apply_ops(job, -ECANCELED);
+		msm_gem_vm_unusable(job->vm);
+	}
+
 	vm->mmu->funcs->prealloc_cleanup(vm->mmu, &job->prealloc);
 
 	atomic_sub(job->prealloc.count, &vm->prealloc_throttle.in_flight);
 
 	drm_sched_job_cleanup(_job);
 
+	/*
+	 * A job that was killed before it ran still has its BOs pinned.  The
+	 * job's fence does not keep them busy anymore, so take the object lock
+	 * to unpin them.
+	 */
+	if (job->bos_pinned) {
+		job_foreach_bo(obj, job) {
+			msm_gem_lock(obj);
+			msm_gem_unpin_locked(obj);
+			msm_gem_unlock(obj);
+		}
+	}
+
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
 
 	msm_submitqueue_put(job->queue);
 	dma_fence_put(job->fence);
 
-	/* In error paths, we could have unexecuted ops: */
-	while (!list_empty(&job->vm_ops)) {
-		struct msm_vm_op *op =
-			list_first_entry(&job->vm_ops, struct msm_vm_op, node);
-		list_del(&op->node);
-		kfree(op);
-	}
-
 	wake_up(&vm->prealloc_throttle.wait);
 
 	kfree(job);
-- 
2.43.0

