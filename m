Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B0606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H8Jw5WrH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 949EE10F038;
	Sat, 14 Nov 2026 16:25:11 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5734110E1D4
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 14:19:08 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-36ecc11bd26so243956eec.3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 06:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794665948; x=1795270748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mbi96igc2n0483c/SqG4t1PVFDZn4uBg/WQ+jK8IEKc=;
 b=H8Jw5WrHYNXFFjbA5hOQ/Gd3U5/PHcYYWuRkx8+XudfiDCaUh3KyHosvSgpfNQZ1U2
 IQr8FUtakLC9f3wTpb6aYFXBy4zP946H8GTWcN4P9vDBfACbDmrq1sggY05O3KKtk5wF
 AaKs6ah4pIYeBg9zOJST3MfmOZr0F5rejvmhFSuW7BJlx8zUdpKKbjNgLFEIzLpbkKou
 AwjYqy+LJv5UjZlXMBCcets3xxDDrsMhtmRX8+LbR2CI43ECfQttpcBDqj0ltzZhl/2y
 5A5CupR/t8b+iUeb2kHkYcsHBUE4M55xWEiAmHtIwuFJM2EkkdP2zRXm4nK/2Q42Lixw
 +CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794665948; x=1795270748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mbi96igc2n0483c/SqG4t1PVFDZn4uBg/WQ+jK8IEKc=;
 b=atiUbw84krY6xWYEJ7QZ2Mu2rQ0g911swikBfzp31Vmbg3DVMJAXFpHgpqpcVLiT3r
 cczVovVeVnDCOkeT3wUNBzbTFMpaBs1wgTmCuKK6HKwf0Nrr+B/MxH4O9YR/77SicmW1
 vZgk7m8MUTJZ6615V20Ejhn5OPrlEXKYDtHjld/WOUL/imQxxTbKaPCFmOpdYe1qLPTV
 5/tvlVpLc9mnmWvLr2CQ8S2COs4mhVRHISxgtSCwsCEZL5N9oPFswQZAKSyqTtEYOYpt
 LUX60B5THTmBR7nFRPGkTZfrnn/sx3dqAtuO0z1h9teka4VNmMqB03oqPTLRXqVb9QdG
 cAtA==
X-Forwarded-Encrypted: i=1;
 AL+hErEaG3nLD4PNAljXk18CH5SEZVuTfI0vtCPzFHoeVEL02RDP7jKqqJZlkeiAnXYAjdvEOreAfhNIVCI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8T9wbhMMXGX2oGGslZY4Okt8b18TpFbXDiCGUKPIevK5dHRWcs
 oQ7S6611KZjb0MkGvnHxKZcouNHV6DX7zFdkoc3LnoH+RGyfrrYzm9C8
X-Gm-Gg: AYBFou2kqGE7zXKJ9ywJPtz4GgSTnd2eO+9xjxECjkFyjQF16+3VyqYFmaQLFnf3S51
 xfXB1eyAx6Dxhbq4900yvN7ibbIKzuhASXf02nVsY1K8822PuWX+gjo1sF6uvRdH3316OYJbRfr
 vI9c7JU01lyKZoHfb5IdTufHtl3wftSFwjMuL8qziG6t+ENk5yr65VHvx8jzGXKDquP//RO5HNY
 T9t29HEdOLpoTVIT4Xx6ufz+90SCnDv/sKEGOyytsK6gQPqr/j4seU6vACkdmU01klOcC2+exFH
 pv5MRUC+s5w2GjnRk/CcwqrX/R/kRKWwa/2AHgFIjC6ENJoA/HZcr+dKgkNPActWgSi4O3ZCCB5
 8269y1O9ql+8GPDh7GT4PvSl2mrdlf7Bd90k2swway597T7LTPrnP2LRy6aiAtVcdR6yjZVLID8
 nNdTjrGQIubBf9g1AcI6LHqaLpvfVpI0gVhowto8Fao+718Q0vkVIEBetFP3j/CtdVymWIiMTJH
 xxiJI+oASNh/+dMC+KCs3vhRWd2qH3RofIJbYN98m4QNHoaMHWtznOfGHgQlx1aDB19FE+lMgOu
 3Zs90ZRmxBtCHnal7kgKJpj0L/srLyQlKYnWjDHCptjbXhPQRa85hlGVkbwZDq3ggwn7lixTvZi
 w7Ko=
X-Received: by 2002:a05:7022:283:10b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-1b503086f3emr8214426c88.1.1794665947348; 
 Sat, 14 Nov 2026 06:19:07 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b2519sm14745032c88.13.2026.11.14.06.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 06:19:06 -0800 (PST)
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
Subject: [PATCH v3 1/3] drm/msm: Release the pins and ops of a killed VM_BIND
 job
Date: Sat, 14 Nov 2026 23:18:49 +0900
Message-ID: <20261114141851.134290-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114141851.134290-1-arpe1618@gmail.com>
References: <20261114141851.134290-1-arpe1618@gmail.com>
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
vm_op_enqueue() took for them, and unpins the BOs of the job. When the
entity of a job is killed, e.g. on SIGKILL while the process exits, the
scheduler frees the job without running it. msm_vma_job_free() then
frees the queued ops without applying them and without dropping their
references, and leaves the BOs pinned. Besides the leaks, the VM no
longer matches its pgtables: for example, the pages of a VMA that was
unmapped from the VM are still mapped.

