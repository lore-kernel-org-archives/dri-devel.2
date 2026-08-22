Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CC2C5DF9D
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9F610E4A3;
	Sun, 23 Aug 2026 09:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tr3+0Ql8";
	dkim-atps=neutral
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C57710E0D0
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 14:25:43 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-66c7127a73dso2206722d50.2
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787408742; x=1788013542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QxqAR5ocTjBBUS/ny625Id0I7Kf488fcpzoDzJMtITk=;
 b=Tr3+0Ql8HgeI17IxIhy2Z8lG67KjOC9rDQsqlMDSpiWnq38u/Dxk5Bb5Q7/zVtyZE7
 tjX8g229rjMP3wYkY4146P3HWCM6DOzRMQxlWTt9iFNdZrZeX7rO5Z2E/VoNWEUYvENg
 6xw0KNkotSXzqbLcknrwAUSgmbwByDTxW+Q1WBEio6RLGUZTkOrYaeoFvhYQiud3IdTA
 FPa6tuokcu7wTKwQLdfSQwuXZaUjpSVddEG8G2vFPWSMjgauwqXSunsKtaUxnneQBsdP
 UHGpI1fgZzLCUJWGBIdP3xIOp+qa/GANV23bj2bn1lmjfuBr8xXCBwky/Fo/s06S2H3E
 BeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787408742; x=1788013542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QxqAR5ocTjBBUS/ny625Id0I7Kf488fcpzoDzJMtITk=;
 b=W8G2A5s5nq2Ty2Lsf14BbZnv9VV1lFV1IBsXnn6sThkq8POprjlhW5p9+w2LQogQES
 YR5hQ6SdZEAPt41dEZ8jSmFpf68LPhwd2xJoJWiA6qw/OBMoSUBLtquy7AeqUYCdSXXu
 JSzjuLKHXvo/Eu+TsLIA10MIklkqAj89ZWZaxRAnLeAQwywocrfxeVsMGYBUAEGQP2Qi
 clipsJ9Je5f/S0W05jZ4k6+rWFUvPWIUd/NfC1DQBB+XMujRAQ6cv9+zffnIFgH3uRL5
 8NvQ5HYStUp0WvFMEHJQnIJaamL/oQ6TqySINaOUs7gpgLMHVJBk71tZbQ9R2+cPymcJ
 2FGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLyq2N68GBKmOyQ36DU2xncuYFO3r2rFTF/0oldZ/CQFKaCjKZZ+OCeDJkPTY9ifZTGNQR9ftUNpw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lxUrOairfWkYDAekqljx6Fp79SK9KuEL507dQZ7lMHyFMagsss
 NEODRvHHDjt+4wNCcjA0jyA507IhPoClVLg8j6nUkdh5ETVGy1nZJT5E
X-Gm-Gg: AR+sD11my8cEFbkFQgVQRsdRDfX/p0dc5wEJ4Be0C3Loe3N9bTzOVAj0+e5my+J4ydX
 MAYAs98geCjFlK25AW2gnJmLSSQ9N1UXdJoudFGFLW9iU28wuzpndC2Pyh1tNpvivvzdKusnC/y
 O/SGHKijkiB6DqajmnAk9A938xrQG3yyV22fFw2XE4otId8MmWtatYJU7QLDLJUgf2GBkAPYTxW
 AD9NotqYBWwNMOchr4Kld9JCPLcCnzX/i8KjYGcPXBL7NcwBCDxNZN1udJ9wNzgvx8y34/26k3h
 jyGQFoTYb7O8uPx8wiZrkvA+N+3TxPdfxd31Hg6trkVJv1HtURzEEK7ajrKKrQusSN/aXukDfc8
 krAo7rYyaxN1cxRvY37DdbpkwWMq2hfslq15W773k9lXKXYdk4r3F7OQUF5afqjsHvDsMS+cCo1
 wOCux60xBBZTht3/0+NFNpmFeZGBEHbNAmXqqg0vWLNeDQcG7aI2xR4ffwuWF9F4vUlASXPmBd+
 gWh1jDTBE2kW8bxJnuoNpnYcuXRDCzsnRq+ZQ9mUIlZ8gsNb936lR8kbWL/llMa2jGu
X-Received: by 2002:a05:690e:d8c:b0:66c:f689:8e60 with SMTP id
 956f58d0204a3-66cf6899d6cmr910360d50.23.1787408742210; 
 Sat, 22 Aug 2026 07:25:42 -0700 (PDT)
