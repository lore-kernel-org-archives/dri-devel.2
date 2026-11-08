Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28744606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rsb/fwgv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6774310E1E5;
	Sun,  8 Nov 2026 09:33:54 +0000 (UTC)
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6170A10E1E5
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 09:33:47 +0000 (UTC)
Received: by mail-pj2-f4.google.com with SMTP id
 d9443c01a7336-2e96b8bfb43so1496005ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 01:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794130427; x=1794735227; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L1j8Lq8aH3eQS1NmaOYlRxmMWR7OBcOWfEbp3qYjkPs=;
 b=Rsb/fwgv3bvt1i6bvF5bJo2sDueN38+HYOEx+YeQXrs3i6iXjQrJpijVcPtMWdJvt8
 qHU/CFgRDLpnhfhtH9lhx66LMvophAbIlG2dUBcz6lKXUUJnL2WJm2Fp/D0JSNhnvGMc
 o11/tsZcJWrtGaCEn7f3gGk3rIf5u9spKLdUhD1pJeTEeusG66AwiugQdvelcLUvAT46
 7VjxehOLD41JSme3QW74bW9+Le3ykt306Po8U4HZYu6q2mRGx4QG0JLiQx+S98bvvcVc
 X3KC95GTU4AB9+II4Xp10O6URObh1gMYu1mNdVXQmdvLlRkQ5RdLxanES0wexz3zqgcD
 1LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794130427; x=1794735227;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=L1j8Lq8aH3eQS1NmaOYlRxmMWR7OBcOWfEbp3qYjkPs=;
 b=g+HkxgXW0ABUx0940rlITrVg2vWsj1cpDwbMs/nhkFHdTEO2abOO4SKwbmEgHYeFOK
 6OpQ/fTFYUH+axJWLDdnJMUvnpIlCRg61AWA3ptIDs97BM/LaIcV1HVU2yGJNyOn+96o
 qLlZ+gvmG6XN8IFYjSF20ybhB06blqrGZgaMY0O0o1V2SuGaEKUzM2G2qkAHT8HEGXwl
 vnFlYTEEwyCc8V/qrMVi2L+jUuVNRNM9HpfFbPIbgPIyJ9uhVvyl2d38ibFus/jTay8B
 8bk5SASVfyBLs92Z00i5AwwoS/XwlTp2LuMZO6P/kWin3Fwm/TbCk1ELRHq9EmnP7NV/
 CD5A==
X-Forwarded-Encrypted: i=1;
 AL+hErF9vFHmfiXm/SH736yimDNR7Co4KToaAKPfR6MZ1iHpDRxs4fzyOL0oyA8wMtumQSGJLrcLSv8rbWs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/j0VYrMJ/DPkrdHW3eVp2wffncykprJUFnf36Fm2vrjN1aLR/W
 2UZQhNbNrpL8pdLnwqKYyUmHLORuD0J6iK8yodO0L/smJv1sedUfKVfo
X-Gm-Gg: AYBFou1m4vC+XuZ1qPBDuZcpCevMdnJAKpm5MRnNLFsm3Vip5+tYKfkR7l2gbBFhSLW
 V9hOTQZk6pTbAD7TxF8LKXdyMgU8RokCmqPmBoGpUHP3Uccauq8OlxbSfac+8p5RUdA98sjCnxH
 IEtlPIlbvpgZawR+p/Igli76SDUhuY9TwJnFYljInNCE7Elp9cyB+NTKkGFyWBjLsbyYVyXDs7C
 +xKAGW1UOaojF7QCRq0ZulIlmw7gz1tW0H4HTZjUg5NcLhVgSYz1uFtl77MM7973xrPVVT9o34N
 rc0iTAaq3gkSgyjcXr8q5IsAMwqi8tKfXuVQiNnu79RdzcCH3Hu2innldnyHt8sZzDqZa0TTgip
 rV4ZxhYLP9s/WNWY6QY0pkr48iT0sWBmZKQ/pR61sLRkD59r9uflU4f6HgE/mj+35pRpLMp3v8o
 lHjhdebZVljJzKL2IZ7Yr0FPmFZWR3V23xyFDL8JfawLK6SgaEnlldnbNrPmnVAmdbrQ0Xv1dy/
 kfLPAdaNxdOrcm5I8PXnDgsDu0Ay2+d6NzwCKZzpH6H5Ozr5crVUou5shj00XBFakzwf6M7qtGT
 Jec1ePYpU7SEIMe+p2nl+PKcGMd6Df91yXsqScgIQrFexTSOUybdF7JC6haF