The scheduler only frees a killed job once its dependencies have
signalled and the job queued before it on the same entity has run or
been killed, so the updates of the jobs that ran before it have all been
applied by then. In msm_vma_job_free(), apply the queued updates the way
msm_vma_job_run() does on error: skip the maps, but apply the unmaps, so
that their references can be dropped without freeing pages that are
still mapped, and mark the VM unusable. Killed jobs can be freed
concurrently, but as they only unmap, their order does not matter. Move
that part of msm_vma_job_run() into a helper for this. Also clear
bos_pinned once msm_vma_job_run() has unpinned the BOs, as msm_job_run()
does for submits, and unpin the BOs of a job that still has them pinned,
taking the object lock, as the job's fence does not keep them busy
anymore.

msm_ioctl_vm_bind() frees a job that fails right away, before its
dependencies and the previous jobs of its queue have completed, so the
queued updates of such a job must not be applied. Move the freeing
itself into vm_bind_job_free(), and call that directly from there.

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

Julius Bairaktaris' "drm/msm: Keep objects of queued VM_BIND unmaps
busy" keeps the objects of queued unmaps busy with the job's fence:
https://lore.kernel.org/r/20261111080619.244138-1-julius@bairaktaris.de
For a killed job, the scheduler signals that fence before it calls
free_job(), so with both patches, these objects are no longer busy for
the short time until this patch applies the unmaps. Without this patch,
the unmaps of a killed job are never applied. Closing that window would
need the objects to stay pinned until their unmaps are applied. The two
patches apply in either order.

Not addressed here, as before this patch:
- The error path of msm_ioctl_vm_bind() still frees the queued ops of a
  failed job without applying them or dropping their references. Their
  unmaps could only be applied after the job's dependencies and the
  previous jobs of its queue, i.e. by queuing the job anyway.
- The issues in the error handling of vm_bind_job_prepare() that
  Sashiko listed for v2: a VMA left in the VM when vm_op_enqueue()
  fails, which a later remap of a MAP_NULL area turns into a NULL
  dereference, and the vm_bo reference in msm_gem_vm_sm_step_remap().

 drivers/gpu/drm/msm/msm_gem_vma.c | 87 ++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 8b702422030a..0b9f2e8916b7 100644
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
@@ -753,16 +769,22 @@ msm_vma_job_run(struct drm_sched_job *_job)
 		msm_gem_unpin_active(obj);
 	}
 
+	job->bos_pinned = false;
+
 	mutex_unlock(&dev->gem_lru_mutex);
 
 	/* VM_BIND ops are synchronous, so no fence to wait on: */
 	return NULL;
 }
 
+/*
+ * Free a job, whether it ran or not.  Ops that are still queued are freed
+ * without being applied, and without dropping their object references, as
+ * the pages of their unmaps may still be mapped.
+ */
 static void
-msm_vma_job_free(struct drm_sched_job *_job)
+vm_bind_job_free(struct msm_vm_bind_job *job)
 {
-	struct msm_vm_bind_job *job = to_msm_vm_bind_job(_job);
 	struct msm_gem_vm *vm = to_msm_vm(job->vm);
 	struct drm_gem_object *obj;
 
@@ -770,7 +792,20 @@ msm_vma_job_free(struct drm_sched_job *_job)
 
 	atomic_sub(job->prealloc.count, &vm->prealloc_throttle.in_flight);
 
-	drm_sched_job_cleanup(_job);
+	drm_sched_job_cleanup(&job->base);
+
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
 
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
@@ -791,6 +826,29 @@ msm_vma_job_free(struct drm_sched_job *_job)
 	kfree(job);
 }
 
+static void
+msm_vma_job_free(struct drm_sched_job *_job)
+{
+	struct msm_vm_bind_job *job = to_msm_vm_bind_job(_job);
+
+	/*
+	 * A job that the scheduler frees without having run it was killed,
+	 * e.g. because its entity was destroyed.  Its queued updates were
+	 * already applied to the VM's address space, but not to its pgtables.
+	 * The scheduler has waited for the job's dependencies, and for the job
+	 * before it on the entity to run or be killed, so apply its unmaps now,
+	 * before the references to the unmapped objects are dropped, and give
+	 * up on the VM, as its maps are skipped.  Killed jobs only unmap, so
+	 * the order in which they are freed does not matter.
+	 */
+	if (!list_empty(&job->vm_ops)) {
+		vm_bind_job_apply_ops(job, -ECANCELED);
+		msm_gem_vm_unusable(job->vm);
+	}
+
+	vm_bind_job_free(job);
+}
+
 static const struct drm_sched_backend_ops msm_vm_bind_ops = {
 	.run_job = msm_vma_job_run,
 	.free_job = msm_vma_job_free
@@ -1607,8 +1665,13 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	}
 
 	if (!IS_ERR_OR_NULL(job)) {
+		/*
+		 * Not msm_vma_job_free(): the job's dependencies and the
+		 * previous jobs of the queue may not have completed, so its
+		 * queued updates must not be applied here.
+		 */
 		if (ret)
-			msm_vma_job_free(&job->base);
+			vm_bind_job_free(job);
 	} else {
 		/*
 		 * If the submit hasn't yet taken ownership of the queue
-- 
2.43.0