Received: from DigitalOasis.tail29fcbc.ts.net
 (104-182-93-176.lightspeed.brhmal.sbcglobal.net. [104.182.93.176])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66cf4a2c3c2sm911142d50.17.2026.08.22.07.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 07:25:41 -0700 (PDT)
From: Bocaj Gnuoy <bocajgnuoy@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 oded.gabbay@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bocaj Gnuoy <bocajgnuoy@gmail.com>
Subject: [PATCH] drm/amdkfd: don't leak BOs when process teardown can't unmap
 them
Date: Sat, 22 Aug 2026 09:25:21 -0500
Message-ID: <20260822142521.899098-1-bocajgnuoy@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

kfd_process_device_free_bos() discards the return value of both
amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu() and
amdgpu_amdkfd_gpuvm_free_memory_of_gpu(), then drops the idr handle
unconditionally.  That is fine as long as the free succeeds, but the unmap
has to validate the page-table BOs first (vm_validate_pt_pd_bos()), and
that allocates.  When the process is dying *because* memory is exhausted -
e.g. GTT pinned up to amdgpu.gttsize by a compute client that then aborted
on ENOMEM - the unmap fails with "failed to validate PT BOs",
mem->mapped_to_gpu_memory stays non-zero, and
amdgpu_amdkfd_gpuvm_free_memory_of_gpu() bails out with -EBUSY before it
removes the BO from process_info->kfd_bo_list.  The handle is dropped
anyway, so nothing will ever free that kgd_mem again.

The consequences are worse than a leak.  drm_release() ->
amdgpu_vm_fini() -> amdgpu_amdkfd_gpuvm_destroy_cb() then trips

  WARN_ON(!list_empty(&process_info->kfd_bo_list));
  WARN_ON(!list_empty(&process_info->userptr_inval_list));

and frees process_info regardless, while the leaked BO stays in TTM's
eviction LRU with bo_vas pointing into the just-freed amdgpu_vm.  A
subsequent amdgpu_gem_create_ioctl() that forces TTM eviction can then walk
into it and spin in amdgpu_vm_bo_move() -> _raw_spin_lock(), which produces
repeating rcu_preempt self-detected stalls, blocks reclaim-related work
(__lru_add_drain_all()) and eventually makes the machine unusable - within
about ten minutes here.  A recoverable ENOMEM becomes an unrecoverable
hang.

Note the free path itself does not allocate - it reserves the BO, detaches
the attachments and drops the references - so it can complete even when the
unmap could not.  Give amdgpu_amdkfd_gpuvm_free_memory_of_gpu() a @force
flag and set it on the teardown callers, which have no later chance to try
again.  The -EBUSY guard is kept for the ioctl paths, where userspace can
still unmap and retry, and where kfd_ioctl_free_memory_of_gpu() already
leaves the handle in place on failure.

Reported on: RX 6900 XT (gfx1030), amdgpu 3.64.0, kernel 7.1.6/7.1.8,
booted with amdgpu.gttsize=4096.  The failing allocation was on the Navi 21
at 0000:06:00.0, which enumerates as ROCm0; a gfx1100 is also present in
the same box but was not the device that ran out.

Tooling disclosure, per Documentation/process/generated-content.rst: this
bug was diagnosed and this patch written with the assistance of Claude Code
(claude-opus-5) in a single interactive session. The input was a kernel
trace captured on the reporting host - two WARNs out of
amdgpu_amdkfd_gpuvm_destroy_cb() during an aborting client's teardown,
followed by an unrecoverable deadlock in the TTM eviction path in the next
process to allocate - together with the request to find the cause and, if
possible, fix it. The assistant read the KFD BO lifecycle in the v7.1.8 and
v7.2 sources, identified the -EBUSY early return as the point at which the
BO is stranded on the process_info lists, and wrote both the diff and this
changelog. The diff was then rebased onto amd-staging-drm-next and the
call-site audit redone against that tree: one prototype, one definition and
eight call sites, all converted. The rebase caught a real miss - the tree
has gained kfd_process_free_gpuvm_map() alongside kfd_process_free_gpuvm(),
and the original hunk's trailing context matched the wrong one of the two.
Both are teardown-only (kfd_process_destroy_pdds() and the create_process()
error unwind), so both take force=true. checkpatch.pl was the only
additional analysis tool used.

