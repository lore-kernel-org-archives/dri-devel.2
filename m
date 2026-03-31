Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CB1FF60EE
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B4010EA49;
	Tue, 31 Mar 2026 09:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WdhsvwTb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9334010EA2C;
 Tue, 31 Mar 2026 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774948877; x=1806484877;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qQlncALkzb9hdidzpyd2vqbLcbjLAlRji3MajrtLd6I=;
 b=WdhsvwTb3ZLjUwiagkKb9rl9PiqgQzyp9TsBmHOwhTz5uaDWaCvZXfSp
 goF8YwTD/pmnMpORVMsBofptQhsfO/z3k/q0SR8JaRcdnMMl9cOaifTR7
 U4RbnppDR95+MhKhAOYocClO0mnoZldRskQGO52xtfHpIOIAqqT5K7awn
 vgaHEEoBCIpgcqSAxTs68bMbm0oKj9jBh+5PwZlctfMJevZ38o93F3yuz
 SvTky1TkQr5eqaDdwrJYT8ofdzCtOWrGB0H836xOLOe1My81v3qk1rOVr
 vKpQ6uTDTiJyst3X/I2xW+YQXL9+goQDNN01mLFT5j4TxMgS2fXqR6eXW A==;
X-CSE-ConnectionGUID: p4A8vpPiSGaEiZkF3hbK8Q==
X-CSE-MsgGUID: bB1dG7unSCiquhjhX5CYJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="74988595"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="74988595"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:21:17 -0700
X-CSE-ConnectionGUID: 4aXApRE2RuqMO7aAOXtf/Q==
X-CSE-MsgGUID: T+/83HPoRtiqbj1k5yJRgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="226288688"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.28])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:21:11 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Alice Ryhl <aliceryhl@google.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: [PATCH 5/5] drm/exec, drm/xe,
 drm/amdgpu: Add an accessor for struct drm_exec::ticket
Date: Tue, 31 Mar 2026 11:20:23 +0200
Message-ID: <20260331092023.81616-6-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Drivers were accessing this drm_exec member directly.
Provide an accessor, drm_exec_ticket() to avoid that.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           | 6 +++---
 drivers/gpu/drm/xe/xe_validation.c               | 4 ++--
 include/drm/drm_exec.h                           | 5 +++++
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 29b400cdd6d5..8a4fb9a62485 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2998,7 +2998,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 	/* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
 	 * validations above would invalidate DMABuf imports again.
 	 */
-	ret = process_validate_vms(process_info, &exec.ticket);
+	ret = process_validate_vms(process_info, drm_exec_ticket(exec));
 	if (ret) {
 		pr_debug("Validating VMs failed, ret: %d\n", ret);
 		goto validate_map_fail;
@@ -3039,7 +3039,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 			goto validate_map_fail;
 		}
 
-		ret = amdgpu_vm_handle_moved(adev, peer_vm, &exec.ticket);
+		ret = amdgpu_vm_handle_moved(adev, peer_vm, drm_exec_ticket(exec));
 		if (ret) {
 			dev_dbg(adev->dev,
 				"Memory eviction: handle moved failed, pid %8d. Try again.\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index c4ee19603460..c725a7976c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1157,7 +1157,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			return r;
 	}
 
-	r = amdgpu_vm_handle_moved(adev, vm, &p->exec.ticket);
+	r = amdgpu_vm_handle_moved(adev, vm, drm_exec_ticket(&p->exec));
 	if (r)
 		return r;
 
@@ -1358,7 +1358,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	cs->out.handle = seq;
 	leader->uf_sequence = seq;
 
-	amdgpu_vm_bo_trace_cs(&fpriv->vm, &p->exec.ticket);
+	amdgpu_vm_bo_trace_cs(&fpriv->vm, drm_exec_ticket(&p->exec));
 	for (i = 0; i < p->gang_size; ++i) {
 		amdgpu_job_free_resources(p->jobs[i]);
 		trace_amdgpu_cs_ioctl(p->jobs[i]);
@@ -1793,7 +1793,7 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	*map = mapping;
 
 	/* Double check that the BO is reserved by this CS */
-	if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != &parser->exec.ticket)
+	if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != drm_exec_ticket(&parser->exec))
 		return -EINVAL;
 
 	/* Make sure VRAM is allocated contigiously */
diff --git a/drivers/gpu/drm/xe/xe_validation.c b/drivers/gpu/drm/xe/xe_validation.c
index a611438eaafe..8dff4d0ec895 100644
--- a/drivers/gpu/drm/xe/xe_validation.c
+++ b/drivers/gpu/drm/xe/xe_validation.c
@@ -156,7 +156,7 @@ int xe_validation_ctx_init(struct xe_validation_ctx *ctx, struct xe_validation_d
 
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
 /*
- * This abuses both drm_exec and ww_mutex internals and should be
+ * This abuses ww_mutex internals and should be
  * replaced by checking for -EDEADLK when we can make TTM
  * stop converting -EDEADLK to -ENOMEM.
  * An alternative is to not have exhaustive eviction with
@@ -164,7 +164,7 @@ int xe_validation_ctx_init(struct xe_validation_ctx *ctx, struct xe_validation_d
  */
 static bool xe_validation_contention_injected(struct drm_exec *exec)
 {
-	return !!exec->ticket.contending_lock;
+	return !!drm_exec_ticket(exec)->contending_lock;
 }
 
 #else
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index 5ed5be1f8244..50d056a87de0 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -151,6 +151,11 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
 		goto *__drm_exec_retry_ptr;		\
 	} while (0)
 
+static inline struct ww_acquire_ctx *drm_exec_ticket(struct drm_exec *exec)
+{
+	return &exec->ticket;
+}
+
 void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr);
 void drm_exec_fini(struct drm_exec *exec);
 bool drm_exec_cleanup(struct drm_exec *exec);
-- 
2.53.0

