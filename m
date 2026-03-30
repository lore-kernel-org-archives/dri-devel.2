Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7A110D14A2
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461C910E494;
	Mon, 30 Mar 2026 11:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qecIzZ3G";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995DB10E494
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:35:12 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso800918166b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 04:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774870511; x=1775475311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vqY6YiaLNlQCEP7q+Nu54Vt1vO291I/2sltGJknyu9M=;
 b=qecIzZ3Gv0QMt6tdG9nWV1Qq5tE1vzVD+O3MVw8oTkYztdGErb6iRFRifeKdqcgwWO
 9LVxzXa8pY9Nk8eVXESrRDAeUDB5Hn9BqgkhAPauXrtUO6ynI+jyqpEMSkh+g0vFtK7G
 VEsz7xLr2tOTOoVKZ82vJlXj8n+EnpFwpL6kmmmmVoHCSn/lk+yu33p3WnbidiVr47GL
 f6m9puSQUKA6ca9yIVfSqtWCZGpwdN71GqqkT4hsEardHjWEWOakx0RhQHSaLq1nzgzc
 hJaMQjmTpGaTCDcm2WusQgN+PvUrQrnBEfpz2qZfL8xb0B11xjyxmt3zXKQEOl6NjM4/
 VKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774870511; x=1775475311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqY6YiaLNlQCEP7q+Nu54Vt1vO291I/2sltGJknyu9M=;
 b=rfsBzNJP9H0gJ76iSajgwg++RVPZlDnLlRTd3VPEr451cWQKgw8pE2A+j2VLuozsew
 91ju2MyU6gufIrp6qs6XTu4s8RybwTGzE00bArhCQsH62SYhnB2w2MTpTB2CfTplQ1AK
 8Q+LaHV5uufonMZV/aEbNAShh8Ry4xDQndPptoYIz4hUEcKUy13wVD81LmWlF6kExU/1
 CKYVgisfVg+BPJxFjlY9bVAHsmwKGA1dAZ29BZVriPOWYvX/8EUkelFNBnz79gj0O+BL
 EQ/DDd5kmKIb6Ff5K6dko/fUc4Q9fG5CKkCMWBQtb7/xrR6gkMGt3Xy80u1O1Tcfz0KX
 29eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7vUUjj0UZDh7+H8jQjRWPfQT+zvIGfwWIAjxGtfT1HpK8MydShKEjyx4Qq8WWTm4ypsrBtFPNTxQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwblB9lzXGAk3Y0yb+Tc/5wkyUr2B7pn/aHHdKcVwarnS2DdKAU
 bBKF3hM4d1Gtg2vVIzXCzKCnmAXXH/TPhQSbHlNGGchd4MvxkhB+icHn
X-Gm-Gg: ATEYQzwtVuHsN4g9Ha9YP3QgqGR3MuTOQ4xytqAkxV7LFYIHk2VIVIQhUbL8hf47DjC
 bwi5XpPtSfrmcF7SKAUNGrq2h0FwnUtN4A0IlV7UtD0X4hINn6Ddy53vA032vrZ7cXB3nU4L2Le
 0w9Shf6AiOGu6eC8Y2O44uJ39Y8hX5yxPVjl9nqfPGmOJK7HVRVyqAVPfiqhxeInvtV76qtb+E1
 cNsxlaKLm8zGQIIVdn0FTuSLY/OnZe9OSwbYo4Nv20Yjp+mzg+RMwLOpaEUgHsjtnw92gG2vtzk
 aiKVExr3hEl6iQ6DbF2tMo8lIEGNPcLoJkXLRxolTtCH3DiVsuc6Zs4dnopNPxt9NaWajdL9uh9
 Ep4oxHU+wDY4q5yfG/euqpIv7ESWDvuVJW3OJF2lJdu1Z/pI1eYVfCVZaSM+kwpq/SPEdAdQcSG
 XJ1iIgvlCWxfjvgyT/S6UVadXOzCY+deyb
X-Received: by 2002:a17:907:2d8a:b0:b98:f1d:6a63 with SMTP id
 a640c23a62f3a-b9b2e5921bbmr865454266b.9.1774870510699; 
 Mon, 30 Mar 2026 04:35:10 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66c07ab15basm369758a12.17.2026.03.30.04.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:35:10 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v3] drm/amdgpu: replace PASID IDR with XArray
Date: Mon, 30 Mar 2026 16:35:01 +0500
Message-ID: <20260330113501.25654-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