X-Received: by 2002:a05:6a21:485:b0:3de:71c4:a228 with SMTP id
 adf61e73a8af0-3eed232050bmr1065043637.15.1794130426673; 
 Sun, 08 Nov 2026 01:33:46 -0800 (PST)
Received: from [192.168.50.20] ([50.7.253.42])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb969314a5sm558346a12.17.2026.11.08.01.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 01:33:46 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Sun, 08 Nov 2026 20:15:39 +1100
Subject: [PATCH] drm/amdkfd: preserve the byte address when removing retry
 faults
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-kfd-fault-filter-address-20261108-v1-1-ef13f9dd24e4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2N3QrCMAxGX0VybWAtMn9eRbxI19RFZyfJNoSxd
 3dV2OX5+DhnBmMVNrjsZlCexKTPK7j9DpqW8p1R4srgK187V53wmSImGrsBk3QDK1KMyma4PQ6
 pOtfJB0+OYPW8lZN8fo3r7c82hgc3QxGXRyBjDEq5actUEja9sMydZEZW7XUrHGFZvmGsM4y4A
 AAA
X-Change-ID: 20261108-kfd-fault-filter-address-20261108-4f096f2b2a1a
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, honghuan@amd.com, honglei1.huang@amd.com, 
 linux-kernel@vger.kernel.org, 
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
 Natalie Vock <nat@pixelcluster.dev>, Philip Yang <Philip.Yang@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, psirt@amd.com, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev, Simona Vetter <simona@ffwll.ch>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

svm_range_restore_pages() receives a CPU page number, but passes it
unchanged to amdgpu_gmc_filter_faults_remove() when recovery is deferred
or returns -EAGAIN. The software fault filter uses a byte address and
PASID as its key, so this can leave the fault filtered until the entry
ages out.

Pass the original byte address to svm_range_restore_pages() and derive
the CPU page number locally for range operations. Use the original
address for both filter removals. This also preserves the GPU subpage
offset when CPU pages are larger than the 4 KiB GPU page size.

Fixes: b3dc91f97317 ("drm/amdkfd: enable subsequent retry fault")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-203586@kernel.org
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
No testing on AMD hardware. Any test will be appreciated.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c41e9c0916b7..86ef849097fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3092,7 +3092,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		drm_exec_fini(&exec);
 
 		if (!svm_range_restore_pages(adev, pasid, vmid,
-					     node_id, addr >> PAGE_SHIFT, ts, write_fault))
+					     node_id, addr, ts, write_fault))
 			return true;
 
 		/* Re-acquire the VM lock, could be that the VM was freed in between. */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 79455e23a030..c85d6bb73629 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3130,8 +3130,9 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, uint64_t ts, bool write_fault)
+			uint64_t fault_addr, uint64_t ts, bool write_fault)
 {
+	uint64_t addr = fault_addr >> PAGE_SHIFT;
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
@@ -3249,7 +3250,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_lock(&prange->migrate_mutex);
 
 	if (svm_range_skip_recover(prange)) {
-		amdgpu_gmc_filter_faults_remove(node->adev, addr, pasid);
+		amdgpu_gmc_filter_faults_remove(node->adev, fault_addr, pasid);
 		r = 0;
 		goto out_unlock_range;
 	}
@@ -3353,7 +3354,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	if (r == -EAGAIN) {
 		pr_debug("recover vm fault later\n");
-		amdgpu_gmc_filter_faults_remove(node->adev, addr, pasid);
+		amdgpu_gmc_filter_faults_remove(node->adev, fault_addr, pasid);
 		r = 0;
 	}
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c7d7adae4476..38744e716f74 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -178,7 +178,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
+			    uint32_t vmid, uint32_t node_id, uint64_t fault_addr, uint64_t ts,
 			    bool write_fault);
 int svm_range_evict_svm_bo(struct amdgpu_bo *bo);
 
@@ -230,7 +230,7 @@ static inline void svm_range_list_fini(struct kfd_process *p)
 static inline int svm_range_restore_pages(struct amdgpu_device *adev,
 					  unsigned int pasid,
 					  uint32_t client_id, uint32_t node_id,
-					  uint64_t addr, uint64_t ts, bool write_fault)
+					  uint64_t fault_addr, uint64_t ts, bool write_fault)
 {
 	return -EFAULT;
 }

---
base-commit: 403b3d68346d7ba25f474f0686ad1d05feb65b7c
change-id: 20261108-kfd-fault-filter-address-20261108-4f096f2b2a1a

Best regards,
--  
Aveline Noir <jm5905938@gmail.com>