Tested on a RX 6900 XT + RX 7900 XTX box, kernel 7.2.0-1-cachyos, booted
with amdgpu.gttsize=4096 so the GTT wall is reachable. A HIP-linked client
(llama.cpp with both the HIP and Vulkan backends present) was made to pin
host memory up to the 4 GiB cap and die on the resulting ENOMEM. Same
kernel version, same cap, same workload, same binary either side; the
patch is the only variable:

                              unpatched   patched
  peak GTT                      4.00 GiB   4.00 GiB
  "failed to validate PT BOs"         34         36
  exit                           139/SEGV   139/SEGV
  teardown WARNs                       2          0
  "Force-freeing BO VA"                0          9

Both sides died the same way, on SIGSEGV, so the difference is in teardown
and not in how the client failed.  The force-free count of 9 matched the 9
KFD allocations an earlier kprobe run measured for this client, consistent
with all of those allocations being reclaimed.

End to end: on the unpatched kernel, relaunching the same workload after
that abort is what hangs the machine - the new client's
amdgpu_gem_create_ioctl walks the eviction LRU into the orphaned object.
With the patch, a second run under heavier pressure (1904 "failed to
validate PT BOs", 35 force-freed BOs) again left zero WARNs, and the
relaunch then loaded in 12 seconds and served normally instead of
deadlocking. GTT returned to its 0.05 GiB idle baseline afterwards, so the
memory is genuinely reclaimed rather than merely not deadlocking. Across
four runs the client died variously on SIGABRT and SIGSEGV; the leak
tracked memory exhaustion at teardown, never the signal.

Note the WARNs that fire vary between runs: the originally reported crash
tripped :1608 and :1610 (kfd_bo_list, userptr_inval_list), while this
reproduction tripped :1608 and :1609 (kfd_bo_list, userptr_valid_list).
Both are the same skipped list_del_init(&mem->validate_list) - that node
serves whichever list the BO currently sits on, so the leak is
list-agnostic. The client also died on SIGSEGV rather than the abort seen
originally; the leak depends on memory being exhausted at teardown, not on
how the process died, which is consistent with SIGKILL alone never
reproducing it.

Limitations, per Documentation/process/coding-assistants.rst step 8:
- The deadlock itself was reproduced on the unpatched kernel, but its stack
  trace was not captured: the jammed workqueue takes journald down with it,
  so nothing reaches disk. Capturing it needs netconsole or a serial
  console. The teardown WARNs, which are the direct measure of the leak,
  are captured in full.
- The claim that the deadlocked spinlock lives inside the leaked object
  still rests on address arithmetic (lock at the WARNed structure + 0x30).
  Confirming the offset needs a debug build, which has not been done.
- Verification is single-box: one gfx1100 + gfx1030 machine, one kernel
  version.

The -EBUSY guard itself dates to commit a46a2cd103a8 ("drm/amdgpu: Add
GPUVM memory management functions for KFD") and is correct for the ioctl
path. The leak became reachable only once a caller started dropping the
last handle regardless of the return value.

Fixes: 52b29d73340d ("drm/amdkfd: Add per-process IDR for buffer handles")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5672
Assisted-by: LLM checkpatch
Tested-by: Bocaj Gnuoy <bocajgnuoy@gmail.com>
Signed-off-by: Bocaj Gnuoy <bocajgnuoy@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 25 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  9 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 21 ++++++++++++----
 4 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 1b7dc0d3963b..4ad843105443 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -326,7 +326,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		uint64_t *offset, uint32_t flags, bool criu_resume);
 int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv,
-		uint64_t *size);
+		uint64_t *size, bool force);
 int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
 					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 1e71829e0fc6..dc1fa664feca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1901,7 +1901,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv,