Commit 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
converted the global PASID allocator from IDA to IDR with a spinlock
for cyclic allocation, but introduced two locking bugs:

1) idr_alloc_cyclic() is called with GFP_KERNEL under spin_lock(),
   which can sleep.

2) amdgpu_pasid_free() can be called from hardirq context via the
   fence signal path (amdgpu_pasid_free_cb), but the lock is taken
   with plain spin_lock() in process context, creating a potential
   deadlock:

     CPU0
     ----
     spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
     <Interrupt>
       spin_lock(&amdgpu_pasid_idr_lock) // deadlock

   The hardirq call chain is:

     sdma_v6_0_process_trap_irq
      -> amdgpu_fence_process
       -> dma_fence_signal
        -> drm_sched_job_done
         -> dma_fence_signal
          -> amdgpu_pasid_free_cb
           -> amdgpu_pasid_free

   This was observed on an RX 7900 XTX when exiting a Vulkan game
   running under Proton/Wine, which triggers the fence callback path
   during VM teardown.

Replace the IDR + spinlock with an XArray, which provides built-in
cyclic allocation (__xa_alloc_cyclic) and fine-grained IRQ-safe
locking (xa_lock_irqsave).  This fixes both bugs in a single,
cleaner conversion.

Suggested-by: Lazar, Lijo <lijo.lazar@amd.com>
Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v3: Replace IDR with XArray instead of fixing the spinlock, as
    suggested by Lijo Lazar.
    https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
    lock inconsistency (spin_lock -> spin_lock_irqsave).
    https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
    using idr_preload/GFP_NOWAIT.
    https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 50 +++++++++++++------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index d88523568b62..1e660fbc42ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -22,7 +22,7 @@
  */
 #include "amdgpu_ids.h"
 
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/dma-fence-array.h>
 
 
@@ -35,13 +35,13 @@
  * PASIDs are global address space identifiers that can be shared
  * between the GPU, an IOMMU and the driver. VMs on different devices
  * may use the same PASID if they share the same address
- * space. Therefore PASIDs are allocated using IDR cyclic allocator
- * (similar to kernel PID allocation) which naturally delays reuse.
- * VMs are looked up from the PASID per amdgpu_device.
+ * space. Therefore PASIDs are allocated using an XArray cyclic
+ * allocator (similar to kernel PID allocation) which naturally delays
+ * reuse. VMs are looked up from the PASID per amdgpu_device.
  */
 
-static DEFINE_IDR(amdgpu_pasid_idr);
-static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
+static DEFINE_XARRAY_ALLOC(amdgpu_pasid_xa);
+static u32 amdgpu_pasid_xa_next;
 
 /* Helper to free pasid from a fence callback */
 struct amdgpu_pasid_cb {
@@ -53,8 +53,7 @@ struct amdgpu_pasid_cb {
  * amdgpu_pasid_alloc - Allocate a PASID
  * @bits: Maximum width of the PASID in bits, must be at least 1
  *
- * Uses kernel's IDR cyclic allocator (same as PID allocation).
- * Allocates sequentially with automatic wrap-around.
+ * Uses XArray cyclic allocator for sequential allocation with wrap-around.
  *
  * Returns a positive integer on success. Returns %-EINVAL if bits==0.
  * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
@@ -62,20 +61,25 @@ struct amdgpu_pasid_cb {
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
-	int pasid;
+	unsigned long flags;
+	u32 pasid;
+	int r;
 
 	if (bits == 0)
 		return -EINVAL;
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_KERNEL);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	r = __xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
+			      XA_LIMIT(1, (1U << bits) - 1),
+			      &amdgpu_pasid_xa_next, GFP_ATOMIC);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
 
-	if (pasid >= 0)
+	if (r >= 0) {
 		trace_amdgpu_pasid_allocated(pasid);
+		return pasid;
+	}
 
-	return pasid;
+	return r;
 }
 
 /**
@@ -84,11 +88,13 @@ int amdgpu_pasid_alloc(unsigned int bits)
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
+
 	trace_amdgpu_pasid_freed(pasid);
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	__xa_erase(&amdgpu_pasid_xa, pasid);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -625,13 +631,11 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
+ * amdgpu_pasid_mgr_cleanup - Cleanup PASID manager
  *
- * Cleanup the IDR allocator.
+ * Free all internal data structures of the XArray allocator.
  */
 void amdgpu_pasid_mgr_cleanup(void)
 {
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_destroy(&amdgpu_pasid_idr);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_destroy(&amdgpu_pasid_xa);
 }
-- 
2.53.0