-		uint64_t *size)
+		uint64_t *size, bool force)
 {
 	struct amdkfd_process_info *process_info = mem->process_info;
 	unsigned long bo_size = mem->bo->tbo.base.size;
@@ -1922,9 +1922,26 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	 */
 
 	if (mapped_to_gpu_memory > 0) {
-		pr_debug("BO VA 0x%llx size 0x%lx is still mapped.\n",
-				mem->va, bo_size);
-		return -EBUSY;
+		/*
+		 * Refusing to free a mapped BO is only meaningful while the
+		 * process can still unmap it. On process teardown (@force)
+		 * there is no such chance: the caller drops the last handle
+		 * to @mem regardless, so bailing out here leaks the BO onto
+		 * process_info->kfd_bo_list / userptr_inval_list. Those lists
+		 * are then destroyed non-empty in
+		 * amdgpu_amdkfd_gpuvm_destroy_cb(), leaving a BO in TTM's
+		 * eviction LRU whose bo_vas point into the freed amdgpu_vm.
+		 * The next client to trigger eviction deadlocks in
+		 * amdgpu_vm_bo_move(). Tear the mappings down instead - the
+		 * VM is going away right after us anyway.
+		 */
+		if (!force) {
+			pr_debug("BO VA 0x%llx size 0x%lx is still mapped.\n",
+				 mem->va, bo_size);
+			return -EBUSY;
+		}
+		pr_warn("Force-freeing BO VA 0x%llx size 0x%lx still mapped %u time(s)\n",
+			mem->va, bo_size, mapped_to_gpu_memory);
 	}
 
 	/* At this point the BO is guaranteed to be freed, so unpin the
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6fd18488d5cf..0121c6dc77b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1219,7 +1219,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 
 err_free:
 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, (struct kgd_mem *)mem,
-					       pdd->drm_priv, NULL);
+					       pdd->drm_priv, NULL, false);
 err_unlock:
 err_pdd:
 err_large_bar:
@@ -1262,7 +1262,8 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 	}
 
 	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev,
-				(struct kgd_mem *)mem, pdd->drm_priv, &size);
+				(struct kgd_mem *)mem, pdd->drm_priv, &size,
+				false);
 
 	/* If freeing the buffer failed, leave the handle in place for
 	 * clean-up during process tear-down.
@@ -1618,7 +1619,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 
 err_free:
 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev, (struct kgd_mem *)mem,
-					       pdd->drm_priv, NULL);
+					       pdd->drm_priv, NULL, false);
 err_unlock:
 	mutex_unlock(&p->mutex);
 	return r;
@@ -2483,7 +2484,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 	if (idr_handle < 0) {
 		pr_err("Could not allocate idr\n");
 		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev, *kgd_mem, pdd->drm_priv,
-						       NULL);
+						       NULL, false);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0a7c1900da95..6d5126aa6fe7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -743,7 +743,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
 
 	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->adev, mem, pdd->drm_priv);
 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, mem, pdd->drm_priv,
-					       NULL);
+					       NULL, true);
 }
 
 static void kfd_process_free_gpuvm_map(struct kgd_mem *mem,
@@ -759,7 +759,7 @@ static void kfd_process_free_gpuvm_map(struct kgd_mem *mem,
 
 	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->adev, mem, pdd->drm_priv);
 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, mem, pdd->drm_priv,
-					       NULL);
+					       NULL, true);
 }
 
 /* kfd_process_alloc_gpuvm - Allocate GPU VM for the KFD process
@@ -814,7 +814,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 
 err_map_mem:
 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->adev, *mem, pdd->drm_priv,
-					       NULL);
+					       NULL, false);
 err_alloc_mem:
 	*mem = NULL;
 	*kptr = NULL;
@@ -1119,18 +1119,29 @@ static void kfd_process_device_free_bos(struct kfd_process_device *pdd)
 	 * local memory object
 	 */
 	idr_for_each_entry(&pdd->alloc_idr, mem, id) {
+		int r;
 
 		for (i = 0; i < p->n_pdds; i++) {
 			struct kfd_process_device *peer_pdd = p->pdds[i];
 
 			if (!peer_pdd->drm_priv)
 				continue;
+			/*
+			 * This can fail under memory pressure: unmapping has
+			 * to validate the page-table BOs first. Ignore it and
+			 * force the free below - the handle is dropped either
+			 * way, so a failed free would leak the BO onto the
+			 * process_info lists and poison the eviction LRU.
+			 */
 			amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 				peer_pdd->dev->adev, mem, peer_pdd->drm_priv);
 		}
 
-		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev, mem,
-						       pdd->drm_priv, NULL);
+		r = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev, mem,
+							   pdd->drm_priv, NULL,
+							   true);
+		if (r)
+			pr_err("Failed to free BO on process teardown: %d\n", r);
 		kfd_process_device_remove_obj_handle(pdd, id);
 	}
 }
-- 
2.55.0

